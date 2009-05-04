From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv3] Add --reference option to git submodule.
Date: Mon, 4 May 2009 22:30:01 +0300
Message-ID: <20090504193001.GA13719@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 04 21:33:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M13uh-0003uy-VX
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 21:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbZEDTdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 15:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbZEDTdL
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 15:33:11 -0400
Received: from mx2.redhat.com ([66.187.237.31]:44157 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448AbZEDTdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 15:33:09 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n44JV3Js024890;
	Mon, 4 May 2009 15:31:03 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n44JV2K5011946;
	Mon, 4 May 2009 15:31:02 -0400
Received: from redhat.com (vpn-10-18.str.redhat.com [10.32.10.18])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n44JUvbd021014;
	Mon, 4 May 2009 15:30:59 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118258>

This adds --reference option to git submodule add and
git submodule update commands, which is passed to git clone.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I think it's ready now :) Comments?

Changes from v2: added test script, fixed update --reference with --init.

Changes from v1: fixes in documentation, fix test usage and
make it portable.

 Documentation/git-submodule.txt |   14 ++++++-
 git-submodule.sh                |   38 ++++++++++++++++--
 t/t7406-submodule-reference.sh  |   81 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 6 deletions(-)
 create mode 100755 t/t7406-submodule-reference.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3b8df44..14256c6 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,10 +9,12 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b branch] [--] <repository> <path>
+'git submodule' [--quiet] add [-b branch]
+	      [--reference <repository>] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--] [<path>...]
+'git submodule' [--quiet] update [--init] [-N|--no-fetch]
+	      [--reference <repository>] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
 'git submodule' [--quiet] sync [--] [<path>...]
@@ -177,6 +179,14 @@ OPTIONS
 	This option is only valid for the update command.
 	Don't fetch new objects from the remote site.
 
+--reference <repository>::
+	This option is only valid for add and update commands.  These
+	commands sometimes need to clone a remote repository. In this case,
+	this option will be passed to the linkgit:git-clone[1] command.
++
+*NOTE*: Do *not* use this option unless you have read the note
+for linkgit:git-clone[1]'s --reference and --shared options carefully.
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/git-submodule.sh b/git-submodule.sh
index 8e234a4..ab1ed02 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -15,6 +15,7 @@ require_work_tree
 command=
 branch=
 quiet=
+reference=
 cached=
 nofetch=
 
@@ -91,6 +92,7 @@ module_clone()
 {
 	path=$1
 	url=$2
+	reference="$3"
 
 	# If there already is a directory at the submodule path,
 	# expect it to be empty (since that is the default checkout
@@ -106,7 +108,12 @@ module_clone()
 	test -e "$path" &&
 	die "A file already exist at path '$path'"
 
-	git-clone -n "$url" "$path" ||
+	if test -n "$reference"
+	then
+		git-clone "$reference" -n "$url" "$path"
+	else
+		git-clone -n "$url" "$path"
+	fi ||
 	die "Clone of '$url' into submodule path '$path' failed"
 }
 
@@ -131,6 +138,15 @@ cmd_add()
 		-q|--quiet)
 			quiet=1
 			;;
+		--reference)
+			case "$2" in '') usage ;; esac
+			reference="--reference=$2"
+			shift
+			;;
+		--reference=*)
+			reference="$1"
+			shift
+			;;
 		--)
 			shift
 			break
@@ -203,7 +219,7 @@ cmd_add()
 		git config submodule."$path".url "$url"
 	else
 
-		module_clone "$path" "$realrepo" || exit
+		module_clone "$path" "$realrepo" "$reference" || exit
 		(
 			unset GIT_DIR
 			cd "$path" &&
@@ -314,13 +330,22 @@ cmd_update()
 			quiet=1
 			;;
 		-i|--init)
+			init=1
 			shift
-			cmd_init "$@" || return
 			;;
 		-N|--no-fetch)
 			shift
 			nofetch=1
 			;;
+		--reference)
+			case "$2" in '') usage ;; esac
+			reference="--reference=$2"
+			shift 2
+			;;
+		--reference=*)
+			reference="$1"
+			shift
+			;;
 		--)
 			shift
 			break
@@ -334,6 +359,11 @@ cmd_update()
 		esac
 	done
 
+	if test -n "$init"
+	then
+		cmd_init "--" "$@" || return
+	fi
+
 	module_list "$@" |
 	while read mode sha1 stage path
 	do
@@ -351,7 +381,7 @@ cmd_update()
 
 		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
-			module_clone "$path" "$url" || exit
+			module_clone "$path" "$url" "$reference"|| exit
 			subsha1=
 		else
 			subsha1=$(unset GIT_DIR; cd "$path" &&
diff --git a/t/t7406-submodule-reference.sh b/t/t7406-submodule-reference.sh
new file mode 100755
index 0000000..cc16d3f
--- /dev/null
+++ b/t/t7406-submodule-reference.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+#
+# Copyright (c) 2009, Red Hat Inc, Author: Michael S. Tsirkin (mst@redhat.com)
+#
+
+test_description='test clone --reference'
+. ./test-lib.sh
+
+base_dir=`pwd`
+
+U=$base_dir/UPLOAD_LOG
+
+test_expect_success 'preparing first repository' \
+'test_create_repo A && cd A &&
+echo first > file1 &&
+git add file1 &&
+git commit -m A-initial'
+
+cd "$base_dir"
+
+test_expect_success 'preparing second repository' \
+'git clone A B && cd B &&
+echo second > file2 &&
+git add file2 &&
+git commit -m B-addition &&
+git repack -a -d &&
+git prune'
+
+cd "$base_dir"
+
+test_expect_success 'preparing supermodule' \
+'test_create_repo super && cd super &&
+echo file > file &&
+git add file &&
+git commit -m B-super-initial'
+
+cd "$base_dir"
+
+test_expect_success 'submodule add --reference' \
+'cd super && git submodule add --reference ../B "file://$base_dir/A" sub &&
+git commit -m B-super-added'
+
+cd "$base_dir"
+
+test_expect_success 'after add: existence of info/alternates' \
+'test `wc -l <super/sub/.git/objects/info/alternates` = 1'
+
+cd "$base_dir"
+
+test_expect_success 'that reference gets used with add' \
+'cd super/sub &&
+echo "0 objects, 0 kilobytes" > expected &&
+git count-objects > current &&
+diff expected current'
+
+cd "$base_dir"
+
+test_expect_success 'cloning supermodule' \
+'git clone super super-clone'
+
+cd "$base_dir"
+
+test_expect_success 'update with reference' \
+'cd super-clone && git submodule update --init --reference ../B'
+
+cd "$base_dir"
+
+test_expect_success 'after update: existence of info/alternates' \
+'test `wc -l <super-clone/sub/.git/objects/info/alternates` = 1'
+
+cd "$base_dir"
+
+test_expect_success 'that reference gets used with update' \
+'cd super-clone/sub &&
+echo "0 objects, 0 kilobytes" > expected &&
+git count-objects > current &&
+diff expected current'
+
+cd "$base_dir"
+
+test_done
-- 
1.6.3.rc3.1.g830204
