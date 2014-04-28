From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/32] read-cache: be specific what part of the index has changed
Date: Mon, 28 Apr 2014 17:55:29 +0700
Message-ID: <1398682553-11634-9-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:55:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejDd-0001Xz-CG
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbaD1KzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:55:21 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:41757 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755299AbaD1KzP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:55:15 -0400
Received: by mail-pd0-f174.google.com with SMTP id z10so4822026pdj.33
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JQkN9VRhzt9e1fqSp9mWbhUNWgRzjrFl+WXWc3p8aA0=;
        b=vdQLAsx5kFA2Kofb2ZrqIUCp0k5nZQSmW25HKHLNmIDORKFVZtP+8I9GamXuvgMpJT
         vGGJxHHVpkWehV4WpyA7TUCjRFhTviVPy2m/BIY1IbkafBzhQyW1fdg0JtvdUyRZAFhs
         4ncn5QcyBZ0k7/evbRoJogyTUVirqFsrc5erVEkwoncT7L/QvuRXj5IIqm53g/moCL6Z
         KPz36faQBdnlzVdnhTqJsgxp10WMlK49HDsmv+DxCjF6NnP5ytRiGRHIDDV/JwHoXuNs
         MoElSdzA5Uue6US7T5FRzP3BMpc81G+jXSCB7e8neuYkdivr3RyGnAZJpz7Xn9UlGGci
         vmMQ==
X-Received: by 10.68.132.42 with SMTP id or10mr27967745pbb.80.1398682514970;
        Mon, 28 Apr 2014 03:55:14 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id g6sm89680913pat.2.2014.04.28.03.55.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:55:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:42 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247275>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |  4 ++++
 read-cache.c | 11 ++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 57ad318..d692b74 100644
--- a/cache.h
+++ b/cache.h
@@ -268,6 +268,10 @@ static inline unsigned int canon_mode(unsigned int=
 mode)
=20
 #define cache_entry_size(len) (offsetof(struct cache_entry,name) + (le=
n) + 1)
=20
+#define CE_ENTRY_CHANGED	(1 << 0)
+#define CE_ENTRY_REMOVED	(1 << 1)
+#define CE_ENTRY_ADDED		(1 << 2)
+
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int version;
diff --git a/read-cache.c b/read-cache.c
index 9819363..6971fc4 100644
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
--=20
1.9.1.346.ga2b5940
