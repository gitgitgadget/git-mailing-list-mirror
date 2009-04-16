From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] git add -p: new "quit" command at the prompt.
Date: Thu, 16 Apr 2009 18:46:22 +0200
Message-ID: <1239900383-29628-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqiql4tuov.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 18:53:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuUpg-0007K2-Ly
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 18:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757169AbZDPQug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 12:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756197AbZDPQug
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 12:50:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:38687 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756247AbZDPQue (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 12:50:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3GGkXeN028350
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2009 18:46:33 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LuUjQ-0004w1-RI; Thu, 16 Apr 2009 18:46:32 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LuUjQ-0007iS-OT; Thu, 16 Apr 2009 18:46:32 +0200
X-Mailer: git-send-email 1.6.2.2.449.g92961.dirty
In-Reply-To: <vpqiql4tuov.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 16 Apr 2009 18:46:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116711>

There's already 'd' to stop staging hunks in a file, but no explicit
command to stop the interactive staging (for the current files and the
remaining ones).  Of course you can do 'd' and then ^C, but it would be
more intuitive to allow 'quit' action.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.txt |    1 +
 git-add--interactive.perl |   20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ce71838..709e04b 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -245,6 +245,7 @@ patch::
 
        y - stage this hunk
        n - do not stage this hunk
+       q - quite, do not stage this hunk nor any of the remaining ones
        a - stage this and all the remaining hunks in the file
        d - do not stage this hunk nor any of the remaining hunks in the file
        j - leave this hunk undecided, see next undecided hunk
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
