From: Jonathon Mah <me@JonathonMah.com>
Subject: Bug: write-tree corrupts intent-to-add index state
Date: Tue, 6 Nov 2012 00:53:27 -0800
Message-ID: <3E62F933-76CD-4578-8684-21444EAA454F@JonathonMah.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 09:58:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVezh-0008G3-NY
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 09:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab2KFI6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 03:58:37 -0500
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:8697 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751798Ab2KFI6g convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Nov 2012 03:58:36 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2012 03:58:36 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtAmALbOmFBHynyrPGdsb2JhbAANN4pRuHwBAQEBOIMTOoEpGhOvSIMqkESRcGEDiFqgdQ
Received: from c-71-202-124-171.hsd1.ca.comcast.net (HELO [192.168.120.21]) ([71.202.124.171])
  by ipmail06.adl2.internode.on.net with ESMTP; 06 Nov 2012 19:23:30 +1030
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209104>

Hi revisionaries,

I came across what appears to be a bug while working today. I had several changes, both staged and unstaged, and two files that I had marked with intent-to-add (git add -N).

$ git status -sb
## Library-3.x...origin/Library-3.x [ahead 4]
M  Library/LIRootSource.m
 M Library/Library.xcodeproj/project.pbxproj
[...]
 M Library/SceneKit/LISceneKitBookshelfScene.m
AM Library/SceneKit/LISceneKitDisplayedMediumProxy.h
AM Library/SceneKit/LISceneKitDisplayedMediumProxy.m

(The last two files were added with -N.) I then attempted to stash my work, but that failed:

$ git stash -k
error: Entry 'Library/SceneKit/LISceneKitDisplayedMediumProxy.h' not uptodate. Cannot merge.
Cannot save the current worktree state

Re-checking the status showed that the intent-to-add files were now simply modified, yet they did not appear in git ls-tree -r HEAD.

$ git status -sb
## Library-3.x...origin/Library-3.x [ahead 4]
M  Library/LIRootSource.m
 M Library/Library.xcodeproj/project.pbxproj
[...]
 M Library/SceneKit/LISceneKitBookshelfScene.m
 M Library/SceneKit/LISceneKitDisplayedMediumProxy.h
 M Library/SceneKit/LISceneKitDisplayedMediumProxy.m

It appears the index forgot that those files were new. So not only has the intent-to-add status been lost, but git status shows a file existing in neither HEAD nor the index as not-new-but-modified.

Tracing through it, I narrowed it down to git write-tree affecting the index state. As far as I can tell, it's incorrect for that command to change the index. I'm now out of my (shallow) depth in the git codebase, so I'm throwing it out there for someone to tackle (hopefully). I've attached a failing test case.

Additional notes for bug hunters:

- I've only seen files in already-existing subdirectories lose intent-to-add status, whereas marking a file in the top-level as i-t-a is preserved during write-tree.

- The 'git ls-files -s --debug' output doesn't change across the write-tree:

100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	dir/baz
  ctime: 0:0
  mtime: 0:0
  dev: 0	ino: 0
  uid: 0	gid: 0
  size: 0	flags: 20004000


---
 t/t2203-add-intent.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index ec35409..fcc67c0 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -62,5 +62,27 @@ test_expect_success 'can "commit -a" with an i-t-a entry' '
 	git commit -a -m all
 '
 
+test_expect_success 'i-t-a status unaffected by write-tree' '
+	git reset --hard &&
+	mkdir dir &&
+	echo frotz >dir/bar &&
+	git add dir &&
+	git commit -m "establish dir" &&
+	echo fizfaz >foo &&
+	echo fragz >dir/baz &&
+	git add rezrov &&
+	git add -N foo &&
+	git add -N dir/baz &&
+	cat >expect <<-\EOF &&
+	AM dir/baz
+	AM foo
+	EOF
+	git status --untracked-files=no --porcelain >actual &&
+	test_cmp actual expect &&
+	git write-tree &&
+	git status --untracked-files=no --porcelain >actual &&
+	test_cmp actual expect
+'
+
 test_done
 
-- 
1.8.0



Jonathon Mah
me@JonathonMah.com
