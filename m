From: Ben Woosley <Ben.Woosley@gmail.com>
Subject: [PATCH] Update git-p4 to be compatible with git-lfs 1.2
Date: Wed, 20 Apr 2016 18:28:34 +0000
Message-ID: <0102015434ee502d-d91a9a46-299f-47b0-a583-104b540200bc-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 20:28:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aswrj-0006IM-Qi
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 20:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbcDTS2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 14:28:37 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:53674
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751824AbcDTS2g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 14:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1461176914;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=D19ol9npfcQvdTd4W2rXyVwWcuF7DhsRM6aLwuteW3w=;
	b=VgC3Ici+V+Yqml1OWH7ipf7YqODOM8p5eS+o57C2n1AuH9PZAnNvCIkErwD9zvwj
	S4IPpXHBRPXs2p2PhQMtWBK1q5ap+CDkzqUy+WTkrtCtqk7GzZEocGuaqg+DHbMxzP5
	j/CrgiE7EApo41AKQpJhRF1u+kAmAhAcoDOYCItw=
X-SES-Outgoing: 2016.04.20-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292052>

From: Ben Woosley <ben.woosley@gmail.com>

The git lfs pointer output was changed in:
https://github.com/github/git-lfs/pull/1105

This was causing Mac Travis runs to fail, as homebrew had updated to 1.2
while Linux was pinned at 1.1 via GIT_LFS_VERSION.

The travis builds against 1.1 and 1.2 both on linux. Mac can't do the same as
it takes the latest homebrew version regardless.
---
 .travis.yml | 9 ++++++++-
 git-p4.py   | 7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 78e433b..71510ee 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -23,7 +23,6 @@ env:
   global:
     - DEVELOPER=1
     - P4_VERSION="15.2"
-    - GIT_LFS_VERSION="1.1.0"
     - DEFAULT_TEST_TARGET=prove
     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
     - GIT_TEST_OPTS="--verbose --tee"
@@ -31,6 +30,14 @@ env:
     # t9810 occasionally fails on Travis CI OS X
     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
     - GIT_SKIP_TESTS="t9810 t9816"
+  matrix:
+    - GIT_LFS_VERSION="1.2.0"
+    - GIT_LFS_VERSION="1.1.0"
+
+matrix:
+  exclude:
+    - os: osx
+      env: GIT_LFS_VERSION="1.1.0"
 
 before_install:
   - >
diff --git a/git-p4.py b/git-p4.py
index 527d44b..6c06d17 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1064,7 +1064,12 @@ def generatePointer(self, contentFile):
         if pointerProcess.wait():
             os.remove(contentFile)
             die('git-lfs pointer command failed. Did you install the extension?')
-        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
+        pointerLines = pointerFile.split('\n')
+        # In git-lfs < 1.2, the pointer output included some extraneous information
+        # this was removed in https://github.com/github/git-lfs/pull/1105
+        if pointerLines[0].startswith('Git LFS pointer for'):
+            pointerLines = pointerLines[2:]
+        pointerContents = [i+'\n' for i in pointerLines[:-1]]
         oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
         localLargeFile = os.path.join(
             os.getcwd(),

--
https://github.com/git/git/pull/231
