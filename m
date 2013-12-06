From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] rev-parse: diagnose ambiguous revision/filename
 arguments
Date: Fri, 6 Dec 2013 17:08:09 -0500
Message-ID: <20131206220809.GC25620@sigill.intra.peff.net>
References: <20131206220520.GA30652@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 23:08:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp3ZK-0006Jg-2H
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 23:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161519Ab3LFWIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 17:08:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:51867 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161517Ab3LFWIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 17:08:11 -0500
Received: (qmail 11225 invoked by uid 102); 6 Dec 2013 22:08:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Dec 2013 16:08:11 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Dec 2013 17:08:09 -0500
Content-Disposition: inline
In-Reply-To: <20131206220520.GA30652@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238958>

If you have both a file and a branch named "foo", running:

  git log foo

will complain. We should do the same in rev-parse, and
demand that it be disambiguated with:

  git rev-parse foo --

or

  git rev-parse -- foo

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c            | 12 ++++++++----
 t/t1506-rev-parse-diagnosis.sh | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a60fcd3..a3a58bf 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -781,10 +781,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		}
 
 		/* Not a flag argument */
-		if (try_difference(arg))
-			continue;
-		if (try_parent_shorthands(arg))
+		if (try_difference(arg) || try_parent_shorthands(arg)) {
+			if (!has_dashdash)
+				verify_non_filename(prefix, arg);
 			continue;
+		}
 		name = arg;
 		type = NORMAL;
 		if (*arg == '^') {
@@ -794,8 +795,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		if (!get_sha1(name, sha1)) {
 			if (verify)
 				revs_count++;
-			else
+			else {
 				show_rev(type, sha1, name);
+				if (!has_dashdash)
+					verify_non_filename(prefix, arg);
+			}
 			continue;
 		}
 		if (verify)
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 613d9bf..dc1f1dc 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -220,4 +220,26 @@ test_expect_success 'arg before dashdash must be a revision (ambiguous)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ambiguous arg without dashdash (normal)' '
+	>foobar &&
+	git update-ref refs/heads/foobar HEAD &&
+	test_must_fail git rev-parse foobar 2>stderr &&
+	test_i18ngrep ambiguous stderr
+'
+
+test_expect_success 'ambiguous arg without dashdash (difference)' '
+	>one..two &&
+	git update-ref refs/heads/one HEAD &&
+	git update-ref refs/heads/two HEAD &&
+	test_must_fail git rev-parse one..two 2>stderr &&
+	test_i18ngrep ambiguous stderr
+'
+
+test_expect_success 'ambiguous arg without dashdash (parents)' '
+	>"foobar^@" &&
+	git update-ref refs/heads/foobar HEAD &&
+	test_must_fail git rev-parse foobar^@ 2>stderr &&
+	test_i18ngrep ambiguous stderr
+'
+
 test_done
-- 
1.8.5.524.g6743da6
