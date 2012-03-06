From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/11] archive: support streaming large files to a tar
 archive
Date: Mon, 05 Mar 2012 16:57:47 -0800
Message-ID: <7vmx7uwnp0.fsf@alter.siamese.dyndns.org>
References: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
 <1330919028-6611-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 01:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4ij0-0001tQ-9R
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 01:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640Ab2CFA5w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 19:57:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932608Ab2CFA5v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 19:57:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0850E67C2;
	Mon,  5 Mar 2012 19:57:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=pHBleKOtnOxjMeJacQjXPeJpC
	AA=; b=W8VZT78U+D4pdawyeasxSfTmpCenqxAk3asoieu/yl4YjD5UAfTExqAJ6
	M6/cyBo4J9lf6naqhMomT+KlCoi+b2P1iYusamBZ0alj7SQR+2hCrnhxrZInnRg1
	fwX+6u6BNtp5xufj/TWmyoYtY2hxPhFHHxTL0Pv1Qqq9MrOB/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=c0NV718hyCiaRlYKCc2
	vkMazMIJZxyBBty837lAU8zci6Q2goHmkt7F/pVfyRFJ5SHtCRbv2ePeovwlXwT/
	jrFzCgEZECDfcsR/7m64qgJ9fezy6SMO6LUtjNCRzPn9YKGQG0faXyvy6Zxbp0ry
	vcM/SKHuFnQNsF+7tmKzx0M0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0019E67C1;
	Mon,  5 Mar 2012 19:57:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DFEC67C0; Mon,  5 Mar 2012
 19:57:49 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64DBB2D2-6727-11E1-BC7F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192293>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

This is *way* *too* underdocumented.

=46or example, it is totally unclear from the patch what determines
the last parameter to write_archive_entries(), OK_TO_STREAM.  Does
it depend on the nature of the payload?  Does the backend decide it,
in other words, if it is prepared to read from a streaming API or not?

I wanted to first take all the "do not slurp things in core, and
instead read from streaming API" patches from this series, but I
had to stop at this one.

> ---
>  archive-tar.c    |   35 ++++++++++++++++++++++++++++-------
>  archive-zip.c    |    9 +++++----
>  archive.c        |   51 ++++++++++++++++++++++++++++++++++----------=
-------
>  archive.h        |   11 +++++++++--
>  t/t1050-large.sh |    2 +-
>  5 files changed, 77 insertions(+), 31 deletions(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index 20af005..5bffe49 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -5,6 +5,7 @@
>  #include "tar.h"
>  #include "archive.h"
>  #include "run-command.h"
> +#include "streaming.h"
> =20
>  #define RECORDSIZE	(512)
>  #define BLOCKSIZE	(RECORDSIZE * 20)
> @@ -123,9 +124,29 @@ static size_t get_path_prefix(const char *path, =
size_t pathlen, size_t maxlen)
>  	return i;
>  }
> =20
> +static void write_file(struct git_istream *stream, const void *buffe=
r,
> +		       unsigned long size)
> +{
> +	if (!stream) {
> +		write_blocked(buffer, size);
> +		return;
> +	}
> +	for (;;) {
> +		char buf[1024 * 16];
> +		ssize_t readlen;
> +
> +		readlen =3D read_istream(stream, buf, sizeof(buf));
> +
> +		if (!readlen)
> +			break;
> +		write_blocked(buf, readlen);
> +	}
> +}
> +
>  static int write_tar_entry(struct archiver_args *args,
> -		const unsigned char *sha1, const char *path, size_t pathlen,
> -		unsigned int mode, void *buffer, unsigned long size)
> +			   const unsigned char *sha1, const char *path,
> +			   size_t pathlen, unsigned int mode, void *buffer,
> +			   struct git_istream *stream, unsigned long size)
>  {
>  	struct ustar_header header;
>  	struct strbuf ext_header =3D STRBUF_INIT;
> @@ -200,14 +221,14 @@ static int write_tar_entry(struct archiver_args=
 *args,
> =20
>  	if (ext_header.len > 0) {
>  		err =3D write_tar_entry(args, sha1, NULL, 0, 0, ext_header.buf,
> -				ext_header.len);
> +				      NULL, ext_header.len);
>  		if (err)
>  			return err;
>  	}
>  	strbuf_release(&ext_header);
>  	write_blocked(&header, sizeof(header));
> -	if (S_ISREG(mode) && buffer && size > 0)
> -		write_blocked(buffer, size);
> +	if (S_ISREG(mode) && size > 0)
> +		write_file(stream, buffer, size);
>  	return err;
>  }
> =20
> @@ -219,7 +240,7 @@ static int write_global_extended_header(struct ar=
chiver_args *args)
> =20
>  	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1),=
 40);
>  	err =3D write_tar_entry(args, NULL, NULL, 0, 0, ext_header.buf,
> -			ext_header.len);
> +			      NULL, ext_header.len);
>  	strbuf_release(&ext_header);
>  	return err;
>  }
> @@ -308,7 +329,7 @@ static int write_tar_archive(const struct archive=
r *ar,
>  	if (args->commit_sha1)
>  		err =3D write_global_extended_header(args);
>  	if (!err)
> -		err =3D write_archive_entries(args, write_tar_entry);
> +		err =3D write_archive_entries(args, write_tar_entry, 1);
>  	if (!err)
>  		write_trailer();
>  	return err;
> diff --git a/archive-zip.c b/archive-zip.c
> index 02d1f37..4a1e917 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -120,9 +120,10 @@ static void *zlib_deflate(void *data, unsigned l=
ong size,
>  	return buffer;
>  }
> =20
> -static int write_zip_entry(struct archiver_args *args,
> -		const unsigned char *sha1, const char *path, size_t pathlen,
> -		unsigned int mode, void *buffer, unsigned long size)
> +int write_zip_entry(struct archiver_args *args,
> +			   const unsigned char *sha1, const char *path,
> +			   size_t pathlen, unsigned int mode, void *buffer,
> +			   struct git_istream *stream, unsigned long size)
>  {
>  	struct zip_local_header header;
>  	struct zip_dir_header dirent;
> @@ -271,7 +272,7 @@ static int write_zip_archive(const struct archive=
r *ar,
>  	zip_dir =3D xmalloc(ZIP_DIRECTORY_MIN_SIZE);
>  	zip_dir_size =3D ZIP_DIRECTORY_MIN_SIZE;
> =20
> -	err =3D write_archive_entries(args, write_zip_entry);
> +	err =3D write_archive_entries(args, write_zip_entry, 0);
>  	if (!err)
>  		write_zip_trailer(args->commit_sha1);
> =20
> diff --git a/archive.c b/archive.c
> index 1ee837d..257eadf 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -5,6 +5,7 @@
>  #include "archive.h"
>  #include "parse-options.h"
>  #include "unpack-trees.h"
> +#include "streaming.h"
> =20
>  static char const * const archive_usage[] =3D {
>  	"git archive [options] <tree-ish> [<path>...]",
> @@ -59,26 +60,35 @@ static void format_subst(const struct commit *com=
mit,
>  	free(to_free);
>  }
> =20
> -static void *sha1_file_to_archive(const char *path, const unsigned c=
har *sha1,
> -		unsigned int mode, enum object_type *type,
> -		unsigned long *sizep, const struct commit *commit)
> +void sha1_file_to_archive(void **buffer, struct git_istream **stream=
,
> +			  const char *path, const unsigned char *sha1,
> +			  unsigned int mode, enum object_type *type,
> +			  unsigned long *sizep,
> +			  const struct commit *commit)
>  {
> -	void *buffer;
> +	if (stream) {
> +		struct stream_filter *filter;
> +		filter =3D get_stream_filter(path, sha1);
> +		if (!commit && S_ISREG(mode) && is_null_stream_filter(filter)) {
> +			*buffer =3D NULL;
> +			*stream =3D open_istream(sha1, type, sizep, NULL);
> +			return;
> +		}
> +		*stream =3D NULL;
> +	}
> =20
> -	buffer =3D read_sha1_file(sha1, type, sizep);
> -	if (buffer && S_ISREG(mode)) {
> +	*buffer =3D read_sha1_file(sha1, type, sizep);
> +	if (*buffer && S_ISREG(mode)) {
>  		struct strbuf buf =3D STRBUF_INIT;
>  		size_t size =3D 0;
> =20
> -		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
> +		strbuf_attach(&buf, *buffer, *sizep, *sizep + 1);
>  		convert_to_working_tree(path, buf.buf, buf.len, &buf);
>  		if (commit)
>  			format_subst(commit, buf.buf, buf.len, &buf);
> -		buffer =3D strbuf_detach(&buf, &size);
> +		*buffer =3D strbuf_detach(&buf, &size);
>  		*sizep =3D size;
>  	}
> -
> -	return buffer;
>  }
> =20
>  static void setup_archive_check(struct git_attr_check *check)
> @@ -97,6 +107,7 @@ static void setup_archive_check(struct git_attr_ch=
eck *check)
>  struct archiver_context {
>  	struct archiver_args *args;
>  	write_archive_entry_fn_t write_entry;
> +	int stream_ok;
>  };
> =20
>  static int write_archive_entry(const unsigned char *sha1, const char=
 *base,
> @@ -109,6 +120,7 @@ static int write_archive_entry(const unsigned cha=
r *sha1, const char *base,
>  	write_archive_entry_fn_t write_entry =3D c->write_entry;
>  	struct git_attr_check check[2];
>  	const char *path_without_prefix;
> +	struct git_istream *stream =3D NULL;
>  	int convert =3D 0;
>  	int err;
>  	enum object_type type;
> @@ -133,25 +145,29 @@ static int write_archive_entry(const unsigned c=
har *sha1, const char *base,
>  		strbuf_addch(&path, '/');
>  		if (args->verbose)
>  			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> -		err =3D write_entry(args, sha1, path.buf, path.len, mode, NULL, 0)=
;
> +		err =3D write_entry(args, sha1, path.buf, path.len, mode, NULL, NU=
LL, 0);
>  		if (err)
>  			return err;
>  		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
>  	}
> =20
> -	buffer =3D sha1_file_to_archive(path_without_prefix, sha1, mode,
> -			&type, &size, convert ? args->commit : NULL);
> -	if (!buffer)
> +	sha1_file_to_archive(&buffer, c->stream_ok ? &stream : NULL,
> +			     path_without_prefix, sha1, mode,
> +			     &type, &size, convert ? args->commit : NULL);
> +	if (!buffer && !stream)
>  		return error("cannot read %s", sha1_to_hex(sha1));
>  	if (args->verbose)
>  		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> -	err =3D write_entry(args, sha1, path.buf, path.len, mode, buffer, s=
ize);
> +	err =3D write_entry(args, sha1, path.buf, path.len, mode, buffer, s=
tream, size);
> +	if (stream)
> +		close_istream(stream);
>  	free(buffer);
>  	return err;
>  }
> =20
>  int write_archive_entries(struct archiver_args *args,
> -		write_archive_entry_fn_t write_entry)
> +			  write_archive_entry_fn_t write_entry,
> +			  int stream_ok)
>  {
>  	struct archiver_context context;
>  	struct unpack_trees_options opts;
> @@ -167,13 +183,14 @@ int write_archive_entries(struct archiver_args =
*args,
>  		if (args->verbose)
>  			fprintf(stderr, "%.*s\n", (int)len, args->base);
>  		err =3D write_entry(args, args->tree->object.sha1, args->base,
> -				len, 040777, NULL, 0);
> +				  len, 040777, NULL, NULL, 0);
>  		if (err)
>  			return err;
>  	}
> =20
>  	context.args =3D args;
>  	context.write_entry =3D write_entry;
> +	context.stream_ok =3D stream_ok;
> =20
>  	/*
>  	 * Setup index and instruct attr to read index only
> diff --git a/archive.h b/archive.h
> index 2b0884f..370cca9 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -27,9 +27,16 @@ extern void register_archiver(struct archiver *);
>  extern void init_tar_archiver(void);
>  extern void init_zip_archiver(void);
> =20
> -typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, =
const unsigned char *sha1, const char *path, size_t pathlen, unsigned i=
nt mode, void *buffer, unsigned long size);
> +struct git_istream;
> +typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
> +					const unsigned char *sha1,
> +					const char *path, size_t pathlen,
> +					unsigned int mode,
> +					void *buffer,
> +					struct git_istream *stream,
> +					unsigned long size);
> =20
> -extern int write_archive_entries(struct archiver_args *args, write_a=
rchive_entry_fn_t write_entry);
> +extern int write_archive_entries(struct archiver_args *args, write_a=
rchive_entry_fn_t write_entry, int stream_ok);
>  extern int write_archive(int argc, const char **argv, const char *pr=
efix, int setup_prefix, const char *name_hint, int remote);
> =20
>  const char *archive_format_from_filename(const char *filename);
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index 52acae5..5336eb8 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -151,7 +151,7 @@ test_expect_failure 'repack' '
>  	git repack -ad
>  '
> =20
> -test_expect_failure 'tar achiving' '
> +test_expect_success 'tar achiving' '
>  	git archive --format=3Dtar HEAD >/dev/null
>  '
