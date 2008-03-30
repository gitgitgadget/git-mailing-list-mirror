From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 01:55:13 +0200
Message-ID: <20080330235513.GA23259@atjola.homenet>
References: <20080330231408.GR11666@genesis> <20080330232612.GA23063@atjola.homenet> <20080330233916.GU11666@genesis>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 01:56:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7NX-0007aA-UU
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 01:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbYC3XzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2008 19:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbYC3XzR
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 19:55:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:56704 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752758AbYC3XzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 19:55:17 -0400
Received: (qmail invoked by alias); 30 Mar 2008 23:55:14 -0000
Received: from i577ADF86.versanet.de (EHLO atjola.local) [87.122.223.134]
  by mail.gmx.net (mp051) with SMTP; 31 Mar 2008 01:55:14 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19Srb41Ka1SmXBjaH0suGZLKC7r206B7YUdHsugeU
	y3XpDz67SJgkFd
Content-Disposition: inline
In-Reply-To: <20080330233916.GU11666@genesis>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78533>

On 2008.03.31 01:39:16 +0200, Miklos Vajna wrote:
> This patch modifies git gc --auto so that it will not always repack w=
hen
> a user is on battery.
>=20
> It introduces the new gc.deferonbattery configuration variable, which
> defaults to true. If it's true and the user is on battery, it will no=
t
> run git gc --auto.
>=20
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>=20
> On Mon, Mar 31, 2008 at 01:26:12AM +0200, Bj=F6rn Steinbrink <B.Stein=
brink@gmx.de> wrote:
> > Hm, maybe move that check into need_to_gc instead? Seems a bit weir=
d
> > to
> > lie about the status instead of just skipping the status check.
>=20
> Right, I've moved the check to need_to_gc().
>=20
> > The /proc stuff is already deprecated IIRC, the new file to check o=
n
> > Linux is /sys/class/power_supply/AC/online.
>=20
> And that makes the patch smaller as well. :)

Oh, oops, I didn't meant to say that you should remove the /proc/*
checks, just that they'll probably break in the future and that the new
location needs to be added. Those running older kernels should probably
not be excluded ;-)

Bj=F6rn

> Something like this?
>=20
>  Documentation/git-gc.txt |    4 ++++
>  builtin-gc.c             |   24 ++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index d424a4e..7d54148 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -104,6 +104,10 @@ The optional configuration variable 'gc.pruneExp=
ire' controls how old
>  the unreferenced loose objects have to be before they are pruned.  T=
he
>  default is "2 weeks ago".
> =20
> +The optional configuration variable 'gc.deferonbattery' determines i=
f
> +`git gc --auto` should be disabled if the system is running on batte=
ry.
> +This defaults to true.
> +
>  See Also
>  --------
>  linkgit:git-prune[1]
> diff --git a/builtin-gc.c b/builtin-gc.c
> index 8cef36f..512a357 100644
> --- a/builtin-gc.c
> +++ b/builtin-gc.c
> @@ -23,6 +23,7 @@ static const char * const builtin_gc_usage[] =3D {
>  };
> =20
>  static int pack_refs =3D 1;
> +static int defer_on_battery =3D 1;
>  static int aggressive_window =3D -1;
>  static int gc_auto_threshold =3D 6700;
>  static int gc_auto_pack_limit =3D 50;
> @@ -67,6 +68,10 @@ static int gc_config(const char *var, const char *=
value)
>  		prune_expire =3D xstrdup(value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "gc.deferonbattery")) {
> +		defer_on_battery =3D git_config_bool(var, value);
> +		return 0;
> +	}
>  	return git_default_config(var, value);
>  }
> =20
> @@ -157,6 +162,20 @@ static int too_many_packs(void)
>  	return gc_auto_pack_limit <=3D cnt;
>  }
> =20
> +static int is_on_battery(void)
> +{
> +	FILE *fp;
> +	unsigned int state =3D 1;
> +
> +	if ((fp =3D fopen("/sys/class/power_supply/AC/online", "r"))) {
> +		if (fscanf(fp, "%d", &state) !=3D 1)
> +			state =3D 1;
> +		fclose(fp);
> +		return state !=3D 1;
> +	}
> +	return 0;
> +}
> +
>  static int need_to_gc(void)
>  {
>  	/*
> @@ -176,6 +195,11 @@ static int need_to_gc(void)
>  		append_option(argv_repack, "-A", MAX_ADD);
>  	else if (!too_many_loose_objects())
>  		return 0;
> +
> +	if(defer_on_battery && is_on_battery()) {
> +		fprintf(stderr, "Auto packing deferred; on battery");
> +		return 0;
> +	}
>  	return 1;
>  }
> =20
