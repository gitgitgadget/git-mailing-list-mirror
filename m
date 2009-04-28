From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] Add --reference option to git submodule
Date: Tue, 28 Apr 2009 09:52:37 +0300
Message-ID: <20090428065237.GA5972@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 08:53:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyhCR-0005Pp-OM
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 08:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759850AbZD1Gxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 02:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759694AbZD1Gxl
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 02:53:41 -0400
Received: from mx2.redhat.com ([66.187.237.31]:48653 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759838AbZD1Gxk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 02:53:40 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n3S6rdV5023316;
	Tue, 28 Apr 2009 02:53:39 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n3S6rcth016845;
	Tue, 28 Apr 2009 02:53:39 -0400
Received: from redhat.com (vpn-10-64.str.redhat.com [10.32.10.64])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n3S6ra4c030488;
	Tue, 28 Apr 2009 02:53:37 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117747>

This adds --reference option to 'git submodule add' and
'git submodule update' commands, which is passed on to git clone.
This option is useful when the submodule is large, such as linux kernel.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I noticed that there's no easy way to specify a reference
for submodule repositories. Here's a patch to add this option.

 Documentation/git-submodule.txt |   14 ++++++++++++--
 git-submodule.sh                |   31 ++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3b8df44..0584cb7 100644
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
+	this option will be passed to linkgit:git-clone[1] command.
++
+*NOTE*: Do *not* use this option unless you have read the note
+for linkgit:git-clone[1] --reference and --shared options carefully.
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/git-submodule.sh b/git-submodule.sh
index 8e234a4..32be246 100755
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
+	if test "reference"
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
@@ -321,6 +337,15 @@ cmd_update()
 			shift
 			nofetch=1
 			;;
+		--reference)
+			case "$2" in '') usage ;; esac
+			reference="$2"
+			shift 2
+			;;
+		--reference=*)
+			reference="$1"
+			shift
+			;;
 		--)
 			shift
 			break
@@ -351,7 +376,7 @@ cmd_update()
 
 		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
-			module_clone "$path" "$url" || exit
+			module_clone "$path" "$url" "$reference"|| exit
 			subsha1=
 		else
 			subsha1=$(unset GIT_DIR; cd "$path" &&
-- 
1.6.3.rc3.dirty
