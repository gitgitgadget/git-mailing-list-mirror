From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Utilize config variable pager.stash in stash list command
Date: Mon, 15 Aug 2011 16:47:14 -0700
Message-ID: <20110815234714.GB4699@sigill.intra.peff.net>
References: <4e47dcf9.55313988.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Tue Aug 16 01:47:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt6sN-0000Ue-My
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 01:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab1HOXrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Aug 2011 19:47:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38123
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab1HOXrS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 19:47:18 -0400
Received: (qmail 30438 invoked by uid 107); 15 Aug 2011 23:47:56 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Aug 2011 19:47:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2011 16:47:14 -0700
Content-Disposition: inline
In-Reply-To: <4e47dcf9.55313988.bm000@wupperonline.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179396>

On Sun, Aug 14, 2011 at 04:31:49PM +0200, Ingo Br=C3=BCckl wrote:

> Signed-off-by: Ingo Br=C3=BCckl <ib@wupperonline.de>
> ---
>  By now stash list ignores it.
>=20
>  git-stash.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-stash.sh b/git-stash.sh
> index f4e6f05..7bb0856 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -264,7 +264,8 @@ have_stash () {
>=20
>  list_stash () {
>  	have_stash || return 0
> -	git log --format=3D"%gd: %gs" -g "$@" $ref_stash --
> +	test "$(git config --get pager.stash)" =3D "false" && no_pager=3D--=
no-pager
> +	git $no_pager log --format=3D"%gd: %gs" -g "$@" $ref_stash --
>  }

It's not quite as simple as this these days. The pager.* variables can
also point to a program to run as a pager for this specific command.

This stuff is supposed to be handled by the "git" wrapper itself, which
will either run the pager (if the config is boolean true, or a specific
command), or will set an environment variable to avoid running one for
any subcommand (if it's boolean false).

However, we don't respect pager.* config for external commands there at
all. I think this was due to some initialization-order bugs that made i=
t
hard for us to look at config before exec'ing external commands. But
perhaps they are gone, as the patch below[1] seems to work OK for me.

---
 git.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 8828c18..47a6d3d 100644
--- a/git.c
+++ b/git.c
@@ -459,6 +459,8 @@ static void execv_dashed_external(const char **argv=
)
 	const char *tmp;
 	int status;
=20
+	if (use_pager =3D=3D -1)
+		use_pager =3D check_pager_config(argv[0]);
 	commit_pager_choice();
=20
 	strbuf_addf(&cmd, "git-%s", argv[0]);

-Peff

[1] I posted this in a similar discussion several months ago:

    http://thread.gmane.org/gmane.comp.version-control.git/161756/focus=
=3D161771

I think what it really needs is more testing to see if looking at the
config then has any unintended side effects.
