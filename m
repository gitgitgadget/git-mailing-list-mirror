X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jim Meyering <jim@meyering.net>
Subject: Set permissions of each new file before "cvs add"ing it.
Date: Sun, 03 Dec 2006 20:51:27 +0100
Message-ID: <87ac24zrk0.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 19:51:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Original-Lines: 47
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33134>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqxN7-000083-JW for gcvg-git@gmane.org; Sun, 03 Dec
 2006 20:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760030AbWLCTv3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 14:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760040AbWLCTv2
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 14:51:28 -0500
Received: from mx.meyering.net ([82.230.74.64]:30431 "EHLO mx.meyering.net")
 by vger.kernel.org with ESMTP id S1760030AbWLCTv2 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 14:51:28 -0500
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000) id
 301F615B2; Sun,  3 Dec 2006 20:51:27 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Without the following patch, git-cvsexportcommit would fail to propagate
permissions of files added in git to the CVS repository.  I.e., when I
added an executable script in coreutils' git repo, then tried to propagate
that addition to the mirroring CVS repository, the script ended up added
not executable there.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 git-cvsexportcommit.perl |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 7bac16e..f819eb2 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -268,6 +268,7 @@ if (($? >> 8) == 2) {
 }

 foreach my $f (@afiles) {
+    set_new_file_permissions($f);
     if (grep { $_ eq $f } @bfiles) {
       system('cvs', 'add','-kb',$f);
     } else {
@@ -342,3 +343,21 @@ sub safe_pipe_capture {
     }
     return wantarray ? @output : join('',@output);
 }
+
+# For any file we want to add to cvs, we must first set its permissions
+# properly, *before* the "cvs add ..." command.  Otherwise, it is impossible
+# to change the permission of the file in the CVS repository using only cvs
+# commands.  This should be fixed in cvs-1.12.14.
+sub set_new_file_permissions {
+    my ($file) = @_;
+    # Given input like this:
+    # ba45154d8e9f5f49f46c8c2c2d8a554db7c3465f ...
+    # :000000 100755 0000000... b595dc6... A  tests/du/one-file-system
+    # extract the three octal permission digits:
+    my $cmd = 'git-whatchanged --max-count=1 --pretty=oneline -- $f'
+      . q! | sed -n '2s/^:00* [0-7][0-7][0-7]\([0-7][0-7][0-7]\) .*/\1/p'!;
+    my $perm = `$cmd`;
+
+    chmod oct($perm), $file
+      or die "failed to set permissions of \"$file\": $!\n";
+}
--
