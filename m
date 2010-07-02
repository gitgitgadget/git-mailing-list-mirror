From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 2/2] Convert the users for of for_each_string_list to
	string_list_for_each
Date: Fri, 2 Jul 2010 22:55:59 +0200
Message-ID: <20100702205559.GB4941@blimp.localdomain>
References: <AANLkTimYyHtjCfRtrTgVh3LJeJQeBpdXMRsf3khKatFx@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 00:20:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUobE-0003YV-Cb
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 00:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab0GBWUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 18:20:38 -0400
Received: from mout5.freenet.de ([195.4.92.95]:44628 "EHLO mout5.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700Ab0GBWUh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 18:20:37 -0400
Received: from [195.4.92.21] (helo=11.mx.freenet.de)
	by mout5.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1OUnHJ-0005GF-T9; Fri, 02 Jul 2010 22:56:05 +0200
Received: from krlh-5f720059.pool.mediaways.net ([95.114.0.89]:55775 helo=tigra.home)
	by 11.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1OUnHJ-00008p-2j; Fri, 02 Jul 2010 22:56:05 +0200
Received: from blimp.localdomain (unknown [192.168.0.83])
	by tigra.home (Postfix) with ESMTP id 30F3B9FD14;
	Fri,  2 Jul 2010 22:56:00 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id EFE1636D28; Fri,  2 Jul 2010 22:55:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimYyHtjCfRtrTgVh3LJeJQeBpdXMRsf3khKatFx@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150172>

The macro is suitable for all these cases and will reduce code of
need to just iterate over the items of a string list.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Tue, Jun 29, 2010 10:37:17 +0200:
> > On Tue, Jun 29, 2010 at 10:33, Alex Riesen <raa.lkml@gmail.com> wro=
te:
> >> BTW, now that I took a look at it... The iteration over string_lis=
t
> >> items looks a little overengineered. At least from the point of
> >> view of the existing users of the feature. Wouldn't a simple loop
> >> be just as simple to use (if not simplier) and faster (no uninline=
able
> >> function calls and argument preparation and passing needed)?
> >>
> >> #define string_list_foreach(item,list) \
> >> =A0 =A0 =A0 =A0for (item =3D (list)->items; item < (list)->items +=
 (list)->nr; ++item)
> >>
>=20
> And this converts existing callers. Removes more than adds.
>=20

Rebased on recent Git master (after Julian Philips patches).

 notes.c        |   46 ++++++++++++++--------------------------------
 resolve-undo.c |   34 +++++++++++++++-------------------
 2 files changed, 29 insertions(+), 51 deletions(-)

diff --git a/notes.c b/notes.c
index 1978244..2d03068 100644
--- a/notes.c
+++ b/notes.c
@@ -877,14 +877,6 @@ void string_list_add_refs_from_colon_sep(struct st=
ring_list *list,
 	strbuf_release(&globbuf);
 }
=20
-static int string_list_add_refs_from_list(struct string_list_item *ite=
m,
-					  void *cb)
-{
-	struct string_list *list =3D cb;
-	string_list_add_refs_by_glob(list, item->string);
-	return 0;
-}
-
 static int notes_display_config(const char *k, const char *v, void *cb=
)
 {
 	int *load_refs =3D cb;
@@ -947,30 +939,18 @@ void init_notes(struct notes_tree *t, const char =
*notes_ref,
 	load_subtree(t, &root_tree, t->root, 0);
 }
=20
-struct load_notes_cb_data {
-	int counter;
-	struct notes_tree **trees;
-};
-
-static int load_one_display_note_ref(struct string_list_item *item,
-				     void *cb_data)
-{
-	struct load_notes_cb_data *c =3D cb_data;
-	struct notes_tree *t =3D xcalloc(1, sizeof(struct notes_tree));
-	init_notes(t, item->string, combine_notes_ignore, 0);
-	c->trees[c->counter++] =3D t;
-	return 0;
-}
-
 struct notes_tree **load_notes_trees(struct string_list *refs)
 {
+	struct string_list_item *item;
+	int counter =3D 0;
 	struct notes_tree **trees;
-	struct load_notes_cb_data cb_data;
 	trees =3D xmalloc((refs->nr+1) * sizeof(struct notes_tree *));
-	cb_data.counter =3D 0;
-	cb_data.trees =3D trees;
-	for_each_string_list(refs, load_one_display_note_ref, &cb_data);
-	trees[cb_data.counter] =3D NULL;
+	string_list_foreach(item, refs) {
+		struct notes_tree *t =3D xcalloc(1, sizeof(struct notes_tree));
+		init_notes(t, item->string, combine_notes_ignore, 0);
+		trees[counter++] =3D t;
+	}
+	trees[counter] =3D NULL;
 	return trees;
 }
=20
@@ -995,10 +975,12 @@ void init_display_notes(struct display_notes_opt =
*opt)
=20
 	git_config(notes_display_config, &load_config_refs);
=20
-	if (opt && opt->extra_notes_refs)
-		for_each_string_list(opt->extra_notes_refs,
-				     string_list_add_refs_from_list,
-				     &display_notes_refs);
+	if (opt && opt->extra_notes_refs) {
+		struct string_list_item *item;
+		string_list_foreach(item, opt->extra_notes_refs)
+			string_list_add_refs_by_glob(&display_notes_refs,
+						     item->string);
+	}
=20
 	display_notes_trees =3D load_notes_trees(&display_notes_refs);
 	string_list_clear(&display_notes_refs, 0);
diff --git a/resolve-undo.c b/resolve-undo.c
index 174ebec..dad5402 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -28,29 +28,25 @@ void record_resolve_undo(struct index_state *istate=
, struct cache_entry *ce)
 	ui->mode[stage - 1] =3D ce->ce_mode;
 }
=20
-static int write_one(struct string_list_item *item, void *cbdata)
+void resolve_undo_write(struct strbuf *sb, struct string_list *resolve=
_undo)
 {
-	struct strbuf *sb =3D cbdata;
-	struct resolve_undo_info *ui =3D item->util;
-	int i;
+	struct string_list_item *item;
+	string_list_foreach(item, resolve_undo) {
+		struct resolve_undo_info *ui =3D item->util;
+		int i;
=20
-	if (!ui)
-		return 0;
-	strbuf_addstr(sb, item->string);
-	strbuf_addch(sb, 0);
-	for (i =3D 0; i < 3; i++)
-		strbuf_addf(sb, "%o%c", ui->mode[i], 0);
-	for (i =3D 0; i < 3; i++) {
-		if (!ui->mode[i])
+		if (!ui)
 			continue;
-		strbuf_add(sb, ui->sha1[i], 20);
+		strbuf_addstr(sb, item->string);
+		strbuf_addch(sb, 0);
+		for (i =3D 0; i < 3; i++)
+			strbuf_addf(sb, "%o%c", ui->mode[i], 0);
+		for (i =3D 0; i < 3; i++) {
+			if (!ui->mode[i])
+				continue;
+			strbuf_add(sb, ui->sha1[i], 20);
+		}
 	}
-	return 0;
-}
-
-void resolve_undo_write(struct strbuf *sb, struct string_list *resolve=
_undo)
-{
-   for_each_string_list(resolve_undo, write_one, sb);
 }
=20
 struct string_list *resolve_undo_read(const char *data, unsigned long =
size)
--=20
1.7.1.304.g8446
