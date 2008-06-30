From: Patrick Higgins <patrick.higgins@cexp.com>
Subject: [PATCH/RFC] Emulating symlinks on Windows with file copies
Date: Mon, 30 Jun 2008 17:54:13 -0600
Message-ID: <1214870053-11537-1-git-send-email-patrick.higgins@cexp.com>
Cc: Patrick Higgins <patrick.higgins@cexp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 01:56:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDTET-0005LX-Pz
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 01:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbYF3Xzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 19:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754842AbYF3Xzc
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 19:55:32 -0400
Received: from mx02.cexp.com ([170.131.136.83]:38244 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831AbYF3Xzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 19:55:31 -0400
Received: from mailgate2.cexp.com (uscobrmfa-se-07.cexp.com [170.131.144.37])
	by mx02.cexp.com (Postfix) with ESMTP id 0DDBD369E46
	for <git@vger.kernel.org>; Mon, 30 Jun 2008 17:54:15 -0600 (MDT)
Received: from localhost.localdomain ([10.128.5.63]) by USCOBRMFA-SE-52.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 30 Jun 2008 17:54:14 -0600
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.1/8.13.1) with ESMTP id m5UNsEvV011560;
	Mon, 30 Jun 2008 17:54:14 -0600
Received: (from phiggins@localhost)
	by localhost.localdomain (8.13.1/8.13.1/Submit) id m5UNsDXE011559;
	Mon, 30 Jun 2008 17:54:13 -0600
X-Mailer: git-send-email 1.5.6.dirty
X-OriginalArrivalTime: 30 Jun 2008 23:54:14.0786 (UTC) FILETIME=[99E1C620:01C8DB0C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86973>

Signed-off-by: Patrick Higgins <patrick.higgins@cexp.com>
---

This is a very basic script to test out the idea of using copies to emulate
symlinks on Windows. I don't track any changes in the index yet which seems
necessary as a next step.

Symlinks get deleted and replaced with copies. Existing unchanged copies
are ignored. Copies that have been modified get merged into the target of
the link.

This might have some messy cases that I haven't considered yet, but it seems
like a fairly straightforward way to make a repository containing file
symlinks useful on Windows.

I have not yet started on directories. This technique would probably get
messy with directories. Perhaps junction (reparse) points would be better
for directories?

 git-sync-symlinks.perl |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100755 git-sync-symlinks.perl

diff --git a/git-sync-symlinks.perl b/git-sync-symlinks.perl
new file mode 100755
index 0000000..223ae83
--- /dev/null
+++ b/git-sync-symlinks.perl
@@ -0,0 +1,44 @@
+#!/usr/bin/perl -w
+
+use strict;
+use File::Copy;
+use Fcntl ':mode';
+
+my $filepipe = open(FILELIST, '-|', 'git', 'ls-tree', '-z', '-r', 'HEAD')
+    or die("Cannot call git ls-tree : $!");
+
+local $/ = "\0";
+
+while ( <FILELIST> ) {
+    chomp;
+    if (/^120000 blob ([0-9a-f]{40})\t(.*)$/) {
+        my ($id, $path) = ($1, $2);
+        my $target = `git cat-file blob $id`;
+        chomp($target);
+        my @path_stat = lstat($path);
+        my @target_stat = stat($target);
+        
+        if (S_ISLNK($path_stat[2])) {
+            printf("Copying '%s' to '%s'\n", $target, $path);
+            unlink($path);
+            copy($target, $path);
+        }
+        elsif ($path_stat[7] != $target_stat[7] ||
+               `git hash-object $path` ne `git hash-object $target`)
+        {
+            printf("Merging '%s' to '%s'\n", $path, $target);
+            my @target_parts = split(/\s+/, `git ls-tree HEAD $target`);
+            my $target_id = $target_parts[2];
+            my $original = $target . ".BASE";
+            open(ORIGINAL, '-|', 'git', 'cat-file', 'blob', $target_id);
+            open(ORIGINAL_OUT, '>', $original);
+            while ( <ORIGINAL> ) {
+                print ORIGINAL_OUT $_;
+            }
+            close ORIGINAL_OUT;
+            close ORIGINAL;
+            system('git', 'merge-file', $target, $original, $path);
+        }
+    }
+}
+close FILELIST;
-- 
1.5.6.dirty
