From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 1/2] lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
Date: Sun, 20 Jul 2014 13:47:03 +0100
Organization: OPDS
Message-ID: <232C089CF449490C9F5B398996DD314C@PhilipOakley>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com> <1405858399-23082-1-git-send-email-pclouds@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8qWK-0002Uj-0r
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 14:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbaGTMrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 08:47:08 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:8423 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751779AbaGTMrH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jul 2014 08:47:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ai4dABi6y1NOl389PGdsb2JhbABZgw5SV4J4hTu8RhwKhz4BAQIBAYEFFwQBAQEBODaDfgUBAQQBCAEBGQQLAQUWCAEBIQUGAgMFAgEDFQUCBSECAhQBBAgQAgYHAxQGAQcLCAIBAgMBDASIDQMJDAmqKIZ/iE0NhzqBLItygi2CfzaBGAWRHIgGg1CKFIIyiB6BQzwvAQ
X-IPAS-Result: Ai4dABi6y1NOl389PGdsb2JhbABZgw5SV4J4hTu8RhwKhz4BAQIBAYEFFwQBAQEBODaDfgUBAQQBCAEBGQQLAQUWCAEBIQUGAgMFAgEDFQUCBSECAhQBBAgQAgYHAxQGAQcLCAIBAgMBDASIDQMJDAmqKIZ/iE0NhzqBLItygi2CfzaBGAWRHIgGg1CKFIIyiB6BQzwvAQ
X-IronPort-AV: E=Sophos;i="5.01,695,1400022000"; 
   d="scan'208";a="505594890"
Received: from host-78-151-127-61.as13285.net (HELO PhilipOakley) ([78.151.127.61])
  by out1.ip03ir2.opaltelecom.net with SMTP; 20 Jul 2014 13:47:04 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253924>

=46rom: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com>
> Something extra is, because struct lock_file is usually used as stati=
c
> variables in many places. This patch reduces bss section by about 80k
> bytes (or 23%) on Linux.

This didn't scan for me. Perhaps it's the punctuation. Maybe:

Additionally, because the struct lock_file variables are [were] in many
places static, this patch reduces the bss section size by about 80k
bytes (or 23%) on Linux.

Does my tweak reflect your intent?
Philip.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> This helps remove the length check in v1 of the next patch.
>
> cache.h    |  2 +-
> lockfile.c | 56=20
> ++++++++++++++++++++++++++++++++------------------------
> 2 files changed, 33 insertions(+), 25 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 44aa439..9ecb636 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -554,7 +554,7 @@ struct lock_file {
>  int fd;
>  pid_t owner;
>  char on_list;
> - char filename[PATH_MAX];
> + char *filename;
> };
> #define LOCK_DIE_ON_ERROR 1
> #define LOCK_NODEREF 2
> diff --git a/lockfile.c b/lockfile.c
> index 8fbcb6a..968b28f 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -7,13 +7,19 @@
> static struct lock_file *lock_file_list;
> static const char *alternate_index_output;
>
> +static void clear_filename(struct lock_file *lk)
> +{
> + free(lk->filename);
> + lk->filename =3D NULL;
> +}
> +
> static void remove_lock_file(void)
> {
>  pid_t me =3D getpid();
>
>  while (lock_file_list) {
>  if (lock_file_list->owner =3D=3D me &&
> -     lock_file_list->filename[0]) {
> +     lock_file_list->filename) {
>  if (lock_file_list->fd >=3D 0)
>  close(lock_file_list->fd);
>  unlink_or_warn(lock_file_list->filename);
> @@ -77,10 +83,16 @@ static char *last_path_elm(char *p)
>  * Always returns p.
>  */
>
> -static char *resolve_symlink(char *p, size_t s)
> +static char *resolve_symlink(const char *in)
> {
> + static char p[PATH_MAX];
> + size_t s =3D sizeof(p);
>  int depth =3D MAXDEPTH;
>
> + if (strlen(in) >=3D sizeof(p))
> + return NULL;
> + strcpy(p, in);
> +
>  while (depth--) {
>  char link[PATH_MAX];
>  int link_len =3D readlink(p, link, sizeof(link));
> @@ -124,17 +136,12 @@ static char *resolve_symlink(char *p, size_t s)
>
> static int lock_file(struct lock_file *lk, const char *path, int=20
> flags)
> {
> - /*
> - * subtract 5 from size to make sure there's room for adding
> - * ".lock" for the lock file name
> - */
> - static const size_t max_path_len =3D sizeof(lk->filename) - 5;
> -
> - if (strlen(path) >=3D max_path_len)
> + int len;
> + if (!(flags & LOCK_NODEREF) && !(path =3D resolve_symlink(path)))
>  return -1;
> + len =3D strlen(path) + 5; /* .lock */
> + lk->filename =3D xmallocz(len);
>  strcpy(lk->filename, path);
> - if (!(flags & LOCK_NODEREF))
> - resolve_symlink(lk->filename, max_path_len);
>  strcat(lk->filename, ".lock");
>  lk->fd =3D open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
>  if (0 <=3D lk->fd) {
> @@ -153,7 +160,7 @@ static int lock_file(struct lock_file *lk, const=20
> char *path, int flags)
>       lk->filename);
>  }
>  else
> - lk->filename[0] =3D 0;
> + clear_filename(lk);
>  return lk->fd;
> }
>
> @@ -231,16 +238,17 @@ int close_lock_file(struct lock_file *lk)
>
> int commit_lock_file(struct lock_file *lk)
> {
> - char result_file[PATH_MAX];
> - size_t i;
> - if (lk->fd >=3D 0 && close_lock_file(lk))
> + char *result_file;
> + if ((lk->fd >=3D 0 && close_lock_file(lk)) || !lk->filename)
>  return -1;
> - strcpy(result_file, lk->filename);
> - i =3D strlen(result_file) - 5; /* .lock */
> - result_file[i] =3D 0;
> - if (rename(lk->filename, result_file))
> + result_file =3D xmemdupz(lk->filename,
> +        strlen(lk->filename) - 5 /* .lock */);
> + if (rename(lk->filename, result_file)) {
> + free(result_file);
>  return -1;
> - lk->filename[0] =3D 0;
> + }
> + free(result_file);
> + clear_filename(lk);
>  return 0;
> }
>
> @@ -260,11 +268,11 @@ void set_alternate_index_output(const char=20
> *name)
> int commit_locked_index(struct lock_file *lk)
> {
>  if (alternate_index_output) {
> - if (lk->fd >=3D 0 && close_lock_file(lk))
> + if ((lk->fd >=3D 0 && close_lock_file(lk)) || !lk->filename)
>  return -1;
>  if (rename(lk->filename, alternate_index_output))
>  return -1;
> - lk->filename[0] =3D 0;
> + clear_filename(lk);
>  return 0;
>  }
>  else
> @@ -273,10 +281,10 @@ int commit_locked_index(struct lock_file *lk)
>
> void rollback_lock_file(struct lock_file *lk)
> {
> - if (lk->filename[0]) {
> + if (lk->filename) {
>  if (lk->fd >=3D 0)
>  close(lk->fd);
>  unlink_or_warn(lk->filename);
>  }
> - lk->filename[0] =3D 0;
> + clear_filename(lk);
> }
> --=20
> 1.9.1.346.ga2b5940
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
