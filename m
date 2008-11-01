From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Introduce receive.denyDeletes
Date: Sat, 1 Nov 2008 11:07:06 -0700
Message-ID: <20081101180705.GA14706@spearce.org>
References: <20081030191134.62455c24@perceptron> <20081030183210.GO14786@spearce.org> <20081030194503.2f9ece1a@perceptron> <7v63n99omx.fsf@gitster.siamese.dyndns.org> <20081031143022.GQ14786@spearce.org> <20081101154216.45021eee@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jan Krrrger <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Nov 01 19:11:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwKvy-0008Rc-43
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 19:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbYKASHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Nov 2008 14:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbYKASHH
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 14:07:07 -0400
Received: from george.spearce.org ([209.20.77.23]:46805 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYKASHH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 14:07:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0F16D3835F; Sat,  1 Nov 2008 18:07:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081101154216.45021eee@perceptron>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99755>

Jan Krrrger <jk@jk.gs> wrote:
> Occasionally, it may be useful to prevent branches from getting delet=
ed from
> a centralized repository, particularly when no administrative access =
to the
> server is available to undo it via reflog. It also makes
> receive.denyNonFastForwards more useful if it is used for access cont=
rol
> since it prevents force-updating by deleting and re-creating a ref.
>=20
> Signed-off-by: Jan Kr=FCger <jk@jk.gs>
> ---
> Like this, then?

Acked-by: Shawn O. Pearce <spearce@spearce.org>
=20
>  Documentation/config.txt |    4 ++++
>  builtin-receive-pack.c   |   12 ++++++++++++
>  t/t5400-send-pack.sh     |   11 +++++++++++
>  3 files changed, 27 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 29369d0..965ed74 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1188,6 +1188,10 @@ receive.unpackLimit::
>  	especially on slow filesystems.  If not set, the value of
>  	`transfer.unpackLimit` is used instead.
> =20
> +receive.denyDeletes::
> +	If set to true, git-receive-pack will deny a ref update that delete=
s
> +	the ref. Use this to prevent such a ref deletion via a push.
> +
>  receive.denyNonFastForwards::
>  	If set to true, git-receive-pack will deny a ref update which is
>  	not a fast forward. Use this to prevent such an update via a push,
> diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
> index 9f60f31..2c0225c 100644
> --- a/builtin-receive-pack.c
> +++ b/builtin-receive-pack.c
> @@ -11,6 +11,7 @@
> =20
>  static const char receive_pack_usage[] =3D "git-receive-pack <git-di=
r>";
> =20
> +static int deny_deletes =3D 0;
>  static int deny_non_fast_forwards =3D 0;
>  static int receive_fsck_objects;
>  static int receive_unpack_limit =3D -1;
> @@ -23,6 +24,11 @@ static int capabilities_sent;
> =20
>  static int receive_pack_config(const char *var, const char *value, v=
oid *cb)
>  {
> +	if (strcmp(var, "receive.denydeletes") =3D=3D 0) {
> +		deny_deletes =3D git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (strcmp(var, "receive.denynonfastforwards") =3D=3D 0) {
>  		deny_non_fast_forwards =3D git_config_bool(var, value);
>  		return 0;
> @@ -185,6 +191,12 @@ static const char *update(struct command *cmd)
>  		      "but I can't find it!", sha1_to_hex(new_sha1));
>  		return "bad pack";
>  	}
> +	if (deny_deletes && is_null_sha1(new_sha1) &&
> +	    !is_null_sha1(old_sha1) &&
> +	    !prefixcmp(name, "refs/heads/")) {
> +		error("denying ref deletion for %s", name);
> +		return "deletion prohibited";
> +	}
>  	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
>  	    !is_null_sha1(old_sha1) &&
>  	    !prefixcmp(name, "refs/heads/")) {
> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> index 544771d..6fe2f87 100755
> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -103,6 +103,17 @@ unset GIT_CONFIG GIT_CONFIG_LOCAL
>  HOME=3D`pwd`/no-such-directory
>  export HOME ;# this way we force the victim/.git/config to be used.
> =20
> +test_expect_failure \
> +	'pushing a delete should be denied with denyDeletes' '
> +	cd victim &&
> +	git config receive.denyDeletes true &&
> +	git branch extra master &&
> +	cd .. &&
> +	test -f victim/.git/refs/heads/extra &&
> +	test_must_fail git send-pack ./victim/.git/ :extra master
> +'
> +rm -f victim/.git/refs/heads/extra
> +
>  test_expect_success \
>          'pushing with --force should be denied with denyNonFastforwa=
rds' '
>  	cd victim &&
> --=20
> 1.6.0.3.524.g86cf.dirty

--=20
Shawn.
