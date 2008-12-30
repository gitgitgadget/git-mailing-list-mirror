From: Jason Riedy <jason@acm.org>
Subject: [PATCH] Pass --upload-pack and --receive-pack through submodules.
Date: Tue, 30 Dec 2008 10:09:42 -0500
Message-ID: <1230649782-14710-1-git-send-email-jason@acm.org>
References: <1230605055-30723-1-git-send-email-jason@acm.org>
Cc: Jason Riedy <jason@acm.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 16:11:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHgFd-0005cn-3x
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 16:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbYL3PJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 10:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbYL3PJ7
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 10:09:59 -0500
Received: from a.mail.sonic.net ([64.142.16.245]:44721 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbYL3PJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 10:09:58 -0500
Received: from localhost.localdomain (misc-148-78-88-138.pool.starband.net [148.78.88.138])
	(authenticated bits=0)
	by a.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id mBUF9lL3004033;
	Tue, 30 Dec 2008 07:09:50 -0800
X-Mailer: git-send-email 1.6.1.60.g1f086.dirty
In-Reply-To: <1230605055-30723-1-git-send-email-jason@acm.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104188>

While I no longer have to worry about a zillion ancient OS versions,
I now have to worry about a remote site where I cannot control the
path for non-interactive shells.  Thus, submodules need to handle
explicitly specified git-upload-pack and git-receive-pack programs.

There may be a fun shell quoting dance to avoid the extra conditionals.
Any such dance would be even more confusing to read.

Signed-off-by: Jason Riedy <jason@acm.org>
---
  Sorry; I forgot the documentation patch last time.  And it might be
  better just to copy the entire submodule config directly to the remote
  section...

 Documentation/git-submodule.txt |   15 +++++++-
 Documentation/gitmodules.txt    |   13 ++++++-
 git-submodule.sh                |   81 +++++++++++++++++++++++++++++++++++++--
 t/t7404-submodule-packbin.sh    |   53 +++++++++++++++++++++++++
 4 files changed, 156 insertions(+), 6 deletions(-)
 create mode 100755 t/t7404-submodule-packbin.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2f207fb..9e2de16 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b branch] [--] <repository> <path>
+'git submodule' [--quiet] add [-b branch] [-u <git-upload-pack>] [--receive-pack <git-receive-pack>] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [--] [<path>...]
@@ -159,6 +159,19 @@ OPTIONS
 --branch::
 	Branch of repository to add as submodule.
 
+--upload-pack <upload-pack>::
+-u <upload-pack>::
+	When given, and the repository to clone from is accessed
+	via ssh, this specifies a non-default path for the
+	'git-upload-pack' program on the remote end.  See
+	linkgit:git-fetch-pack[1].
+
+--receive-pack <receive-pack>::
+	When given, and the repository to clone from is accessed
+	via ssh, this specifies a non-default path for the
+	'git-receive-pack' program on the remote end.  See
+	linkgit:git-push[1].
+
 --cached::
 	This option is only valid for status and summary commands.  These
 	commands typically use the commit found in the submodule HEAD, but
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index d1a17e2..3387951 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -30,6 +30,13 @@ submodule.<name>.path::
 submodule.<name>.url::
 	Defines an url from where the submodule repository can be cloned.
 
+submodule.<name>.receivepack::
+	The default program to execute on the remote side when pushing.  See
+	option \--receive-pack of linkgit:git-push[1].
+
+submodule.<name>.uploadpack::
+	The default program to execute on the remote side when fetching.  See
+	option \--upload-pack of linkgit:git-fetch-pack[1].
 
 EXAMPLES
 --------
@@ -42,12 +49,16 @@ Consider the following .gitmodules file:
 
 	[submodule "libbar"]
 		path = include/bar
-		url = git://bar.com/git/lib.git
+		url = ssh://bar.com/~/git/lib.git
+		uploadpack = /home/you/bin/git-upload-pack-wrapper
+		receivepack = /home/you/bin/git-receive-pack-wrapper
 
 
 This defines two submodules, `libfoo` and `libbar`. These are expected to
 be checked out in the paths 'include/foo' and 'include/bar', and for both
 submodules an url is specified which can be used for cloning the submodules.
+For `libbar`, packs are retrieved and stored via the upload and receive
+wrappers, respectively.
 
 SEE ALSO
 --------
diff --git a/git-submodule.sh b/git-submodule.sh
index 2f47e06..1a8a968 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -90,6 +90,8 @@ module_clone()
 {
 	path=$1
 	url=$2
+	uploadpack=$3
+	receivepack=$4
 
 	# If there already is a directory at the submodule path,
 	# expect it to be empty (since that is the default checkout
@@ -105,8 +107,23 @@ module_clone()
 	test -e "$path" &&
 	die "A file already exist at path '$path'"
 
-	git-clone -n "$url" "$path" ||
+	if test "$uploadpack"
+	then
+	    git-clone --upload-pack $uploadpack -n "$url" "$path"
+	else
+	    git-clone -n "$url" "$path"
+	fi ||
 	die "Clone of '$url' into submodule path '$path' failed"
+	if test "$uploadpack"
+	then
+	    git config -f "${path}/.git/config" remote.origin.uploadpack "$uploadpack" ||
+	    echo "  Warn: Failed to set uploadpack for '$url' in submodule path '$path'."
+	fi
+	if test "$receivepack"
+	then
+	    git config -f "${path}/.git/config" remote.origin.receivepack "$receivepack" ||
+	    echo "  Warn: Failed to set receivepack for '$url' in submodule path '$path'."
+	fi
 }
 
 #
@@ -130,6 +147,16 @@ cmd_add()
 		-q|--quiet)
 			quiet=1
 			;;
+		-u|--upload-pack)
+			case "$2" in '') usage ;; esac
+			uploadpack=$2
+			shift
+			;;
+		--receive-pack)
+			case "$2" in '') usage ;; esac
+			receivepack=$2
+			shift
+			;;
 		--)
 			shift
 			break
@@ -191,9 +218,17 @@ cmd_add()
 			;;
 		esac
 		git config submodule."$path".url "$url"
+		if test "$uploadpack"
+		then
+		    git config submodule."$path".uploadpack "$uploadpack"
+		fi
+		if test "$receivepack"
+		then
+		    git config submodule."$path".receivepack "$receivepack"
+		fi
 	else
 
-		module_clone "$path" "$realrepo" || exit
+		module_clone "$path" "$realrepo" "$uploadpack" "$receivepack" || exit
 		(unset GIT_DIR; cd "$path" && git checkout -f -q ${branch:+-b "$branch" "origin/$branch"}) ||
 		die "Unable to checkout submodule '$path'"
 	fi
@@ -202,7 +237,19 @@ cmd_add()
 	die "Failed to add submodule '$path'"
 
 	git config -f .gitmodules submodule."$path".path "$path" &&
-	git config -f .gitmodules submodule."$path".url "$repo" &&
+	git config -f .gitmodules submodule."$path".url "$repo" ||
+	die "Failed to register submodule '$path'"
+
+	if test "$uploadpack"
+        then
+	    git config -f .gitmodules submodule."$path".uploadpack "$uploadpack" ||
+	    die "Failed to register submodule '$path'"
+	fi
+	if test "$receivepack"
+        then
+	    git config -f .gitmodules submodule."$path".receivepack "$receivepack" ||
+	    die "Failed to register submodule '$path'"
+	fi
 	git add .gitmodules ||
 	die "Failed to register submodule '$path'"
 }
@@ -277,6 +324,19 @@ cmd_init()
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
+		uploadpack=$(git config -f .gitmodules submodule."$name".uploadpack)
+		receivepack=$(git config -f .gitmodules submodule."$name".receivepack)
+		if test "$uploadpack"
+		then
+		    git config submodule."$name".uploadpack "$uploadpack" ||
+		    echo "  Warn: Failed to set uploadpack for '$url' in submodule path '$path'."
+		fi
+		if test "$receivepack"
+		then
+		    git config submodule."$name".receivepack "$receivepack" ||
+		    echo "  Warn: Failed to set receivepack for '$url' in submodule path '$path'."
+		fi
+
 		say "Submodule '$name' ($url) registered for path '$path'"
 	done
 }
@@ -330,7 +390,8 @@ cmd_update()
 
 		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
-			module_clone "$path" "$url" || exit
+			module_clone "$path" "$url" "$(git config submodule."$name".uploadpack)" \
+			    "$(git config submodule."$name".receivepack)" || exit
 			subsha1=
 		else
 			subsha1=$(unset GIT_DIR; cd "$path" &&
@@ -655,6 +716,18 @@ cmd_sync()
 			remote=$(get_default_remote)
 			say "Synchronizing submodule url for '$name'"
 			git config remote."$remote".url "$url"
+			uploadpack=$(git config -f .gitmodules submodule."$name".uploadpack)
+			receivepack=$(git config -f .gitmodules submodule."$name".receivepack)
+			if test "$uploadpack"
+			then
+			    git config submodule."$name".uploadpack "$uploadpack" ||
+			    echo "  Warn: Failed to set uploadpack for '$url' in submodule path '$name'."
+			fi
+			if test "$receivepack"
+			then
+			    git config submodule."$name".receivepack "$receivepack" ||
+			    echo "  Warn: Failed to set receivepack for '$url' in submodule path '$name'."
+			fi
 		)
 		fi
 	done
diff --git a/t/t7404-submodule-packbin.sh b/t/t7404-submodule-packbin.sh
new file mode 100755
index 0000000..d46b3e6
--- /dev/null
+++ b/t/t7404-submodule-packbin.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 E. Jason Riedy
+#
+
+test_description='git submodule with explicit pack programs
+
+These tests exercise git submodule with --upload-pack and --receive-pack arguments.
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo file > file &&
+	git add file &&
+	test_tick &&
+	git commit -m upstream
+	git clone . super &&
+	git clone super submodule &&
+	(cd super &&
+	 git submodule add --upload-pack "${GIT_EXEC_PATH}/git-upload-pack" --receive-pack "${GIT_EXEC_PATH}/git-receive-pack" ../submodule submodule &&
+	 test_tick &&
+	 git commit -m "submodule"
+	) &&
+	git clone super super-clone &&
+	(cd super-clone && git submodule update --init)
+'
+
+test_expect_success 'push submodule change' '
+	(cd super &&
+         cd submodule &&
+         git checkout master &&
+	 echo second line >> file &&
+	 test_tick &&
+	 git commit -a -m "change submodule inside" &&
+         git push origin +master:pushed
+	)
+'
+
+test_expect_success 'pull submodule change' '
+	(cd submodule &&
+         git pull . pushed &&
+	 echo second line >> file &&
+	 test_tick &&
+	 git commit -a -m "change submodule outside"
+	) &&
+        (cd super &&
+         cd submodule &&
+         git pull origin master
+        )
+'
+
+test_done
-- 
1.6.1.60.g1f086.dirty
