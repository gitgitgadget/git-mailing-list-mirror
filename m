From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] index-pack: kill union delta_base to save memory
Date: Fri, 03 Jul 2015 09:51:57 -0700
Message-ID: <xmqqoajt5glu.fsf@gitster.dls.corp.google.com>
References: <1429354025-24659-1-git-send-email-pclouds@gmail.com>
	<1429354025-24659-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 18:52:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB4C9-0005MN-Nn
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 18:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbbGCQwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jul 2015 12:52:04 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36179 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbbGCQwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 12:52:00 -0400
Received: by igrv9 with SMTP id v9so120144963igr.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=2IE6cpnY/O5xl1sCEvEQhCqDvf6S0OVnOYWbjr6MVzQ=;
        b=tiHw5ClUTAU8wwqPBC39s/iblye+d+IPN9lQoePRrECPEYzm3Pwx2EbokEm3JoPKfT
         mKxNx8Nzi3LLIdxESrXPRAJ8BJYoV29gfgz575/7iKM8OUFjLVUfj8WeEEcrC8coCaUz
         kdyCj5cxhpdv3/bZwrk6okctGOk9oSf2hMabQEUs2n/aY2jwrRQeTZQsqyKTgMMdWuH8
         ZaJ7eJ8fJZiSwgjOqrT4vLCM7PEeTSaCUpPSLqWGOghMVp4p9p8/2wj4UMfZd76T5YOQ
         W1ost67JcQqRoQwdn4WlZFQWpSsRBoJjfUKhm9QckDvgATcX3yYJNmnK7l7hXKVp4E8O
         iGgg==
X-Received: by 10.107.30.69 with SMTP id e66mr23844193ioe.76.1435942320323;
        Fri, 03 Jul 2015 09:52:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by mx.google.com with ESMTPSA id 140sm6523343ion.16.2015.07.03.09.51.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 09:51:58 -0700 (PDT)
In-Reply-To: <1429354025-24659-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 18
 Apr 2015 17:47:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273296>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Once we know the number of objects in the input pack, we allocate an
> array of nr_objects of struct delta_entry. On x86-64, this struct is
> 32 bytes long. The union delta_base, which is part of struct
> delta_entry, provides enough space to store either ofs-delta (8 bytes=
)
> or ref-delta (20 bytes).

Sorry for responding to a patch 7000+ messages ago, but some kind
folks at Google were puzzled by this code, and I think they found a
small bug.

>  static void fix_unresolved_deltas(struct sha1file *f, int nr_unresol=
ved)
>  {
> -	struct delta_entry **sorted_by_pos;
> +	struct ref_delta_entry **sorted_by_pos;
>  	int i, n =3D 0;
> =20
>  	/*
> @@ -1282,28 +1344,25 @@ static void fix_unresolved_deltas(struct sha1=
file *f, int nr_unresolved)
>  	 * resolving deltas in the same order as their position in the pack=
=2E
>  	 */
>  	sorted_by_pos =3D xmalloc(nr_unresolved * sizeof(*sorted_by_pos));
> -	for (i =3D 0; i < nr_deltas; i++) {
> -		if (objects[deltas[i].obj_no].real_type !=3D OBJ_REF_DELTA)
> -			continue;
> -		sorted_by_pos[n++] =3D &deltas[i];
> -	}
> +	for (i =3D 0; i < nr_ref_deltas; i++)
> +		sorted_by_pos[n++] =3D &ref_deltas[i];
>  	qsort(sorted_by_pos, n, sizeof(*sorted_by_pos), delta_pos_compare);

You allocate an array of nr_unresolved (which is the sum of
nr_ref_deltas and nr_ofs_deltas in the new world order with patch)
entries, fill only the first nr_ref_deltas entries of it, and then
sort that first n (=3D nr_ref_deltas) entries.  The qsort and the
subsequent loop only looks at the first n entries, so nothing is
filling or reading these nr_ofs_deltas entres at the end.

I do not see any wrong behaviour other than temporary wastage of
nr_ofs_deltas pointers that would be caused by this, but this
allocation is misleading.

Also, the old code before this change had to use 'i' and 'n' because
some of the things we see in the (old) deltas[] array we scanned
with 'i' would not make it into the sorted_by_pos[] array in the old
world order, but now because you have only ref delta in a separate
ref_deltas[] array, they increment lock&step.  That also puzzled me
while re-reading this code.

Perhaps something like this is needed?


 builtin/index-pack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 48fa472..d6c48cd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1334,7 +1334,7 @@ static int delta_pos_compare(const void *_a, cons=
t void *_b)
 static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolve=
d)
 {
 	struct ref_delta_entry **sorted_by_pos;
-	int i, n =3D 0;
+	int i;
=20
 	/*
 	 * Since many unresolved deltas may well be themselves base objects
@@ -1346,12 +1346,12 @@ static void fix_unresolved_deltas(struct sha1fi=
le *f, int nr_unresolved)
 	 * before deltas depending on them, a good heuristic is to start
 	 * resolving deltas in the same order as their position in the pack.
 	 */
-	sorted_by_pos =3D xmalloc(nr_unresolved * sizeof(*sorted_by_pos));
+	sorted_by_pos =3D xmalloc(nr_ref_deltas * sizeof(*sorted_by_pos));
 	for (i =3D 0; i < nr_ref_deltas; i++)
-		sorted_by_pos[n++] =3D &ref_deltas[i];
-	qsort(sorted_by_pos, n, sizeof(*sorted_by_pos), delta_pos_compare);
+		sorted_by_pos[i] =3D &ref_deltas[i];
+	qsort(sorted_by_pos, nr_ref_deltas, sizeof(*sorted_by_pos), delta_pos=
_compare);
=20
-	for (i =3D 0; i < n; i++) {
+	for (i =3D 0; i < nr_ref_deltas; i++) {
 		struct ref_delta_entry *d =3D sorted_by_pos[i];
 		enum object_type type;
 		struct base_data *base_obj =3D alloc_base_data();
