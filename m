From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] git-tag: add flag to verify a tag
Date: Wed, 03 Jan 2007 13:59:00 +0100
Message-ID: <877iw4tgff.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 03 13:58:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H25h6-0000DV-NP
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 13:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbXACM6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 07:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbXACM6H
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 07:58:07 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:52229 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbXACM6G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 07:58:06 -0500
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 07:58:05 EST
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l03Cw2l24504
	for <git@vger.kernel.org>; Wed, 3 Jan 2007 13:58:04 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35861>


This way "git tag -v $tag" is the UI for git-verify-tag.
---
 Documentation/git-tag.txt |    7 ++++++-
 generate-cmdlist.sh       |    1 -
 git-tag.sh                |   10 +++++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 48b82b8..80bece0 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,7 +9,7 @@ git-tag - Create a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git-tag' [-a | -s | -u <key-id>] [-f | -d] [-m <msg> | -F <file>]
+'git-tag' [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg> | -F <file>]
 	 <name> [<head>]
 'git-tag' -l [<pattern>]
 
@@ -35,6 +35,8 @@ GnuPG key for signing.
 
 `-d <tag>` deletes the tag.
 
+`-v <tag>` verifies the gpg signature of the tag.
+
 `-l <pattern>` lists tags that match the given pattern (or all
 if no pattern is given).
 
@@ -55,6 +57,9 @@ OPTIONS
 -d::
 	Delete an existing tag with the given name
 
+-v::
+	Verify the gpg signature of given the tag
+
 -l <pattern>::
 	List tags that match the given pattern (or all if no pattern is given).
 
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 06c42b0..1de14ea 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -37,7 +37,6 @@ show
 show-branch
 status
 tag
-verify-tag
 EOF
 while read cmd
 do
diff --git a/git-tag.sh b/git-tag.sh
index e1bfa82..c9e1180 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2005 Linus Torvalds
 
-USAGE='-l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <tagname> [<head>]'
+USAGE='-l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg>] <tagname> [<head>]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
@@ -12,6 +12,7 @@ force=
 message=
 username=
 list=
+verify=
 while case "$#" in 0) break ;; esac
 do
     case "$1" in
@@ -69,6 +70,13 @@ do
 		echo "Deleted tag $tag_name."
 	exit $?
 	;;
+    -v)
+	shift
+	tag_name="$1"
+	tag=$(git-show-ref --verify --hash -- "refs/tags/$tag_name") ||
+		die "Seriously, what tag are you talking about?"
+	git-verify-tag -v "$tag"
+	exit $?
     -*)
         usage
 	;;
-- 
1.5.0.rc0.g91ea
