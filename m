From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/32] read-cache: save deleted entries in split index
Date: Mon, 28 Apr 2014 17:55:40 +0700
Message-ID: <1398682553-11634-20-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:56:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejEY-0002mf-GQ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbaD1K4R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:56:17 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:43542 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbaD1K4O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:56:14 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so5732108pbc.9
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=poTK+klpnYJZn6APGPuPH5m05JxRHnZARQIBkvhbVF4=;
        b=bYU4AvakaM7DOBdPB0MsDpGPRGYLGK9xgekosmLcBWCE6UabHGULSywKC1vEVxbCA2
         z14myjdsm33AaA5sMuo+MVcqUqiqVdZCjBMVtwX6NAXNJ06Ih7Yfaeah3Bl0dv6iLZkz
         +hLa18oA/o4JJS4LCKVryI7llUT/kuuFk06N+WT0fGLoqX8YeJieEFBNVU9pFC9KXl4N
         m4MZHlO7sWFte8XzkR7qgJWl7wxK6fz3PpCpNXTbPIGRYOITHnCY612bA9ePH56jF7Po
         bEGDCJStBc9qvOonL6KAktv/6DEGuyOeb/wxUS9ipXjHnnz8bqTAcGSUbxTrzzlBcfYX
         i3Jw==
X-Received: by 10.66.65.138 with SMTP id x10mr24687716pas.17.1398682574580;
        Mon, 28 Apr 2014 03:56:14 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id vm3sm34202468pbc.45.2014.04.28.03.56.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:56:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:57:42 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247283>

Entries that belong to the base index should not be freed. Mark
CE_REMOVE to track them.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c  | 14 ++++++++------
 split-index.c | 12 ++++++++++++
 split-index.h |  1 +
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 2f2e0c1..7cdb171 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -39,7 +39,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce,
=20
 /* changes that can be kept in $GIT_DIR/index (basically all extension=
s) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
-		 CE_ENTRY_ADDED)
+		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED)
=20
 struct index_state the_index;
 static const char *alternate_index_output;
@@ -488,7 +488,7 @@ int remove_index_entry_at(struct index_state *istat=
e, int pos)
=20
 	record_resolve_undo(istate, ce);
 	remove_name_hash(istate, ce);
-	free(ce);
+	save_or_free_index_entry(istate, ce);
 	istate->cache_changed |=3D CE_ENTRY_REMOVED;
 	istate->cache_nr--;
 	if (pos >=3D istate->cache_nr)
@@ -512,7 +512,7 @@ void remove_marked_cache_entries(struct index_state=
 *istate)
 	for (i =3D j =3D 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE) {
 			remove_name_hash(istate, ce_array[i]);
-			free(ce_array[i]);
+			save_or_free_index_entry(istate, ce_array[i]);
 		}
 		else
 			ce_array[j++] =3D ce_array[i];
@@ -577,7 +577,9 @@ static int different_name(struct cache_entry *ce, s=
truct cache_entry *alias)
  * So we use the CE_ADDED flag to verify that the alias was an old
  * one before we accept it as
  */
-static struct cache_entry *create_alias_ce(struct cache_entry *ce, str=
uct cache_entry *alias)
+static struct cache_entry *create_alias_ce(struct index_state *istate,
+					   struct cache_entry *ce,
+					   struct cache_entry *alias)
 {
 	int len;
 	struct cache_entry *new;
@@ -590,7 +592,7 @@ static struct cache_entry *create_alias_ce(struct c=
ache_entry *ce, struct cache_
 	new =3D xcalloc(1, cache_entry_size(len));
 	memcpy(new->name, alias->name, len);
 	copy_cache_entry(new, ce);
-	free(ce);
+	save_or_free_index_entry(istate, ce);
 	return new;
 }
=20
@@ -683,7 +685,7 @@ int add_to_index(struct index_state *istate, const =
char *path, struct stat *st,
 		set_object_name_for_intent_to_add_entry(ce);
=20
 	if (ignore_case && alias && different_name(ce, alias))
-		ce =3D create_alias_ce(ce, alias);
+		ce =3D create_alias_ce(istate, ce, alias);
 	ce->ce_flags |=3D CE_ADDED;
=20
 	/* It was suspected to be racily clean, but it turns out to be Ok */
diff --git a/split-index.c b/split-index.c
index 63b52bb..2bb5d55 100644
--- a/split-index.c
+++ b/split-index.c
@@ -88,3 +88,15 @@ void discard_split_index(struct index_state *istate)
 	}
 	free(si);
 }
+
+void save_or_free_index_entry(struct index_state *istate, struct cache=
_entry *ce)
+{
+	if (ce->index &&
+	    istate->split_index &&
+	    istate->split_index->base &&
+	    ce->index <=3D istate->split_index->base->cache_nr &&
+	    ce =3D=3D istate->split_index->base->cache[ce->index - 1])
+		ce->ce_flags |=3D CE_REMOVE;
+	else
+		free(ce);
+}
diff --git a/split-index.h b/split-index.h
index 8d74041..5302118 100644
--- a/split-index.h
+++ b/split-index.h
@@ -12,6 +12,7 @@ struct split_index {
 };
=20
 struct split_index *init_split_index(struct index_state *istate);
+void save_or_free_index_entry(struct index_state *istate, struct cache=
_entry *ce);
 int read_link_extension(struct index_state *istate,
 			const void *data, unsigned long sz);
 int write_link_extension(struct strbuf *sb,
--=20
1.9.1.346.ga2b5940
