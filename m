From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 03/14] buitin/describe.c: use new hash map implementation
Date: Thu, 14 Nov 2013 20:18:35 +0100
Message-ID: <5285220B.4020403@gmail.com>
References: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:18:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2R4-0007bA-55
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab3KNTSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:18:35 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:41597 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab3KNTSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:18:33 -0500
Received: by mail-wi0-f175.google.com with SMTP id hm11so7643383wib.14
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=CpPQd1SBTLVVEbdGKNITWnmu2cOM9f6WZSx7L9CSM+4=;
        b=LGN22dK1rhBi+ZlgbVIzHsPWK+76U/NcLKR20YfEcUrT9R1J3VSZUEB6vTlOiXFXRF
         jEAkNF3cjydyW4Hd8N9xn5VkIFLd3n7KGyE3p7eo2dluP0Vn9d9Xxnla95RQ0ZUcc/uX
         iw3hXaik9Rhz3xBu8zFelPM42WU0SoC0JnRybTDJ7YikmyK+zQT5TnZIxcPfGepNBC9m
         7TvDeGk/lmIBL7bvQoxvwnuCKQns1dymqFgJFtzk2VHIbWAa3Yiyes1NNE64YTQkCyaw
         IiXzJ+1Ug3NkyqoQogd/GS/Sa/uBX89GSeJxzqDjKNXwoBtrQQP/Oe/bf9w/nU0UAg9m
         cebA==
X-Received: by 10.180.37.239 with SMTP id b15mr4277182wik.40.1384456712877;
        Thu, 14 Nov 2013 11:18:32 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id gg20sm7777337wic.1.2013.11.14.11.18.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:18:32 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52851FB5.4050406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237863>

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c | 53 ++++++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 6f62109..0b2cef4 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -6,7 +6,7 @@
 #include "exec_cmd.h"
 #include "parse-options.h"
 #include "diff.h"
-#include "hash.h"
+#include "hashmap.h"
 #include "argv-array.h"
 
 #define SEEN		(1u << 0)
@@ -25,7 +25,7 @@ static int longformat;
 static int first_parent;
 static int abbrev = -1; /* unspecified */
 static int max_candidates = 10;
-static struct hash_table names;
+static struct hashmap names;
 static int have_util;
 static const char *pattern;
 static int always;
@@ -37,7 +37,7 @@ static const char *diff_index_args[] = {
 };
 
 struct commit_name {
-	struct commit_name *next;
+	struct hashmap_entry entry;
 	unsigned char peeled[20];
 	struct tag *tag;
 	unsigned prio:2; /* annotated tag = 2, tag = 1, head = 0 */
@@ -50,6 +50,12 @@ static const char *prio_names[] = {
 	"head", "lightweight", "annotated",
 };
 
+static int commit_name_cmp(const struct commit_name *cn1,
+		const struct commit_name *cn2, const void *peeled)
+{
+	return hashcmp(cn1->peeled, peeled ? peeled : cn2->peeled);
+}
+
 static inline unsigned int hash_sha1(const unsigned char *sha1)
 {
 	unsigned int hash;
@@ -59,21 +65,9 @@ static inline unsigned int hash_sha1(const unsigned char *sha1)
 
 static inline struct commit_name *find_commit_name(const unsigned char *peeled)
 {
-	struct commit_name *n = lookup_hash(hash_sha1(peeled), &names);
-	while (n && !!hashcmp(peeled, n->peeled))
-		n = n->next;
-	return n;
-}
-
-static int set_util(void *chain, void *data)
-{
-	struct commit_name *n;
-	for (n = chain; n; n = n->next) {
-		struct commit *c = lookup_commit_reference_gently(n->peeled, 1);
-		if (c)
-			c->util = n;
-	}
-	return 0;
+	struct commit_name key;
+	hashmap_entry_init(&key, hash_sha1(peeled));
+	return hashmap_get(&names, &key, peeled);
 }
 
 static int replace_name(struct commit_name *e,
@@ -118,16 +112,10 @@ static void add_to_known_names(const char *path,
 	struct tag *tag = NULL;
 	if (replace_name(e, prio, sha1, &tag)) {
 		if (!e) {
-			void **pos;
 			e = xmalloc(sizeof(struct commit_name));
 			hashcpy(e->peeled, peeled);
-			pos = insert_hash(hash_sha1(peeled), e, &names);
-			if (pos) {
-				e->next = *pos;
-				*pos = e;
-			} else {
-				e->next = NULL;
-			}
+			hashmap_entry_init(e, hash_sha1(peeled));
+			hashmap_add(&names, e);
 			e->path = NULL;
 		}
 		e->tag = tag;
@@ -292,7 +280,14 @@ static void describe(const char *arg, int last_one)
 		fprintf(stderr, _("searching to describe %s\n"), arg);
 
 	if (!have_util) {
-		for_each_hash(&names, set_util, NULL);
+		struct hashmap_iter iter;
+		struct commit *c;
+		struct commit_name *n = hashmap_iter_first(&names, &iter);
+		for (; n; n = hashmap_iter_next(&iter)) {
+			c = lookup_commit_reference_gently(n->peeled, 1);
+			if (c)
+				c->util = n;
+		}
 		have_util = 1;
 	}
 
@@ -463,9 +458,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		return cmd_name_rev(args.argc, args.argv, prefix);
 	}
 
-	init_hash(&names);
+	hashmap_init(&names, (hashmap_cmp_fn) commit_name_cmp, 0);
 	for_each_rawref(get_name, NULL);
-	if (!names.nr && !always)
+	if (!names.size && !always)
 		die(_("No names found, cannot describe anything."));
 
 	if (argc == 0) {
-- 
1.8.5.rc0.333.g5394214
