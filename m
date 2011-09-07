From: Wang Hui <Hui.Wang@windriver.com>
Subject: [PATCH v3 1/1] sha1_file: normalize alt_odb path before comparing and storing
Date: Wed, 7 Sep 2011 18:37:47 +0800
Message-ID: <1315391867-31277-2-git-send-email-Hui.Wang@windriver.com>
References: <1315391867-31277-1-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>, <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:29:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Lvu-0001be-J0
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab1IGR3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:29:00 -0400
Received: from mail.windriver.com ([147.11.1.11]:63202 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab1IGR26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:28:58 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p87AbUsI005434
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 7 Sep 2011 03:40:00 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Wed, 7 Sep 2011 03:38:02 -0700
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1315391867-31277-1-git-send-email-Hui.Wang@windriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180877>

From: Hui Wang <Hui.Wang@windriver.com>

When it needs to compare and add an alt object path to the
alt_odb_list, we normalize this path first since comparing normalized
path is easy to get correct result.

Use strbuf to replace some string operations, since it is cleaner and
safer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Hui Wang <Hui.Wang@windriver.com>
---
 sha1_file.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f7c3408..fa2484b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -248,27 +248,27 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 	const char *objdir = get_object_directory();
 	struct alternate_object_database *ent;
 	struct alternate_object_database *alt;
-	/* 43 = 40-byte + 2 '/' + terminating NUL */
-	int pfxlen = len;
-	int entlen = pfxlen + 43;
-	int base_len = -1;
+	int pfxlen, entlen;
+	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (!is_absolute_path(entry) && relative_base) {
-		/* Relative alt-odb */
-		if (base_len < 0)
-			base_len = strlen(relative_base) + 1;
-		entlen += base_len;
-		pfxlen += base_len;
+		strbuf_addstr(&pathbuf, real_path(relative_base));
+		strbuf_addch(&pathbuf, '/');
 	}
-	ent = xmalloc(sizeof(*ent) + entlen);
+	strbuf_add(&pathbuf, entry, len);
 
-	if (!is_absolute_path(entry) && relative_base) {
-		memcpy(ent->base, relative_base, base_len - 1);
-		ent->base[base_len - 1] = '/';
-		memcpy(ent->base + base_len, entry, len);
-	}
-	else
-		memcpy(ent->base, entry, pfxlen);
+	normalize_path_copy(pathbuf.buf, pathbuf.buf);
+
+	pfxlen = strlen(pathbuf.buf);
+
+	/* Drop the last '/' from path can make memcmp more accurate */
+	if (pathbuf.buf[pfxlen-1] == '/')
+		pfxlen -= 1;
+
+	entlen = pfxlen + 43; /* '/' + 2 hex + '/' + 38 hex + NUL */
+	ent = xmalloc(sizeof(*ent) + entlen);
+	memcpy(ent->base, pathbuf.buf, pfxlen);
+	strbuf_release(&pathbuf);
 
 	ent->name = ent->base + pfxlen + 1;
 	ent->base[pfxlen + 3] = '/';
-- 
1.6.3.1
