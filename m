From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 05/19] A number of changes to push_all and pull_all:
Date: Sat, 9 Mar 2013 19:24:36 +0000
Message-ID: <CALeLG_=D7PYhUdCqo=z7-Ss-UirnwhZconPR=Pp5Q4iBuX6Q1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:25:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPOB-0000GC-On
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145Ab3CITYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:24:37 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:50842 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CITYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:24:37 -0500
Received: by mail-ob0-f177.google.com with SMTP id eh20so2193487obb.22
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=UkE/NVucSAxHewpuckpgC+R3BJc1IhXDmEt+CeNDG7Y=;
        b=lWqu1TM0Y1pzx3B8aHV9ND2/wTLOOXxtCW8ifHKrZnGVPBHqaW9Xh31m3KVf6nmo1C
         mb2whUQkYHNHDsNVvhIfvH1Qvf5XioKvP6V2gcc+Tis83eT1Y9tRjam5pAbBDTcOm2tD
         qOqktRjQhcJXKBRFHTWwTdviXz/gXVQN00m2kWdheAe0ZTShund35xPRq0g3IsshlFAX
         a1GmOkxR9rny7i7/azBIRP+v2b9sNnicHUn8A7wKZEvXyE1+qjVCib1RYo/IZLMQeh6c
         R8NeMMg78lzx0iXEQ8TTsv8TsyCJldU+VPtOUCQOofp9H6VCxlN0LGwhg3tEg4wuiBWF
         m0kw==
X-Received: by 10.60.20.193 with SMTP id p1mr5173395oee.133.1362857076646;
 Sat, 09 Mar 2013 11:24:36 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:24:36 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQmP4MR95b10xqsT1ObZePN+PtOEViKOT4w90EdfOHf3jtYBr8+1FwhCDsZAO8UdAvjs+U0r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217742>

>From 10f2260165d6be3a6ab477ed38fd8ab0308c11e6 Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:31:59 +0000
Subject: [PATCH 05/19] A number of changes to push_all and pull_all:

* adding commands in "add" to populate the .gittrees file
* changing underscores to dashes (push_all -> push-all)
* changing commands to not be hardcoded to branch "master" from remote
* letting the user specify 0, 1, or 2 arguments to push and pull, like
normal "git push" and "git pull".  We'll try to look up missing
information from .gittrees, like git normally does from .git/config

Conflicts:
	.gitignore
	contrib/subtree/git-subtree.sh

Original-Author: mhoffman <matt.hoffman@quantumretail.com>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 57 ++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index c3b1208..74e4c74 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -12,7 +12,8 @@ git subtree add   --prefix=<prefix> <commit>
 git subtree add   --prefix=<prefix> <repository> <commit>
 git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <refspec...>
-git subtree pull_all
+git subtree pull-all
+git subtree push-all
 git subtree push  --prefix=<prefix> <repository> <refspec...>
 git subtree split --prefix=<prefix> <commit...>
 git subtree from-submodule --prefix=<prefix>
@@ -103,18 +104,18 @@ done
 command="$1"
 shift
 case "$command" in
-	add|merge|pull|from-submodule|pull_all|push_all) default= ;;
+	add|merge|pull|from-submodule|pull-all|push-all) default= ;;
 	split|push) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
 esac

-if [ -z "$prefix" -a "$command" != "pull_all" -a "$command" !=
"push_all" ]; then
+if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" !=
"push-all" ]; then
 	die "You must provide the --prefix option."
 fi

 case "$command" in
-    pull_all);;
-    push_all);;
+    pull-all);;
+    push-all);;
 	add) [ -e "$prefix" ] &&
 		die "prefix '$prefix' already exists." ;;
 	*)   [ -e "$prefix" ] ||
@@ -123,7 +124,7 @@ esac

 dir="$(dirname "$prefix/.")"

-if [ "$command" != "pull" -a "$command" != "add" -a "$command" !=
"push" -a "$command" != "pull_all" ]; then
+if [ "$command" != "pull" -a "$command" != "add" -a "$command" !=
"push" -a "$command" != "pull-all" ]; then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs="$(git rev-parse --no-revs --no-flags "$@")" || exit $?
 	if [ -n "$dirs" ]; then
@@ -531,6 +532,14 @@ cmd_add_repository()
 	revs=FETCH_HEAD
 	set -- $revs
 	cmd_add_commit "$@"
+
+  # now add it to our list of repos
+  git config -f .gittrees --unset subtree.$dir.url
+  git config -f .gittrees --add subtree.$dir.url $repository
+  git config -f .gittrees --unset subtree.$dir.path
+  git config -f .gittrees --add subtree.$dir.path $dir
+  git config -f .gittrees --unset subtree.$dir.branch
+  git config -f .gittrees --add subtree.$dir.branch $refspec
 }

 cmd_add_commit()
@@ -704,13 +713,21 @@ cmd_merge()

 cmd_pull()
 {
-    if [ $# -ne 1 ]; then
-	    die "You must provide <branch>"
+  if [ $# -gt 2 ]; then
+	    die "You should provide either <refspec> or <repository> <refspec>"
 	fi
 	if [ -e "$dir" ]; then
 	    ensure_clean
-	    repository=$(git config -f .gittrees subtree.$prefix.url)
-	    refspec=$1
+      if [ $# -eq 1 ]; then
+	      repository=$(git config -f .gittrees subtree.$prefix.url)
+	      refspec=$1
+      elif [ $# -eq 2 ]; then
+        repository=$1
+        refspec=$2
+      else
+	      repository=$(git config -f .gittrees subtree.$prefix.url)
+        refspec=$(git config -f .gittrees subtree.$prefix.branch)
+      fi
 	    git fetch $repository $refspec || exit $?
 	    echo "git fetch using: " $repository $refspec
 	    revs=FETCH_HEAD
@@ -723,12 +740,20 @@ cmd_pull()

 cmd_push()
 {
-	if [ $# -ne 1 ]; then
-	    die "You must provide <branch>"
+	if [ $# -gt 2 ]; then
+	    die "You shold provide either <refspec> or <repository> <refspec>"
 	fi
 	if [ -e "$dir" ]; then
-	    repository=$(git config -f .gittrees subtree.$prefix.url)
-	    refspec=$1
+      if [ $# -eq 1 ]; then
+	      repository=$(git config -f .gittrees subtree.$prefix.url)
+        refspec=$1
+      elif [ $# -eq 2 ]; then
+        repository=$1
+        refspec=$2
+      else
+	      repository=$(git config -f .gittrees subtree.$prefix.url)
+        refspec=$(git config -f .gittrees subtree.$prefix.branch)
+      fi
 	    echo "git push using: " $repository $refspec
 	    git push $repository $(git subtree split
--prefix=$prefix):refs/heads/$refspec
 	else
@@ -763,7 +788,7 @@ cmd_from-submodule()
 	rm -rf $tmp_repo
 }

-cmd_pull_all()
+cmd_pull-all()
 {
     git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
         while read path; do
@@ -771,7 +796,7 @@ cmd_pull_all()
         done
 }

-cmd_push_all()
+cmd_push-all()
 {
     git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
         while read path; do
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
