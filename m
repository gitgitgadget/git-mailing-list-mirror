From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Mon, 23 Jan 2012 17:32:31 +0700
Message-ID: <CACsJy8BCGi3s8gXr4kk-u8tDWztV6ozg1Tap23Q=TxA5d9iL+g@mail.gmail.com>
References: <20110607200659.GA6177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 23 11:33:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpHD5-0004Qr-9J
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 11:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130Ab2AWKdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 05:33:06 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33227 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab2AWKdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2012 05:33:04 -0500
Received: by bkas6 with SMTP id s6so2287448bka.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 02:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=N6dbPJEDGoCN9uhECfxEvN+LJWyeVCt9D+NlWGTzI9I=;
        b=bP7r5xdk1BhudNvQYjlp/PYK0ZLDdpKW6elaPnb60CBJR39H5rEbTq7o9rMizILdbz
         Q+geoI7F2LYdBY+SHJa8HDIE2MAUgF0nK1SdadVy6ITFWCbT02bE9b/y7jVzrZGWr+io
         AUX03O3UKfub7NKk+FLETC6TZGOoiIY+4hcFg=
Received: by 10.204.152.75 with SMTP id f11mr2861170bkw.127.1327314782304;
 Mon, 23 Jan 2012 02:33:02 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Mon, 23 Jan 2012 02:32:31 -0800 (PST)
In-Reply-To: <20110607200659.GA6177@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188984>

(Bringing up an old thread)

On Wed, Jun 8, 2011 at 3:06 AM, Jeff King <peff@peff.net> wrote:
> ...
> But another way to think about it is that commits, the index, and the
> working tree are all "locations" with content. And one common operati=
on
> you may want to do is to move content from one spot to another, eithe=
r
> whole, by file, or by diff hunks. To a new user, knowing that "add" i=
s
> the command for moving content from thet working tree to the index do=
es
> not help them know which command to use to do the opposite content
> movement.
> ...
> My idea is therefore to have a single command for moving content from
> one location to another. You specify a source and a destination and g=
et
> a uniform interface for moving content.
>
> A proof-of-concept patch is below. Be aware that is meant to be
> illustrative and is not well tested. Also, it is a minimal presentati=
on
> of the concept. Other "locations" may also be meaningful. I'll includ=
e
> some ideas below the patch.
>
> ---
> =C2=A0Makefile =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0git-put.sh | =C2=A0 70 ++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A02 files changed, 71 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 git-put.sh
>
> diff --git a/Makefile b/Makefile
> index e40ac0c..4564506 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -368,6 +368,7 @@ SCRIPT_SH +=3D git-merge-one-file.sh
> =C2=A0SCRIPT_SH +=3D git-merge-resolve.sh
> =C2=A0SCRIPT_SH +=3D git-mergetool.sh
> =C2=A0SCRIPT_SH +=3D git-pull.sh
> +SCRIPT_SH +=3D git-put.sh
> =C2=A0SCRIPT_SH +=3D git-quiltimport.sh
> =C2=A0SCRIPT_SH +=3D git-rebase.sh
> =C2=A0SCRIPT_SH +=3D git-repack.sh
> diff --git a/git-put.sh b/git-put.sh
> new file mode 100644
> index 0000000..f673e14
> --- /dev/null
> +++ b/git-put.sh
> @@ -0,0 +1,70 @@
> +#!/bin/sh
> +
> +SUBDIRECTORY_OK=3DYes
> +OPTIONS_KEEPDASHASH=3DYes
> +OPTIONS_SPEC=3D"\
> +git put [options] <from> <to> [--] <file...>
> +
> +Move contents from one place to another, where <from> and <to> are o=
ne of:
> + =C2=A01. A commit (e.g., master, HEAD~10, v1.7.5)
> + =C2=A02. The special token INDEX to indicate git's index.
> + =C2=A03. The special token WORKTREE to indicate the working directo=
ry.
> +
> +Options:
> +--
> +p =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0don't move whole files; u=
se the patch interface
> +"
> +. git-sh-setup
> +
> +patch=3D
> +while test $# !=3D 0; do
> + =C2=A0 =C2=A0 =C2=A0 case "$1" in
> + =C2=A0 =C2=A0 =C2=A0 -p) patch=3D--patch ;;
> + =C2=A0 =C2=A0 =C2=A0 --) shift; break ;;
> + =C2=A0 =C2=A0 =C2=A0 *) usage ;;
> + =C2=A0 =C2=A0 =C2=A0 esac
> + =C2=A0 =C2=A0 =C2=A0 shift
> +done
> +test $# -lt 2 && usage
> +
> +from=3D$1; shift
> +to=3D$1; shift
> +test "$1" =3D "--" && shift
> +
> +type_of() {
> + =C2=A0 =C2=A0 =C2=A0 case "$1" in
> + =C2=A0 =C2=A0 =C2=A0 INDEX) echo index ;;
> + =C2=A0 =C2=A0 =C2=A0 WORKTREE) echo worktree ;;
> + =C2=A0 =C2=A0 =C2=A0 *) echo commit ;;
> + =C2=A0 =C2=A0 =C2=A0 esac
> +}
> +
> +# Checkout contents to worktree without munging the index in
> +# between.
> +worktree_checkout() {
> + =C2=A0 =C2=A0 =C2=A0 old=3D$GIT_INDEX_FILE
> + =C2=A0 =C2=A0 =C2=A0 test -z "$old" && old=3D$(git rev-parse --git-=
dir)/index
> + =C2=A0 =C2=A0 =C2=A0 new=3D$(git rev-parse --git-dir)/put-index.tmp
> + =C2=A0 =C2=A0 =C2=A0 cp "$old" "$new" &&
> + =C2=A0 =C2=A0 =C2=A0 GIT_INDEX_FILE=3D$new git checkout "$@"
> + =C2=A0 =C2=A0 =C2=A0 status=3D$?
> + =C2=A0 =C2=A0 =C2=A0 rm -f "$new"
> + =C2=A0 =C2=A0 =C2=A0 exit $status
> +}
> +
> +case "$(type_of "$from"),$(type_of "$to")" in
> +*,commit)
> + =C2=A0 =C2=A0 =C2=A0 die "You can't modify an existing commit." ;;
> +index,index)
> + =C2=A0 =C2=A0 =C2=A0 die "You can't move content from the index on =
top of itself." ;;
> +worktree,index)
> + =C2=A0 =C2=A0 =C2=A0 exec git add $patch -- "$@" ;;
> +commit,index)
> + =C2=A0 =C2=A0 =C2=A0 exec git reset $patch "$from" -- "$@" ;;
> +index,worktree)
> + =C2=A0 =C2=A0 =C2=A0 exec git checkout $patch -- "$@" ;;
> +worktree,worktree)
> + =C2=A0 =C2=A0 =C2=A0 die "You can't move content in the worktree on=
 top of itself." ;;
> +commit,worktree)
> + =C2=A0 =C2=A0 =C2=A0 worktree_checkout $patch "$from" -- "$@" ;;
> +esac
>
>
> As you can see, this handles only three typoes of locations: the
> worktree, the index, and an arbitrary commit (really a tree-ish).

Last time we were stuck at the magic keywords INDEX and WORKTREE. What
if we sort of follow scp naming convention:

 - Normal paths are working tree's paths
 - Paths with a colon in it are in "remote" locations (index or a
tree). The part before colon specifies the location.

We could have:

git put <src> [<src>...] <dst>
git put <src> [<src>...] <dst> -- <pathspec>

Where <src> and <dst> could be

 - <tree-ish> <colon> [<pathspec>]
 - [0-3] <colon> [<pathspec>]
 - <pathspec> (or plain path)

In the first form, pathspec could be specified in <src>. If <dst> is
worktree, then "." would be enough (or path to repo's root to be more
strict). In the second form, no pathspec can be part of <src> nor
<dst> because they're at the end already.

With this syntax we could have:

git put 0:path/to/file.c . (or git put 0: path/to/file.c)
 -> copy file.c from index to worktree (at the same path "path/to/file.=
c")
git put path/to/file 0:
 -> copy file to index
git put HEAD: . -- path/
 -> checkout everything in path/ from HEAD

I'm not sure how mutiple <src> should work, but there may be a use case=
 for it.

> Some other types I've thought of are:
> ...
> =C2=A0- branches as destinations; obviously we can't change an existi=
ng
> =C2=A0 =C2=A0commit, but what about something like:
>
> =C2=A0 =C2=A0 =C2=A0git put WORKTREE BRANCH:foo
>
> =C2=A0 =C2=A0to optionally create a new branch "refs/heads/foo" based=
 on the
> =C2=A0 =C2=A0current HEAD, push changes into a temporary index that m=
atches its
> =C2=A0 =C2=A0tip, and then making a new commit based on top.
>
> =C2=A0 =C2=A0This would serve a similar purpose to stashes, except th=
at they
> =C2=A0 =C2=A0would be named and could operate as full branches. I wou=
ld find it
> =C2=A0 =C2=A0useful for picking apart a mass of worktree changes into=
 discrete
> =C2=A0 =C2=A0commits.
>
> =C2=A0- allow multiple destinations, like
>
> =C2=A0 =C2=A0 # equivalent to "git checkout --"
> =C2=A0 =C2=A0 git put HEAD INDEX,WORKTREE

These obviously do not work with the syntax I propose.
--=20
Duy
