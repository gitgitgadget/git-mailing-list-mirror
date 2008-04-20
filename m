From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Allow cherry-pick (and revert) to add signoff line
Date: Sun, 20 Apr 2008 20:28:57 +0200
Message-ID: <20080420182857.GA15277@atjola.homenet>
References: <1208714585-4053-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 20:29:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JneIN-00069l-FH
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 20:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469AbYDTS3B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 14:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbYDTS3B
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 14:29:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:36380 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753225AbYDTS3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 14:29:00 -0400
Received: (qmail invoked by alias); 20 Apr 2008 18:28:58 -0000
Received: from i577ADBD9.versanet.de (EHLO atjola.local) [87.122.219.217]
  by mail.gmx.net (mp017) with SMTP; 20 Apr 2008 20:28:58 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19RKA520ZFRJIfpnliONOcr68QMa/CfHrv+nUJmGi
	xiP0Vb1yIWM28c
Content-Disposition: inline
In-Reply-To: <1208714585-4053-1-git-send-email-dpmcgee@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79975>

On 2008.04.20 13:03:05 -0500, Dan McGee wrote:
> I often find myself pulling patches off of other peoples trees using
> cherry-pick, and following it with an immediate 'git commit --amend -=
s'
> command. Eliminate the need for a double commit by allowing signoff o=
n a
> cherry-pick or revert.
>=20
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> ---
>=20
> This is something I have done in my workflow for a long time, and it =
seems
> like a weird omission to me. Signoffs can be done on git-am without h=
aving
> a second commit, and I often have a workflow where I am picking patch=
es from
> other users' topic branches and have reviewed the patch and would lik=
e to
> signoff when I pull it into my tree.
>=20
> I'm not particularly happy about the 4 case if statement at the end, =
so I'd
> be happy to clean that up if anyone has suggestions.
>=20
>  builtin-revert.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/builtin-revert.c b/builtin-revert.c
> index 607a2f0..433d0dd 100644
> --- a/builtin-revert.c
> +++ b/builtin-revert.c
> @@ -33,7 +33,7 @@ static const char * const cherry_pick_usage[] =3D {
>  	NULL
>  };
> =20
> -static int edit, no_replay, no_commit, mainline;
> +static int edit, no_replay, no_commit, mainline, signoff;
>  static enum { REVERT, CHERRY_PICK } action;
>  static struct commit *commit;
> =20
> @@ -53,6 +53,7 @@ static void parse_args(int argc, const char **argv)
>  		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
>  		OPT_BOOLEAN('x', NULL, &no_replay, "append commit name when cherry=
-picking"),
>  		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
> +		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by: header")=
,
>  		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
>  		OPT_END(),
>  	};
> @@ -404,10 +405,14 @@ static int revert_or_cherry_pick(int argc, cons=
t char **argv)
>  	 */
> =20
>  	if (!no_commit) {
> -		if (edit)
> +		if (edit && !signoff)
>  			return execl_git_cmd("commit", "-n", NULL);
> -		else
> +		else if (edit)
> +			return execl_git_cmd("commit", "-n", "-s", NULL);
> +		else if (!signoff)
>  			return execl_git_cmd("commit", "-n", "-F", defmsg, NULL);
> +		else
> +			return execl_git_cmd("commit", "-n", "-s", "-F", defmsg, NULL);

maybe like this?

	if (!no_commit) {
		char **argv[6] =3D { "commit", "-n" };
		int argc =3D 2;
		if (signoff)
			argv[argc++] =3D "-s";
		if (!edit) {
			argv[argc++] =3D "-F";
			argv[argc++] =3D defmsg;
		}
		argv[argc] =3D NULL;
		execv_git_command(argv);
	}

It duplicates what execl_git_cmd does, but other places already work
similar (eg. cmd_describe, when --contains is given), and IMHO it's
nicer than the if-else chain.

Bj=F6rn
