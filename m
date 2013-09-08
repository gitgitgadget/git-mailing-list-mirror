From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] config: make numeric parsing errors more clear
Date: Sun, 8 Sep 2013 04:38:22 -0400
Message-ID: <20130908083822.GD29554@sigill.intra.peff.net>
References: <20130908082724.GA27184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 10:38:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIaVv-00072u-0i
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012Ab3IHIia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:38:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:43795 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3IHIi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 04:38:26 -0400
Received: (qmail 11577 invoked by uid 102); 8 Sep 2013 08:38:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 03:38:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 04:38:22 -0400
Content-Disposition: inline
In-Reply-To: <20130908082724.GA27184@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234223>

If we try to parse an integer config argument and get a
number outside of the representable range, we die with the
cryptic message: "bad config value for '%s'".

We can improve two things:

  1. Show the value that produced the error (e.g., bad
     config value '3g' for 'foo.bar').

  2. Mention the reason the value was rejected (e.g.,
     "invalid unit" versus "out of range").

A few tests need to be updated with the new output, but that
should not be representative of real-world breakage, as
scripts should not be depending on the exact text of our
stderr output, which is subject to i18n anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
I was tempted to clean up the tortured string construction in
die_bad_number(), but my understanding is that translators prefer to see
the string in as whole a piece as we can get it, rather than building it
piecemeal from "if"s. And though this isn't marked for translation, it
probably should be.

 config.c                | 17 ++++++++++++-----
 t/t1300-repo-config.sh  |  6 +++---
 t/t4055-diff-context.sh |  2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/config.c b/config.c
index 7332b06..87f87ba 100644
--- a/config.c
+++ b/config.c
@@ -543,18 +543,25 @@ int git_config_int(const char *name, const char *value)
 	return 1;
 }
 
-static void die_bad_config(const char *name)
+static void die_bad_number(const char *name, const char *value)
 {
+	const char *reason = errno == ERANGE ?
+			     "out of range" :
+			     "invalid unit";
+	if (!value)
+		value = "";
+
 	if (cf && cf->name)
-		die("bad config value for '%s' in %s", name, cf->name);
-	die("bad config value for '%s'", name);
+		die("bad numeric config value '%s' for '%s' in %s: %s",
+		    value, name, cf->name, reason);
+	die("bad numeric config value '%s' for '%s': %s", value, name, reason);
 }
 
 int git_config_int(const char *name, const char *value)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_config(name);
+		die_bad_number(name, value);
 	return ret;
 }
 
@@ -562,7 +569,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_config(name);
+		die_bad_number(name, value);
 	return ret;
 }
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index c4a7d84..20aee6e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -657,11 +657,11 @@ test_expect_success 'invalid unit' '
 	echo 1auto >expect &&
 	git config aninvalid.unit >actual &&
 	test_cmp expect actual &&
-	cat > expect <<-\EOF
-	fatal: bad config value for '\''aninvalid.unit'\'' in .git/config
+	cat >expect <<-\EOF
+	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'' in .git/config: invalid unit
 	EOF
 	test_must_fail git config --int --get aninvalid.unit 2>actual &&
-	test_cmp actual expect
+	test_i18ncmp expect actual
 '
 
 cat > expect << EOF
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 97172b4..cd04543 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -73,7 +73,7 @@ test_expect_success 'non-integer config parsing' '
 test_expect_success 'non-integer config parsing' '
 	git config diff.context no &&
 	test_must_fail git diff 2>output &&
-	test_i18ngrep "bad config value" output
+	test_i18ngrep "bad numeric config value" output
 '
 
 test_expect_success 'negative integer config parsing' '
-- 
1.8.4.2.g87d4a77
