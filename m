From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 3/7] git-svn: On MSYS, escape and quote SVN_SSH also if set by the user
Date: Sat, 15 Oct 2011 15:05:16 +0100
Message-ID: <1318687520-19522-4-git-send-email-patthoyts@users.sourceforge.net>
References: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 15 16:06:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF4sD-0004D3-3t
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 16:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab1JOOFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 10:05:45 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:64763 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752853Ab1JOOF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 10:05:29 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.4])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015140527.GEFG8898.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 15:05:27 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1RF4rf-0001k8-Ng; Sat, 15 Oct 2011 15:05:27 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 684CD207A7; Sat, 15 Oct 2011 15:05:27 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=4LikjozNDCAA:10 a=pGLkceISAAAA:8 a=19I1k8K98J2gF8G2pksA:9 a=MSl-tDqOz04A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183661>

From: Sebastian Schuberth <sschuberth@gmail.com>

While GIT_SSH does not require any escaping / quoting (e.g. for paths
containing spaces), SVN_SSH requires it due to its use in a Perl script.

Previously, SVN_SSH has only been escaped and quoted automatically if it
was unset and thus derived from GIT_SSH. For user convenience, do the
escaping and quoting also for a SVN_SSH set by the user. This way, the
user is able to use the same unescaped and unquoted syntax for GIT_SSH
and SVN_SSH.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-svn.perl |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a0410f0..3b33379 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -22,14 +22,13 @@ $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
 $Git::SVN::Ra::_log_window_size = 100;
 $Git::SVN::_minimize_url = 'unset';
 
-if (! exists $ENV{SVN_SSH}) {
-	if (exists $ENV{GIT_SSH}) {
-		$ENV{SVN_SSH} = $ENV{GIT_SSH};
-		if ($^O eq 'msys') {
-			$ENV{SVN_SSH} =~ s/\\/\\\\/g;
-			$ENV{SVN_SSH} =~ s/(.*)/"$1"/;
-		}
-	}
+if (! exists $ENV{SVN_SSH} && exists $ENV{GIT_SSH}) {
+	$ENV{SVN_SSH} = $ENV{GIT_SSH};
+}
+
+if (exists $ENV{SVN_SSH} && $^O eq 'msys') {
+	$ENV{SVN_SSH} =~ s/\\/\\\\/g;
+	$ENV{SVN_SSH} =~ s/(.*)/"$1"/;
 }
 
 $Git::SVN::Log::TZ = $ENV{TZ};
-- 
1.7.7.1.gbba15
