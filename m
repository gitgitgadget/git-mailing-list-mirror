From: Craig Silverstein <csilvers.mail@gmail.com>
Subject: [PATCH] git-new-workdir: support submodules
Date: Mon, 22 Dec 2014 18:10:27 -0800
Message-ID: <1419360673.196271.13944.nullmailer@meta>
Cc: jrnieder@gmail.com, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 19:51:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3UYD-00020U-W3
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbaLWSvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:51:17 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:46801 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756507AbaLWSvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:51:16 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so8459230pab.2
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 10:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:subject:to:cc:message-id;
        bh=RNmv8N+zTRqtqCLzCoWqHIRf4vrN1fRl0uL+zYS9A5M=;
        b=zz3AbXcQRHFkaMS9tYlL1PF0P3YHX2nTxPwwj8tT9Zw05MTZJQHnQjer13gm7ehvAl
         KrYQcCB2FxKwcUrt5M2y/RrsiQqdg4gDtdxDSHqYCKeuoSFLU6PGcCaipRgE+TPTJlkF
         iTaoaQguct3wLkBP3fc03xX/Jf7SBMa+EFVv8Y0CTK9ZKbtcWlbUusx+SJM9k/mav1mt
         a7aM/+EvFf0GgyK2fCUVj5x2Z6VYkLgvNYg7xCKs5NAh2ilbdNEmJ0Bcbs3YWL+bNAuP
         cZre3XaMFa6FsiV1npL35EIpsctqpf5llacquPZtraCSylTzhLSI9HAXiQc/lyTG8J1S
         vgfw==
X-Received: by 10.66.178.198 with SMTP id da6mr46828579pac.126.1419360675702;
        Tue, 23 Dec 2014 10:51:15 -0800 (PST)
Received: from meta ([2001:438:fffd:26:9816:47c3:5cf6:cefc])
        by mx.google.com with ESMTPSA id w5sm20712624pdj.13.2014.12.23.10.51.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Dec 2014 10:51:14 -0800 (PST)
X-Google-Original-From: Craig Silverstein <csilvers@khanacademy.org>
Received: (nullmailer pid 13945 invoked by uid 1000);
	Tue, 23 Dec 2014 18:51:13 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261763>

The basic problem with submodules, from git-new-workdir's point of
view, is that instead of having a .git directory, they have a .git
file with contents `gitdir: <some other path>`.  This is a problem
because the submodule's config file has an entry like `worktree =
../../../khan-exercises` which is relative to "<some other path>"
rather than to "submodule_dir/.git".

As a result, if we want the new workdir to work properly, it needs to
keep the same directory structure as the original repository: it
should also contain a .git file with a 'gitdir', and the actual .git
contents should be in the place mentioned therein.  (There are other
ways we could have solved this problem, including modifying the
'config' file, but this seemed most in keeping with the symlink-y
philosophy of git-new-branch.)

This commit implements this, by detecting if the source .git directory
is actually a .git file with 'gitdir: ...' as its contents, and if so
reproducing the .git file + gitdir structure in the destination
work-tree.

Test plan:
On a repo (~/khan/webapp) with a submodule, ran

    git new-workdir ~/khan/webapp /tmp/webapp      # the main module
    git new-workdir ~/khan/webapp/khan-exercises /tmp/webapp/khan-exercises

and saw that /tmp/webapp/khan-exercises was populated correctly,
/tmp/webapp/.git/modules/khan-exercises existed with symlinks, and
/tmp/webapp/khan-exercises/.git was a file with a 'gitdir:' entry
pointing to the .git/modules directory.

Signed-off-by: Craig Silverstein <csilvers@khanacademy.org>
---
 contrib/workdir/git-new-workdir | 55 +++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 888c34a..3cc50de 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -52,26 +52,45 @@ then
 		"a complete repository."
 fi
 
+# don't modify an existing directory, unless it's empty
+if test -d "$new_workdir" && test $(ls -a1 "$new_workdir/." | wc -l) -ne 2
+then
+	die "destination directory '$new_workdir' is not empty."
+fi
+
 # make sure the links in the workdir have full paths to the original repo
 git_dir=$(cd "$git_dir" && pwd) || exit 1
 
-# don't recreate a workdir over an existing directory, unless it's empty
-if test -d "$new_workdir"
+new_git_dir="$new_workdir/.git"
+
+# if $orig_git is a .git file with a 'gitdir' entry (as is the case for
+# submodules), have the new git dir follow that same pattern.  otherwise
+# the 'worktree' entry in .git/config, which is a relative path, will
+# not resolve properly because we're not in the expected subdirectory.
+gitdir_text=$(sed -ne 's/^gitdir: *//p' "$orig_git/.git" 2>/dev/null)
+if test -n "$gitdir_text"; then
+	ln -s "$orig_git/.git" "$new_workdir/.git" || failed
+	new_git_dir="$new_workdir/$gitdir_text"
+fi
+
+# if new_workdir already exists, leave it along in case of error
+if ! test -d "$new_workdir"
 then
-	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2
-	then
-		die "destination directory '$new_workdir' is not empty."
-	fi
-	cleandir="$new_workdir/.git"
-else
-	cleandir="$new_workdir"
+	clean_new_workdir=true
 fi
 
-mkdir -p "$new_workdir/.git" || failed
-cleandir=$(cd "$cleandir" && pwd) || failed
+mkdir -p "$new_git_dir" || failed
 
+cleandir=$(cd "$cleandir" && pwd) || failed
 cleanup () {
-	rm -rf "$cleandir"
+	if test z"$clean_new_workdir" = ztrue
+	then
+		rm -rf "$new_workdir"
+	fi
+	# this may (or may not) be a noop if new_workdir was already deleted.
+	rm -rf "$new_git_dir"
+	# this is a noop unless .git is a 'gitdir: ...' file.
+	rm -f "$new_workdir/.git"
 }
 siglist="0 1 2 15"
 trap cleanup $siglist
@@ -84,22 +103,20 @@ do
 	# create a containing directory if needed
 	case $x in
 	*/*)
-		mkdir -p "$new_workdir/.git/${x%/*}"
+		mkdir -p "$new_git_dir/${x%/*}"
 		;;
 	esac
 
-	ln -s "$git_dir/$x" "$new_workdir/.git/$x" || failed
+	ln -s "$git_dir/$x" "$new_git_dir/$x" || failed
 done
 
-# commands below this are run in the context of the new workdir
-cd "$new_workdir" || failed
-
 # copy the HEAD from the original repository as a default branch
-cp "$git_dir/HEAD" .git/HEAD || failed
+cp "$git_dir/HEAD" "$new_git_dir/HEAD" || failed
 
 # the workdir is set up.  if the checkout fails, the user can fix it.
 trap - $siglist
 
 # checkout the branch (either the same as HEAD from the original repository,
-# or the one that was asked for)
+# or the one that was asked for).  we must be in the new workdir for this.
+cd "$new_workdir" || failed
 git checkout -f $branch
-- 
2.2.1
