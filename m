From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH/RFC] pack-objects documentation and usage update
Date: Tue, 22 Jan 2008 09:03:05 +0100
Message-ID: <4795A339.40103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 09:03:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHE6j-0001Ek-JH
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 09:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbYAVIDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 03:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbYAVIDJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 03:03:09 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:24386 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbYAVIDH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 03:03:07 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JHE5w-00047T-F5
	for git@vger.kernel.org; Tue, 22 Jan 2008 09:02:56 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP id 54457546
	for <git@vger.kernel.org>; Tue, 22 Jan 2008 09:03:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71429>

With the previous ordering in the short usage help it was difficult to
spot that either a base-name or --stdout must be specified. Some
punctuation is dropped because it is more hindrance than help.

The documentation of --reflog is added and the synopsis updated to include
all options that pack-objects understands.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
Since this patch does not fill in the missing documentation of
--keep-unreachable, I marked it as RFC.

08cdfb13374 says about --keep-unreachable:

    This new option is meant to be used in conjunction with the
    options "git repack -a -d" usually invokes the underlying
    pack-objects with.  When this option is given, objects unreachable
    from the refs in packs named with --unpacked= option are added
    to the resulting pack, in addition to the reachable objects that
    are not in packs marked with *.keep files.

but this sentence is too complicated for my small brain.

-- Hannes

 Documentation/git-pack-objects.txt |   15 ++++++++++++---
 builtin-pack-objects.c             |    4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 74cc7c1..6a3ddc9 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -9,9 +9,13 @@ git-pack-objects - Create a packed archive of objects
 SYNOPSIS
 --------
 [verse]
-'git-pack-objects' [-q] [--no-reuse-delta] [--delta-base-offset] [--non-empty]
-	[--local] [--incremental] [--window=N] [--depth=N] [--all-progress]
-	[--revs [--unpacked | --all]*] [--stdout | base-name] < object-list
+'git-pack-objects' [-q | --progress | --all-progress]
+        [--max-pack-size=N] [--local] [--incremental]
+        [--window=N] [--window-memory=N] [--depth=N]
+        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]
+        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog]
+        [--keep-unreachable] --stdout | base-name < ref-or-object-list
+


 DESCRIPTION
@@ -73,6 +77,11 @@ base-name::
 	as if all refs under `$GIT_DIR/refs` are specified to be
 	included.

+--reflog::
+	This implies `--revs`. In addition to the objects reachable
+	from the revision arguments, pack also those objects that
+	are reachable from those revisions' reflogs.
+
 --window=[N], --depth=[N]::
 	These two options affect how the objects contained in
 	the pack are stored using delta compression.  The
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ec10238..cd7a272 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -20,12 +20,12 @@
 #endif

 static const char pack_usage[] = "\
-git-pack-objects [{ -q | --progress | --all-progress }] \n\
+git-pack-objects [-q | --progress | --all-progress] \n\
 	[--max-pack-size=N] [--local] [--incremental] \n\
 	[--window=N] [--window-memory=N] [--depth=N] \n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
 	[--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
-	[--stdout | base-name] [--keep-unreachable] [<ref-list | <object-list]";
+	[--keep-unreachable] --stdout | base-name < ref-or-object-list";

 struct object_entry {
 	struct pack_idx_entry idx;
-- 
1.5.4.rc3.24.g25a9a
