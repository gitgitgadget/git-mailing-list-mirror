From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/3] Convert hash functions to char instead of struct object
Date: Mon, 18 May 2009 23:34:03 -0500
Message-ID: <1242707644-29893-2-git-send-email-dpmcgee@gmail.com>
References: <449c10960905182132h2c1b38b4jd28721adaeb38484@mail.gmail.com>
 <1242707644-29893-1-git-send-email-dpmcgee@gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 06:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6H2I-00051l-Ql
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 06:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbZESEec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 00:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbZESEeb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 00:34:31 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:50589 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbZESEeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 00:34:31 -0400
Received: by yx-out-2324.google.com with SMTP id 3so2267774yxj.1
        for <git@vger.kernel.org>; Mon, 18 May 2009 21:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TPVC7/iPlQ8QYRDKy5/JWArpCsutFoV5uelJu60U1ug=;
        b=pKWFXfhRCzxt75UpCU+0qaTquDus+EHeSPOUELZW2RGi0j1IpK9KE5ToLh1QbZlmrk
         RBYmyrYWlPGhiLGSTNvEDyFhV8eqU3a1LyUm6/VjEz9J0CSxBCsZVx7weaCU3TOhlyjS
         ZREQWuRE5ZFIJWKPt79oiR54l5fDyJaVGOV84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D/QSLRIP1yb+Oa1KQ/0GyqmRcOOi54cN47Ctd9TJQN2qVIOsqYc2WIXgwPjfktKFkL
         LC7RUbfMB3ivyrouI+acZCxcg0O294uzAPRLwU5Lg5W9AiDbMiJ8404yv/j6WKEDSCBv
         2AtgEhxgQdzlwCe2EIJbo+kGUnCfsgJrzhRYw=
Received: by 10.90.75.13 with SMTP id x13mr337145aga.96.1242707672763;
        Mon, 18 May 2009 21:34:32 -0700 (PDT)
Received: from localhost (adsl-76-197-232-78.dsl.chcgil.sbcglobal.net [76.197.232.78])
        by mx.google.com with ESMTPS id 1sm8959548agb.48.2009.05.18.21.34.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 21:34:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1242707644-29893-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119490>

This will allow us to unify the three hash functions into just one.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 decorate.c |    9 ++++-----
 object.c   |    6 +++---
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/decorate.c b/decorate.c
index 2f8a63e..3c08b96 100644
--- a/decorate.c
+++ b/decorate.c
@@ -6,11 +6,10 @@
 #include "object.h"
 #include "decorate.h"
 
-static unsigned int hash_obj(const struct object *obj, unsigned int n)
+static unsigned int hash_chars(const unsigned char *c, unsigned int n)
 {
 	unsigned int hash;
-
-	memcpy(&hash, obj->sha1, sizeof(unsigned int));
+	memcpy(&hash, c, sizeof(unsigned int));
 	return hash % n;
 }
 
@@ -18,7 +17,7 @@ static void *insert_decoration(struct decoration *n, const struct object *base,
 {
 	int size = n->size;
 	struct object_decoration *hash = n->hash;
-	unsigned int j = hash_obj(base, size);
+	unsigned int j = hash_chars(base->sha1, size);
 
 	while (hash[j].base) {
 		if (hash[j].base == base) {
@@ -75,7 +74,7 @@ void *lookup_decoration(struct decoration *n, const struct object *obj)
 	/* nothing to lookup */
 	if (!n->size)
 		return NULL;
-	j = hash_obj(obj, n->size);
+	j = hash_chars(obj->sha1, n->size);
 	for (;;) {
 		struct object_decoration *ref = n->hash + j;
 		if (ref->base == obj)
diff --git a/object.c b/object.c
index a6ef439..09c4d3c 100644
--- a/object.c
+++ b/object.c
@@ -43,16 +43,16 @@ int type_from_string(const char *str)
 	die("invalid object type \"%s\"", str);
 }
 
-static unsigned int hash_obj(struct object *obj, unsigned int n)
+static unsigned int hash_chars(const unsigned char *c, unsigned int n)
 {
 	unsigned int hash;
-	memcpy(&hash, obj->sha1, sizeof(unsigned int));
+	memcpy(&hash, c, sizeof(unsigned int));
 	return hash % n;
 }
 
 static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
 {
-	unsigned int j = hash_obj(obj, size);
+	unsigned int j = hash_chars(obj->sha1, size);
 
 	while (hash[j]) {
 		j++;
-- 
1.6.3.1
