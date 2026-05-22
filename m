Received: from bsmtp3.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835C3382EC
	for <git@vger.kernel.org>; Fri, 22 May 2026 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437173; cv=none; b=DJTWbsLAYEKJbpixfMZfYbr4wzIDFvvqSUUntuxxSjBcop7ViCzIZs4bUjbcw++yS3pdIGkcP1NMrxPp762go9uottaTSY41Z0aeikKxlYjyxzuNIBULOvTGxS37EqNgqoNMI+Hjg136J5Iav5pnAfcenoH1CkhUlh3EDR9cLE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437173; c=relaxed/simple;
	bh=2iGLQ08WTH52dlB5qgH/EllGoaAPCY/G+6tUuWGRw5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0FGgTqw0tbKhDyfkgeQicQ0KECpskcQB2ZO8TdqQ+SkCelUOkHxNOZnaCGQGWWAvaXYpMjGVuRt3ANZKJk+F+9pfsgf2L5/gIpx4FG+khBq/giHgzpBTDPBXnAdLV2smV/bowQi1+BCpbJGEgXIm4paGNOxT6SiynierZNIupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gMHsV4mTHzRnly;
	Fri, 22 May 2026 10:06:06 +0200 (CEST)
Message-ID: <e5a9a410-bf62-4afd-9560-2dea01fe936b@kdbg.org>
Date: Fri, 22 May 2026 10:06:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] git-gui: guard set/unset of GIT_DIR and
 GIT_WORK_TREE
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-2-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260520202411.108764-2-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.05.26 um 22:24 schrieb Mark Levedahl:
> git-gui unconditionally exports _gitdir as GIT_DIR, and _gitworktree as
> GIT_WORK_TREE, to the environment, and furthermore unconditionally
> unsets these environment variables in many

"many cases"?

> 
> git gui must have a repository, so _gitdir can never be empty and its
> export is always valid if repository discovery completes successfully.

_gitdir cannot be empty, so we should be able to drop the conditionals
around 'set env(GIT_DIR) $_gitdir'.

> 
> git gui might not find a worktree, so _gitworktree can be empty. While
> having no worktree is valid for blame/browser subcommands, exporting
> GIT_WORK_TREE=<empty> is not valid. Rather, an empty GIT_WORK_TREE
> raises errors in git builtins, for instance 'git branch --show-current'
> as used by git, and causes breakage. This is one cause of git blame /
> git browser not working without a worktree.
> 
> A user may set GIT_DIR and/or GIT_WORK_TREE to override git's normal
> discovery rules, including repository configuration of core.worktree
> and/or worktree specific gitdirs. It is always safe to export the
> absolute pathnames of the discovered values, even though they may not be
> needed. However, the gitdir might not be found from the worktree without
> GIT_DIR being set. Furthermore, the worktree defined by the discovered
> gitdir might be overridden by GIT_WORK_TREE set before git-gui started.
> So, it is also sometimes necessary that one or both of these variables
> is set.

While all you say here is true, the actual reason for the dance is more
like the simpler: provide a clean slate for the new process and return
to the old state after it has been started.

> 
> So, let's provide two procs, one to unset GIT_DIR / GIT_WORK_TREE if
> they are set, one to set GIT_DIR and, if not empty, GIT_WORK_TREE,  so
> all call sites do the same thing, and problems with _gitworktree == {}
> are avoided.

That being said, I propose the two patches below (pasted here for
review), after which we do not need these functions anymore IMHO
because the call sites are one-liners around GIT_DIR anyway.

The commits are available here:

git fetch https://github.com/j6t/git-gui.git js/unset-git-work-tree
https://github.com/j6t/git-gui/tree/js/unset-git-work-tree

------ 8< ------
Subject: [PATCH 1/2] git-gui: remove unnecessary 'cd $_gitworktree' from do_gitk

In the procedure that invokes Gitk, we have a 'cd $_gitworktree'. Such
a change of the current directory is not necessary, because

- if we have a working tree, then the startup routine has already
  changed the current directory to the root of the working tree, which
  *is* $_gitworktree; or

- if we are in a bare repository, then there is no point in changing
  the current directory anywhere. (And $_gitworktree is empty.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-gui.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 23fe76e498bd..8d2b02b13fa0 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2021,11 +2021,7 @@ proc do_gitk {revs {is_submodule false}} {
 
 		set pwd [pwd]
 
-		if {!$is_submodule} {
-			if {![is_bare]} {
-				cd $_gitworktree
-			}
-		} else {
+		if {$is_submodule} {
 			cd $current_diff_path
 			if {$revs eq {--}} {
 				set s $file_states($current_diff_path)
-- 
2.54.0.215.g4fe990ec16

------ 8< ------
Subject: [PATCH 2/2] git-gui: operate git commands without GIT_WORK_TREE

The manual page of the git command states about the --git-dir option:

   Specifying the location of the ".git" directory using this option
   (or GIT_DIR environment variable) turns off the repository
   discovery [...], and tells Git that you are at the top level of
   the working tree.

Use this to our advantage:

- Set GIT_DIR in the environment to the value that was discovered, so
  that the invoked git commands operate on the same repository
  database that Git GUI uses even after it changes the working
  directory.

- After changing the working directory to the top level of the working
  tree, ensure that GIT_WORK_TREE is not set, because, as per
  documentation, all git invocations from then on will assume that the
  current working directory is also the top level working tree.

- Remove the now obsolete GIT_WORK_TREE dance when subordinate Gitk or
  Git GUI are invoked for a submodule.

Do keep the state of GIT_WORK_TREE if we are in a bare repository,
because Git GUI is not interested in the worktree at all, as no commit
mode is possible in a bare repository.

This avoids cases where an empty GIT_WORK_TREE was exported into the
environment, most notably by a call of `git gui blame HEAD file` in a
bare repository. (Although, this particular error is currently masked
by an earlier failure in `rev-parse --show-toplevel`, which requires a
working tree.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-gui.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8d2b02b13fa0..3819f8be2211 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1183,6 +1183,7 @@ if {$_prefix ne {}} {
 		exit 1
 	}
 	set _gitworktree [pwd]
+	catch {unset env(GIT_WORK_TREE)}
 	unset cdup
 } elseif {![is_enabled bare]} {
 	if {[is_bare]} {
@@ -1199,6 +1200,7 @@ if {$_prefix ne {}} {
 		exit 1
 	}
 	set _gitworktree [pwd]
+	catch {unset env(GIT_WORK_TREE)}
 }
 set _reponame [file split [file normalize $_gitdir]]
 if {[lindex $_reponame end] eq {.git}} {
@@ -1208,7 +1210,6 @@ if {[lindex $_reponame end] eq {.git}} {
 }
 
 set env(GIT_DIR) $_gitdir
-set env(GIT_WORK_TREE) $_gitworktree
 
 ######################################################################
 ##
@@ -2007,7 +2008,7 @@ proc incr_font_size {font {amt 1}} {
 
 proc do_gitk {revs {is_submodule false}} {
 	global current_diff_path file_states current_diff_side ui_index
-	global _gitdir _gitworktree
+	global _gitdir
 
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
@@ -2041,18 +2042,16 @@ proc do_gitk {revs {is_submodule false}} {
 				}
 				set revs $old_sha1...$new_sha1
 			}
-			# GIT_DIR and GIT_WORK_TREE for the submodule are not the ones
-			# we've been using for the main repository, so unset them.
+			# GIT_DIR for the submodule is not the one we've been using for
+			# the main repository, so unset it. (GIT_WORK_TREE is already unset.)
 			# TODO we could make life easier (start up faster?) for gitk
 			# by setting these to the appropriate values to allow gitk
 			# to skip the heuristics to find their proper value
 			unset env(GIT_DIR)
-			unset env(GIT_WORK_TREE)
 		}
 		safe_exec_bg [concat $cmd $revs "--" "--"]
 
 		set env(GIT_DIR) $_gitdir
-		set env(GIT_WORK_TREE) $_gitworktree
 		cd $pwd
 
 		if {[info exists main_status]} {
@@ -2076,12 +2075,11 @@ proc do_git_gui {} {
 		error_popup [mc "Couldn't find git gui in PATH"]
 	} else {
 		global env
-		global _gitdir _gitworktree
+		global _gitdir
 
-		# see note in do_gitk about unsetting these vars when
+		# see note in do_gitk about unsetting this variable when
 		# running tools in a submodule
 		unset env(GIT_DIR)
-		unset env(GIT_WORK_TREE)
 
 		set pwd [pwd]
 		cd $current_diff_path
@@ -2089,7 +2087,6 @@ proc do_git_gui {} {
 		safe_exec_bg [concat $exe gui]
 
 		set env(GIT_DIR) $_gitdir
-		set env(GIT_WORK_TREE) $_gitworktree
 		cd $pwd
 
 		set status_operation [$::main_status \
-- 
2.54.0.215.g4fe990ec16

