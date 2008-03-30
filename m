From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 01:26:12 +0200
Message-ID: <20080330232612.GA23063@atjola.homenet>
References: <20080330231408.GR11666@genesis>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 01:26:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg6vS-00010h-HH
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 01:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbYC3X0P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2008 19:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYC3X0P
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 19:26:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:36912 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751237AbYC3X0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 19:26:14 -0400
Received: (qmail invoked by alias); 30 Mar 2008 23:26:13 -0000
Received: from i577ADF86.versanet.de (EHLO atjola.local) [87.122.223.134]
  by mail.gmx.net (mp029) with SMTP; 31 Mar 2008 01:26:13 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX182Xn8bOFI2wmQeQnrymbufvzMK5oKg1y+lHiMVRS
	F0J78DVEwIVsPU
Content-Disposition: inline
In-Reply-To: <20080330231408.GR11666@genesis>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78525>

On 2008.03.31 01:14:08 +0200, Miklos Vajna wrote:
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
> Idea is from e2fsprogs, such a repack may take a lot of time and usua=
lly
> you don't have infinite time when you are on battery.. :)
>=20
> If the patch looks OK, just it's too late for 1.5.5, then please let =
me
> know and I'll resend after 1.5.5.
>=20
> Thanks.
>=20
>  Documentation/git-gc.txt |    4 +++
>  builtin-gc.c             |   49 ++++++++++++++++++++++++++++++++++++=
++++++++++
>  2 files changed, 53 insertions(+), 0 deletions(-)
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
> index 8cef36f..7beb046 100644
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
> @@ -157,6 +162,45 @@ static int too_many_packs(void)
>  	return gc_auto_pack_limit <=3D cnt;
>  }
> =20
> +static int is_on_battery(void)
> +{
> +	FILE *fp;
> +	DIR *dir;
> +	char buf[256], state[256], path[256];
> +	unsigned int ac =3D 0;
> +	struct dirent* entry;
> +
> +	if (!defer_on_battery)
> +		return 0;

Hm, maybe move that check into need_to_gc instead? Seems a bit weird to
lie about the status instead of just skipping the status check.

> +
> +	if ((fp =3D fopen("/proc/apm", "r"))) {
> +		if (fscanf(fp, "%s %s %s %x", buf, buf, buf, &ac) !=3D 4)
> +			ac =3D 1;
> +		fclose(fp);
> +		return ac !=3D 1;
> +	}
> +	if((dir =3D opendir("/proc/acpi/ac_adapter"))) {
> +		while ((entry =3D readdir(dir))) {
> +			if (!strcmp(".", entry->d_name) || !strcmp("..",
> +						entry->d_name))
> +				continue;
> +			snprintf(path, 255, "/proc/acpi/ac_adapter/%s/state",
> +					entry->d_name);
> +			if ((fp =3D fopen(path, "r"))) {
> +				if (fscanf(fp, "%s %s", buf, state) !=3D 2)
> +					state[0] =3D '\0';
> +				fclose(fp);
> +				if (!strncmp(state, "off-line", 8)) {
> +					closedir(dir);
> +					return 1;
> +				}
> +			}
> +		}
> +		closedir(dir);
> +	}
> +	return 0;
> +}

The /proc stuff is already deprecated IIRC, the new file to check on
Linux is /sys/class/power_supply/AC/online.

Bj=F6rn

> +
>  static int need_to_gc(void)
>  {
>  	/*
> @@ -176,6 +220,11 @@ static int need_to_gc(void)
>  		append_option(argv_repack, "-A", MAX_ADD);
>  	else if (!too_many_loose_objects())
>  		return 0;
> +
> +	if(is_on_battery()) {
> +		fprintf(stderr, "Auto packing deferred; on battery");
> +		return 0;
> +	}
>  	return 1;
>  }
> =20
