From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] index-pack: fix overallocation of sorted_by_pos array
Date: Fri, 03 Jul 2015 18:21:40 -0700
Message-ID: <xmqqzj3c3efv.fsf_-_@gitster.dls.corp.google.com>
References: <1429354025-24659-1-git-send-email-pclouds@gmail.com>
	<1429354025-24659-3-git-send-email-pclouds@gmail.com>
	<xmqqoajt5glu.fsf@gitster.dls.corp.google.com>
	<CACsJy8D872sj9WQec_FZrTxx=gqy++L1XLxJdEtEQNpGpFYr=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 03:21:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBC9P-0000AY-9l
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 03:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbbGDBVp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jul 2015 21:21:45 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34285 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbbGDBVn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 21:21:43 -0400
Received: by igcsj18 with SMTP id sj18so197509354igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=8YrULq5GInnVraYL83M5aCN4dBnXrFhEYvgylgPWrHA=;
        b=L8bD8gWwOhcVxTDytolp2arO906eHbnlHJN4RiJoi4JywtLquSyZDEw4uf3iaFvjDM
         tkZdUZnsqTaNPGFdGhlzotAvxaQ1HD+VipXGe8NBNcyHdHjjBpsCFU1CLJIQRQjqCfN0
         tvzbp7Ah8qs7+FgLPvk3BsIChPDzi+wk9rHzio/7t3/Dm/KXjbgVLu2pRZ26Liy7gz47
         IoNkbT1YggxET4Ab+6/IQOGKmATKXJypQunbPwMw/kIXD91jc+iQf9EqOGtxLdiLvplI
         4xYJHrXZLDQ2v1egvDUNqEJYdzlnA8xpRCTz3NgjE5qu/Lxfqr/1j0agIjgcUtM9Yrlv
         /fKw==
X-Received: by 10.50.117.35 with SMTP id kb3mr26147858igb.13.1435972902510;
        Fri, 03 Jul 2015 18:21:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by mx.google.com with ESMTPSA id i66sm4506133ioe.0.2015.07.03.18.21.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 18:21:41 -0700 (PDT)
In-Reply-To: <CACsJy8D872sj9WQec_FZrTxx=gqy++L1XLxJdEtEQNpGpFYr=Q@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 4 Jul 2015 01:29:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273340>

When c6458e60 (index-pack: kill union delta_base to save memory,
2015-04-18) attempted to reduce the memory footprint of index-pack,
one of the key thing it did was to keep track of ref-deltas and
ofs-deltas separately.

In fix_unresolved_deltas(), however it forgot that it now wants to
look only at ref deltas in one place.  The code allocated an array
sufficient to hold both ref- and ofs-deltas, stuffed only ref-deltas
in the array, sorted it (with the right count) and iterated over the
array (with the right count).

There is no externally visible ill effect, other than a small
wastage of memory, but the code was misleading.

Also, the old code before this change had to use 'i' and 'n' because
some of the things we see in the (old) deltas[] array we scanned
with 'i' would not make it into the sorted_by_pos[] array in the old
world order, but now because you have only ref delta in a separate
ref_deltas[] array, they increment lock&step.  We no longer need
separate variables (nor the nr_unresolved parameter).

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with a formal log message.  Again, this is not really a
   "bug"-fix; just returning the memory that we allocated without
   using to the system, and making the code easier to follow.

 builtin/index-pack.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3ed53e3..fa13e20 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1223,7 +1223,7 @@ static void resolve_deltas(void)
  * - append objects to convert thin pack to full pack if required
  * - write the final 20-byte SHA-1
  */
-static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolve=
d);
+static void fix_unresolved_deltas(struct sha1file *f);
 static void conclude_pack(int fix_thin_pack, const char *curr_pack, un=
signed char *pack_sha1)
 {
 	if (nr_ref_deltas + nr_ofs_deltas =3D=3D nr_resolved_deltas) {
@@ -1245,7 +1245,7 @@ static void conclude_pack(int fix_thin_pack, cons=
t char *curr_pack, unsigned cha
 		memset(objects + nr_objects + 1, 0,
 		       nr_unresolved * sizeof(*objects));
 		f =3D sha1fd(output_fd, curr_pack);
-		fix_unresolved_deltas(f, nr_unresolved);
+		fix_unresolved_deltas(f);
 		strbuf_addf(&msg, _("completed with %d local objects"),
 			    nr_objects - nr_objects_initial);
 		stop_progress_msg(&progress, msg.buf);
@@ -1328,10 +1328,10 @@ static int delta_pos_compare(const void *_a, co=
nst void *_b)
 	return a->obj_no - b->obj_no;
 }
=20
-static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolve=
d)
+static void fix_unresolved_deltas(struct sha1file *f)
 {
 	struct ref_delta_entry **sorted_by_pos;
-	int i, n =3D 0;
+	int i;
=20
 	/*
 	 * Since many unresolved deltas may well be themselves base objects
@@ -1343,12 +1343,12 @@ static void fix_unresolved_deltas(struct sha1fi=
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
--=20
2.5.0-rc1-213-g8b7a1c9
