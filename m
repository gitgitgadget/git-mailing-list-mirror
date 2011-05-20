From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/3] bisect: refactor sha1_array into a generic sha1 list
Date: Thu, 19 May 2011 21:17:42 -0300
Message-ID: <BANLkTikYih5hOU=_Q9N_b8VZ_KJeb8zePg@mail.gmail.com>
References: <20110519213231.GA29702@sigill.intra.peff.net>
	<20110519213433.GB29793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 20 02:18:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNDPo-0007OY-Rh
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 02:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab1ETARs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 20:17:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49549 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab1ETARo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 20:17:44 -0400
Received: by gwaa18 with SMTP id a18so1138544gwa.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6iq5d4VjIbXfOGaKC0hiZEL6ByHlV7/nfKnZ6DaLbS8=;
        b=wotM2yF/u+qYlN7gun/gURMssTrUA3/9DiAL1kDtTke698yBW8xBP3/XvYbEhz/F+E
         mTFIF4gz2NDJ19z4yxSshcgVyv5atQAJLzTvDlEvReXXl5qXD3Ej/Ivh9rGVRPFpoctU
         W1RDO19cCUYeKujgSz3O1Hp7+fiueXvXc1MF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h8cjaRWuqisc5A4VB2rTy8G+1MX/wdxNNrW5eeyhyFEmFgp5QCQAfG4tO8dpYF6j6+
         3VtSbHari6z1U3Hy9vPcfz4Pb+4gPv18RL5Zw87dVQY3mbN5nGNO8VDfIqQf0/7X5VOO
         NB5oN8Elcwku1CAu6j64Mx3gxAqHMuk3hzwVg=
Received: by 10.151.99.21 with SMTP id b21mr57001ybm.57.1305850662488; Thu, 19
 May 2011 17:17:42 -0700 (PDT)
Received: by 10.151.82.7 with HTTP; Thu, 19 May 2011 17:17:42 -0700 (PDT)
In-Reply-To: <20110519213433.GB29793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174028>

On Thu, May 19, 2011 at 6:34 PM, Jeff King <peff@peff.net> wrote:
> This is a generally useful abstraction, so let's let others
> make use of it. =C2=A0The refactoring is more or less a straight
> copy; however, functions and struct members have had their
> names changed to match string_list, which is the most
> similar data structure.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I was tempted also to rename it to sha1_list to match string_list. Bu=
t
> after working with commit_list recently, where the linked list nature
> was important, I began to think that string_list is perhaps mis-named=
=2E
>
> =C2=A0Makefile =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
> =C2=A0bisect.c =C2=A0 =C2=A0 | =C2=A0 70 ++++++++++++----------------=
-----------------------------
> =C2=A0sha1-array.c | =C2=A0 43 +++++++++++++++++++++++++++++++++++
> =C2=A0sha1-array.h | =C2=A0 18 +++++++++++++++
> =C2=A04 files changed, 78 insertions(+), 55 deletions(-)
> =C2=A0create mode 100644 sha1-array.c
> =C2=A0create mode 100644 sha1-array.h
>
> diff --git a/Makefile b/Makefile
> index 5379aaa..a357d58 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -540,6 +540,7 @@ LIB_H +=3D rerere.h
> =C2=A0LIB_H +=3D resolve-undo.h
> =C2=A0LIB_H +=3D revision.h
> =C2=A0LIB_H +=3D run-command.h
> +LIB_H +=3D sha1-array.h
> =C2=A0LIB_H +=3D sha1-lookup.h
> =C2=A0LIB_H +=3D sideband.h
> =C2=A0LIB_H +=3D sigchain.h
> @@ -642,6 +643,7 @@ LIB_OBJS +=3D revision.o
> =C2=A0LIB_OBJS +=3D run-command.o
> =C2=A0LIB_OBJS +=3D server-info.o
> =C2=A0LIB_OBJS +=3D setup.o
> +LIB_OBJS +=3D sha1-array.o
> =C2=A0LIB_OBJS +=3D sha1-lookup.o
> =C2=A0LIB_OBJS +=3D sha1_file.o
> =C2=A0LIB_OBJS +=3D sha1_name.o
> diff --git a/bisect.c b/bisect.c
> index 060c042..dd7e8ed 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -9,13 +9,7 @@
> =C2=A0#include "run-command.h"
> =C2=A0#include "log-tree.h"
> =C2=A0#include "bisect.h"
> -
> -struct sha1_array {
> - =C2=A0 =C2=A0 =C2=A0 unsigned char (*sha1)[20];
> - =C2=A0 =C2=A0 =C2=A0 int sha1_nr;
> - =C2=A0 =C2=A0 =C2=A0 int sha1_alloc;
> - =C2=A0 =C2=A0 =C2=A0 int sorted;
> -};
> +#include "sha1-array.h"
>
> =C2=A0static struct sha1_array good_revs;
> =C2=A0static struct sha1_array skipped_revs;
> @@ -425,22 +419,15 @@ static void argv_array_push_sha1(struct argv_ar=
ray *array,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_array_push(array, strbuf_detach(&buf,=
 NULL));
> =C2=A0}
>
> -static void sha1_array_push(struct sha1_array *array,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 const unsigned char *sha1)
> -{
> - =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(array->sha1, array->sha1_nr + 1, ar=
ray->sha1_alloc);
> - =C2=A0 =C2=A0 =C2=A0 hashcpy(array->sha1[array->sha1_nr++], sha1);
> -}
> -
> =C2=A0static int register_ref(const char *refname, const unsigned cha=
r *sha1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0int flags, void *cb_data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(refname, "bad")) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current_bad_sh=
a1 =3D sha1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!prefixcmp(refname, "good-")) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha1_array_push(&g=
ood_revs, sha1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha1_array_append(=
&good_revs, sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!prefixcmp(refname, "skip-")) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha1_array_push(&s=
kipped_revs, sha1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha1_array_append(=
&skipped_revs, sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> @@ -477,41 +464,14 @@ static void read_bisect_paths(struct argv_array=
 *array)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fclose(fp);
> =C2=A0}
>
> -static int array_cmp(const void *a, const void *b)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return hashcmp(a, b);
> -}
> -
> -static void sort_sha1_array(struct sha1_array *array)
> -{
> - =C2=A0 =C2=A0 =C2=A0 qsort(array->sha1, array->sha1_nr, sizeof(*arr=
ay->sha1), array_cmp);
> -
> - =C2=A0 =C2=A0 =C2=A0 array->sorted =3D 1;
> -}
> -
> -static const unsigned char *sha1_access(size_t index, void *table)
> -{
> - =C2=A0 =C2=A0 =C2=A0 unsigned char (*array)[20] =3D table;
> - =C2=A0 =C2=A0 =C2=A0 return array[index];
> -}
> -
> -static int lookup_sha1_array(struct sha1_array *array,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned char *sha1)
> -{
> - =C2=A0 =C2=A0 =C2=A0 if (!array->sorted)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sort_sha1_array(ar=
ray);
> -
> - =C2=A0 =C2=A0 =C2=A0 return sha1_pos(sha1, array->sha1, array->sha1=
_nr, sha1_access);
> -}
> -
> =C2=A0static char *join_sha1_array_hex(struct sha1_array *array, char=
 delim)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf joined_hexs =3D STRBUF_INIT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>
> - =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < array->sha1_nr; i++) {
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < array->nr; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addstr(=
&joined_hexs, sha1_to_hex(array->sha1[i]));
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i + 1 < array-=
>sha1_nr)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i + 1 < array-=
>nr)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0strbuf_addch(&joined_hexs, delim);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> @@ -546,13 +506,13 @@ struct commit_list *filter_skipped(struct commi=
t_list *list,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (count)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*count =3D 0;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!skipped_revs.sha1_nr)
> + =C2=A0 =C2=A0 =C2=A0 if (!skipped_revs.nr)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return list;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (list) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit_=
list *next =3D list->next;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list->next =3D=
 NULL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (0 <=3D lookup_=
sha1_array(&skipped_revs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (0 <=3D sha1_ar=
ray_lookup(&skipped_revs,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 list->item->object.sha1)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (skipped_first && !*skipped_first)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*skipped_first =3D 1;
> @@ -647,7 +607,7 @@ static struct commit_list *managed_skipped(struct=
 commit_list *list,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*tried =3D NULL;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!skipped_revs.sha1_nr)
> + =C2=A0 =C2=A0 =C2=A0 if (!skipped_revs.nr)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return list;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0list =3D filter_skipped(list, tried, 0, &c=
ount, &skipped_first);
> @@ -672,7 +632,7 @@ static void bisect_rev_setup(struct rev_info *rev=
s, const char *prefix,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* rev_argv.argv[0] will be ignored by set=
up_revisions */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_array_push(&rev_argv, xstrdup("bisect=
_rev_setup"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_array_push_sha1(&rev_argv, current_ba=
d_sha1, bad_format);
> - =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < good_revs.sha1_nr; i++)
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < good_revs.nr; i++)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_array_pus=
h_sha1(&rev_argv, good_revs.sha1[i],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 good_format);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_array_push(&rev_argv, xstrdup("--"));
> @@ -772,12 +732,12 @@ static struct commit *get_commit_reference(cons=
t unsigned char *sha1)
>
> =C2=A0static struct commit **get_bad_and_good_commits(int *rev_nr)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 int len =3D 1 + good_revs.sha1_nr;
> + =C2=A0 =C2=A0 =C2=A0 int len =3D 1 + good_revs.nr;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit **rev =3D xmalloc(len * size=
of(*rev));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i, n =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rev[n++] =3D get_commit_reference(current_=
bad_sha1);
> - =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < good_revs.sha1_nr; i++)
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < good_revs.nr; i++)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rev[n++] =3D g=
et_commit_reference(good_revs.sha1[i]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*rev_nr =3D n;
>
> @@ -840,9 +800,9 @@ static void check_merge_bases(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned=
 char *mb =3D result->item->object.sha1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hashcmp(m=
b, current_bad_sha1)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0handle_bad_merge_base();
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (0 <=3D =
lookup_sha1_array(&good_revs, mb)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (0 <=3D =
sha1_array_lookup(&good_revs, mb)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (0 <=3D =
lookup_sha1_array(&skipped_revs, mb)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (0 <=3D =
sha1_array_lookup(&skipped_revs, mb)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0handle_skipped_merge_base(mb);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0printf("Bisecting: a merge base must be tested\n");
> @@ -903,7 +863,7 @@ static void check_good_are_ancestors_of_bad(const=
 char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Bisecting with no good rev is ok. */
> - =C2=A0 =C2=A0 =C2=A0 if (good_revs.sha1_nr =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 if (good_revs.nr =3D=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if all good revs are ancestor of =
the bad rev. */
> @@ -968,7 +928,7 @@ int bisect_next_all(const char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bisect_common(&revs);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0revs.commits =3D find_bisection(revs.commi=
ts, &reaches, &all,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!!skippe=
d_revs.sha1_nr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!!skippe=
d_revs.nr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0revs.commits =3D managed_skipped(revs.comm=
its, &tried);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!revs.commits) {
> diff --git a/sha1-array.c b/sha1-array.c
> new file mode 100644
> index 0000000..5b75a5a
> --- /dev/null
> +++ b/sha1-array.c
> @@ -0,0 +1,43 @@
> +#include "cache.h"
> +#include "sha1-array.h"
> +#include "sha1-lookup.h"
> +
> +void sha1_array_append(struct sha1_array *array, const unsigned char=
 *sha1)
> +{
> + =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(array->sha1, array->nr + 1, array->=
alloc);
> + =C2=A0 =C2=A0 =C2=A0 hashcpy(array->sha1[array->nr++], sha1);
> + =C2=A0 =C2=A0 =C2=A0 array->sorted =3D 0;
> +}
> +
> +static int void_hashcmp(const void *a, const void *b)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return hashcmp(a, b);
> +}
> +
> +void sha1_array_sort(struct sha1_array *array)
> +{
> + =C2=A0 =C2=A0 =C2=A0 qsort(array->sha1, array->nr, sizeof(*array->s=
ha1), void_hashcmp);
> + =C2=A0 =C2=A0 =C2=A0 array->sorted =3D 1;
> +}
> +
> +static const unsigned char *sha1_access(size_t index, void *table)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned char (*array)[20] =3D table;
> + =C2=A0 =C2=A0 =C2=A0 return array[index];
> +}
> +
> +int sha1_array_lookup(struct sha1_array *array, const unsigned char =
*sha1)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (!array->sorted)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha1_array_sort(ar=
ray);
> + =C2=A0 =C2=A0 =C2=A0 return sha1_pos(sha1, array->sha1, array->nr, =
sha1_access);
> +}
> +
> +void sha1_array_clear(struct sha1_array *array)
> +{
> + =C2=A0 =C2=A0 =C2=A0 free(array->sha1);
> + =C2=A0 =C2=A0 =C2=A0 array->sha1 =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 array->nr =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 array->alloc =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 array->sorted =3D 0;
> +}
> diff --git a/sha1-array.h b/sha1-array.h
> new file mode 100644
> index 0000000..15d3b6b
> --- /dev/null
> +++ b/sha1-array.h
> @@ -0,0 +1,18 @@
> +#ifndef SHA1_ARRAY_H
> +#define SHA1_ARRAY_H
> +
> +struct sha1_array {
> + =C2=A0 =C2=A0 =C2=A0 unsigned char (*sha1)[20];
> + =C2=A0 =C2=A0 =C2=A0 int nr;
> + =C2=A0 =C2=A0 =C2=A0 int alloc;
Would be worth to change from int to unsigned int? Maybe is fine as is
though. It's that in some places we use unsigned int (string_list is
one example).

> + =C2=A0 =C2=A0 =C2=A0 int sorted;
> +};
> +
> +#define SHA1_ARRAY_INIT { NULL, 0, 0, 0 }
> +
> +void sha1_array_append(struct sha1_array *array, const unsigned char=
 *sha1);
> +void sha1_array_sort(struct sha1_array *array);
> +int sha1_array_lookup(struct sha1_array *array, const unsigned char =
*sha1);
> +void sha1_array_clear(struct sha1_array *array);
> +
Thanks for the nice API!

> +#endif /* SHA1_ARRAY_H */
> --
> 1.7.5.8.ga95ab
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
