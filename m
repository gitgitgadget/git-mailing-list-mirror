From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] tg-push: Filter out plain SHA1s from being pushed.
Date: Sun, 28 Feb 2010 11:18:07 +0100
Message-ID: <20100228101807.GB13987@pengutronix.de>
References: <1267308548-10136-1-git-send-email-thomas@schwinge.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Schwinge <thomas@schwinge.name>
X-From: git-owner@vger.kernel.org Sun Feb 28 11:18:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlgE4-0006XQ-Hd
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 11:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031745Ab0B1KSK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2010 05:18:10 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38234 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031648Ab0B1KSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 05:18:08 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1NlgDv-00030o-Ri; Sun, 28 Feb 2010 11:18:07 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1NlgDv-0003nq-Fb; Sun, 28 Feb 2010 11:18:07 +0100
Content-Disposition: inline
In-Reply-To: <1267308548-10136-1-git-send-email-thomas@schwinge.name>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141246>

Hello,

On Sat, Feb 27, 2010 at 11:09:08PM +0100, Thomas Schwinge wrote:
> Otherwise, problems arise when branches depend (via .topdeps) on SHA1=
s:
>=20
>     $ tg push -r tmp t/____longjmp_chk_cleanup_linux_x86_64
>     fatal: 77c84aeb81808c3109665949448dba59965c391e cannot be resolve=
d to branch.
>     fatal: The remote end hung up unexpectedly
> ---
>=20
> Hello!
>=20
> I was facing the following problem:
>=20
>     thomas@dirichlet:~/tmp/source/glibc/git/glibc.hurd $ bash -v -x /=
usr/bin/tg push -r tmp t/____longjmp_chk_cleanup_linux_x86_64
>     [...]
>     ++ read _dep
>     ++ missing_deps=3D
>     ++ rm /tmp/tg-depsfile.nCfywI
>     ++ return 0
>     ++ xargs git push tmp
>     ++ sort -u /tmp/tg-push-listfile.sZeHIr
>     fatal: 77c84aeb81808c3109665949448dba59965c391e cannot be resolve=
d to branch.
>     fatal: The remote end hung up unexpectedly
>     rm -f "/tmp/tg-push-listfile.sZeHIr"
>     + rm -f /tmp/tg-push-listfile.sZeHIr
>=20
> That's the actual problem:
>=20
>     thomas@dirichlet:~/tmp/source/glibc/git/glibc.hurd $ git push tmp=
 77c84aeb81808c3109665949448dba59965c391e
>     fatal: 77c84aeb81808c3109665949448dba59965c391e cannot be resolve=
d to branch.
>     fatal: The remote end hung up unexpectedly
>=20
> ... which is due to:
>=20
>     $ git show t/____longjmp_chk_cleanup_linux_x86_64:.topdeps
>     77c84aeb81808c3109665949448dba59965c391e
>=20
> All other parts (at least those I tested / got to use so far) work ju=
st
> fine when passing SHA1s.
>=20
> Here is a patch to make this work for tg push, too.
>=20
>     thomas@dirichlet:~/tmp/source/glibc/git/glibc.hurd $ tg push -r t=
mp t/____longjmp_chk_cleanup_linux_x86_64
>     Counting objects: 196207, done.
>     Compressing objects: 100% (32953/32953), done.
>     Writing objects: 100% (196207/196207), 66.45 MiB | 4047 KiB/s, do=
ne.
>     Total 196207 (delta 163379), reused 191592 (delta 159243)
>     To /media/Stalin/tmp/glibc
>      * [new branch]      t/____longjmp_chk_cleanup_linux_x86_64 -> t/=
____longjmp_chk_cleanup_linux_x86_64
>      * [new branch]      refs/top-bases/t/____longjmp_chk_cleanup_lin=
ux_x86_64 -> refs/top-bases/t/____longjmp_chk_cleanup_linux_x86_64
>=20
>=20
>  tg-push.sh |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/tg-push.sh b/tg-push.sh
> index cd208a0..28cad81 100644
> --- a/tg-push.sh
> +++ b/tg-push.sh
> @@ -71,6 +71,9 @@ for name in $branches; do
>  	$recurse_deps && [ -n "$_dep_is_tgish" ] &&
>  		no_remotes=3D1 recurse_deps push_branch "$name"
> =20
> +	# filter out plain SHA1s
>  	# remove multiple occurrences of the same branch
> -	sort -u "$_listfile" | xargs git push $dry_run "$remote"
> +	grep -vE '^[0-9a-f]{40}$' < "$_listfile" \
> +		| sort -u \
> +			| xargs git push $dry_run "$remote"
>  done
probably this is good enough.  Still I wonder if there is a better way
to detect if a given rev is a sha1 or a branch.

test "$(git rev-parse "$rev")" =3D "$rev"

comes to mind.  Anybody who gives names to branches that match
^[0-9a-f]{40}$ has other problems probably.

I think I will take it anyhow (and fix up the broken indention).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
