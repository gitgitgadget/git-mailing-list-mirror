From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] log.decorate: accept 0/1 bool values
Date: Wed, 17 Nov 2010 12:00:45 -0500
Message-ID: <20101117170045.GA4108@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 17 18:01:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIlNP-0007Jk-Hk
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 18:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934924Ab0KQRAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 12:00:50 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55772 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932743Ab0KQRAu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 12:00:50 -0500
Received: (qmail 6885 invoked by uid 111); 17 Nov 2010 17:00:46 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 17 Nov 2010 17:00:46 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Nov 2010 12:00:45 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161623>

We explicitly document "0" and "1" as synonyms for "false"
and "true" in boolean config options. However, we don't
actually handle those values in git_config_maybe_bool.

In most cases this works fine, as we call git_config_bool,
which in turn calls git_config_bool_or_int, which in turn
calls git_config_maybe_bool. Values of 0/1 are considered
"not bool", but their integer values end up being converted
to the corresponding boolean values.

However, the log.decorate code looks for maybe_bool
explicitly, so that it can fall back to the "short" and
"full" strings. It does not handle 0/1 at all, and considers
them invalid values.

We cannot simply add 0/1 support to git_config_maybe_bool.
That would confuse git_config_bool_or_int, which may want to
distinguish the integer values "0" and "1" from bools.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't know that anyone explicitly cares about distinguishing "0" from
"false", but we do expose this interface via "git config --bool-or-int",
and we test for it explicitly in t1300. So I kept the existing behavior
intact in that instance.

Note that another way to solve this would be to check explicitly for
"short" or "full" and then just call git_config_bool itself. That works
in this case, but not for an open-ended case (i.e., where you can take
either a bool, or any arbitrary string). And I needed that case for my
patch 2/2. :)

 config.c       |   16 ++++++++++++++--
 t/t4202-log.sh |    9 +++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 4b0a820..9918b93 100644
--- a/config.c
+++ b/config.c
@@ -410,7 +410,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 	return ret;
 }
 
-int git_config_maybe_bool(const char *name, const char *value)
+static int git_config_maybe_bool_text(const char *name, const char *value)
 {
 	if (!value)
 		return 1;
@@ -427,9 +427,21 @@ int git_config_maybe_bool(const char *name, const char *value)
 	return -1;
 }
 
+int git_config_maybe_bool(const char *name, const char *value)
+{
+	int v = git_config_maybe_bool_text(name, value);
+	if (0 <= v)
+		return v;
+	if (!strcmp(value, "0"))
+		return 0;
+	if (!strcmp(value, "1"))
+		return 1;
+	return -1;
+}
+
 int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
-	int v = git_config_maybe_bool(name, value);
+	int v = git_config_maybe_bool_text(name, value);
 	if (0 <= v) {
 		*is_bool = 1;
 		return v;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2e51356..2043bb8 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -422,6 +422,15 @@ test_expect_success 'log.decorate configuration' '
 	test_cmp expect.full actual &&
 
 	git config --unset-all log.decorate &&
+	git config log.decorate 1 &&
+	git log --oneline >actual &&
+	test_cmp expect.short actual &&
+	git log --oneline --decorate=full >actual &&
+	test_cmp expect.full actual &&
+	git log --oneline --decorate=no >actual &&
+	test_cmp expect.none actual &&
+
+	git config --unset-all log.decorate &&
 	git config log.decorate short &&
 	git log --oneline >actual &&
 	test_cmp expect.short actual &&
-- 
1.7.3.2.362.g308e9
