From: Jeff King <peff@peff.net>
Subject: [PATCH 15/25] t9502: fix &&-chain breakage
Date: Fri, 20 Mar 2015 06:13:01 -0400
Message-ID: <20150320101301.GO12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvW-0005jg-9z
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbbCTKNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:35707 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbbCTKND (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:13:03 -0400
Received: (qmail 5906 invoked by uid 102); 20 Mar 2015 10:13:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:13:04 -0500
Received: (qmail 21623 invoked by uid 107); 20 Mar 2015 10:13:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:13:01 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265889>

This script misses a trivial &&-chain in one of its tests,
but it also has a weird reverse: it includes an &&-chain
outside of any test_expect block! This "cat" should never
fail, but if it did, we would not notice, as it would cause
us to skip the follow-on test entirely (which does not
appear intentional; there are many later tests which rely on
this cat).

Let's instead move the setup into its own test_expect_success
block, which is the standard practice nowadays.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9502-gitweb-standalone-parse-output.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 86dfee2..a93e159 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -145,9 +145,11 @@ test_expect_success 'forks: not skipped unless "forks" feature enabled' '
 	grep -q ">fork of .*<"           gitweb.body
 '
 
-cat >>gitweb_config.perl <<\EOF &&
-$feature{'forks'}{'default'} = [1];
-EOF
+test_expect_success 'enable forks feature' '
+	cat >>gitweb_config.perl <<-\EOF
+	$feature{'forks'}{'default'} = [1];
+	EOF
+'
 
 test_expect_success 'forks: forks skipped if "forks" feature enabled' '
 	gitweb_run "a=project_list" &&
@@ -173,7 +175,7 @@ test_expect_success 'forks: can access forked repository' '
 '
 
 test_expect_success 'forks: project_index lists all projects (incl. forks)' '
-	cat >expected <<-\EOF
+	cat >expected <<-\EOF &&
 	.git
 	foo.bar.git
 	foo.git
-- 
2.3.3.520.g3cfbb5d
