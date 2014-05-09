From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/17] contrib: remove 'workdir'
Date: Fri,  9 May 2014 14:11:37 -0500
Message-ID: <1399662703-355-12-git-send-email-felipe.contreras@gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:12:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqDu-0001jz-85
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239AbaEITMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:12:34 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:34897 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207AbaEITMd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:12:33 -0400
Received: by mail-yh0-f43.google.com with SMTP id f10so4136321yha.30
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JHbOgifmd0JHy2lHfkhUKPL3LrI4wS9dm8C79D5m308=;
        b=SNIo9tc0l9jZatugA5+/ZV0GaeoSR5HiNWjbt+udTAiS3orlW0sz/TWBeyB4643b8F
         RZCIWMgSmKGoKLjIINFJovyXNPhmsBxuJG24PeidNjP/+jZG3y89G59n247SB67NWTK5
         nrkvwy+19BebnyAdYgkR+GUf6KyIDZfyCqOuH0n7awws8Zbnynsq1lnDEqmd0UsZQyrp
         UCfvq0uPJkhkUyaDNlYPjj7ochxEBvjvhX91mYJcOqe5riqDGRRlgJ4hwmb2TAV0LAsg
         nE67tMPuQZFoR3/Q8AYgY3gWD2qPNTBgkp7nATSiS9pvrxYaECRn1QfH+yn0U5PhD07i
         NM+g==
X-Received: by 10.236.32.178 with SMTP id o38mr17677750yha.119.1399662752471;
        Fri, 09 May 2014 12:12:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id u21sm7399372yhb.51.2014.05.09.12.12.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:12:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
In-Reply-To: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248623>

No activity since 2010, no documentation, no tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/workdir/git-new-workdir | 82 -----------------------------------------
 1 file changed, 82 deletions(-)
 delete mode 100755 contrib/workdir/git-new-workdir

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
deleted file mode 100755
index 75e8b25..0000000
--- a/contrib/workdir/git-new-workdir
+++ /dev/null
@@ -1,82 +0,0 @@
-#!/bin/sh
-
-usage () {
-	echo "usage:" $@
-	exit 127
-}
-
-die () {
-	echo $@
-	exit 128
-}
-
-if test $# -lt 2 || test $# -gt 3
-then
-	usage "$0 <repository> <new_workdir> [<branch>]"
-fi
-
-orig_git=$1
-new_workdir=$2
-branch=$3
-
-# want to make sure that what is pointed to has a .git directory ...
-git_dir=$(cd "$orig_git" 2>/dev/null &&
-  git rev-parse --git-dir 2>/dev/null) ||
-  die "Not a git repository: \"$orig_git\""
-
-case "$git_dir" in
-.git)
-	git_dir="$orig_git/.git"
-	;;
-.)
-	git_dir=$orig_git
-	;;
-esac
-
-# don't link to a configured bare repository
-isbare=$(git --git-dir="$git_dir" config --bool --get core.bare)
-if test ztrue = z$isbare
-then
-	die "\"$git_dir\" has core.bare set to true," \
-		" remove from \"$git_dir/config\" to use $0"
-fi
-
-# don't link to a workdir
-if test -h "$git_dir/config"
-then
-	die "\"$orig_git\" is a working directory only, please specify" \
-		"a complete repository."
-fi
-
-# don't recreate a workdir over an existing repository
-if test -e "$new_workdir"
-then
-	die "destination directory '$new_workdir' already exists."
-fi
-
-# make sure the links use full paths
-git_dir=$(cd "$git_dir"; pwd)
-
-# create the workdir
-mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!"
-
-# create the links to the original repo.  explicitly exclude index, HEAD and
-# logs/HEAD from the list since they are purely related to the current working
-# directory, and should not be shared.
-for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
-do
-	case $x in
-	*/*)
-		mkdir -p "$(dirname "$new_workdir/.git/$x")"
-		;;
-	esac
-	ln -s "$git_dir/$x" "$new_workdir/.git/$x"
-done
-
-# now setup the workdir
-cd "$new_workdir"
-# copy the HEAD from the original repository as a default branch
-cp "$git_dir/HEAD" .git/HEAD
-# checkout the branch (either the same as HEAD from the original repository, or
-# the one that was asked for)
-git checkout -f $branch
-- 
1.9.2+fc1.28.g12374c0
