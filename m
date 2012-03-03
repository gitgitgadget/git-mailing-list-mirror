From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [RFH] unpack-trees: cache_entry lifetime issue?
Date: Sat, 03 Mar 2012 15:14:48 +0100
Message-ID: <4F522758.9050205@lsrfire.ath.cx>
References: <4F5102A2.70303@lsrfire.ath.cx> <7vk432dd89.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 15:15:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3pjh-00006p-Le
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 15:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab2CCOO5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Mar 2012 09:14:57 -0500
Received: from india601.server4you.de ([85.25.151.105]:38683 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab2CCOO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 09:14:56 -0500
Received: from [192.168.2.105] (p579BED61.dip.t-dialin.net [87.155.237.97])
	by india601.server4you.de (Postfix) with ESMTPSA id D22642F8030;
	Sat,  3 Mar 2012 15:14:54 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vk432dd89.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192109>

Am 02.03.2012 20:17, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>=20
>> which shows some parts of unpack-trees.c that I use as context to
>> ask: Should we check for o->merge in line 775, before using src[0]?
>>
>> If o->merge is 0, the src[0] will be NULL right up to the call of
>> unpack_nondirectories() in line 772.  There it may be set (in line
>> 582).  In that case we'll end up at line 779, where mark_ce_used()
>> is applied to it.
>>
>> I suspect that this is unintended and that line 775 should rather
>> read "if (o->merge&&  src[0]) {".  Can someone with a better
>> understanding of unpack-trees confirm or refute that suspicion?
>=20
> Yeah, src[0] is meant to hold the entry from the current index to tak=
e it
> as well as our tree into account during o->merge, and I do not think =
it
> should affect when we are only reading tree(s) into the index.
>=20
> I think da165f4 (unpack-trees.c: prepare for looking ahead in the ind=
ex,
> 2010-01-07) simply forgot that the codepath also has to work when it =
is
> not merging.
>=20
> Having said that, I do not know offhand if we just should nothing in
> no-merge case, or we should be doing something else instead, without
> thinking a bit more.

Thanks.

Next question: Should the function fn() in struct unpack_trees_options
be able to replace src[0], and unpack_callback() is then supposed to
use the new pointer after calling unpack_nondirectories()?  If not
then we can clean up things a bit by moving the src array into
unpack_nondirectories().

=46or now, just this patch, which cleans up memory, but not the code:

-- >8 --
Subject: unpack-trees: plug minor memory leak

The allocations made by unpack_nondirectories() using create_ce_entry()
are never freed.  In the case of a merge, we hand them to
call_unpack_fn() and never look at them again.  In the non-merge case,
we duplicate them using add_entry() and later only look at the first
allocated element (src[0]), perhaps even only by mistake.

To clean up after ourselves, explicitly loop through the entries and
free their memory for merges.  For non-merges, split out the actual
addition from add_entry() into the new helper do_add_entry().  Then
call that non-duplicating function instead of add_entry() to avoid the
leak.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 unpack-trees.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 7c9ecf6..c594e4a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -102,21 +102,28 @@ void setup_unpack_trees_porcelain(struct unpack_t=
rees_options *opts,
 		opts->unpack_rejects[i].strdup_strings =3D 1;
 }
=20
-static void add_entry(struct unpack_trees_options *o, struct cache_ent=
ry *ce,
-	unsigned int set, unsigned int clear)
+static void do_add_entry(struct unpack_trees_options *o, struct cache_=
entry *ce,
+			 unsigned int set, unsigned int clear)
 {
-	unsigned int size =3D ce_size(ce);
-	struct cache_entry *new =3D xmalloc(size);
-
 	clear |=3D CE_HASHED | CE_UNHASHED;
=20
 	if (set & CE_REMOVE)
 		set |=3D CE_WT_REMOVE;
=20
+	ce->next =3D NULL;
+	ce->ce_flags =3D (ce->ce_flags & ~clear) | set;
+	add_index_entry(&o->result, ce,
+			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
+}
+
+static void add_entry(struct unpack_trees_options *o, struct cache_ent=
ry *ce,
+	unsigned int set, unsigned int clear)
+{
+	unsigned int size =3D ce_size(ce);
+	struct cache_entry *new =3D xmalloc(size);
+
 	memcpy(new, ce, size);
-	new->next =3D NULL;
-	new->ce_flags =3D (new->ce_flags & ~clear) | set;
-	add_index_entry(&o->result, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_=
REPLACE);
+	do_add_entry(o, new, set, clear);
 }
=20
 /*
@@ -582,12 +589,18 @@ static int unpack_nondirectories(int n, unsigned =
long mask,
 		src[i + o->merge] =3D create_ce_entry(info, names + i, stage);
 	}
=20
-	if (o->merge)
-		return call_unpack_fn(src, o);
+	if (o->merge) {
+		int rc =3D call_unpack_fn(src, o);
+		for (i =3D 0; i < n; i++) {
+			if (src[i + 1] !=3D o->df_conflict_entry)
+				free(src[i + 1]);
+		}
+		return rc;
+	}
=20
 	for (i =3D 0; i < n; i++)
 		if (src[i] && src[i] !=3D o->df_conflict_entry)
-			add_entry(o, src[i], 0, 0);
+			do_add_entry(o, src[i], 0, 0);
 	return 0;
 }
=20
--=20
1.7.9.2
