From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/14] pack v4: add pv4_free_dict()
Date: Sun,  8 Sep 2013 14:22:28 +0700
Message-ID: <1378624960-8919-3-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:19:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZHk-0003eT-Am
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776Ab3IHHTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:19:48 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:44493 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHTs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:19:48 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so4879629pbc.22
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rrh4Vqwm3iM29dtvtuurf3AVNGoR0ffYdJ9wpVp0Pyc=;
        b=VkV4YDgfKonij0A6knEj202lw6flp/TNaJsPWe5meSy3CQphjO/wyWKInxCYqPiaQ8
         ltvfk3CCsG9H0bikh56tItkv4+z6jxZ3+z47urvOBtQeA4Xcp4cwbDzp6DciIafJLuU2
         t6eNBCXsgx4icxIq1gxql042cDGYgmXi5mm2M7YkTtsfVh8jFXcGUdb6aeZhdAbgbGD6
         k/TcqnFsCEBp6UPhd0lnMjq/huzmtH6weX/3WGniIzjr2TLnvaKfiZ+EyWODtV70+1Hp
         +sezP1zjyBmlv4x357Kmf/OJ0ZffDTIY7TgHwr2dv0VOAOnSrI0uCj16lCImlaF/Vra8
         sl/Q==
X-Received: by 10.66.154.1 with SMTP id vk1mr13368811pab.85.1378624787575;
        Sun, 08 Sep 2013 00:19:47 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id oj6sm9313872pab.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:19:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:22:54 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234199>

---
 packv4-parse.c | 8 ++++++++
 packv4-parse.h | 1 +
 sha1_file.c    | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/packv4-parse.c b/packv4-parse.c
index 82661ba..d515bb9 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -63,6 +63,14 @@ struct packv4_dict *pv4_create_dict(const unsigned char *data, int dict_size)
 	return dict;
 }
 
+void pv4_free_dict(struct packv4_dict *dict)
+{
+	if (dict) {
+		free((void*)dict->data);
+		free(dict);
+	}
+}
+
 static struct packv4_dict *load_dict(struct packed_git *p, off_t *offset)
 {
 	struct pack_window *w_curs = NULL;
diff --git a/packv4-parse.h b/packv4-parse.h
index 0b2405a..e6719f6 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -8,6 +8,7 @@ struct packv4_dict {
 };
 
 struct packv4_dict *pv4_create_dict(const unsigned char *data, int dict_size);
+void pv4_free_dict(struct packv4_dict *dict);
 
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 		     off_t offset, unsigned long size);
diff --git a/sha1_file.c b/sha1_file.c
index c7bf677..1528e28 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -763,6 +763,8 @@ void free_pack_by_name(const char *pack_name)
 			}
 			close_pack_index(p);
 			free(p->bad_object_sha1);
+			pv4_free_dict(p->ident_dict);
+			pv4_free_dict(p->path_dict);
 			*pp = p->next;
 			if (last_found_pack == p)
 				last_found_pack = NULL;
-- 
1.8.2.83.gc99314b
