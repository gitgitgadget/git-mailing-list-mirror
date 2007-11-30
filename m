From: Jeff King <peff@peff.net>
Subject: [PATCH] cvsimport: fix usage of cvsimport.module
Date: Fri, 30 Nov 2007 17:22:12 -0500
Message-ID: <20071130222212.GA30037@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 23:22:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyEFo-0002Ek-Qg
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 23:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbXK3WWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 17:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbXK3WWP
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 17:22:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2385 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbXK3WWP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 17:22:15 -0500
Received: (qmail 5669 invoked by uid 111); 30 Nov 2007 22:22:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 30 Nov 2007 17:22:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2007 17:22:12 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66664>

There were two problems:

  1. We only look at the config variable if there is no module
     given on the command line. We checked this by comparing
     @ARGV == 0. However, at the time of the comparison, we
     have not yet parsed the dashed options, meaning that
     "git cvsimport" would read the variable but "git
     cvsimport -a" would not. This is fixed by simply moving
     the check after the call to getopt.

  2. If the config variable did not exist, we were adding an
     empty string to @ARGV. The rest of the script, rather
     than barfing for insufficient input, would then try to
     import the module '', leading to rather confusing error
     messages. Based on patch from Emanuele Giaquinta.

Signed-off-by: Jeff King <peff@peff.net>
---
On Fri, Nov 30, 2007 at 08:33:04PM +0100, Emanuele Giaquinta wrote:

> I found another minor bug in git-cvsimport, which the
> attached patch fixes [...]

Emanuele, thanks for submitting the patch. However, please be sure
to copy the list (git@vger.kernel.org), and please follow
the format described in Documentation/SubmittingPatches.

As it turns out, while checking your patch, I found another
serious error, so I just rolled them together.

 git-cvsimport.perl   |    8 ++++----
 t/t9600-cvsimport.sh |   21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 321a27e..92648f4 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -108,10 +108,6 @@ sub read_repo_config {
             }
 		}
 	}
-    if (@ARGV == 0) {
-        chomp(my $module = `git-repo-config --get cvsimport.module`);
-        push(@ARGV, $module);
-    }
 }
 
 my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:";
@@ -119,6 +115,10 @@ read_repo_config($opts);
 getopts($opts) or usage();
 usage if $opt_h;
 
+if (@ARGV == 0) {
+		chomp(my $module = `git-repo-config --get cvsimport.module`);
+		push(@ARGV, $module) if $? == 0;
+}
 @ARGV <= 1 or usage("You can't specify more than one CVS module");
 
 if ($opt_d) {
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 3338d44..29fee2d 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -98,4 +98,25 @@ test_expect_success 'update git module' '
 
 '
 
+test_expect_success 'update cvs module' '
+
+	cd module-cvs &&
+		echo 1 >tick &&
+		cvs add tick &&
+		cvs commit -m 1
+	cd ..
+
+'
+
+test_expect_success 'cvsimport.module config works' '
+
+	cd module-git &&
+		git config cvsimport.module module &&
+		git cvsimport -a -z0 &&
+		git merge origin &&
+	cd .. &&
+	git diff module-cvs/tick module-git/tick
+
+'
+
 test_done
-- 
1.5.3.6.2064.g2e22f-dirty
