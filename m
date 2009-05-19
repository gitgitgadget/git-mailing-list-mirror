From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 3/3] Unify sha1 char hash functions
Date: Mon, 18 May 2009 23:34:04 -0500
Message-ID: <1242707644-29893-3-git-send-email-dpmcgee@gmail.com>
References: <449c10960905182132h2c1b38b4jd28721adaeb38484@mail.gmail.com>
 <1242707644-29893-1-git-send-email-dpmcgee@gmail.com>
 <1242707644-29893-2-git-send-email-dpmcgee@gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 06:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6H2J-00051l-Gd
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 06:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbZESEeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 00:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbZESEef
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 00:34:35 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:50589 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbZESEee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 00:34:34 -0400
Received: by yx-out-2324.google.com with SMTP id 3so2267774yxj.1
        for <git@vger.kernel.org>; Mon, 18 May 2009 21:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mL4QUknyrYxxTGXLQ7GxjE4zPJ3ETwFPcebBMC0XYVM=;
        b=ZYTd9Sl+7mfZdKmpwCSjYIRdzwFmkhuTcZLqi9gdQfPH+zK1beWAh9QIkKAb9yYUyc
         mOcmfEUOMQhObvHSeoY/xdZlTF1g8wXIFGLs8xMl5MDhw8zC9KQQunvTBE+qOh3JnV51
         bTTYrzHGQzScGtfZtJFXrJkxiuyyeg7no0Dqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VRAUP5G+DEWHFXfOpH9MdPS9o/uuSWLQ/kVKoSYaUtgmQ1YKoNi94T9OUEG4HzTpCC
         cIChTb3VzGY7swYtjJQzvQblBZSX4AHqpq/upQe1iDk7Paj2288q7BcUovqczl8t3usk
         afFT/zhmvhXApqw0jGH0O3Q7080jFUcl2L4xI=
Received: by 10.90.86.9 with SMTP id j9mr4944568agb.32.1242707676015;
        Mon, 18 May 2009 21:34:36 -0700 (PDT)
Received: from localhost (adsl-76-197-232-78.dsl.chcgil.sbcglobal.net [76.197.232.78])
        by mx.google.com with ESMTPS id 5sm8968390agc.55.2009.05.18.21.34.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 21:34:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1242707644-29893-2-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expose a canonical one in object.c; convert the hashtable_index call and
the calls in decorate.c.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 decorate.c |    7 -------
 object.c   |   11 ++---------
 object.h   |    1 +
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/decorate.c b/decorate.c
index 3c08b96..4332924 100644
--- a/decorate.c
+++ b/decorate.c
@@ -6,13 +6,6 @@
 #include "object.h"
 #include "decorate.h"
 
-static unsigned int hash_chars(const unsigned char *c, unsigned int n)
-{
-	unsigned int hash;
-	memcpy(&hash, c, sizeof(unsigned int));
-	return hash % n;
-}
-
 static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
 {
 	int size = n->size;
diff --git a/object.c b/object.c
index 09c4d3c..34f65e5 100644
--- a/object.c
+++ b/object.c
@@ -43,7 +43,7 @@ int type_from_string(const char *str)
 	die("invalid object type \"%s\"", str);
 }
 
-static unsigned int hash_chars(const unsigned char *c, unsigned int n)
+unsigned int hash_chars(const unsigned char *c, unsigned int n)
 {
 	unsigned int hash;
 	memcpy(&hash, c, sizeof(unsigned int));
@@ -62,13 +62,6 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
 	hash[j] = obj;
 }
 
-static unsigned int hashtable_index(const unsigned char *sha1)
-{
-	unsigned int i;
-	memcpy(&i, sha1, sizeof(unsigned int));
-	return i % obj_hash_size;
-}
-
 struct object *lookup_object(const unsigned char *sha1)
 {
 	unsigned int i;
@@ -77,7 +70,7 @@ struct object *lookup_object(const unsigned char *sha1)
 	if (!obj_hash)
 		return NULL;
 
-	i = hashtable_index(sha1);
+	i = hash_chars(sha1, obj_hash_size);
 	while ((obj = obj_hash[i]) != NULL) {
 		if (!hashcmp(sha1, obj->sha1))
 			break;
diff --git a/object.h b/object.h
index 89dd0c4..ed73a0a 100644
--- a/object.h
+++ b/object.h
@@ -37,6 +37,7 @@ struct object {
 
 extern const char *typename(unsigned int type);
 extern int type_from_string(const char *str);
+extern unsigned int hash_chars(const unsigned char *c, unsigned int n);
 
 extern unsigned int get_max_object_index(void);
 extern struct object *get_indexed_object(unsigned int);
-- 
1.6.3.1
