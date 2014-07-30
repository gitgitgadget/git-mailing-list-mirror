From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/9] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 30 Jul 2014 04:08:33 -0400
Message-ID: <CAPig+cTDxTpo53WhfkQbt8EuY15Ttj1NHbh2Do-TKYq2xVvP+g@mail.gmail.com>
References: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
	<1406548995-28549-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 10:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCOwE-00038P-HC
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 10:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbaG3IIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2014 04:08:37 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:44845 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaG3IIe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2014 04:08:34 -0400
Received: by mail-yh0-f52.google.com with SMTP id t59so502089yho.11
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=hODs0H72pMmBbDeyVHTsHotxZcl/+AnD71oQQM4y1nY=;
        b=xQo4czImDW/8lIEvbrKv8U/qtHBEzRkrnv3ACH2J/0adI4RGUgacYkjXQUqmSFtGRn
         LDv+0PlRrYdkbPD7YOPNyGkX98vlGe1cFkv1UfeOlBP8X+oJrKb8+CzKV2QwrJA7LG7r
         /HuqAkJKQ2D+Dwt7wAhXfdVom8jW18b9FK/BMUp2nL9IKe28os5BByiVQZuDA9wp9MdT
         YC2cMEZ+++dTA5HGxpZS5huNJ4Ljl2uZW7J08JnKXOk+JdSbee/ZHa2tmmhxc0tP9WuC
         EkXfwND5NNJj9r7TBnwJCLS3cTJbLu1O37n26WpOhoZNAaS9bgNB6TGYCPfbT00YUoUK
         qSHQ==
X-Received: by 10.236.82.147 with SMTP id o19mr4182774yhe.112.1406707713470;
 Wed, 30 Jul 2014 01:08:33 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Wed, 30 Jul 2014 01:08:33 -0700 (PDT)
In-Reply-To: <1406548995-28549-5-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: uS9u5O4EgBMHIN_jl4bcLUI5mDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254480>

On Monday, July 28, 2014, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com> wrote:
> Instead of reading the index from disk and worrying about disk
> corruption, the index is cached in memory (memory bit-flips happen
> too, but hopefully less often). The result is faster read.
>
> The biggest gain is not having to verify the trailing SHA-1, which
> takes lots of time especially on large index files. But this also
> opens doors for further optimiztions:

s/optimiztions/optimizations/

>  - we could create an in-memory format that's essentially the memory
>    dump of the index to eliminate most of parsing/allocation
>    overhead. The mmap'd memory can be used straight away.
>
>  - we could cache non-index info such as name hash
>
> The shared memory's name folows the template "git-<object>-<SHA1>"

s/folows/follows/

> where <SHA1> is the trailing SHA-1 of the index file. <object> is
> "index" for cached index files (and may be "name-hash" for name-hash
> cache). If such shared memory exists, it contains the same index
> content as on disk. The content is already validated by the daemon an=
d
> git won't validate it again (except comparing the trailing SHA-1s).
>
> Git can poke the daemon to tell it to refresh the index cache, or to
> keep it alive some more minutes via UNIX signals. It can't give any
> real index data directly to the daemon. Real data goes to disk first,
> then the daemon reads and verifies it from there.
>
> $GIT_DIR/index-helper.pid contains a reference to daemon process (and
> it's pid on *nix). The file's mtime is updated every time it's access=
ed

s/it's pid/its pid/

> (or should be updated often enough). Old index-helper.pid is consider=
ed
> stale and ignored.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/index-helper.c b/index-helper.c
> new file mode 100644
> index 0000000..8fa0af9
> --- /dev/null
> +++ b/index-helper.c
> @@ -0,0 +1,157 @@
> +static void share_index(struct index_state *istate, struct index_shm=
 *is)
> +{
> +       void *new_mmap;
> +       if (istate->mmap_size <=3D 20 ||
> +           hashcmp(istate->sha1,
> +                   (unsigned char *)istate->mmap + istate->mmap_size=
 - 20) ||
> +           !hashcmp(istate->sha1, is->sha1) ||
> +           git_shm_map(O_CREAT | O_EXCL | O_RDWR, 0700, istate->mmap=
_size,
> +                       &new_mmap, PROT_READ | PROT_WRITE, MAP_SHARED=
,
> +                       "git-index-%s", sha1_to_hex(istate->sha1)) < =
0)

Do any of these failure conditions deserve a diagnostic message to let
the user know that there was a problem?

> +               return;
> +
> +       free_index_shm(is);
> +       is->size =3D istate->mmap_size;
> +       is->shm =3D new_mmap;
> +       hashcpy(is->sha1, istate->sha1);
> +       memcpy(new_mmap, istate->mmap, istate->mmap_size - 20);
> +
> +       /*
> +        * The trailing hash must be written last after everything is
> +        * written. It's the indication that the shared memory is now
> +        * ready.
> +        */
> +       hashcpy((unsigned char *)new_mmap + istate->mmap_size - 20, i=
s->sha1);
> +}
> diff --git a/read-cache.c b/read-cache.c
> index b679781..ff28142 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1465,6 +1467,65 @@ static struct cache_entry *create_from_disk(st=
ruct ondisk_cache_entry *ondisk,
>         return ce;
>  }
>
> +/*
> + * Try to open and verify a cached shm index if available. Return 0 =
if
> + * succeeds (istate->mmap and istate->mmap_size are updated). Return
> + * negative otherwise.
> + */
> +static int try_shm(struct index_state *istate)
> +{
> +       void *new_mmap =3D NULL;
> +       size_t old_size =3D istate->mmap_size;

Is old_size needed? Can you not simply reference istate->mmap_size
directly each place old_size is mentioned?

> +       ssize_t new_length;

Nit: 'size' vs. 'length' inconsistency in variable name choices.

> +       const unsigned char *sha1;
> +       struct stat st;
> +
> +       if (old_size <=3D 20 ||
> +           stat(git_path("index-helper.pid"), &st))
> +               return -1;
> +       sha1 =3D (unsigned char *)istate->mmap + old_size - 20;
> +       new_length =3D git_shm_map(O_RDONLY, 0700, -1, &new_mmap,
> +                                PROT_READ, MAP_SHARED,
> +                                "git-index-%s", sha1_to_hex(sha1));
> +       if (new_length <=3D 20 ||
> +           hashcmp((unsigned char *)istate->mmap + old_size - 20,
> +                   (unsigned char *)new_mmap + new_length - 20)) {
> +               if (new_mmap)
> +                       munmap(new_mmap, new_length);
> +               poke_daemon(&st, 1);
> +               return -1;
> +       }
> +       munmap(istate->mmap, istate->mmap_size);
> +       istate->mmap =3D new_mmap;
> +       istate->mmap_size =3D new_length;
> +       poke_daemon(&st, 0);
> +       return 0;
> +}
> +
>  /* remember to discard_cache() before reading a different cache! */
>  int do_read_index(struct index_state *istate, const char *path, int =
must_exist)
>  {
> diff --git a/shm.c b/shm.c
> new file mode 100644
> index 0000000..4ec1a00
> --- /dev/null
> +++ b/shm.c
> @@ -0,0 +1,67 @@
> +#include "git-compat-util.h"
> +#include "shm.h"
> +
> +#ifdef HAVE_SHM
> +
> +#define SHM_PATH_LEN 72                /* we don't create very long =
paths.. */
> +
> +ssize_t git_shm_map(int oflag, int perm, ssize_t length, void **mmap=
,
> +                   int prot, int flags, const char *fmt, ...)
> +{
> +       va_list ap;
> +       char path[SHM_PATH_LEN];

Is there a reason to avoid strbuf here?

> +       int fd;
> +
> +       path[0] =3D '/';
> +       va_start(ap, fmt);
> +       vsprintf(path + 1, fmt, ap);
> +       va_end(ap);
> +       fd =3D shm_open(path, oflag, perm);
> +       if (fd < 0)
> +               return -1;
> +       if (length > 0 && ftruncate(fd, length)) {
> +               shm_unlink(path);
> +               close(fd);
> +               return -1;
> +       }
> +       if (length < 0 && !(oflag & O_CREAT)) {
> +               struct stat st;
> +               if (fstat(fd, &st))
> +                       die_errno("unable to stat %s", path);
> +               length =3D st.st_size;
> +       }
> +       *mmap =3D xmmap(NULL, length, prot, flags, fd, 0);
> +       close(fd);
> +       if (*mmap =3D=3D MAP_FAILED) {
> +               *mmap =3D NULL;
> +               shm_unlink(path);
> +               return -1;
> +       }
> +       return length;
> +}
