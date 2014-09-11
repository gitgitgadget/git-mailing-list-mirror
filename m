From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 22/32] checkout: support checking out into a new working
 directory
Date: Thu, 11 Sep 2014 11:02:36 -0400
Message-ID: <5411B98C.1090905@xiplink.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com> <1410388928-32265-1-git-send-email-pclouds@gmail.com> <1410388928-32265-23-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 17:02:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS5tK-0002u8-Bv
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 17:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbaIKPCa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Sep 2014 11:02:30 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:60242 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbaIKPC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 11:02:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp20.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 8368E180102;
	Thu, 11 Sep 2014 11:02:28 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp20.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 452241800FF;
	Thu, 11 Sep 2014 11:02:28 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Thu, 11 Sep 2014 15:02:28 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1410388928-32265-23-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256847>

On 14-09-10 06:41 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> "git checkout --to" sets up a new working directory with a .git file
> pointing to $GIT_DIR/worktrees/<id>. It then executes "git checkout"
> again on the new worktree with the same arguments except "--to" is
> taken out. The second checkout execution, which is not contaminated
> with any info from the current repository, will actually check out an=
d
> everything that normal "git checkout" does.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-checkout.txt         | 43 +++++++++++++++
>  Documentation/git.txt                  |  3 +-
>  Documentation/gitrepository-layout.txt |  7 +++
>  builtin/checkout.c                     | 95 ++++++++++++++++++++++++=
+++++++++-
>  path.c                                 |  2 +-
>  t/t2025-checkout-to.sh (new +x)        | 63 ++++++++++++++++++++++
>  6 files changed, 209 insertions(+), 4 deletions(-)
>  create mode 100755 t/t2025-checkout-to.sh
>=20
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index 33ad2ad..bd0fc1d 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -225,6 +225,13 @@ This means that you can use `git checkout -p` to=
 selectively discard
>  edits from your current working tree. See the ``Interactive Mode''
>  section of linkgit:git-add[1] to learn how to operate the `--patch` =
mode.
> =20
> +--to=3D<path>::
> +	Check out a branch in a separate working directory at
> +	`<path>`. A new working directory is linked to the current
> +	repository, sharing everything except working directory
> +	specific files such as HEAD, index... See "MULTIPLE CHECKOUT
> +	MODE" section for more information.
> +
>  <branch>::
>  	Branch to checkout; if it refers to a branch (i.e., a name that,
>  	when prepended with "refs/heads/", is a valid ref), then that
> @@ -388,6 +395,42 @@ $ git reflog -2 HEAD # or
>  $ git log -g -2 HEAD
>  ------------
> =20
> +MULTIPLE CHECKOUT MODE
> +----------------------
> +Normally a working directory is attached to repository. When "git
> +checkout --to" is used, a new working directory is attached to the
> +current repository. This new working directory is called "linked
> +checkout" as compared to the "main checkout" prepared by "git init" =
or
> +"git clone". A repository has one main checkout and zero or more
> +linked checkouts.
> +
> +Each linked checkout has a private directory in $GIT_DIR/worktrees i=
n
> +the main checkout, usually named after the base name of the new
> +working directory, optionally with a number added to make it
> +unique. For example, the command `git checkout --to ../test-next nex=
t`
> +running with $GIT_DIR=3D/path/main may create the directory
> +`$GIT_DIR/worktrees/test-next` (or `$GIT_DIR/worktrees/test-next1` i=
f
> +`test-next` is already taken).
> +
> +Within a linked checkout, $GIT_DIR is set to point to this private
> +directory (e.g. `/path/main/worktrees/test-next` in the example) and
> +$GIT_COMMON_DIR is set to point back to the main checkout's $GIT_DIR
> +(e.g. `/path/main`). Setting is done via a .git file located at the
> +top directory of the linked checkout.
> +
> +Path resolution via `git rev-parse --git-path` would use either
> +$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, the
> +linked checkout's `$GIT_DIR/HEAD` resolve to
> +`/path/main/worktrees/test-next/HEAD` (not `/path/main/HEAD` which i=
s
> +the main checkout's HEAD) while `$GIT_DIR/refs/heads/master` would u=
se
> +$GIT_COMMON_DIR and resolve to `/path/main/refs/heads/master`, which
> +is shared across checkouts.
> +
> +See linkgit:gitrepository-layout[5] for more information. The rule o=
f
> +thumb is do not make any assumption about whether a path belongs to
> +$GIT_DIR or $GIT_COMMON_DIR when you need to directly access somethi=
ng
> +inside $GIT_DIR. Use `git rev-parse --git-path` to get the final pat=
h.
> +

Um, didn't you say in [1] that you'd use the text I posted in [2]?

[1] http://article.gmane.org/gmane.comp.version-control.git/256446
[2] http://article.gmane.org/gmane.comp.version-control.git/256323

		M.
