From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v1 23/45] check-ignore: convert to use parse_pathspec
Date: Fri, 12 Apr 2013 16:03:05 +0100
Message-ID: <20130412150304.GH26949@pacific.linksys.moosehall>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-24-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 17:03:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQfVR-0000Wz-LU
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 17:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab3DLPDI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 11:03:08 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:33106 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab3DLPDH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 11:03:07 -0400
Received: from localhost (0.4.0.0.6.9.f.2.8.9.8.0.5.f.0.9.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:90f5:898:2f96:40])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 260A22E330;
	Fri, 12 Apr 2013 16:03:06 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1363327620-29017-24-git-send-email-pclouds@gmail.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220984>

On Fri, Mar 15, 2013 at 01:06:38PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> check-ignore (at least the test suite) seems to rely on the pattern
> order. PATHSPEC_KEEP_ORDER is introduced to explictly express this.
> The lack of PATHSPEC_MAXDEPTH_VALID is sufficient because it's the
> only flag that reorders pathspecs, but it's less obvious that way.

Sorry for the slow response - I only just noticed this today.  (It
would be useful if any future patches to check-ignore Cc: me
explicitly, to catch my mail filters.)

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/check-ignore.c | 34 +++++++++++++++++++++-------------
>  pathspec.c             |  6 +++++-
>  pathspec.h             |  1 +
>  t/t0008-ignores.sh     |  8 ++++----
>  4 files changed, 31 insertions(+), 18 deletions(-)
>=20
> diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
> index 0240f99..6e55f06 100644
> --- a/builtin/check-ignore.c
> +++ b/builtin/check-ignore.c
> @@ -53,14 +53,14 @@ static void output_exclude(const char *path, stru=
ct exclude *exclude)
>  	}
>  }
> =20
> -static int check_ignore(const char *prefix, const char **pathspec)
> +static int check_ignore(int argc, const char **argv, const char *pre=
fix)
>  {
>  	struct dir_struct dir;
> -	const char *path, *full_path;
>  	char *seen;
>  	int num_ignored =3D 0, dtype =3D DT_UNKNOWN, i;
>  	struct path_exclude_check check;
>  	struct exclude *exclude;
> +	struct pathspec pathspec;
> =20
>  	/* read_cache() is only necessary so we can watch out for submodule=
s. */
>  	if (read_cache() < 0)
> @@ -70,31 +70,39 @@ static int check_ignore(const char *prefix, const=
 char **pathspec)
>  	dir.flags |=3D DIR_COLLECT_IGNORED;
>  	setup_standard_excludes(&dir);
> =20
> -	if (!pathspec || !*pathspec) {
> +	if (!argc) {

Is there a compelling reason for introducing argc as a new parameter
to check_ignore(), other than simplifying the above line?  And why
rename the pathspec parameter to argv?  Both these changes are
misleading AFAICS, since paths provided to check_ignore() can come
from sources other than CLI arguments (i.e. via --stdin). =20

The introduction of argc also makes it possible to invoke
check_ignore() with arguments which are not self-consistent.

I haven't been following your pathspec work, but FWIW the other
changes in this patch look reasonable at a glance.

Thanks,
Adam
