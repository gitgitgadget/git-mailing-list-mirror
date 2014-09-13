From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH] archive: support filtering paths with glob
Date: Sat, 13 Sep 2014 12:52:49 +0200
Message-ID: <1433062.XhRCATRB3s@al>
References: <7752133.8a4hJ4krff@al> <1409837872-20837-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 12:53:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSkwt-0001af-Rh
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 12:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbaIMKwz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Sep 2014 06:52:55 -0400
Received: from lekensteyn.nl ([178.21.112.251]:33628 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbaIMKwy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Sep 2014 06:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=N3MsUOpcd3iue/nEjz3qyQT3KkvCi9CMMFF+rviBmiA=;
	b=bHG8fFHo3/co5vNedsmqYD0ef2/ioWNTIgyws5YiIZyHqgFPOAE512qt4f351fU/JfFivgyCqS9OhMZ7LkE2ZHHlPCKuG8Zj7haLVxGFjZDGkr8h9rBXCR8gG6pNu7MXMjELvth2bQOstz1w8kqc8CkAjVsYWGpCZmCvMrkY+K3n/luOh5ACaHLbarq1CkbjZO75KTI83poet3/7RUDaFVfSK2S2d9MGXCAOgLBj0JXNExgXQyu6MroNeV4s8xJeSdKMsAeiaBRbVn+TafOMiOrHRIeubiDPuvk0PknEgLakiiUGsCsSUD9qzkQ+eQWQw6+LVLOS7fr39FvYATS22g==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XSkwj-0002xf-Qs; Sat, 13 Sep 2014 12:52:50 +0200
User-Agent: KMail/4.13.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.0; x86_64; ; )
In-Reply-To: <1409837872-20837-1-git-send-email-pclouds@gmail.com>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256961>

On Thursday 04 September 2014 20:37:52 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> This patch fixes two problems with using :(glob) (or even "*.c"
> without ":(glob)").
>=20
> The first one is we forgot to turn on the 'recursive' flag in struct
> pathspec. Without that, tree_entry_interesting() will not mark
> potential directories "interesting" so that it can confirm whether
> those directories have anything matching the pathspec.
>=20
> The marking directories interesting has a side effect that we need to
> walk inside a directory to realize that there's nothing interested in
> there. By that time, 'archive' code has already written the (empty)
> directory down. That means lots of empty directories in the result
> archive.
>=20
> This problem is fixed by lazily writing directories down when we know
> they are actually needed. There is a theoretical bug in this
> implementation: we can't write empty trees/directories that match tha=
t
> pathspec.
>=20
> Noticed-by: Peter Wu <peter@lekensteyn.nl>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Ah, ignore my last mail, I just noticed this one. This patch works fine=
=2E By the
way, the glob pattern is treated as a 'nullglob'. If you specify a glob=
 pattern
that matches nothing, an empty archive is created. Perhaps an error mes=
sage
should be raised for that as it is unlikely that a user wants that?

Tested-by: Peter Wu <peter@lekensteyn.nl>

> ---
>  Similar approach could probably be used for teaching ls-tree about p=
athspec..
>=20
>  archive.c           | 82 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++-
>  t/t5000-tar-tree.sh | 10 +++++++
>  2 files changed, 91 insertions(+), 1 deletion(-)
>=20
> diff --git a/archive.c b/archive.c
> index 3fc0fb2..9e62bf4 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -98,9 +98,19 @@ static void setup_archive_check(struct git_attr_ch=
eck *check)
>  	check[1].attr =3D attr_export_subst;
>  }
> =20
> +struct directory {
> +	struct directory *up;
> +	unsigned char sha1[20];
> +	int baselen, len;
> +	unsigned mode;
> +	int stage;
> +	char path[FLEX_ARRAY];
> +};
> +
>  struct archiver_context {
>  	struct archiver_args *args;
>  	write_archive_entry_fn_t write_entry;
> +	struct directory *bottom;
>  };
> =20
>  static int write_archive_entry(const unsigned char *sha1, const char=
 *base,
> @@ -146,6 +156,65 @@ static int write_archive_entry(const unsigned ch=
ar *sha1, const char *base,
>  	return write_entry(args, sha1, path.buf, path.len, mode);
>  }
> =20
> +static void queue_directory(const unsigned char *sha1,
> +		const char *base, int baselen, const char *filename,
> +		unsigned mode, int stage, struct archiver_context *c)
> +{
> +	struct directory *d;
> +	d =3D xmallocz(sizeof(*d) + baselen + 1 + strlen(filename));
> +	d->up	   =3D c->bottom;
> +	d->baselen =3D baselen;
> +	d->mode	   =3D mode;
> +	d->stage   =3D stage;
> +	c->bottom  =3D d;
> +	d->len =3D sprintf(d->path, "%.*s%s/", baselen, base, filename);
> +	hashcpy(d->sha1, sha1);
> +}
> +
> +static int write_directory(struct archiver_context *c)
> +{
> +	struct directory *d =3D c->bottom;
> +	int ret;
> +
> +	if (!d)
> +		return 0;
> +	c->bottom =3D d->up;
> +	d->path[d->len - 1] =3D '\0'; /* no trailing slash */
> +	ret =3D
> +		write_directory(c) ||
> +		write_archive_entry(d->sha1, d->path, d->baselen,
> +				    d->path + d->baselen, d->mode,
> +				    d->stage, c) !=3D READ_TREE_RECURSIVE;
> +	free(d);
> +	return ret ? -1 : 0;
> +}
> +
> +static int queue_or_write_archive_entry(const unsigned char *sha1,
> +		const char *base, int baselen, const char *filename,
> +		unsigned mode, int stage, void *context)
> +{
> +	struct archiver_context *c =3D context;
> +
> +	while (c->bottom &&
> +	       !(baselen >=3D c->bottom->len &&
> +		 !strncmp(base, c->bottom->path, c->bottom->len))) {
> +		struct directory *next =3D c->bottom->up;
> +		free(c->bottom);
> +		c->bottom =3D next;
> +	}
> +
> +	if (S_ISDIR(mode)) {
> +		queue_directory(sha1, base, baselen, filename,
> +				mode, stage, c);
> +		return READ_TREE_RECURSIVE;
> +	}
> +
> +	if (write_directory(c))
> +		return -1;
> +	return write_archive_entry(sha1, base, baselen, filename, mode,
> +				   stage, context);
> +}
> +
>  int write_archive_entries(struct archiver_args *args,
>  		write_archive_entry_fn_t write_entry)
>  {
> @@ -167,6 +236,7 @@ int write_archive_entries(struct archiver_args *a=
rgs,
>  			return err;
>  	}
> =20
> +	memset(&context, 0, sizeof(context));
>  	context.args =3D args;
>  	context.write_entry =3D write_entry;
> =20
> @@ -187,9 +257,17 @@ int write_archive_entries(struct archiver_args *=
args,
>  	}
> =20
>  	err =3D read_tree_recursive(args->tree, "", 0, 0, &args->pathspec,
> -				  write_archive_entry, &context);
> +				  args->pathspec.has_wildcard ?
> +				  queue_or_write_archive_entry :
> +				  write_archive_entry,
> +				  &context);
>  	if (err =3D=3D READ_TREE_RECURSIVE)
>  		err =3D 0;
> +	while (context.bottom) {
> +		struct directory *next =3D context.bottom->up;
> +		free(context.bottom);
> +		context.bottom =3D next;
> +	}
>  	return err;
>  }
> =20
> @@ -221,6 +299,7 @@ static int path_exists(struct tree *tree, const c=
har *path)
>  	int ret;
> =20
>  	parse_pathspec(&pathspec, 0, 0, "", paths);
> +	pathspec.recursive =3D 1;
>  	ret =3D read_tree_recursive(tree, "", 0, 0, &pathspec, reject_entry=
, NULL);
>  	free_pathspec(&pathspec);
>  	return ret !=3D 0;
> @@ -237,6 +316,7 @@ static void parse_pathspec_arg(const char **paths=
pec,
>  	parse_pathspec(&ar_args->pathspec, 0,
>  		       PATHSPEC_PREFER_FULL,
>  		       "", pathspec);
> +	ar_args->pathspec.recursive =3D 1;
>  	if (pathspec) {
>  		while (*pathspec) {
>  			if (**pathspec && !path_exists(ar_args->tree, *pathspec))
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 7b8babd..ade7a7f 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -305,4 +305,14 @@ test_expect_success GZIP 'remote tar.gz can be d=
isabled' '
>  		>remote.tar.gz
>  '
> =20
> +test_expect_success 'archive and :(glob)' '
> +	git archive -v HEAD -- ":(glob)**/sh" >/dev/null 2>actual &&
> +	cat >expect <<EOF &&
> +a/
> +a/bin/
> +a/bin/sh
> +EOF
> +	test_cmp expect actual
> +'
> +
>  test_done
