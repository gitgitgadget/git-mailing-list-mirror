From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] rev-parse: diagnose ambiguous revision/filename arguments
Date: Fri, 6 Dec 2013 16:15:09 -0500
Message-ID: <20131206211509.GB20536@sigill.intra.peff.net>
References: <20131206211222.GB20482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 22:15:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp2k2-0004Q3-OS
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 22:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836Ab3LFVPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 16:15:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:51823 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753772Ab3LFVPL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 16:15:11 -0500
Received: (qmail 8533 invoked by uid 102); 6 Dec 2013 21:15:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Dec 2013 15:15:11 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Dec 2013 16:15:09 -0500
Content-Disposition: inline
In-Reply-To: <20131206211222.GB20482@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238952>

If you have both a file and a branch named "foo", running:

  git log foo

will complain. We should do the same in rev-parse, and
demand that it be disambiguated with:

  git rev-parse foo --

or

  git rev-parse -- foo

Signed-off-by: Jeff King <peff@peff.net>
---
Hmm, looking at this again, I guess we need to give the same treatment
to the try_difference code path above, as "foo..bar" can be ambiguous
with a filename (and "git log" seems to diagnose that).

 builtin/rev-parse.c            | 5 ++++-
 t/t1506-rev-parse-diagnosis.sh | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index bb694ab..3ff4f8a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -790,8 +790,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
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
index 613d9bf..7ccbcf4 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -220,4 +220,11 @@ test_expect_success 'arg before dashdash must be a revision (ambiguous)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ambiguous arg without dashdash' '
+	>foobar &&
+	git update-ref refs/heads/foobar HEAD &&
+	test_must_fail git rev-parse foobar 2>stderr &&
+	test_i18ngrep ambiguous stderr
+'
+
 test_done
-- 
1.8.5.524.g6743da6
