From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 11/11] ref-filter: make 'ref_array_item' use a FLEX_ARRAY for refname
Date: Sat,  6 Jun 2015 19:18:16 +0530
Message-ID: <1433598496-31287-11-git-send-email-karthik.188@gmail.com>
References: <5572F904.1080608@gmail.com>
 <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 15:49:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ETT-0005Pt-Ez
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 15:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbbFFNtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 09:49:19 -0400
Received: from mail-pd0-f193.google.com ([209.85.192.193]:34222 "EHLO
	mail-pd0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932535AbbFFNtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 09:49:16 -0400
Received: by pdbht2 with SMTP id ht2so12432382pdb.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TTxRiXjitfB80v/XgWmfD6E7PzUNXz78xuzLyXDQ0p8=;
        b=FFXZFTMKMpPWcRKcyepH2Kzv1Sa83IGlz52rx4wtNHng8Ir6VJaIM/2O+ATWFa0gvM
         FBo2qL837m1WomvTcIidZiLwujcN5/58gIur9RGdIjihp2+6ZNF10s3Jw8+HbEfVtZfu
         7AoTPn0xZi41u86h6a56DVR1nqlZc+FIO4jDsa2jAhX8nW5uTwz4XlbXV84IKRs8nKeY
         phlmENBzbvL4K/edkchMrat1Sbj147gcvdpPHSQcBJAcPhWcHy7+fUMlW+4TS2IIkN6U
         d34Tlynmne2jiAfs2JyOclbZLGEOObpITLMXkOwlYxdMS77DubBMwwLuYjL7POnV+eQM
         khhg==
X-Received: by 10.66.182.229 with SMTP id eh5mr14387852pac.18.1433598556557;
        Sat, 06 Jun 2015 06:49:16 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id p9sm9715427pds.92.2015.06.06.06.49.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 06:49:15 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270931>

This would remove the need of using a pointer to store refname.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 7 ++++---
 ref-filter.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 91a6ec9..745d3b3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -846,8 +846,10 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 						 const unsigned char *objectname,
 						 int flag)
 {
-	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item));
-	ref->refname = xstrdup(refname);
+	size_t len = strlen(refname);
+	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
+	memcpy(ref->refname, refname, len);
+	ref->refname[len] = '\0';
 	hashcpy(ref->objectname, objectname);
 	ref->flag = flag;
 
@@ -888,7 +890,6 @@ int ref_filter_handler(const char *refname, const struct object_id *oid, int fla
 static void free_array_item(struct ref_array_item *item)
 {
 	free(item->symref);
-	free(item->refname);
 	free(item);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 15e6766..041a39a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -29,7 +29,7 @@ struct ref_array_item {
 	int flag;
 	char *symref;
 	struct atom_value *value;
-	char *refname;
+	char refname[FLEX_ARRAY];
 };
 
 struct ref_array {
-- 
2.4.2
