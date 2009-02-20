From: Heiko Voigt <git-list@hvoigt.net>
Subject: [RFC PATCH] hooks: add some defaults to support sane workflow to
 pre-commit
Date: Fri, 20 Feb 2009 19:13:10 +0100
Message-ID: <499EF2B6.7060103@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 19:21:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laa06-0001Wz-Ua
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 19:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbZBTSTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 13:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbZBTSTz
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 13:19:55 -0500
Received: from darksea.de ([83.133.111.250]:54288 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbZBTSTy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 13:19:54 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Feb 2009 13:19:53 EST
Received: (qmail 4229 invoked from network); 20 Feb 2009 19:12:59 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 20 Feb 2009 19:12:59 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110874>

It sometimes happens that you move to a new machine and forget to setup your
name and email address. To find this out after 10 commits can be quite
frustrating.

As far as I know all "sane" workflows involve topic branches, so
normally a developer will never commit directly on master but use topic
branch instead and merge them into master once finished.

One thing which could be dangerous is if you clone a project containing
submodules. If you would immediately start working in a submodule you
would create commits with detached head. This can be a dangerous operation
in terms of loosing commits and should be forbidden by default.

Signed-off-by: Heiko Voigt <git-list@hvoigt.net>
---

I also would like to vote for enabling some hooks by default. 

 templates/hooks--pre-commit.sample |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 0e49279..6360da0 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -16,3 +16,26 @@ else
 fi
 
 exec git diff-index --check --cached $against --
+
+# check if username and email are setup
+if [ -z "$(git config --global user.name)" ]; then
+    echo "Please set your name and email address"
+    exit 1
+fi
+if [ -z "$(git config --global user.email)" ]; then
+    echo "Please set your name and email address"
+    exit 1
+fi
+
+# work should always be done on a feature branch
+if git branch | grep "^* master" > /dev/null; then
+    echo "No commits on master, please !"
+    exit 1
+fi
+
+# do not allow commits on detached head
+if git branch | grep "^* (no branch)" > /dev/null; then
+    echo "Commit on detached HEAD is dangerous !"
+    echo "Please checkout a branch first ..."
+    exit 1
+fi
-- 
1.6.1.2.390.gba743
