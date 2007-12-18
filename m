From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH] Improved submodule merge support
Date: Tue, 18 Dec 2007 20:50:28 +0100
Message-ID: <20071218195028.GA25510@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 20:51:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4iSy-0002p1-EB
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 20:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbXLRTuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 14:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbXLRTuh
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 14:50:37 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:36494 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbXLRTug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 14:50:36 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1J4iSS-0002XU-Gv; Tue, 18 Dec 2007 20:50:28 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68798>

Currently merging submodules from a super module does not work at
all, here is an example:

$ git merge change1
Updating 41dee71..6dbd2d9
Fast forward
 sub-module |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

$ git merge change2
fatal: cannot read object 4a0b570e9b7c6fd36f964eb6ef55263834462235 'sub-module'
Merge with strategy recursive failed.

$ git status
# On branch mergetest
nothing to commit (working directory clean)

$ git submodule status
 4a0b570e9b7c6fd36f964eb6ef55263834462235 sub-module (undefined)

So - the merge simply failed, and git status has no clue what happened.


With the following patch, this happens instead:

$ git merge change1
Updating 41dee71..6dbd2d9
Fast forward
 sub-module |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

$ git merge change2
Auto-merged sub-module
CONFLICT (submodule): Merge conflict in sub-module - needs b65e6131a2705620a0b08a4ecc44427b9059e4e3
Automatic merge failed; fix conflicts and then commit the result.

$ git status
sub-module: needs merge
# On branch mergetest
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       unmerged:   sub-module
#
no changes added to commit (use "git add" and/or "git commit -a")

$ git submodule status
 11253a619a520fa4b2e2c2f83cb5c897170faafd sub-module (undefined)
 4a0b570e9b7c6fd36f964eb6ef55263834462235 sub-module (undefined)
 b65e6131a2705620a0b08a4ecc44427b9059e4e3 sub-module (undefined)


To resolve this:

$ cd sub-module
$ git merge b65e6131a27
$ cd ..
$ git add sub-module
$ git commit -m 'merged sub-module blablabla'
$ git submodule status
 eb66300641185297648b2a71e41a66b2053fdae0 sub-module (undefined)


So it actually works in some sense, and you see what you need to merge
aftwards in the submodule.

- Finn Arne


-- >8 --
Improved submodule merge support

When merging conflicting submodule changes from a supermodule, generate
a conflict message saying what went wrong. Also leave the tree in a state
where git status shows the conflict, and git submodule status gives the user
enough information to do the merge manally. Previously this would just fail.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 merge-recursive.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2a58dad..33ccc40 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -549,6 +549,10 @@ static void update_file_flags(const unsigned char *sha,
 		void *buf;
 		unsigned long size;
 
+		if (S_ISGITLINK(mode))
+			die("cannot read object %s '%s': It is a submodule!",
+			    sha1_to_hex(sha), path);
+
 		buf = read_sha1_file(sha, &type, &size);
 		if (!buf)
 			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
@@ -1463,10 +1467,13 @@ static int process_entry(const char *path, struct stage_data *entry,
 		mfi = merge_file(&o, &a, &b,
 				 branch1, branch2);
 
+		clean_merge = mfi.clean;
 		if (mfi.clean)
 			update_file(1, mfi.sha, mfi.mode, path);
+		else if (S_ISGITLINK(mfi.mode))
+			output(1, "CONFLICT (submodule): Merge conflict in %s "
+			       "- needs %s", path, sha1_to_hex(b.sha1));
 		else {
-			clean_merge = 0;
 			output(1, "CONFLICT (%s): Merge conflict in %s",
 					reason, path);
 
-- 
1.5.4.rc0.67.gf9c5
