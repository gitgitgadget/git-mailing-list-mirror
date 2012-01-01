From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Sun, 01 Jan 2012 15:58:26 +0100
Message-ID: <4F007492.8010909@web.de>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com> <7vsjk3vw67.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 01 15:58:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhMrt-0005o1-4V
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 15:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab2AAO6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jan 2012 09:58:33 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:34428 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab2AAO6b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jan 2012 09:58:31 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate01.web.de (Postfix) with ESMTP id 71E901A7E48B8
	for <git@vger.kernel.org>; Sun,  1 Jan 2012 15:58:30 +0100 (CET)
Received: from [192.168.178.43] ([91.3.198.21]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0Lbrk4-1SQYzJ1uz6-00jWEz; Sun, 01 Jan 2012 15:58:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vsjk3vw67.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:f/2YBPx7/S5LKDdAHKivGd9IWbdIT7qwFsqZVxnpnIS
 k4kcATlUoDvlooJBhG9hY+WEZPECISAvknrZ86squOnqeWR05c
 hmJRUrN7YsnO6IlLLQt81EMEQ0DKkaxzfrG7N1sOWCXBhY8ECO
 VqdIyRuc1/5vcGfYvihLzldIxDmW4QG5XsaQNyQx+M2zZn6EHU
 avcnPSkyRprWF7rtx9lUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187823>

Am 29.12.2011 23:40, schrieb Junio C Hamano:
> Antony Male <antony.male@gmail.com> writes:
> I further wonder if we can get away without using separate-git-dir option
> in this codepath, though. IOW using
> 
>         git clone $quiet -bare ${reference:+"$reference"} "$url" "$gitdir"
> 
> might be a better solution.

A quick test shows that using a bare repo won't fly because without the
core.worktree setting commands that operate on the work tree can't be
run anymore inside submodules (starting with the initial checkout). If
we could teach setup to take the directory where the gitfile was found
as first guess for the git work tree it looks like we can make that
approach work. I'll see if I can come up with something here ...

> For example (this relates to the point I mumbled "haven't thought this
> through thoroughly yet"), doesn't the newly cloned repository have
> core.worktree that points at the working tree that records the <path>,
> which would become meaningless when a commit in the superproject that
> binds the submodule at different path <path2>?

Yes, and the core.worktree setting also contains an absolute path. So
we must either make that relative too and rewrite it on every "git
submodule add" to record the possibly changed path there or make the
bare clone work with a work tree (which sounds a bit strange ;-).

>  git-submodule.sh |   21 ++++++++-------------
>  1 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3adab93..9a23e9d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -156,21 +156,16 @@ module_clone()
>  		;;
>  	esac
>  
> -	if test -d "$gitdir"
> +	if ! test -d "$gitdir"
>  	then
> -		mkdir -p "$path"
> -		echo "gitdir: $rel_gitdir" >"$path/.git"
> -		rm -f "$gitdir/index"
> -	else
> -		mkdir -p "$gitdir_base"
> -		if test -n "$reference"
> -		then
> -			git-clone $quiet "$reference" -n "$url" "$path" --separate-git-dir "$gitdir"
> -		else
> -			git-clone $quiet -n "$url" "$path" --separate-git-dir "$gitdir"
> -		fi ||
> -		die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
> +		git clone $quiet -n ${reference:+"$reference"} \
> +			--separate-git-dir "$gitdir" "$url" "$path" ||
> +		die "$(eval_gettext "Clone of '\$url' for submodule '\$name' failed")
>  	fi
> +
> +	mkdir -p "$path"
> +	echo "gitdir: $rel_gitdir" >"$path/.git"
> +	rm -f "$gitdir/index"
>  }
>  
>  #

That broke quite some tests for me (even though I really liked
to get rid of that if ;-)

Here is a patch that solves the first part of the absolute paths
problem (passes all tests; parts of the commit message shamelessly
copied from your proposal). Then another patch can tackle the
core.worktree config setting problem to make superprojects
relocatable gain.
---------8<--------
Subject: [PATCH] submodules: always use a relative path to gitdir

Recent versions of "git submodule" maintain the submodule <name> at
<path> in the superproject using a "separate git-dir" mechanism. The
repository data for the submodule is stored in ".git/modules/<name>/"
directory of the superproject, and its working tree is created at
"<path>/" directory, with "<path>/.git" file pointing at the
".git/modules/<name>/" directory.

This is so that we can check out an older version of the superproject
that does not yet have the submodule <name> anywhere without losing
(and later having to re-clone) the submodule repository. Removing
"<path>" won't lose ".git/modules/<name>", and a different branch that
has the submodule at different location in the superproject, say
"<path2>", can create "<path2>/" and ".git" in it to point at the same
".git/modules/<name>".

When instantiating such a submodule, if ".git/modules/<name>/" does
not exist in the superproject, the submodule repository needs to be
cloned there first. Then we only need to create "<path>" directory,
point ".git/modules/<name>/" in the superproject with "<path>/.git",
and check out the working tree.

However, the current code is not structured that way. The codepath to
deal with newly cloned submodules uses "git clone --separate-git-dir"
and creates "<path>" and "<path>/.git". This can make the resulting
submodule working tree at "<path>" different from the codepath for
existing submodules. An example of such differences is that this
codepath prepares "<path>/.git" with an absolute path, while the
normal codepath uses a relative path.

Fix the latter by always writing the relative path to the git directory
in "<path>/.git". To make that work, the 'name' variable has to be set to
the value of the 'path' variable for newly added submodules.

This is only the first step to make superprojects movable again like they
were before the separate-git-dir approach was introduced. The second step
must be to either use a relative path in core.worktree too or to get rid
of that setting by using a bare repo in "./git/modules/<name>".

While at it also replace an if/else construct evaluating the presence
of the 'reference' option with a single line of bash code.

Reported-by: Antony Male <antony.male@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-submodule.sh |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3adab93..2a93c61 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -131,6 +131,7 @@ module_clone()
 	gitdir=
 	gitdir_base=
 	name=$(module_name "$path" 2>/dev/null)
+	test -n "$name" || name="$path"
 	base_path=$(dirname "$path")

 	gitdir=$(git rev-parse --git-dir)
@@ -159,18 +160,15 @@ module_clone()
 	if test -d "$gitdir"
 	then
 		mkdir -p "$path"
-		echo "gitdir: $rel_gitdir" >"$path/.git"
 		rm -f "$gitdir/index"
 	else
 		mkdir -p "$gitdir_base"
-		if test -n "$reference"
-		then
-			git-clone $quiet "$reference" -n "$url" "$path" --separate-git-dir "$gitdir"
-		else
-			git-clone $quiet -n "$url" "$path" --separate-git-dir "$gitdir"
-		fi ||
+		git clone $quiet -n ${reference:+"$reference"} \
+			--separate-git-dir "$gitdir" "$url" "$path" ||
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
 	fi
+
+	echo "gitdir: $rel_gitdir" >"$path/.git"
 }

 #
-- 
1.7.8.2.303.g78a27
