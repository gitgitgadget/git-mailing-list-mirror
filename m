From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] templates: make example pre-commit hook verify submodule commits exist
Date: Mon, 4 May 2009 15:32:29 +1200
Message-ID: <E1M0oxK-0002uG-RT@mail1.catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 05:35:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0oxh-0001wp-I8
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 05:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbZEDDfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 23:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbZEDDfJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 23:35:09 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:60635 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbZEDDfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 23:35:08 -0400
Received: from samv by mail1.catalyst.net.nz with local (Exim 4.63)
	(envelope-from <samv@catalyst.net.nz>)
	id 1M0oxK-0002uG-RT
	for git@vger.kernel.org; Mon, 04 May 2009 15:35:02 +1200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118202>

With submodules it can be quite easy to end up with a situation where the
version in the supermodule doesn't exist in the submodule.  Add to the
example pre-commit hook a script which checks before every commit whether
the submodule commit is likely to exist at the URL defined in the
.gitmodules file.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 This should be useful for those using submodules.  Perhaps it should also
 have an equivalent in the 'git submodule' command.

 templates/hooks--pre-commit.sample |   56 +++++++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 0e49279..26e7cf2 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -7,7 +7,61 @@
 #
 # To enable this hook, rename this file to "pre-commit".
 
-if git-rev-parse --verify HEAD 2>/dev/null
+# first, check that all submodule commits are available by a remote
+# which has the same URL as the one they are listed in.
+if [ -n "$GIT_WORK_TREE" ]
+then
+	cd "$GIT_WORK_TREE"
+fi
+
+git ls-tree $(git write-tree) | grep commit |
+while read mode type sha1 submodule
+do
+	module=$(GIT_CONFIG=.gitmodules git config --list |
+		grep '\.path='"$submodule"\$ |
+		sed 's/submodule\.\([^\.]*\)\..*/\1/')
+	if [ -z "$module" ]
+	then
+		echo "path $submodule is a submodule, but is not" \
+			"listed in .gitmodules" >&2
+		exit 1
+	fi
+	submodule_url=$(GIT_CONFIG=.gitmodules git config \
+		submodule.$submodule.url)
+
+	remotes=$(GIT_DIR=$submodule/.git git config --list |
+		grep '^remote\..*\.url='"$submodule_url" |
+		sed 's/remote\.\([^\.]*\)\..*/\1/')
+
+	found=
+	for remote in $remotes
+	do
+		found=$(GIT_DIR=$submodule/.git git name-rev \
+			--refs=refs/remotes/$remote/* $sha1 2>/dev/null |
+			grep -vw undefined)
+		[ -n "$found" ] && break
+	done
+
+	if [ -z "$found" ]
+	then
+		echo "submodule commit does not appear under tracked remote refs" >&2
+		echo "  submodule = $submodule"
+		echo ".gitmodules = $module"
+		echo "        url = $submodule_url"
+		echo "     commit = $sha1"
+		echo "  tried remotes:" $remotes
+		exit 2
+	fi
+done
+
+# this is the return code of the | while sub-shell above
+rc=$?
+if [ $rc -ne 0 ]
+then
+	exit $rc
+fi
+
+if git-rev-parse --verify HEAD >/dev/null 2>&1
 then
 	against=HEAD
 else
-- 
1.6.0
