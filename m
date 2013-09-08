From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] git-config: always treat --int as 64-bit internally
Date: Sun, 8 Sep 2013 04:40:02 -0400
Message-ID: <20130908084002.GE29554@sigill.intra.peff.net>
References: <20130908082724.GA27184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 10:40:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIaXc-00080g-P5
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960Ab3IHIkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:40:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:43808 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3IHIkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 04:40:07 -0400
Received: (qmail 11650 invoked by uid 102); 8 Sep 2013 08:40:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 03:40:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 04:40:02 -0400
Content-Disposition: inline
In-Reply-To: <20130908082724.GA27184@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234224>

When you run "git config --int", the maximum size of integer
you get depends on how git was compiled, and what it
considers to be an "int".

This is almost useful, because your scripts calling "git
config" will behave similarly to git internally. But relying
on this is dubious; you have to actually know how git treats
each value internally (e.g., int versus unsigned long),
which is not documented and is subject to change. And even
if you know it is "unsigned long", we do not have a
git-config option to match that behavior.

Furthermore, you may simply be asking git to store a value
on your behalf (e.g., configuration for a hook). In that
case, the relevant range check has nothing at all to do with
git, but rather with whatever scripting tools you are using
(and git has no way of knowing what the appropriate range is
there).

Not only is the range check useless, but it is actively
harmful, as there is no way at all for scripts to look
at config variables with large values. For instance, one
cannot reliably get the value of pack.packSizeLimit via
git-config. On an LP64 system, git happily uses a 64-bit
"unsigned long" internally to represent the value, but the
script cannot read any value over 2G.

Ideally, the "--int" option would simply represent an
arbitrarily large integer. For practical purposes, however,
a 64-bit integer is large enough, and is much easier to
implement (and if somebody overflows it, we will still
notice the problem, and not simply return garbage).

Signed-off-by: Jeff King <peff@peff.net>
---
I kind of picked 64-bit as "big enough". But I suppose we could also go
with intmax_t. The only thing we can't do is an unsigned value.

Also, this is the first use of PRId64. I notice we have compatibility
macros for PRIu*, but I'm not sure what to put in one for PRId64.

 builtin/config.c       |  7 ++++---
 cache.h                |  1 +
 config.c               | 17 +++++++++++++++++
 t/t1300-repo-config.sh |  7 +++++++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 4010c43..8b182d2 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -128,7 +128,8 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 		must_print_delim = 1;
 	}
 	if (types == TYPE_INT)
-		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
+		sprintf(value, "%"PRId64,
+			git_config_int64(key_, value_ ? value_ : ""));
 	else if (types == TYPE_BOOL)
 		vptr = git_config_bool(key_, value_) ? "true" : "false";
 	else if (types == TYPE_BOOL_OR_INT) {
@@ -265,8 +266,8 @@ static char *normalize_value(const char *key, const char *value)
 	else {
 		normalized = xmalloc(64);
 		if (types == TYPE_INT) {
-			int v = git_config_int(key, value);
-			sprintf(normalized, "%d", v);
+			int64_t v = git_config_int64(key, value);
+			sprintf(normalized, "%"PRId64, v);
 		}
 		else if (types == TYPE_BOOL)
 			sprintf(normalized, "%s",
diff --git a/cache.h b/cache.h
index 85b544f..ac4525a 100644
--- a/cache.h
+++ b/cache.h
@@ -1190,6 +1190,7 @@ extern int git_config_int(const char *, const char *);
 extern int git_config_early(config_fn_t fn, void *, const char *repo_config);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
+extern int64_t git_config_int64(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
diff --git a/config.c b/config.c
index 87f87ba..6588cf5 100644
--- a/config.c
+++ b/config.c
@@ -534,6 +534,15 @@ static int git_parse_int(const char *value, int *ret)
 	return 1;
 }
 
+static int git_parse_int64(const char *value, int64_t *ret)
+{
+	intmax_t tmp;
+	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int64_t)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
 int git_parse_ulong(const char *value, unsigned long *ret)
 {
 	uintmax_t tmp;
@@ -565,6 +574,14 @@ int git_config_int(const char *name, const char *value)
 	return ret;
 }
 
+int64_t git_config_int64(const char *name, const char *value)
+{
+	int64_t ret;
+	if (!git_parse_int64(value, &ret))
+		die_bad_number(name, value);
+	return ret;
+}
+
 unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 20aee6e..b66c632 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -652,6 +652,13 @@ test_expect_success numbers '
 	test_cmp expect actual
 '
 
+test_expect_success '--int is at least 64 bits' '
+	git config giga.watts 121g &&
+	echo 129922760704 >expect &&
+	git config --int --get giga.watts >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'invalid unit' '
 	git config aninvalid.unit "1auto" &&
 	echo 1auto >expect &&
-- 
1.8.4.2.g87d4a77
