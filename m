From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 23/32] prune: strategies for linked checkouts
Date: Thu, 11 Sep 2014 11:36:12 -0400
Message-ID: <5411C16C.9010406@xiplink.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com> <1410388928-32265-1-git-send-email-pclouds@gmail.com> <1410388928-32265-24-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 17:35:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS6Pb-0000o9-JW
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 17:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625AbaIKPfv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Sep 2014 11:35:51 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:45185 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaIKPfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 11:35:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp16.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 2EE6680138;
	Thu, 11 Sep 2014 11:35:49 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp16.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D296F8012F;
	Thu, 11 Sep 2014 11:35:48 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Thu, 11 Sep 2014 15:35:49 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1410388928-32265-24-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256849>

On 14-09-10 06:41 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> (alias R=3D$GIT_COMMON_DIR/worktrees/<id>)
>=20
>  - linked checkouts are supposed to keep its location in $R/gitdir up
>    to date. The use case is auto fixup after a manual checkout move.
>=20
>  - linked checkouts are supposed to update mtime of $R/gitdir. If
>    $R/gitdir's mtime is older than a limit, and it points to nowhere,
>    worktrees/<id> is to be pruned.
>=20
>  - If $R/locked exists, worktrees/<id> is not supposed to be pruned. =
If
>    $R/locked exists and $R/gitdir's mtime is older than a really long
>    limit, warn about old unused repo.
>=20
>  - "git checkout --to" is supposed to make a hard link named $R/link
>    pointing to the .git file on supported file systems to help detect
>    the user manually deleting the checkout. If $R/link exists and its
>    link count is greated than 1, the repo is kept.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-checkout.txt             | 18 ++++++
>  Documentation/git-prune.txt                |  3 +
>  Documentation/gitrepository-layout.txt     | 19 ++++++
>  builtin/checkout.c                         | 19 +++++-
>  builtin/prune.c                            | 95 ++++++++++++++++++++=
++++++++++
>  setup.c                                    | 13 ++++
>  t/t2026-prune-linked-checkouts.sh (new +x) | 84 ++++++++++++++++++++=
++++++
>  7 files changed, 249 insertions(+), 2 deletions(-)
>  create mode 100755 t/t2026-prune-linked-checkouts.sh
>=20
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index bd0fc1d..a29748e 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -431,6 +431,24 @@ thumb is do not make any assumption about whethe=
r a path belongs to
>  $GIT_DIR or $GIT_COMMON_DIR when you need to directly access somethi=
ng
>  inside $GIT_DIR. Use `git rev-parse --git-path` to get the final pat=
h.
> =20
> +When you are done, simply deleting the linked working directory woul=
d
> +suffice. $GIT_DIR/worktrees can be cleaned up using `git prune
> +--worktrees`.

This needs a tweak or two so that it follows more naturally from the pr=
evious
paragraph.  How about:

	When you are done with a linked working tree you can simply delete
	it.  You can clean up any stale $GIT_DIR/worktrees entries with
	`git prune --worktrees`.

Then in commit 28, when you add worktrees pruning to gc, you should cha=
nge
this paragraph again:

	When you are done with a linked working tree you can simply delete
	it.  The working tree's entry in the repository's $GIT_DIR/worktrees
	directory will eventually be removed automatically (see
	`gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
	`git prune --worktrees` to clean up any stale entries in
	$GIT_DIR/worktrees.

> +After you move a linked working directory to another file system, or
> +on a file system that does not support hard link, execute any git
> +command (e.g. `git status`) in the new working directory so that it
> +could update its location in $GIT_DIR/worktrees and not be
> +accidentally pruned.

It took me a couple of seconds to parse that.  How about:

	If you move a linked working directory to another file system, or
	within a file system that does not support hard links, you need to
	run at least one git command inside the moved linked working
	directory (e.g. `git status`) in order to update its entry in
	$GIT_DIR/worktrees so that it does not get automatically removed.

> +To stop `git prune --worktrees` from deleting a specific working
> +directory (e.g. because it's on a portable device), you could add th=
e
> +file 'locked' to $GIT_DIR/worktrees. For example, if `.git` file of
> +the new working directory points to `/path/main/worktrees/test-next`=
,
> +the full path of the 'locked' file would be
> +`/path/main/worktrees/test-next/locked`. See
> +linkgit:gitrepository-layout[5] for details.

Sorry, I can't help rewriting this one too:

	To prevent `git prune --worktrees` from deleting a
	$GIT_DIR/worktrees entry (which can be useful in some situations,
	such as when the entry's working tree is stored on a portable
	device), add a file named 'locked' to the entry's directory.  For
	example, if a linked working tree's `.git` file points to
	`/path/main/.git/worktrees/test-next` then a file named
	`/path/main/.git/worktrees/test-next/locked` will prevent the
	`test-next` entry from being pruned.  See
	linkgit:gitrepository-layout[5] for details.

I also suggest this paragraph get updated in commit 28, but just change=
 the
first clause, before "(which can be ...":

	To prevent a $GIT_DIR/worktrees entry from being pruned (which ...

Thanks for all this work!

		M.
