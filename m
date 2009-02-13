From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] When archiving a repository there is no way to specify
 a   file as output.
Date: Fri, 13 Feb 2009 23:32:17 +0100
Message-ID: <4995F4F1.1020709@lsrfire.ath.cx>
References: <599636D7828020419E3AB2DE5CCC8130036BF8B1D2@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: carlos.duclos@nokia.com
X-From: git-owner@vger.kernel.org Fri Feb 13 23:33:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY6bb-0006nN-6h
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 23:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbZBMWc0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2009 17:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbZBMWc0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 17:32:26 -0500
Received: from india601.server4you.de ([85.25.151.105]:47625 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbZBMWcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 17:32:25 -0500
Received: from [10.0.1.101] (p57B7F995.dip.t-dialin.net [87.183.249.149])
	by india601.server4you.de (Postfix) with ESMTPSA id 651BC2F8026;
	Fri, 13 Feb 2009 23:32:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <599636D7828020419E3AB2DE5CCC8130036BF8B1D2@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109781>

carlos.duclos@nokia.com schrieb:
> Hi,
>=20
> Short description:
> To enable that I added a new option "--output" that will redirect the=
 output to a file instead to stdout.
>=20
> Long description:
> When archiving a repository there is no way to send the result to a f=
ile without using redirection at shell level. Since there are situation=
s where redirection is not available, for instance when running git ins=
ide a continuous integration system which is already redirecting the ou=
tput, I added an option to write the archive to a file directly.
> In order to do that I added a new option to archiver_args, int output=
_fd, which holds the file descriptor where the resulting archive should=
 be written. If no option is specified in command line that option defa=
ults to 1 and no behavior change, however if the "--output" option is s=
pecified and the file was created that file descriptor points to the ne=
w file. I also modified the write_or_die calls to use "output_fd" inste=
ad of 1, so they write to the file descriptor.
>=20
> From 10e09bf828c18f2846651262b7f647b630e09872 Mon Sep 17 00:00:00 200=
1
> From: Carlos Manuel Duclos Vergara <carlos.duclos@trolltech.com>
> Date: Fri, 13 Feb 2009 16:09:39 +0100
> Subject: [PATCH] When archiving a repository there is no way to speci=
fy a file as output.
>  To enable that I added a new option "--output" that will redirect th=
e output to a file instead to stdout.
>=20
> Signed-off-by: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>
>=20
> ---
>  archive-tar.c |   16 ++++++++++++----
>  archive-zip.c |   21 ++++++++++++++-------
>  archive.c     |   20 ++++++++++++++++++++
>  archive.h     |    1 +
>  4 files changed, 47 insertions(+), 11 deletions(-)
>=20
> diff --git a/archive-tar.c b/archive-tar.c
> index ba890eb..4d8fc03 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -13,11 +13,13 @@ static unsigned long offset;
>=20
>  static int tar_umask =3D 002;
>=20
> +static int output_fd =3D 1;
> +

Static variables hinder libification, but there are already lots of the=
m in
the two archive backends, so I'm neutral on that.

>  /* writes out the whole block, but only if it is full */
>  static void write_if_needed(void)
>  {
>         if (offset =3D=3D BLOCKSIZE) {
> -               write_or_die(1, block, BLOCKSIZE);
> +               write_or_die(output_fd, block, BLOCKSIZE);
>                 offset =3D 0;
>         }
>  }
> @@ -42,7 +44,7 @@ static void write_blocked(const void *data, unsigne=
d long size)
>                 write_if_needed();
>         }
>         while (size >=3D BLOCKSIZE) {
> -               write_or_die(1, buf, BLOCKSIZE);
> +               write_or_die(output_fd, buf, BLOCKSIZE);
>                 size -=3D BLOCKSIZE;
>                 buf +=3D BLOCKSIZE;
>         }
> @@ -66,10 +68,10 @@ static void write_trailer(void)
>  {
>         int tail =3D BLOCKSIZE - offset;
>         memset(block + offset, 0, tail);
> -       write_or_die(1, block, BLOCKSIZE);
> +       write_or_die(output_fd, block, BLOCKSIZE);
>         if (tail < 2 * RECORDSIZE) {
>                 memset(block, 0, offset);
> -               write_or_die(1, block, BLOCKSIZE);
> +               write_or_die(output_fd, block, BLOCKSIZE);
>         }
>  }
>=20
> @@ -234,11 +236,17 @@ static int git_tar_config(const char *var, cons=
t char *value, void *cb)
>         return git_default_config(var, value, cb);
>  }
>=20
> +static void setup_write_backend(struct archiver_args *args)
> +{
> +       output_fd =3D args->output_fd;
> +}
> +

This wrapper doesn't buy you much and is only called once.  Please
just set output_fd directly below.

>  int write_tar_archive(struct archiver_args *args)
>  {
>         int err =3D 0;
>=20
>         git_config(git_tar_config, NULL);
> +       setup_write_backend(args);
>=20
>         if (args->commit_sha1)
>                 err =3D write_global_extended_header(args);
> diff --git a/archive-zip.c b/archive-zip.c
> index cf28504..dd3ba27 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -14,6 +14,8 @@ static unsigned int zip_offset;
>  static unsigned int zip_dir_offset;
>  static unsigned int zip_dir_entries;
>=20
> +static int output_fd =3D 1;
> +
>  #define ZIP_DIRECTORY_MIN_SIZE (1024 * 1024)
>=20
>  struct zip_local_header {
> @@ -219,12 +221,12 @@ static int write_zip_entry(struct archiver_args=
 *args,
>         copy_le32(header.size, uncompressed_size);
>         copy_le16(header.filename_length, pathlen);
>         copy_le16(header.extra_length, 0);
> -       write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
> +       write_or_die(output_fd, &header, ZIP_LOCAL_HEADER_SIZE);
>         zip_offset +=3D ZIP_LOCAL_HEADER_SIZE;
> -       write_or_die(1, path, pathlen);
> +       write_or_die(output_fd, path, pathlen);
>         zip_offset +=3D pathlen;
>         if (compressed_size > 0) {
> -               write_or_die(1, out, compressed_size);
> +               write_or_die(output_fd, out, compressed_size);
>                 zip_offset +=3D compressed_size;
>         }
>=20
> @@ -246,10 +248,10 @@ static void write_zip_trailer(const unsigned ch=
ar *sha1)
>         copy_le32(trailer.offset, zip_offset);
>         copy_le16(trailer.comment_length, sha1 ? 40 : 0);
>=20
> -       write_or_die(1, zip_dir, zip_dir_offset);
> -       write_or_die(1, &trailer, ZIP_DIR_TRAILER_SIZE);
> +       write_or_die(output_fd, zip_dir, zip_dir_offset);
> +       write_or_die(output_fd, &trailer, ZIP_DIR_TRAILER_SIZE);
>         if (sha1)
> -               write_or_die(1, sha1_to_hex(sha1), 40);
> +               write_or_die(output_fd, sha1_to_hex(sha1), 40);
>  }
>=20
>  static void dos_time(time_t *time, int *dos_date, int *dos_time)
> @@ -261,12 +263,17 @@ static void dos_time(time_t *time, int *dos_dat=
e, int *dos_time)
>         *dos_time =3D t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2=
048;
>  }
>=20
> +static void setup_write_backend(struct archiver_args *args)
> +{
> +       output_fd =3D args->output_fd;
> +}
> +

Same here.

>  int write_zip_archive(struct archiver_args *args)
>  {
>         int err;
>=20
>         dos_time(&args->time, &zip_date, &zip_time);
> -
> +       setup_write_backend(args);
>         zip_dir =3D xmalloc(ZIP_DIRECTORY_MIN_SIZE);
>         zip_dir_size =3D ZIP_DIRECTORY_MIN_SIZE;
>=20
> diff --git a/archive.c b/archive.c
> index e6de039..420b853 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -239,6 +239,16 @@ static void parse_treeish_arg(const char **argv,
>         ar_args->time =3D archive_time;
>  }
>=20
> +static void create_output_file(const char *output_file, struct archi=
ver_args *ar_args)
> +{
> +       int fd =3D -1;
> +
> +       fd =3D creat(output_file, S_IRUSR | S_IWUSR);
> +       if(fd < 0)
> +               die("could not create archive file");
> +       ar_args->output_fd =3D fd;
> +}
> +

The local variable fd is initialized immediately before it's set again.
In fact, you don't need even need it at all -- use ar_args->output_fd
directly.

0600 (-rw-------) is a nice and secure permissions for newly created
files, but I think we should apply the users umask here.  tar does,
at least.

>  #define OPT__COMPR(s, v, h, p) \
>         { OPTION_SET_INT, (s), NULL, (v), NULL, (h), \
>           PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (p) }
> @@ -253,6 +263,7 @@ static int parse_archive_args(int argc, const cha=
r **argv,
>         const char *base =3D NULL;
>         const char *remote =3D NULL;
>         const char *exec =3D NULL;
> +    const char *output =3D NULL;

Please indent using tabs, a single one in this line.  Indeed, your
message doesn't contain a single tab, which makes the patch difficult
to apply.  Please see Documentation/SubmittingPatches for how to
make and send patches for git.

>         int compression_level =3D -1;
>         int verbose =3D 0;
>         int i;
> @@ -262,6 +273,7 @@ static int parse_archive_args(int argc, const cha=
r **argv,
>                 OPT_STRING(0, "format", &format, "fmt", "archive form=
at"),
>                 OPT_STRING(0, "prefix", &base, "prefix",
>                         "prepend prefix to each pathname in the archi=
ve"),
> +               OPT_STRING(0, "output", &output, "output file", "writ=
e the results to this file"),

Please wrap lines to make them fit into 80 columns.  You can mimic the =
style
of the option just above the one you're adding.

I think "file" is better as the fourth parameter, as this is, well, jus=
t
another command line argument specifying a file.  That it's used for ou=
tput
doesn't place it in a new class of arguments.  (See comment about argh =
in
parse-options.h.)

>                 OPT__VERBOSE(&verbose),
>                 OPT__COMPR('0', &compression_level, "store only", 0),
>                 OPT__COMPR('1', &compression_level, "compress faster"=
, 1),
> @@ -294,6 +306,14 @@ static int parse_archive_args(int argc, const ch=
ar **argv,
>         if (!base)
>                 base =3D "";
>=20
> +       if(output)
> +               create_output_file(output, args);
> +       else
> +               /*
> +                * Default to stdout
> +                */
> +               args->output_fd =3D 1;
> +
>         if (list) {
>                 for (i =3D 0; i < ARRAY_SIZE(archivers); i++)
>                         printf("%s\n", archivers[i].name);

You don't close the file, which works now because archive terminates
shortly after the last file has been written, but it's unclean.  I
think the best place to put creat() and close() is before and after
the last line of write_archive().

> diff --git a/archive.h b/archive.h
> index 0b15b35..67524fa 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -9,6 +9,7 @@ struct archiver_args {
>         const struct commit *commit;
>         time_t time;
>         const char **pathspec;
> +       int output_fd;
>         unsigned int verbose : 1;
>         int compression_level;
>  };
> --
> 1.6.0.2
>=20
> From 7cbd0a3edb1cf75b5a0644263e1755fd18a5c37d Mon Sep 17 00:00:00 200=
1
> From: Carlos Manuel Duclos Vergara <carlos.duclos@trolltech.com>
> Date: Fri, 13 Feb 2009 16:22:21 +0100
> Subject: [PATCH] Updating documentation for git-archive in order to r=
eflect the new "--output" option.
>=20
> Signed-off-by: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>
>=20
> ---
>  Documentation/git-archive.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archiv=
e.txt
> index 41cbf9c..d1a9d95 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -47,6 +47,9 @@ OPTIONS
>  --prefix=3D<prefix>/::
>         Prepend <prefix>/ to each filename in the archive.
>=20
> +--output=3D<output file>::
> +       Writes the archive to <output file> instead of stdout.
> +
>  <extra>::
>         This can be any options that the archiver backend understand.
>         See next section.

This patch should be part of the one that changes the code.  You
don't need to (and should not) split this up, as this is one
consistent change.  Except for the missing test. :)

> --
> 1.6.0.2
>=20

Thanks,
Ren=E9
