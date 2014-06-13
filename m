From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/32] split-index: do not invalidate cache-tree at read time
Date: Fri, 13 Jun 2014 19:19:42 +0700
Message-ID: <1402661991-14977-24-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:22:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQUy-0004Nk-MB
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbaFMMWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:22:20 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:41106 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbaFMMWT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:22:19 -0400
Received: by mail-pb0-f41.google.com with SMTP id ma3so2097882pbc.0
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0qVDyqG8ShWZ/lYId0ZQxUJdPeursB/r5N8JGj6Dsxc=;
        b=T1WvGUoae1wm9RoGWOZH1aV1a7u3/b4y6KK6So9Lc3IF2XYD30ryNMGXDYmLP/tXCk
         aliQslSAQi90W+qBuIjQug9bCH/Tcdq6+s+lzoP5ppPMBjN8TQZinCA5+SEytff7SF7l
         5zPKXbBOQyRUAadYj7cr5egvrXz5/ZnkDHpkd8c+CRFW42eCD65Itm0bIYptbcAzWUR8
         5bdutwXLiSkXs4Y4m1rN9bXfTJZHSBtFCrSLU3TzsG4NKGxkzFkCvQvGtzN0ZcAdSVz2
         1AACJm2QmuwJYldRZygeq8lJb+2H0VdP2+kbgDzLy/JCFOv41AhAkfaCIMzeBU9PaDP1
         J0aA==
X-Received: by 10.66.136.103 with SMTP id pz7mr2947378pab.140.1402662138628;
        Fri, 13 Jun 2014 05:22:18 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id cj1sm20698636pac.40.2014.06.13.05.22.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:22:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:22:18 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251579>

We are sure that after merge_base_index() is done. cache-tree can
still be used with the final index. So don't destroy cache tree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       | 1 +
 read-cache.c  | 3 ++-
 split-index.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 295bf9d..70fd8ed 100644
--- a/cache.h
+++ b/cache.h
@@ -488,6 +488,7 @@ extern int index_name_pos(const struct index_state =
*, const char *name, int name
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
 #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() *=
/
 #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
+#define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree *=
/
 extern int add_index_entry(struct index_state *, struct cache_entry *c=
e, int option);
 extern void rename_index_entry_at(struct index_state *, int pos, const=
 char *new_name);
 extern int remove_index_entry_at(struct index_state *, int pos);
diff --git a/read-cache.c b/read-cache.c
index 1a7ef7f..d5f70a0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -950,7 +950,8 @@ static int add_index_entry_with_check(struct index_=
state *istate, struct cache_e
 	int skip_df_check =3D option & ADD_CACHE_SKIP_DFCHECK;
 	int new_only =3D option & ADD_CACHE_NEW_ONLY;
=20
-	cache_tree_invalidate_path(istate, ce->name);
+	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
+		cache_tree_invalidate_path(istate, ce->name);
 	pos =3D index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_sta=
ge(ce));
=20
 	/* existing match? Just replace it. */
diff --git a/split-index.c b/split-index.c
index b03a250..33c0c4b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -133,6 +133,7 @@ void merge_base_index(struct index_state *istate)
 	for (i =3D si->nr_replacements; i < si->saved_cache_nr; i++) {
 		add_index_entry(istate, si->saved_cache[i],
 				ADD_CACHE_OK_TO_ADD |
+				ADD_CACHE_KEEP_CACHE_TREE |
 				/*
 				 * we may have to replay what
 				 * merge-recursive.c:update_stages()
--=20
1.9.1.346.ga2b5940
