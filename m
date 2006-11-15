X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Run "git repack -a -d" once more at end, if there's 1MB or more of not-packed data.
Date: Wed, 15 Nov 2006 21:15:44 +0100
Message-ID: <87ejs4mpov.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 20:17:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Original-Lines: 49
X-Virus-Scanned: ClamAV 0.88.5/2196/Wed Nov 15 14:16:17 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31482>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRBl-0005gF-U1 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030684AbWKOUQu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030956AbWKOUQu
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:16:50 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:34211 "EHLO
 zeus1.kernel.org") by vger.kernel.org with ESMTP id S1030684AbWKOUQt (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:16:49 -0500
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64]) by
 zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id kAFKGGOq014728 for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 20:16:29 GMT
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000) id
 EA09B27166; Wed, 15 Nov 2006 21:15:44 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Although I converted upstream coreutils to git last month, I just
reconverted coreutils once again, as a test, and ended up with a
git repository of about 130MB (contrast with my packed git repo of
size 52MB).  That was because there were a lot of commits (but < 1024)
after the final automatic "git-repack -a -d".

Running a final
  git-repack -a -d && git-prune-packed
cut the final repository size down to the expected size.

So this looks like an easy way to improve git-cvsimport.
Just run "git repack ..." at the end if there's more than
some reasonable amount of not-packed data.

My choice of 1MB is a little arbitrarily.  I wouldn't mind missing
the minimal repo size by 1MB.  At the other end of the spectrum,
it's probably not worthwhile to pack everything when the total
repository size is less than 1MB.

Here's the patch:

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 git-cvsimport.perl |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 14e2c61..b54a948 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -876,6 +876,16 @@ while(<CVS>) {
 }
 commit() if $branch and $state != 11;
 
+# The heuristic of repacking every 1024 commits can leave a
+# lot of unpacked data.  If there is more than 1MB worth of
+# not-packed objects, repack once more.
+my $line = `git-count-objects`;
+if ($line =~ /^(\d+) objects, (\d+) kilobytes$/) {
+  my ($n_objects, $kb) = ($1, $2);
+  1024 < $kb
+    and system("git repack -a -d");
+}
+
 foreach my $git_index (values %index) {
     if ($git_index ne '.git/index') {
 	unlink($git_index);
-- 
