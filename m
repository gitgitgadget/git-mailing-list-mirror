From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/32] split-index: do not invalidate cache-tree at read time
Date: Mon, 28 Apr 2014 17:55:44 +0700
Message-ID: <1398682553-11634-24-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:56:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejEr-0003D6-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbaD1K4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:56:39 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:42645 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377AbaD1K4g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:56:36 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so5692351pbc.7
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wVFooQSYvZTAZ3hYVAPgD4gP+6j/0DSxo3mQXovsfKk=;
        b=ikzb+pWmFlG1Flk/EHh2PLukO2WwMyDinZaZG5SxP+NM4w0YvrJboxaL08wT0A5Rgk
         Ykpk4H4dzF8xRZr8d76ED13prFOnFqfMGk+wnhIBBxAYKpe1TMGEHB+7bkv2lDvh5u75
         j/JZJMfh2aR3XyTLYvTVDYTdVKgaWETtQuuhMSQzyrCQwLJOWqT+ERXvtKe1MpR6AzKD
         g/JQSYVmrNuzo4CNvQdpcQFMllUwxRBw6y/r3+nehi9X63dAYq1ZvaZo4QUAH0fqIKJ+
         LOVYz8+ygb5ayBw30A3TPe5L/C3kboikjYkPECKYp9xoLZKytk6uofo556/rVEbGLBDV
         amGQ==
X-Received: by 10.69.17.230 with SMTP id gh6mr28370193pbd.0.1398682595778;
        Mon, 28 Apr 2014 03:56:35 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id kl1sm34169467pbd.73.2014.04.28.03.56.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:56:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:58:03 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247287>

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
index 127804e..be95b84 100644
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
index a5517bf..43a61d3 100644
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
