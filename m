From: matthew sporleder <msporleder@gmail.com>
Subject: Re: [PATCH] index-pack: reduce memory footprint a bit
Date: Tue, 10 Feb 2015 06:08:53 -0600
Message-ID: <CAHKF-Atr_ezupL02aW08S-6NGGLi55vHuVep1mQvOaQq0Xh=FA@mail.gmail.com>
References: <CACsJy8A=6m5sWnDhPPMNrWbZ=fOMXPxO_1GVh-WpHycf5gm+rg@mail.gmail.com>
	<1423487929-28019-1-git-send-email-pclouds@gmail.com>
	<xmqqfvaec2cm.fsf@gitster.dls.corp.google.com>
	<20150210093041.GA30992@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 13:09:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YL9co-0007kJ-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 13:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbbBJMI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2015 07:08:58 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:64735 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbbBJMIz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2015 07:08:55 -0500
Received: by mail-wi0-f175.google.com with SMTP id r20so8493890wiv.2
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 04:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZFAaFfCWjJzX+I3IDuGKoeok8Hb7SDSlVzXD4dp+Co0=;
        b=vd55ctjchnXYEckH9KY9/GrOpcwpklcxSwPPcVJfmKosDua/7Dw56T4GVV+0P7Vwcy
         3S9jzEFJTFc2jxjb3nyQoLKwqPZ+mOtOEWk/3/S0B+0CYhTOvElAi9BXDkpuifsV/ifJ
         lGXWDBHD/FJULlwvCX6geL9TYUtFZmAEMlU9B5bSP/autlWcen/5x63Im5kvBdFCc4vt
         tBej78Rhh1NNo99OFkib8mjp/I63fFD6TtAvgYDd8i0RgTo+zkYTeHnkfx6cNVpT7br1
         d3CbN2qpOYp7sgn6lX+JMzrccCW9ms+JOWmlgwHbO16aGdhG7OR3V5czGpWmgHM1NS0X
         KuFQ==
X-Received: by 10.180.92.199 with SMTP id co7mr45397500wib.47.1423570133996;
 Tue, 10 Feb 2015 04:08:53 -0800 (PST)
Received: by 10.195.13.14 with HTTP; Tue, 10 Feb 2015 04:08:53 -0800 (PST)
In-Reply-To: <20150210093041.GA30992@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263629>

I'm having trouble getting this new patch to apply.  Are you working
on a branch that I can track?

On Tue, Feb 10, 2015 at 3:30 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Feb 09, 2015 at 11:27:21AM -0800, Junio C Hamano wrote:
>> > On a 3.4M object repo that's about 53MB. The saving is less impres=
sive
>> > compared to index-pack total memory use (about 400MB before delta
>> > resolving, so the saving is just 13%)
>> >
>> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@=
gmail.com>
>> > ---
>> >  I'm not sure if this patch is worth pursuing. It makes the code a
>> >  little bit harder to read. I was just wondering how much memory c=
ould
>> >  be saved..
>
> (text reordered)
>
>> I do not find the result all that harder to read.  I however think
>> that the change would make it a lot harder to maintain, especially
>> because the name "object-entry-extra" does not have any direct link
>> to "show-stat" to hint us that this must be allocated when show-stat
>> is in use and must never be looked at when show-stat is not in use.
>
> Noted. To be fixed.
>
>> I would say 13% is already impressive ;-).
>
> The second patch makes the total saving 119MB, close to 30% (again on
> x86-64, 32-bit platform number may be different). If we only compare
> with the size of objects[] and deltas[], the saving percentage is 37%
> (only for clone case) for this repo. Now it looks impressive to me :-=
D
>
> The patch is larger than the previous one, but not really complex. An=
d
> the final index-pack.c is not hard to read either, probably becase we
> already handle ofs-delta and ref-delta separately.
>
> -- 8< --
> Subject: [PATCH 2/2] index-pack: kill union delta_base to save memory
>
> Once we know the number of objects in the input pack, we allocate an
> array of nr_objects of struct delta_entry. On x86-64, this struct is
> 32 bytes long. The union delta_base, which is part of struct
> delta_entry, provides enough space to store either ofs-delta (8 bytes=
)
> or ref-delta (20 bytes).
>
> Notice that with "recent" Git versions, ofs-delta objects are
> preferred over ref-delta objects and ref-delta objects have no reason
> to be present in a clone pack. So in clone case we waste
> (20-8) * nr_objects bytes because of this union. That's about 38MB ou=
t
> of 100MB for deltas[] with 3.4M objects, or 38%. deltas[] would be
> around 62MB without the waste.
>
> This patch attempts to eliminate that. deltas[] array is split into
> two: one for ofs-delta and one for ref-delta. Many functions are also
> duplicated because of this split. With this patch, ofs_delta_entry[]
> array takes 38MB. ref_deltas[] should remain unallocated in clone cas=
e
> (0 bytes). This array grows as we see ref-delta. We save more than
> half in clone case, or 25% of total book keeping.
>
> The saving is more than the calculation above because padding is
> removed by __attribute__((packed)) on ofs_delta_entry. This attribute
> should be ok to use, as we used to have it in our code base for some
> time. The last use was removed because it may lead to incorrect
> behavior when the struct is not packed, which is not the case in
> index-pack.
>
> A note about ofs_deltas allocation. We could use ref_deltas memory
> allocation strategy for ofs_deltas. But that probably just adds more
> overhead on top. ofs-deltas are generally the majority (1/2 to 2/3) i=
n
> any pack. Incremental realloc may lead to too many memcpy. And if we
> preallocate, say 1/2 or 2/3 of nr_objects initially, the growth rate
> of ALLOC_GROW() could make this array larger than nr_objects, wasting
> more memory.
>
> Brought-up-by: Matthew Sporleder <msporleder@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/index-pack.c | 260 +++++++++++++++++++++++++++++++----------=
----------
>  1 file changed, 160 insertions(+), 100 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 07b2c0c..27e3c8b 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -28,11 +28,6 @@ struct object_stat {
>         int base_object_no;
>  };
>
> -union delta_base {
> -       unsigned char sha1[20];
> -       off_t offset;
> -};
> -
>  struct base_data {
>         struct base_data *base;
>         struct base_data *child;
> @@ -52,26 +47,28 @@ struct thread_local {
>         int pack_fd;
>  };
>
> -/*
> - * Even if sizeof(union delta_base) =3D=3D 24 on 64-bit archs, we re=
ally want
> - * to memcmp() only the first 20 bytes.
> - */
> -#define UNION_BASE_SZ  20
> -
>  #define FLAG_LINK (1u<<20)
>  #define FLAG_CHECKED (1u<<21)
>
> -struct delta_entry {
> -       union delta_base base;
> +struct ofs_delta_entry {
> +       off_t offset;
> +       int obj_no;
> +} __attribute__((packed));
> +
> +struct ref_delta_entry {
> +       unsigned char sha1[20];
>         int obj_no;
>  };
>
>  static struct object_entry *objects;
>  static struct object_stat *obj_stat;
> -static struct delta_entry *deltas;
> +static struct ofs_delta_entry *ofs_deltas;
> +static struct ref_delta_entry *ref_deltas;
>  static struct thread_local nothread_data;
>  static int nr_objects;
> -static int nr_deltas;
> +static int nr_ofs_deltas;
> +static int nr_ref_deltas;
> +static int ref_deltas_alloc;
>  static int nr_resolved_deltas;
>  static int nr_threads;
>
> @@ -480,7 +477,8 @@ static void *unpack_entry_data(unsigned long offs=
et, unsigned long size,
>  }
>
>  static void *unpack_raw_entry(struct object_entry *obj,
> -                             union delta_base *delta_base,
> +                             off_t *ofs_offset,
> +                             unsigned char *ref_sha1,
>                               unsigned char *sha1)
>  {
>         unsigned char *p;
> @@ -509,11 +507,10 @@ static void *unpack_raw_entry(struct object_ent=
ry *obj,
>
>         switch (obj->type) {
>         case OBJ_REF_DELTA:
> -               hashcpy(delta_base->sha1, fill(20));
> +               hashcpy(ref_sha1, fill(20));
>                 use(20);
>                 break;
>         case OBJ_OFS_DELTA:
> -               memset(delta_base, 0, sizeof(*delta_base));
>                 p =3D fill(1);
>                 c =3D *p;
>                 use(1);
> @@ -527,8 +524,8 @@ static void *unpack_raw_entry(struct object_entry=
 *obj,
>                         use(1);
>                         base_offset =3D (base_offset << 7) + (c & 127=
);
>                 }
> -               delta_base->offset =3D obj->idx.offset - base_offset;
> -               if (delta_base->offset <=3D 0 || delta_base->offset >=
=3D obj->idx.offset)
> +               *ofs_offset =3D obj->idx.offset - base_offset;
> +               if (*ofs_offset <=3D 0 || *ofs_offset >=3D obj->idx.o=
ffset)
>                         bad_object(obj->idx.offset, _("delta base off=
set is out of bound"));
>                 break;
>         case OBJ_COMMIT:
> @@ -612,55 +609,108 @@ static void *get_data_from_pack(struct object_=
entry *obj)
>         return unpack_data(obj, NULL, NULL);
>  }
>
> -static int compare_delta_bases(const union delta_base *base1,
> -                              const union delta_base *base2,
> -                              enum object_type type1,
> -                              enum object_type type2)
> +static int compare_ofs_delta_bases(off_t offset1, off_t offset2,
> +                                  enum object_type type1,
> +                                  enum object_type type2)
> +{
> +       int cmp =3D type1 - type2;
> +       if (cmp)
> +               return cmp;
> +       return offset1 - offset2;
> +}
> +
> +static int find_ofs_delta(const off_t offset, enum object_type type)
> +{
> +       int first =3D 0, last =3D nr_ofs_deltas;
> +
> +       while (first < last) {
> +               int next =3D (first + last) / 2;
> +               struct ofs_delta_entry *delta =3D &ofs_deltas[next];
> +               int cmp;
> +
> +               cmp =3D compare_ofs_delta_bases(offset, delta->offset=
,
> +                                             type, objects[delta->ob=
j_no].type);
> +               if (!cmp)
> +                       return next;
> +               if (cmp < 0) {
> +                       last =3D next;
> +                       continue;
> +               }
> +               first =3D next+1;
> +       }
> +       return -first-1;
> +}
> +
> +static void find_ofs_delta_children(off_t offset,
> +                                   int *first_index, int *last_index=
,
> +                                   enum object_type type)
> +{
> +       int first =3D find_ofs_delta(offset, type);
> +       int last =3D first;
> +       int end =3D nr_ofs_deltas - 1;
> +
> +       if (first < 0) {
> +               *first_index =3D 0;
> +               *last_index =3D -1;
> +               return;
> +       }
> +       while (first > 0 && ofs_deltas[first - 1].offset =3D=3D offse=
t)
> +               --first;
> +       while (last < end && ofs_deltas[last + 1].offset =3D=3D offse=
t)
> +               ++last;
> +       *first_index =3D first;
> +       *last_index =3D last;
> +}
> +
> +static int compare_ref_delta_bases(const unsigned char *sha1,
> +                                  const unsigned char *sha2,
> +                                  enum object_type type1,
> +                                  enum object_type type2)
>  {
>         int cmp =3D type1 - type2;
>         if (cmp)
>                 return cmp;
> -       return memcmp(base1, base2, UNION_BASE_SZ);
> +       return hashcmp(sha1, sha2);
>  }
>
> -static int find_delta(const union delta_base *base, enum object_type=
 type)
> +static int find_ref_delta(const unsigned char *sha1, enum object_typ=
e type)
>  {
> -       int first =3D 0, last =3D nr_deltas;
> -
> -        while (first < last) {
> -                int next =3D (first + last) / 2;
> -                struct delta_entry *delta =3D &deltas[next];
> -                int cmp;
> -
> -               cmp =3D compare_delta_bases(base, &delta->base,
> -                                         type, objects[delta->obj_no=
].type);
> -                if (!cmp)
> -                        return next;
> -                if (cmp < 0) {
> -                        last =3D next;
> -                        continue;
> -                }
> -                first =3D next+1;
> -        }
> -        return -first-1;
> +       int first =3D 0, last =3D nr_ref_deltas;
> +
> +       while (first < last) {
> +               int next =3D (first + last) / 2;
> +               struct ref_delta_entry *delta =3D &ref_deltas[next];
> +               int cmp;
> +
> +               cmp =3D compare_ref_delta_bases(sha1, delta->sha1,
> +                                             type, objects[delta->ob=
j_no].type);
> +               if (!cmp)
> +                       return next;
> +               if (cmp < 0) {
> +                       last =3D next;
> +                       continue;
> +               }
> +               first =3D next+1;
> +       }
> +       return -first-1;
>  }
>
> -static void find_delta_children(const union delta_base *base,
> -                               int *first_index, int *last_index,
> -                               enum object_type type)
> +static void find_ref_delta_children(const unsigned char *sha1,
> +                                   int *first_index, int *last_index=
,
> +                                   enum object_type type)
>  {
> -       int first =3D find_delta(base, type);
> +       int first =3D find_ref_delta(sha1, type);
>         int last =3D first;
> -       int end =3D nr_deltas - 1;
> +       int end =3D nr_ref_deltas - 1;
>
>         if (first < 0) {
>                 *first_index =3D 0;
>                 *last_index =3D -1;
>                 return;
>         }
> -       while (first > 0 && !memcmp(&deltas[first - 1].base, base, UN=
ION_BASE_SZ))
> +       while (first > 0 && !hashcmp(ref_deltas[first - 1].sha1, sha1=
))
>                 --first;
> -       while (last < end && !memcmp(&deltas[last + 1].base, base, UN=
ION_BASE_SZ))
> +       while (last < end && !hashcmp(ref_deltas[last + 1].sha1, sha1=
))
>                 ++last;
>         *first_index =3D first;
>         *last_index =3D last;
> @@ -927,16 +977,13 @@ static struct base_data *find_unresolved_deltas=
_1(struct base_data *base,
>                                                   struct base_data *p=
rev_base)
>  {
>         if (base->ref_last =3D=3D -1 && base->ofs_last =3D=3D -1) {
> -               union delta_base base_spec;
> -
> -               hashcpy(base_spec.sha1, base->obj->idx.sha1);
> -               find_delta_children(&base_spec,
> -                                   &base->ref_first, &base->ref_last=
, OBJ_REF_DELTA);
> +               find_ref_delta_children(base->obj->idx.sha1,
> +                                       &base->ref_first, &base->ref_=
last,
> +                                       OBJ_REF_DELTA);
>
> -               memset(&base_spec, 0, sizeof(base_spec));
> -               base_spec.offset =3D base->obj->idx.offset;
> -               find_delta_children(&base_spec,
> -                                   &base->ofs_first, &base->ofs_last=
, OBJ_OFS_DELTA);
> +               find_ofs_delta_children(base->obj->idx.offset,
> +                                       &base->ofs_first, &base->ofs_=
last,
> +                                       OBJ_OFS_DELTA);
>
>                 if (base->ref_last =3D=3D -1 && base->ofs_last =3D=3D=
 -1) {
>                         free(base->data);
> @@ -947,7 +994,7 @@ static struct base_data *find_unresolved_deltas_1=
(struct base_data *base,
>         }
>
>         if (base->ref_first <=3D base->ref_last) {
> -               struct object_entry *child =3D objects + deltas[base-=
>ref_first].obj_no;
> +               struct object_entry *child =3D objects + ref_deltas[b=
ase->ref_first].obj_no;
>                 struct base_data *result =3D alloc_base_data();
>
>                 if (!compare_and_swap_type(&child->real_type, OBJ_REF=
_DELTA,
> @@ -963,7 +1010,7 @@ static struct base_data *find_unresolved_deltas_=
1(struct base_data *base,
>         }
>
>         if (base->ofs_first <=3D base->ofs_last) {
> -               struct object_entry *child =3D objects + deltas[base-=
>ofs_first].obj_no;
> +               struct object_entry *child =3D objects + ofs_deltas[b=
ase->ofs_first].obj_no;
>                 struct base_data *result =3D alloc_base_data();
>
>                 assert(child->real_type =3D=3D OBJ_OFS_DELTA);
> @@ -999,15 +1046,20 @@ static void find_unresolved_deltas(struct base=
_data *base)
>         }
>  }
>
> -static int compare_delta_entry(const void *a, const void *b)
> +static int compare_ofs_delta_entry(const void *a, const void *b)
> +{
> +       const struct ofs_delta_entry *delta_a =3D a;
> +       const struct ofs_delta_entry *delta_b =3D b;
> +
> +       return delta_a->offset - delta_b->offset;
> +}
> +
> +static int compare_ref_delta_entry(const void *a, const void *b)
>  {
> -       const struct delta_entry *delta_a =3D a;
> -       const struct delta_entry *delta_b =3D b;
> +       const struct ref_delta_entry *delta_a =3D a;
> +       const struct ref_delta_entry *delta_b =3D b;
>
> -       /* group by type (ref vs ofs) and then by value (sha-1 or off=
set) */
> -       return compare_delta_bases(&delta_a->base, &delta_b->base,
> -                                  objects[delta_a->obj_no].type,
> -                                  objects[delta_b->obj_no].type);
> +       return hashcmp(delta_a->sha1, delta_b->sha1);
>  }
>
>  static void resolve_base(struct object_entry *obj)
> @@ -1053,7 +1105,8 @@ static void *threaded_second_pass(void *data)
>  static void parse_pack_objects(unsigned char *sha1)
>  {
>         int i, nr_delays =3D 0;
> -       struct delta_entry *delta =3D deltas;
> +       struct ofs_delta_entry *ofs_delta =3D ofs_deltas;
> +       unsigned char ref_delta_sha1[20];
>         struct stat st;
>
>         if (verbose)
> @@ -1062,12 +1115,18 @@ static void parse_pack_objects(unsigned char =
*sha1)
>                                 nr_objects);
>         for (i =3D 0; i < nr_objects; i++) {
>                 struct object_entry *obj =3D &objects[i];
> -               void *data =3D unpack_raw_entry(obj, &delta->base, ob=
j->idx.sha1);
> +               void *data =3D unpack_raw_entry(obj, &ofs_delta->offs=
et,
> +                                             ref_delta_sha1, obj->id=
x.sha1);
>                 obj->real_type =3D obj->type;
> -               if (is_delta_type(obj->type)) {
> -                       nr_deltas++;
> -                       delta->obj_no =3D i;
> -                       delta++;
> +               if (obj->type =3D=3D OBJ_OFS_DELTA) {
> +                       nr_ofs_deltas++;
> +                       ofs_delta->obj_no =3D i;
> +                       ofs_delta++;
> +               } else if (obj->type =3D=3D OBJ_REF_DELTA) {
> +                       ALLOC_GROW(ref_deltas, nr_ref_deltas + 1, ref=
_deltas_alloc);
> +                       hashcpy(ref_deltas[nr_ref_deltas].sha1, ref_d=
elta_sha1);
> +                       ref_deltas[nr_ref_deltas].obj_no =3D i;
> +                       nr_ref_deltas++;
>                 } else if (!data) {
>                         /* large blobs, check later */
>                         obj->real_type =3D OBJ_BAD;
> @@ -1118,15 +1177,18 @@ static void resolve_deltas(void)
>  {
>         int i;
>
> -       if (!nr_deltas)
> +       if (!nr_ofs_deltas && !nr_ref_deltas)
>                 return;
>
>         /* Sort deltas by base SHA1/offset for fast searching */
> -       qsort(deltas, nr_deltas, sizeof(struct delta_entry),
> -             compare_delta_entry);
> +       qsort(ofs_deltas, nr_ofs_deltas, sizeof(struct ofs_delta_entr=
y),
> +             compare_ofs_delta_entry);
> +       qsort(ref_deltas, nr_ref_deltas, sizeof(struct ref_delta_entr=
y),
> +             compare_ref_delta_entry);
>
>         if (verbose)
> -               progress =3D start_progress(_("Resolving deltas"), nr=
_deltas);
> +               progress =3D start_progress(_("Resolving deltas"),
> +                                         nr_ref_deltas + nr_ofs_delt=
as);
>
>  #ifndef NO_PTHREADS
>         nr_dispatched =3D 0;
> @@ -1164,7 +1226,7 @@ static void resolve_deltas(void)
>  static void fix_unresolved_deltas(struct sha1file *f, int nr_unresol=
ved);
>  static void conclude_pack(int fix_thin_pack, const char *curr_pack, =
unsigned char *pack_sha1)
>  {
> -       if (nr_deltas =3D=3D nr_resolved_deltas) {
> +       if (nr_ref_deltas + nr_ofs_deltas =3D=3D nr_resolved_deltas) =
{
>                 stop_progress(&progress);
>                 /* Flush remaining pack final 20-byte SHA1. */
>                 flush();
> @@ -1175,7 +1237,7 @@ static void conclude_pack(int fix_thin_pack, co=
nst char *curr_pack, unsigned cha
>                 struct sha1file *f;
>                 unsigned char read_sha1[20], tail_sha1[20];
>                 struct strbuf msg =3D STRBUF_INIT;
> -               int nr_unresolved =3D nr_deltas - nr_resolved_deltas;
> +               int nr_unresolved =3D nr_ofs_deltas + nr_ref_deltas -=
 nr_resolved_deltas;
>                 int nr_objects_initial =3D nr_objects;
>                 if (nr_unresolved <=3D 0)
>                         die(_("confusion beyond insanity"));
> @@ -1197,11 +1259,11 @@ static void conclude_pack(int fix_thin_pack, =
const char *curr_pack, unsigned cha
>                         die(_("Unexpected tail checksum for %s "
>                               "(disk corruption?)"), curr_pack);
>         }
> -       if (nr_deltas !=3D nr_resolved_deltas)
> +       if (nr_ofs_deltas + nr_ref_deltas !=3D nr_resolved_deltas)
>                 die(Q_("pack has %d unresolved delta",
>                        "pack has %d unresolved deltas",
> -                      nr_deltas - nr_resolved_deltas),
> -                   nr_deltas - nr_resolved_deltas);
> +                      nr_ofs_deltas + nr_ref_deltas - nr_resolved_de=
ltas),
> +                   nr_ofs_deltas + nr_ref_deltas - nr_resolved_delta=
s);
>  }
>
>  static int write_compressed(struct sha1file *f, void *in, unsigned i=
nt size)
> @@ -1261,14 +1323,14 @@ static struct object_entry *append_obj_to_pac=
k(struct sha1file *f,
>
>  static int delta_pos_compare(const void *_a, const void *_b)
>  {
> -       struct delta_entry *a =3D *(struct delta_entry **)_a;
> -       struct delta_entry *b =3D *(struct delta_entry **)_b;
> +       struct ref_delta_entry *a =3D *(struct ref_delta_entry **)_a;
> +       struct ref_delta_entry *b =3D *(struct ref_delta_entry **)_b;
>         return a->obj_no - b->obj_no;
>  }
>
>  static void fix_unresolved_deltas(struct sha1file *f, int nr_unresol=
ved)
>  {
> -       struct delta_entry **sorted_by_pos;
> +       struct ref_delta_entry **sorted_by_pos;
>         int i, n =3D 0;
>
>         /*
> @@ -1282,28 +1344,25 @@ static void fix_unresolved_deltas(struct sha1=
file *f, int nr_unresolved)
>          * resolving deltas in the same order as their position in th=
e pack.
>          */
>         sorted_by_pos =3D xmalloc(nr_unresolved * sizeof(*sorted_by_p=
os));
> -       for (i =3D 0; i < nr_deltas; i++) {
> -               if (objects[deltas[i].obj_no].real_type !=3D OBJ_REF_=
DELTA)
> -                       continue;
> -               sorted_by_pos[n++] =3D &deltas[i];
> -       }
> +       for (i =3D 0; i < nr_ref_deltas; i++)
> +               sorted_by_pos[n++] =3D &ref_deltas[i];
>         qsort(sorted_by_pos, n, sizeof(*sorted_by_pos), delta_pos_com=
pare);
>
>         for (i =3D 0; i < n; i++) {
> -               struct delta_entry *d =3D sorted_by_pos[i];
> +               struct ref_delta_entry *d =3D sorted_by_pos[i];
>                 enum object_type type;
>                 struct base_data *base_obj =3D alloc_base_data();
>
>                 if (objects[d->obj_no].real_type !=3D OBJ_REF_DELTA)
>                         continue;
> -               base_obj->data =3D read_sha1_file(d->base.sha1, &type=
, &base_obj->size);
> +               base_obj->data =3D read_sha1_file(d->sha1, &type, &ba=
se_obj->size);
>                 if (!base_obj->data)
>                         continue;
>
> -               if (check_sha1_signature(d->base.sha1, base_obj->data=
,
> +               if (check_sha1_signature(d->sha1, base_obj->data,
>                                 base_obj->size, typename(type)))
> -                       die(_("local object %s is corrupt"), sha1_to_=
hex(d->base.sha1));
> -               base_obj->obj =3D append_obj_to_pack(f, d->base.sha1,
> +                       die(_("local object %s is corrupt"), sha1_to_=
hex(d->sha1));
> +               base_obj->obj =3D append_obj_to_pack(f, d->sha1,
>                                         base_obj->data, base_obj->siz=
e, type);
>                 find_unresolved_deltas(base_obj);
>                 display_progress(progress, nr_resolved_deltas);
> @@ -1495,7 +1554,7 @@ static void read_idx_option(struct pack_idx_opt=
ion *opts, const char *pack_name)
>
>  static void show_pack_info(int stat_only)
>  {
> -       int i, baseobjects =3D nr_objects - nr_deltas;
> +       int i, baseobjects =3D nr_objects - nr_ref_deltas - nr_ofs_de=
ltas;
>         unsigned long *chain_histogram =3D NULL;
>
>         if (deepest_delta)
> @@ -1680,11 +1739,12 @@ int cmd_index_pack(int argc, const char **arg=
v, const char *prefix)
>         objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entr=
y));
>         if (show_stat)
>                 obj_stat =3D xcalloc(nr_objects + 1, sizeof(struct ob=
ject_stat));
> -       deltas =3D xcalloc(nr_objects, sizeof(struct delta_entry));
> +       ofs_deltas =3D xcalloc(nr_objects, sizeof(struct ofs_delta_en=
try));
>         parse_pack_objects(pack_sha1);
>         resolve_deltas();
>         conclude_pack(fix_thin_pack, curr_pack, pack_sha1);
> -       free(deltas);
> +       free(ofs_deltas);
> +       free(ref_deltas);
>         if (strict)
>                 foreign_nr =3D check_objects();
>
> --
> 2.2.0.513.g477eb31
>
> -- 8< --
