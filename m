From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] unpack_entry: invalidate newly added cache entry in case of error
Date: Tue, 30 Apr 2013 10:27:53 +0200
Message-ID: <87ppxcxw1i.fsf@linux-k42r.v.cablecom.net>
References: <1367288992-14979-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 10:28:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX5v6-0003Y1-UP
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 10:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759215Ab3D3I2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 04:28:10 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:36210 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab3D3I2I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 04:28:08 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 30 Apr
 2013 10:27:51 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 30 Apr 2013 10:27:53 +0200
In-Reply-To: <1367288992-14979-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 30
 Apr 2013 09:29:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222919>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> In this particular code path, we add "base" to the delta base
> cache. Then decide to free it, but we forgot about a dangling pointer
> in the cache. Invalidate that entry when we free "base".
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Some of my changes triggered a double free fault at "free(base);" in
>  t5303. This looks like a correct thing to do, but I may be missing
>  something (I'm not even sure how it happened). Please check.

Can you describe how you triggered it?

I ran all of origin/pu through valgrind tests just yesterday, and it
found nothing (yay!), so it doesn't seem to reproduce here?

>  sha1_file.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 64228a2..99ead7c 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1912,7 +1912,8 @@ void clear_delta_base_cache(void)
>  		release_delta_base_cache(&delta_base_cache[p]);
>  }
> =20
> -static void add_delta_base_cache(struct packed_git *p, off_t base_of=
fset,
> +static struct delta_base_cache_entry *
> +add_delta_base_cache(struct packed_git *p, off_t base_offset,
>  	void *base, unsigned long base_size, enum object_type type)
>  {
>  	unsigned long hash =3D pack_entry_hash(p, base_offset);
> @@ -1947,6 +1948,7 @@ static void add_delta_base_cache(struct packed_=
git *p, off_t base_offset,
>  	ent->lru.prev =3D delta_base_cache_lru.prev;
>  	delta_base_cache_lru.prev->next =3D &ent->lru;
>  	delta_base_cache_lru.prev =3D &ent->lru;
> +	return ent;
>  }
> =20
>  static void *read_object(const unsigned char *sha1, enum object_type=
 *type,
> @@ -2086,12 +2088,13 @@ void *unpack_entry(struct packed_git *p, off_=
t obj_offset,
>  		void *delta_data;
>  		void *base =3D data;
>  		unsigned long delta_size, base_size =3D size;
> +		struct delta_base_cache_entry *ent =3D NULL;
>  		int i;
> =20
>  		data =3D NULL;
> =20
>  		if (base)
> -			add_delta_base_cache(p, obj_offset, base, base_size, type);
> +			ent =3D add_delta_base_cache(p, obj_offset, base, base_size, type=
);
> =20
>  		if (!base) {
>  			/*
> @@ -2129,6 +2132,8 @@ void *unpack_entry(struct packed_git *p, off_t =
obj_offset,
>  			      "at offset %"PRIuMAX" from %s",
>  			      (uintmax_t)curpos, p->pack_name);
>  			free(base);
> +			if (ent)
> +				ent->data =3D NULL;
>  			data =3D NULL;
>  			continue;
>  		}

Why not clear_delta_base_cache_entry(), which also handles updating the
lru pointers?

Also I wonder if removing free(base) is the right fix: since the failur=
e
is in decompressing the delta, the base might again be useful and we
should keep it cached.

Either way, one of those needs to be done.  I think the mistake happene=
d
in my abe601b (sha1_file: remove recursion in unpack_entry, 2013-03-27)=
=2E
The change concerning this section was roughly:

-       base =3D cache_or_unpack_entry(p, base_offset, &base_size, type=
, 0);
-       if (!base) {
[...snip error path...]
-       }
-
-       delta_data =3D unpack_compressed_entry(p, w_curs, curpos, delta=
_size);
-       if (!delta_data) {
-               error("failed to unpack compressed delta "
-                     "at offset %"PRIuMAX" from %s",
-                     (uintmax_t)curpos, p->pack_name);
-               free(base);
-               return NULL;
-       }
[...]
-       add_delta_base_cache(p, base_offset, base, base_size, *type);

transforms into

+               if (base)
+                       add_delta_base_cache(p, obj_offset, base, base_=
size, type);
+
+               if (!base) {
[...snip error path...]
+               }
+
+               i =3D --delta_stack_nr;
+               obj_offset =3D delta_stack[i].obj_offset;
+               curpos =3D delta_stack[i].curpos;
+               delta_size =3D delta_stack[i].size;
+
+               if (!base)
+                       continue;
+
+               delta_data =3D unpack_compressed_entry(p, &w_curs, curp=
os, delta_size);
+
+               if (!delta_data) {
+                       error("failed to unpack compressed delta "
+                             "at offset %"PRIuMAX" from %s",
+                             (uintmax_t)curpos, p->pack_name);
+                       free(base);
+                       data =3D NULL;
+                       continue;
+               }

So it's not your mistake at all.  I propose this explanation for the
commit message of whatever fix you make:

In the !delta_data error path of unpack_entry(), we run free(base).
This became a window for use-after-free() in abe601b (sha1_file: remove
recursion in unpack_entry, 2013-03-27), as follows:

Before abe601b, we got the 'base' from cache_or_unpack_entry(..., 0);
keep_cache=3D0 tells it to also remove that entry.  So the 'base' is at
this point not cached, and freeing it in the error path is the right
thing.

After abe601b, the structure changed: we use a three-phase approach
where phase 1 finds the innermost base or a base that is already in the
cache.  In phase 3 we therefore know that all bases we unpack are not
part of the delta cache yet.  (Observe that we pop from the cache in
phase 1, so this is also true for the very first base.)  So we make no
further attempts to look up the bases in the cache, and just call
add_delta_base_cache() on every base object we have assembled.

But the !delta_data error path remained unchanged, and now calls free()
on a base that has already been entered in the cache.  This means that
there is a use-after-free if we later use the same base again.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
