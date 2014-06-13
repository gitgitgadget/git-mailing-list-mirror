From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/32] read-cache: be specific what part of the index has changed
Date: Fri, 13 Jun 2014 19:19:27 +0700
Message-ID: <1402661991-14977-9-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:21:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQTc-000316-Qp
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbaFMMU4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:20:56 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:44098 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbaFMMU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:20:56 -0400
Received: by mail-pd0-f172.google.com with SMTP id fp1so2097417pdb.3
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9usyH/N1niVQynwTKBOcgDl8OXzm3tV7QCk66OhjGJw=;
        b=IJgeeuVyOD/Eil594zCAy3plGzNsl5Ky5SElw+6A/xX9GpAXT4Ttb773oMdiMJcf3c
         ES5us7C659XyV4wRxVGoDHAEifoabw5ecN6bQyuQbaGNAZeH6Zb1Vd77cWzUgmO4Mjlr
         ntFCKYCgpCeXx+u8Byj5MsJvDsxWcrNUmGLDBuNHf7LWteZ3VHwi5AF720mUzhNQhrIq
         OgTUGlPNuFBKlQ22iv2D0KTqoOLnNIrWS6NzijXyup1EXXvAa9lH2vYkNcT5UKdSzTkY
         Vwiz9BQVC17+jNF8q0UXDFa6aZdNlTEb41MANhusoA0D7dnSVUA1rTv6NOMu98rUFI0l
         nd3g==
X-Received: by 10.68.163.197 with SMTP id yk5mr2841272pbb.57.1402662055549;
        Fri, 13 Jun 2014 05:20:55 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id ei4sm3393381pbb.42.2014.06.13.05.20.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:20:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:20:53 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251564>

cache entry additions, removals and modifications are separated
out. The rest of changes are still in the catch-all flag
SOMETHING_CHANGED, which would be more specific later.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c |  6 +++---
 cache.h                |  5 +++++
 read-cache.c           | 11 ++++++-----
 resolve-undo.c         |  2 +-
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 42cbe4b..d2654d6 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -56,7 +56,7 @@ static int mark_ce_flags(const char *path, int flag, =
int mark)
 		else
 			active_cache[pos]->ce_flags &=3D ~flag;
 		cache_tree_invalidate_path(active_cache_tree, path);
-		active_cache_changed =3D 1;
+		active_cache_changed =3D SOMETHING_CHANGED;
 		return 0;
 	}
 	return -1;
@@ -268,7 +268,7 @@ static void chmod_path(int flip, const char *path)
 		goto fail;
 	}
 	cache_tree_invalidate_path(active_cache_tree, path);
-	active_cache_changed =3D 1;
+	active_cache_changed =3D SOMETHING_CHANGED;
 	report("chmod %cx '%s'", flip, path);
 	return;
  fail:
@@ -889,7 +889,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
=20
 		if (the_index.version !=3D preferred_index_format)
-			active_cache_changed =3D 1;
+			active_cache_changed =3D SOMETHING_CHANGED;
 		the_index.version =3D preferred_index_format;
 	}
=20
diff --git a/cache.h b/cache.h
index 57ad318..31d4541 100644
--- a/cache.h
+++ b/cache.h
@@ -268,6 +268,11 @@ static inline unsigned int canon_mode(unsigned int=
 mode)
=20
 #define cache_entry_size(len) (offsetof(struct cache_entry,name) + (le=
n) + 1)
=20
+#define SOMETHING_CHANGED	(1 << 0) /* unclassified changes go here */
+#define CE_ENTRY_CHANGED	(1 << 1)
+#define CE_ENTRY_REMOVED	(1 << 2)
+#define CE_ENTRY_ADDED		(1 << 3)
+
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int version;
diff --git a/read-cache.c b/read-cache.c
index c0c2e39..035c72e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -51,7 +51,7 @@ static void replace_index_entry(struct index_state *i=
state, int nr, struct cache
 	remove_name_hash(istate, old);
 	free(old);
 	set_index_entry(istate, nr, ce);
-	istate->cache_changed =3D 1;
+	istate->cache_changed |=3D CE_ENTRY_CHANGED;
 }
=20
 void rename_index_entry_at(struct index_state *istate, int nr, const c=
har *new_name)
@@ -482,7 +482,7 @@ int remove_index_entry_at(struct index_state *istat=
e, int pos)
 	record_resolve_undo(istate, ce);
 	remove_name_hash(istate, ce);
 	free(ce);
-	istate->cache_changed =3D 1;
+	istate->cache_changed |=3D CE_ENTRY_REMOVED;
 	istate->cache_nr--;
 	if (pos >=3D istate->cache_nr)
 		return 0;
@@ -512,7 +512,7 @@ void remove_marked_cache_entries(struct index_state=
 *istate)
 	}
 	if (j =3D=3D istate->cache_nr)
 		return;
-	istate->cache_changed =3D 1;
+	istate->cache_changed |=3D CE_ENTRY_REMOVED;
 	istate->cache_nr =3D j;
 }
=20
@@ -1002,7 +1002,7 @@ int add_index_entry(struct index_state *istate, s=
truct cache_entry *ce, int opti
 			istate->cache + pos,
 			(istate->cache_nr - pos - 1) * sizeof(ce));
 	set_index_entry(istate, pos, ce);
-	istate->cache_changed =3D 1;
+	istate->cache_changed |=3D CE_ENTRY_ADDED;
 	return 0;
 }
=20
@@ -1101,6 +1101,7 @@ static struct cache_entry *refresh_cache_ent(stru=
ct index_state *istate,
 	    !(ce->ce_flags & CE_VALID))
 		updated->ce_flags &=3D ~CE_VALID;
=20
+	/* istate->cache_changed is updated in the caller */
 	return updated;
 }
=20
@@ -1182,7 +1183,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags,
 				 * means the index is not valid anymore.
 				 */
 				ce->ce_flags &=3D ~CE_VALID;
-				istate->cache_changed =3D 1;
+				istate->cache_changed |=3D CE_ENTRY_CHANGED;
 			}
 			if (quiet)
 				continue;
diff --git a/resolve-undo.c b/resolve-undo.c
index 44c697c..e9dff57 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -110,7 +110,7 @@ void resolve_undo_clear_index(struct index_state *i=
state)
 	string_list_clear(resolve_undo, 1);
 	free(resolve_undo);
 	istate->resolve_undo =3D NULL;
-	istate->cache_changed =3D 1;
+	istate->cache_changed =3D SOMETHING_CHANGED;
 }
=20
 int unmerge_index_entry_at(struct index_state *istate, int pos)
--=20
1.9.1.346.ga2b5940
