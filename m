From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git stash: Avoid data loss when saving a stash
Date: Fri, 28 Jun 2013 11:39:16 -0700
Message-ID: <7vobaqnkq3.fsf@alter.siamese.dyndns.org>
References: <20130628150532.GD12252@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Jun 28 20:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsdZs-0007Bx-So
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 20:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab3F1SjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 14:39:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55613 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459Ab3F1SjT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 14:39:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02B6F2CDFB;
	Fri, 28 Jun 2013 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=tgBvFqMoc+bwPjg1cANwadof0q8=; b=IZDaBrrClHOWbgIqkyMi
	ldSVdrqImYTWkgxlC2t+In6v6ybPB8SSnh4J2XVBMxO5PnW6ixXY729sAwsC+uR2
	7Ukpu/2gBkb2zjhUFmIASXw7N2ZC1sHczHFuNlkyCWuqJ7mrBp7zM32ZeOX9i9rK
	iYinsWmttwZYi+AOOOhoFYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jPnmW2h1T46P36Gt1wWFU54vH1AfSO7YsBpOi7X/cs3J8D
	QPD4dyk30xhTcJCPbzNKSw2/0g1SQ9/ZwU3t/JnZ0G/TmvGpMKLMPcY1JZG6JiH0
	wetpDZkJwoVYZMgAAnvrz5NMVcXw4fMAz6+glCw7Jm46MV320JYykbiDldWrM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAB1C2CDFA;
	Fri, 28 Jun 2013 18:39:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10C792CDF8;
	Fri, 28 Jun 2013 18:39:17 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A4BB37E-E022-11E2-941B-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229224>

Petr Baudis <pasky@ucw.cz> writes:

> Signed-off-by: Petr Baudis <pasky@ucw.cz>
> ---
>
> Please Cc me, I'm currently not subscribed on the list.

Heh, long time no see.

> @@ -71,6 +72,13 @@ linkgit:git-add[1] to learn how to operate the `--patch` mode.
>  +
>  The `--patch` option implies `--keep-index`.  You can use
>  `--no-keep-index` to override this.
> ++
> +In some cases, saving a stash could mean irretrievably removing some
> +data - if a directory with untracked files replaces a tracked file of
> +the same name, the new untracked files are not saved (except in case
> +of `--include-untracked`) but the original tracked file shall be restored.
> +Normally, stash save will abort; `--force` will make it remove the
> +untracked files.

It _might_ look obvious from the context after somebody spends
enough time thinking about this case (and only this case) that
"in such a case" is implied in "Normally, ... will abort", but for a
casual reader who encounters this paragraph for the first time, I do
not think it is obvious.  I'd rephrase to:

    By default, `stash save` will abort in such a case; `--force` will
    allow it to remove the untracked files.

> @@ -258,6 +262,12 @@ save_stash () {
>  		say "$(gettext "No local changes to save")"
>  		exit 0
>  	fi
> +	if test -z "$untracked$force" -a -n "$(git ls-files --killed | head -n 1)"; then

Split the line at the semicolon in "; then".  Also "git grep" will
tell us that we tend to avoid "-a" in "test".

        if test -z "$untracked$force" &&
           test -n "$(git ls-files --killed | head -n 1)"
        then
		...

> +		say "$(gettext "The following untracked files would NOT be saved but need to be removed by stash save:")"
> +		test -n "$GIT_QUIET" || git ls-files --killed | sed 's/^/\t/'
> +		say "$(gettext "Abording. Consider using either the --force or --include-untracked switches.")" >&2

s/Abord/Abort/;

> +		exit 1
> +	fi
>  	test -f "$GIT_DIR/logs/$ref_stash" ||
>  		clear_stash || die "$(gettext "Cannot initialize stash")"
>  
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index debda7a..4ac4ebe 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -673,4 +673,19 @@ test_expect_success 'store updates stash ref and reflog' '
>  	grep quux bazzy
>  '
>  
> +test_expect_success SYMLINKS 'stash symlink to non-empty directory' '
> +	git reset --hard &&
> +	ln -s file2 linkdir &&
> +	git add linkdir &&
> +	git commit -m"+linkdir as symlink" &&
> +	rm linkdir && mkdir linkdir && touch linkdir/file &&

Use ">linkdir/file" instead for clarity, when you are not interested
in modifying the timestamp of an existing file.

> +	! git stash save "symlink to non-empty directory" &&

Use test_must_fail

> +	[ -e linkdir/file ]

"test -f linkdir/file"  You not only want to see it exists, you know
it must be a regular file.

> +'
> +
> +test_expect_success SYMLINKS 'stash symlink to non-empty directory (forced)' '
> +	git stash save --force "symlink to non-empty directory (forced)" &&
> +	[ ! -e linkdir/file ] && [ -L linkdir ]
> +'

"git grep" will tell us that "test -h" is preferred over "test -L"
in our codebase.

> +
>  test_done

Also I do not think you need to limit the tests on symlink-capable
platforms.  You can create the "linkdir" as a regular file and
commit, and make a local change to turn it into a directory, and try
to "stash save" to recover that original regular file.

Thanks.  I'll queue it with a pair of fix-up commits on top, so that
they can later be squashed in.

The result of squashing the fix-ups would look like this.

-- >8 --
From: Petr Baudis <pasky@ucw.cz>
Date: Fri, 28 Jun 2013 17:05:32 +0200
Subject: [PATCH] git stash: avoid data loss when "git stash save" kills a directory

"stash save" is about saving the local change to the working tree,
but also about restoring the state of the last commit to the working
tree.  When a local change is to turn a non-directory to a directory,
in order to restore the non-directory, everything in the directory
needs to be removed.

Which is fine when running "git stash save --include-untracked",
but without that option, untracked, newly created files in the
directory will have to be discarded.

Introduce a safety valve to fail the operation in such case, using
the "ls-files --killed" which was designed for this exact purpose.

The "stash save" is stopped when untracked files need to be
discarded because their leading path ceased to be a directory, and
the user is required to pass --force to really have the data
removed.

Signed-off-by: Petr Baudis <pasky@ucw.cz>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-stash.txt | 12 ++++++++++--
 git-stash.sh                | 12 ++++++++++++
 t/t3903-stash.sh            | 18 ++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index db7e803..7c8b648 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [<message>]]
+	     [-u|--include-untracked] [-a|--all] [-f|--force]
+	     [<message>]]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
@@ -44,7 +45,7 @@ is also possible).
 OPTIONS
 -------
 
-save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-f|--force] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
@@ -71,6 +72,13 @@ linkgit:git-add[1] to learn how to operate the `--patch` mode.
 +
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
++
+In some cases, saving a stash could mean irretrievably removing some
+data - if a directory with untracked files replaces a tracked file of
+the same name, the new untracked files are not saved (except in case
+of `--include-untracked`) but the original tracked file shall be restored.
+By default, `stash save` will abort in such a case; `--force` will allow
+it to remove the untracked files.
 
 list [<options>]::
 
diff --git a/git-stash.sh b/git-stash.sh
index 1e541a2..85c9e2c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -195,6 +195,7 @@ save_stash () {
 	keep_index=
 	patch_mode=
 	untracked=
+	force=
 	while test $# != 0
 	do
 		case "$1" in
@@ -215,6 +216,9 @@ save_stash () {
 		-u|--include-untracked)
 			untracked=untracked
 			;;
+		-f|--force)
+			force=t
+			;;
 		-a|--all)
 			untracked=all
 			;;
@@ -258,6 +262,14 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
+	if test -z "$untracked$force" &&
+	   test -n "$(git ls-files --killed | head -n 1)"
+	then
+		say "$(gettext "The following untracked files would NOT be saved but need to be removed by stash save:")"
+		test -n "$GIT_QUIET" || git ls-files --killed | sed 's/^/\t/'
+		say "$(gettext "Aborting. Consider using either the --force or --include-untracked option.")" >&2
+		exit 1
+	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index debda7a..5d22f17 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -673,4 +673,22 @@ test_expect_success 'store updates stash ref and reflog' '
 	grep quux bazzy
 '
 
+test_expect_success 'stash a change to turn a non-directory to a directory' '
+	git reset --hard &&
+	>testfile &&
+	git add testfile &&
+	git commit -m "add testfile as a regular file" &&
+	rm testfile &&
+	mkdir testfile &&
+	>testfile/file &&
+	test_must_fail git stash save "recover regular file" &&
+	test -f testfile/file
+'
+
+test_expect_success 'stash a change to turn a non-directory to a directory (forced)' '
+	git stash save --force "recover regular file (forced)" &&
+	! test -f testfile/file &&
+	test -f testfile
+'
+
 test_done
-- 
1.8.3.1-814-gbbacdaa
