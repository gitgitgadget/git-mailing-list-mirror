From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH] git submodule foreach: Skip eval for more than one
 argument
Date: Tue, 4 Mar 2014 14:51:06 +0100
Message-ID: <20140304135106.GD11566@login.drsnuggles.stderr.nl>
References: <alpine.DEB.2.00.1309261605330.20647@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZjUm/5Ww7TTYVW0y"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Mar 04 14:51:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKpkb-0006HK-8A
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 14:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757238AbaCDNvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 08:51:12 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:57990 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185AbaCDNvL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 08:51:11 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1WKpkQ-00069P-F6; Tue, 04 Mar 2014 14:51:07 +0100
Received: (nullmailer pid 23645 invoked by uid 1000);
	Tue, 04 Mar 2014 13:51:06 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Anders Kaseorg <andersk@MIT.EDU>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1309261605330.20647@dr-wily.mit.edu>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243342>


--ZjUm/5Ww7TTYVW0y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey folks,

On Thu, Sep 26, 2013 at 04:10:15PM -0400, Anders Kaseorg wrote:
> =E2=80=98eval "$@"=E2=80=99 created an extra layer of shell interpretatio=
n, which was
> probably not expected by a user who passed multiple arguments to git
> submodule foreach:

It seems this patch has broken the use of $name, $path, etc. inside the
command ran by foreach (when it contains more than one argument):


matthijs@grubby:~/test$ git --version
git version 1.9.0
matthijs@grubby:~/test$ git submodule foreach echo '$name'
Entering 'test'
$name

But it works on the single-argument version:

matthijs@grubby:~/test$ git submodule foreach 'echo $name'
Entering 'test'
test

And it used to work in older versions:

matthijs@login:~/test$ git --version
git version 1.7.5.4
matthijs@login:~/test$ git submodule foreach 'echo $name'
Entering 'test'
test
matthijs@login:~/test$ git submodule foreach echo '$name'
Entering 'test'
test


I'm not sure how to fix this exactly. Adding "export" for the variables in
git-submodule.sh seems obvious but doesn't seem to be a complete solution. =
This
makes the variables available in the environment of any commands called (so=
 git
submodule sh -c 'echo $name') works, but the git submodule foreach echo '$n=
ame'
above still doesn't work, since the "$@" used does not do any substitution,=
 it
just executes $@ as a commandline unmodified. Ideally, you would do variable
substitution, but not word splitting, but I'm not sure how to do that. Also,
you'd still need one more layer of backslash escapes, which is probably what
this commit wanted to prevent...

Note that saying "you should use the single argument version if you need
those variables" doesn't seem possible in all cases. In particular, I'm
creating an alias that calls git submodule foreach, where the alias
contains part of the command and the rest of command comes from
arguments to the alias, meaning we always have at least two arguments...

Finally, the new behaviour (e.g., eval with one argument, directly
execute with multiple) is not documented in the manpage, but it seems
relevant enough to need documentation?

Gr.

Matthijs

>=20
> $ git grep "'"
> [searches for single quotes]
> $ git submodule foreach git grep "'"
> Entering '[submodule]'
> /usr/lib/git-core/git-submodule: 1: eval: Syntax error: Unterminated quot=
ed string
> Stopping at '[submodule]'; script returned non-zero status.
>=20
> To fix this, if the user passed more than one argument, just execute
> "$@" directly instead of passing it to eval.
>=20
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  git-submodule.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/git-submodule.sh b/git-submodule.sh
> index c17bef1..3381864 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -545,7 +545,12 @@ cmd_foreach()
>  				sm_path=3D$(relative_path "$sm_path") &&
>  				# we make $path available to scripts ...
>  				path=3D$sm_path &&
> -				eval "$@" &&
> +				if [ $# -eq 1 ]
> +				then
> +					eval "$1"
> +				else
> +					"$@"
> +				fi &&
>  				if test -n "$recursive"
>  				then
>  					cmd_foreach "--recursive" "$@"
> --=20
> 1.8.4
>=20
>=20
>=20

--ZjUm/5Ww7TTYVW0y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlMV2koACgkQz0nQ5oovr7yBUwCcCyqLMnw7UWnwzs2kSa4IN3VC
eX0AoNNztkcbjrMWayZgXnSinFbShtHK
=ZOSh
-----END PGP SIGNATURE-----

--ZjUm/5Ww7TTYVW0y--
