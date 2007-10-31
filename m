From: Brad King <brad.king@kitware.com>
Subject: [PATCH] cvsexportcommit: fix for commits that do not have parents
Date: Wed, 31 Oct 2007 16:55:13 -0400
Message-ID: <4728EBB1.8050404@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 21:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InKb7-0005jT-IU
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 21:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbXJaUzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 16:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbXJaUzP
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 16:55:15 -0400
Received: from public.kitware.com ([66.194.253.19]:38838 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbXJaUzO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 16:55:14 -0400
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id 312511F3BCE
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 16:55:13 -0400 (EDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by hythloth (Postfix) with ESMTP id 273095E6AE
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 16:55:13 -0400 (EDT)
User-Agent: Icedove 1.5.0.12 (X11/20070730)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62867>

Previously commits without parents would fail to export with a
message indicating that the commits had more than one parent.
Instead we should use the --root option for git-diff-tree in
place of a parent.

Signed-off-by: Brad King <brad.king@kitware.com>
---
This is a corrected version of the patch I previously posted which had a typo.
 git-cvsexportcommit.perl |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index f284c88..26844af 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -82,6 +82,7 @@ foreach my $line (@commit) {
     }
 }

+my $noparent = "0000000000000000000000000000000000000000";
 if ($parent) {
     my $found;
     # double check that it's a valid parent
@@ -95,8 +96,10 @@ if ($parent) {
 } else { # we don't have a parent from the cmdline...
     if (@parents == 1) { # it's safe to get it from the commit
 	$parent = $parents[0];
-    } else { # or perhaps not!
-	die "This commit has more than one parent -- please name the parent you want to use explicitly";
+    } elsif (@parents == 0) { # there is no parent
+        $parent = $noparent;
+    } else { # cannot choose automatically from multiple parents
+        die "This commit has more than one parent -- please name the parent you want to use explicitly";
     }
 }

@@ -116,7 +119,11 @@ if ($opt_a) {
 }
 close MSG;

-`git-diff-tree --binary -p $parent $commit >.cvsexportcommit.diff`;# || die "Cannot diff";
+if ($parent eq $noparent) {
+    `git-diff-tree --binary -p --root $commit >.cvsexportcommit.diff`;# || die "Cannot diff";
+} else {
+    `git-diff-tree --binary -p $parent $commit >.cvsexportcommit.diff`;# || die "Cannot diff";
+}

 ## apply non-binary changes

-- 
1.5.3.2
