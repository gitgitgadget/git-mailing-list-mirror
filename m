From: "Geoffrey Irving" <irving@naml.us>
Subject: [PATCH 2/3] cached-sha1-map: refactoring hash traversal code
Date: Tue, 8 Jul 2008 20:56:06 -0700
Message-ID: <7f9d599f0807082056o666fced9nf87cc81447e16e05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 05:57:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGQnk-0000jj-Mk
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 05:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbYGID4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 23:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbYGID4I
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 23:56:08 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:31779 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbYGID4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 23:56:07 -0400
Received: by py-out-1112.google.com with SMTP id p76so1397322pyb.10
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=bH1dUvlgtLiK1LfenZScAIJwFAg4W+dS8gUYKvqH7mU=;
        b=Akn/3NBX0/X10vzpqzYpuqrvjkrTlhjpv2qnfnmOW4LAeT+QXoGG30k36xljX8bynx
         NVGaUBHwKAsHMEpKTVfnPVCZSbv5YCu+uQZIDrtk6pKR7IMZ7JPwYUtsSUYOHuRb0v/X
         k2ck8Bn2UWcU9vAZ1rheKDSVMsnDFPG9C5jSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=lX6D13j7QIc4VGzoA5YK2JAU6jQJUONlAdgr6F3sDXXbOB7Rbs/LpCca+n0nOr5Mx/
         ZWMsJ6WRuRrv82lK4Cz8JqWVcbo68PoWialKLIvTaBX+wAgP1WK6O/IP/74Yj9C36nCQ
         TJGRG+Cb1FGZ7wkjmi98djn+lvIKvyTgVpF+8=
Received: by 10.140.163.3 with SMTP id l3mr607762rve.61.1215575766407;
        Tue, 08 Jul 2008 20:56:06 -0700 (PDT)
Received: by 10.141.202.6 with HTTP; Tue, 8 Jul 2008 20:56:06 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 303c9e661d85a3bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87836>

>From c4e60c28fe66985ac8224da832589c982010744e Mon Sep 17 00:00:00 2001
From: Geoffrey Irving <irving@naml.us>
Date: Tue, 8 Jul 2008 19:47:22 -0700
Subject: [PATCH 2/3] cached-sha1-map: refactoring hash traversal code

Pulling common code from get_cached_sha1_entry and set_cached_sha1_entry
into static find_helper function.
---
 cached-sha1-map.c |   68 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/cached-sha1-map.c b/cached-sha1-map.c
index e363745..147c7a2 100644
--- a/cached-sha1-map.c
+++ b/cached-sha1-map.c
@@ -129,10 +129,14 @@ static size_t get_hash_index(const unsigned char *sha1)
 	return ntohl(*(size_t*)sha1);
 }

-int get_cached_sha1_entry(struct cached_sha1_map *cache,
-	const unsigned char *key, unsigned char *value)
+/*
+ * Returns the index if the entry exists, and the complemented index of
+ * the next free entry otherwise.
+ */
+static long find_helper(struct cached_sha1_map *cache,
+	const unsigned char *key)
 {
-	size_t i, mask;
+	long i, mask;

 	if (!cache->initialized)
 		init_cached_sha1_map(cache);
@@ -140,43 +144,47 @@ int get_cached_sha1_entry(struct cached_sha1_map *cache,
 	mask = cache->size - 1;

 	for (i = get_hash_index(key) & mask; ; i = (i+1) & mask) {
-		if (!hashcmp(key, cache->entries[i].key)) {
-			hashcpy(value, cache->entries[i].value);
-			return 0;
-		} else if (is_null_sha1(cache->entries[i].key))
-			return -1;
+		if (!hashcmp(key, cache->entries[i].key))
+			return i;
+		else if (is_null_sha1(cache->entries[i].key))
+			return ~i;
 	}
 }

+int get_cached_sha1_entry(struct cached_sha1_map *cache,
+	const unsigned char *key, unsigned char *value)
+{
+	long i = find_helper(cache, key);
+	if(i < 0)
+		return -1;
+
+	/* entry found, return value */
+	hashcpy(value, cache->entries[i].value);
+	return 0;
+}
+
 void set_cached_sha1_entry(struct cached_sha1_map *cache,
 	const unsigned char *key, const unsigned char *value)
 {
-	size_t i, mask;
+	long i;
 	struct cached_sha1_entry *entry;

-	if (!cache->initialized)
-		init_cached_sha1_map(cache);
-
-	if (4*cache->count >= 3*cache->size)
-		grow_map(cache);
-
-	mask = cache->size - 1;
-
-	for (i = get_hash_index(key) & mask; ; i = (i+1) & mask) {
-		entry = cache->entries+i;
-
-		if (is_null_sha1(entry->key)) {
-			hashcpy(entry->key, key);
+	i = find_helper(cache, key);
+
+	if (i < 0) { /* write new entry */
+		entry = cache->entries + ~i;
+		hashcpy(entry->key, key);
+		hashcpy(entry->value, value);
+		cache->count++;
+		cache->dirty = 1;
+	} else { /* overwrite existing entry */
+		entry = cache->entries + i;
+		if (hashcmp(value, entry->value)) {
 			hashcpy(entry->value, value);
-			cache->count++;
 			cache->dirty = 1;
-			return;
-		} else if(!hashcmp(key, entry->key)) {
-			if (hashcmp(value, entry->value)) {
-				hashcpy(entry->value, value);
-				cache->dirty = 1;
-			}
-			return;
 		}
 	}
+
+	if (4*cache->count >= 3*cache->size)
+		grow_map(cache);
 }
-- 
1.5.6.2.258.g7a51a
