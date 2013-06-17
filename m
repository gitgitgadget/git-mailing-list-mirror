From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] unpack-trees: don't shift conflicts left and right
Date: Tue, 18 Jun 2013 00:29:27 +0200
Message-ID: <51BF8DC7.4020008@lsrfire.ath.cx>
References: <1371339883-22775-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <7va9mqlvpu.fsf@alter.siamese.dyndns.org> <51BF71D4.402@lsrfire.ath.cx> <7vehc0bh79.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 00:29:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uohvg-0004Q4-3V
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 00:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab3FQW3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 18:29:35 -0400
Received: from india601.server4you.de ([85.25.151.105]:43848 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab3FQW3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 18:29:35 -0400
Received: from [192.168.2.102] (p4FFDAFF1.dip0.t-ipconnect.de [79.253.175.241])
	by india601.server4you.de (Postfix) with ESMTPSA id ECF81134;
	Tue, 18 Jun 2013 00:29:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vehc0bh79.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228119>

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

I'm not sure unpack_trees_options is the right place for that, but it
already has several members that aren't really "options".  It would
look something like this:


 tree-walk.h    | 1 -
 unpack-trees.c | 9 +++++++--
 unpack-trees.h | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index ae04b64..4876695 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -46,7 +46,6 @@ struct traverse_info {
 	int pathlen;
 	struct pathspec *pathspec;
=20
-	unsigned long df_conflicts;
 	traverse_callback_t fn;
 	void *data;
 	int show_all_errors;
diff --git a/unpack-trees.c b/unpack-trees.c
index b27f2a6..1c0ead0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -454,6 +454,10 @@ static int traverse_trees_recursive(int n, unsigne=
d long dirmask,
 	void *buf[MAX_UNPACK_TREES];
 	struct traverse_info newinfo;
 	struct name_entry *p;
+	struct unpack_trees_options *o =3D info->data;
+	unsigned long saved_df_conflicts =3D o->df_conflicts;
+
+	o->df_conflicts |=3D df_conflicts;
=20
 	p =3D names;
 	while (!p->mode)
@@ -464,7 +468,6 @@ static int traverse_trees_recursive(int n, unsigned=
 long dirmask,
 	newinfo.pathspec =3D info->pathspec;
 	newinfo.name =3D *p;
 	newinfo.pathlen +=3D tree_entry_len(p) + 1;
-	newinfo.df_conflicts |=3D df_conflicts;
=20
 	for (i =3D 0; i < n; i++, dirmask >>=3D 1) {
 		const unsigned char *sha1 =3D NULL;
@@ -480,6 +483,8 @@ static int traverse_trees_recursive(int n, unsigned=
 long dirmask,
 	for (i =3D 0; i < n; i++)
 		free(buf[i]);
=20
+	o->df_conflicts =3D saved_df_conflicts;
+
 	return ret;
 }
=20
@@ -565,7 +570,7 @@ static int unpack_nondirectories(int n, unsigned lo=
ng mask,
 {
 	int i;
 	struct unpack_trees_options *o =3D info->data;
-	unsigned long conflicts =3D info->df_conflicts | dirmask;
+	unsigned long conflicts =3D o->df_conflicts | dirmask;
=20
 	/* Do we have *only* directories? Nothing to do */
 	if (mask =3D=3D dirmask && !src[0])
diff --git a/unpack-trees.h b/unpack-trees.h
index 36a73a6..05ee968 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -66,6 +66,7 @@ struct unpack_trees_options {
=20
 	struct cache_entry *df_conflict_entry;
 	void *unpack_data;
+	unsigned long df_conflicts;
=20
 	struct index_state *dst_index;
 	struct index_state *src_index;
