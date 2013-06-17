From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] unpack-trees: don't shift conflicts left and right
Date: Tue, 18 Jun 2013 01:26:45 +0200
Message-ID: <51BF9B35.3010801@lsrfire.ath.cx>
References: <1371339883-22775-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <7va9mqlvpu.fsf@alter.siamese.dyndns.org> <51BF71D4.402@lsrfire.ath.cx> <7vehc0bh79.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 01:26:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoip6-0006vK-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 01:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab3FQX0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 19:26:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:43854 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3FQX0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 19:26:52 -0400
Received: from [192.168.2.102] (p4FFDAFF1.dip0.t-ipconnect.de [79.253.175.241])
	by india601.server4you.de (Postfix) with ESMTPSA id C5F5B108;
	Tue, 18 Jun 2013 01:26:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vehc0bh79.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228123>

Am 17.06.2013 22:44, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>>> The information is only useful for the unpack_trees callback, and
>>> "info->data" is a more appropriate place to hang such a callback
>>> specific data.
>>>
>>> Perhaps we should use info->data field to point at
>>>
>>> 	struct {
>>>           	struct unpack_trees_options *o;
>>>           	unsigned long df_conflict;
>>> 	};
>>>
>>> and get rid of info->conflicts field?
>>
>> Here's a patch that does so, but it complicates matters quite a bit.
>> Did I miss anything (or rather: add too much)?
>=20
> I do not think so.  These bits are needed per recursion level, and
> it cannot be shoved into unpack_trees_options so I suspect that your
> patch is the best we can do.  Or, perhaps we can
>=20
>   - add df_conflict to struct unpack_trees_options;
>=20
>   - have traverse_info->data point at struct unpack_trees_options as
>     before; and
>=20
>   - save the old value of o->df_conflict on the stack of
>     traverse_trees_recursive(), update the field in place, and
>     restore it when the recursion returns???

How about going into the opposite direction and moving df_conflicts
handling more into traverse_tree?  If the function saved the mask
and dirmask in traverse_info then callbacks could calculate the
cumulated d/f conflicts by walking the info chain, similar to how
make_traverse_path works.  That would match the spirit of that
struct.  Below is a patch for that, for illustration.

We could then remove the mask and dirmask parameters from
traverse_callback_t functions, as the callbacks can then get them
through traverse_info.

Ren=C3=A9


 tree-walk.c    |  2 ++
 tree-walk.h    |  2 +-
 unpack-trees.c | 11 ++++++-----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 6e30ef9..dae5db7 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -400,6 +400,8 @@ int traverse_trees(int n, struct tree_desc *t, stru=
ct traverse_info *info)
 		}
 		if (!mask)
 			break;
+		info->mask =3D mask;
+		info->dirmask =3D dirmask;
 		interesting =3D prune_traversal(e, info, &base, interesting);
 		if (interesting < 0)
 			break;
diff --git a/tree-walk.h b/tree-walk.h
index ae04b64..e308859 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -46,7 +46,7 @@ struct traverse_info {
 	int pathlen;
 	struct pathspec *pathspec;
=20
-	unsigned long df_conflicts;
+	unsigned long mask, dirmask;
 	traverse_callback_t fn;
 	void *data;
 	int show_all_errors;
diff --git a/unpack-trees.c b/unpack-trees.c
index b27f2a6..58210d0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -445,7 +445,6 @@ static int switch_cache_bottom(struct traverse_info=
 *info)
 }
=20
 static int traverse_trees_recursive(int n, unsigned long dirmask,
-				    unsigned long df_conflicts,
 				    struct name_entry *names,
 				    struct traverse_info *info)
 {
@@ -464,7 +463,6 @@ static int traverse_trees_recursive(int n, unsigned=
 long dirmask,
 	newinfo.pathspec =3D info->pathspec;
 	newinfo.name =3D *p;
 	newinfo.pathlen +=3D tree_entry_len(p) + 1;
-	newinfo.df_conflicts |=3D df_conflicts;
=20
 	for (i =3D 0; i < n; i++, dirmask >>=3D 1) {
 		const unsigned char *sha1 =3D NULL;
@@ -565,12 +563,16 @@ static int unpack_nondirectories(int n, unsigned =
long mask,
 {
 	int i;
 	struct unpack_trees_options *o =3D info->data;
-	unsigned long conflicts =3D info->df_conflicts | dirmask;
+	unsigned long conflicts =3D dirmask;
+	const struct traverse_info *previnfo;
=20
 	/* Do we have *only* directories? Nothing to do */
 	if (mask =3D=3D dirmask && !src[0])
 		return 0;
=20
+	for (previnfo =3D info->prev; previnfo; previnfo =3D previnfo->prev)
+		conflicts |=3D previnfo->mask & ~previnfo->dirmask;
+
 	/*
 	 * Ok, we've filled in up to any potential index entry in src[0],
 	 * now do the rest.
@@ -820,8 +822,7 @@ static int unpack_callback(int n, unsigned long mas=
k, unsigned long dirmask, str
 			}
 		}
=20
-		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
-					     names, info) < 0)
+		if (traverse_trees_recursive(n, dirmask, names, info) < 0)
 			return -1;
 		return mask;
 	}
