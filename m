From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC PATCH] git add -p: new "quit" command at the prompt.
Date: Fri, 10 Apr 2009 16:57:01 +0200
Message-ID: <1239375421-2556-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 17:32:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsIil-0005f6-PQ
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 17:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbZDJPbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 11:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbZDJPbI
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 11:31:08 -0400
Received: from imag.imag.fr ([129.88.30.1]:40874 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbZDJPbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 11:31:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3AFQ72V029280
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 10 Apr 2009 17:26:07 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LsIAA-0003v7-Rc; Fri, 10 Apr 2009 16:57:02 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LsIAA-0000fo-P4; Fri, 10 Apr 2009 16:57:02 +0200
X-Mailer: git-send-email 1.6.2.2.449.g92961.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 10 Apr 2009 17:26:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116261>

There's already 'd' to stop staging hunks in a file, but no command to
stop the interactive staging (for the current files and the remaining
ones). This patch implements this functionality, and binds it to 'q'.
---

I'm not familiar at all with the code in git-add--interactive.perl, so
my code is mostly cut-and-pasted+adapted from the 'd' command.
Probably suboptimal.

 git-add--interactive.perl |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index def062a..210d230 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -894,6 +894,7 @@ sub help_patch_cmd {
 	print colored $help_color, <<\EOF ;
 y - stage this hunk
 n - do not stage this hunk
+q - quit, do not stage this hunk nor any of the remaining ones
 a - stage this and all the remaining hunks in the file
 d - do not stage this hunk nor any of the remaining hunks in the file
 g - select a hunk to go to
@@ -930,7 +931,7 @@ sub patch_update_cmd {
 					@mods);
 	}
 	for (@them) {
-		patch_update_file($_->{VALUE});
+		return 0 if patch_update_file($_->{VALUE});
 	}
 }
 
@@ -976,6 +977,7 @@ sub display_hunks {
 }
 
 sub patch_update_file {
+	my $quit = 0;
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
@@ -1006,6 +1008,11 @@ sub patch_update_file {
 				$_->{USE} = 0 foreach ($mode, @hunk);
 				last;
 			}
+			elsif ($line =~ /^q/i) {
+				$_->{USE} = 0 foreach ($mode, @hunk);
+				$quit = 1;
+				last;
+			}
 			else {
 				help_patch_cmd('');
 				next;
@@ -1113,6 +1120,16 @@ sub patch_update_file {
 				}
 				next;
 			}
+			elsif ($line =~ /^q/i) {
+				while ($ix < $num) {
+					if (!defined $hunk[$ix]{USE}) {
+						$hunk[$ix]{USE} = 0;
+					}
+					$ix++;
+				}
+				$quit = 1;
+				next;
+			}
 			elsif ($line =~ m|^/(.*)|) {
 				my $regex = $1;
 				if ($1 eq "") {
@@ -1239,6 +1256,7 @@ sub patch_update_file {
 	}
 
 	print "\n";
+	return $quit;
 }
 
 sub diff_cmd {
-- 
1.6.2.2.449.g92961.dirty
