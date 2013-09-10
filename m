From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH/RFC 2/5] buitin/describe.c: use new hash map implementation
Date: Wed, 11 Sep 2013 01:28:56 +0200
Message-ID: <522FAB38.2020004@gmail.com>
References: <522FAAC4.2080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 11 01:29:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJXMn-0000ZF-SO
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 01:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab3IJX27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 19:28:59 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:65086 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab3IJX26 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 19:28:58 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so4284357eek.28
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=tqEQnBu4pPZC3vWQjobqtd/UvndvVpyDgL/oSbxS0WM=;
        b=VIjIVUBOioGCoLPCkx5z5XO7zOt6+STPntLNW1QbQCHF10Da/zIwDS7EbRxueVxv2o
         cO1eNCEfZhn2fajw6XvXfBR2xm67opAJfZzFvHXCa6v4cWoAoRYnKUeEfIVLf9zidmj7
         8pa56Vt14NZVcCs32SAosUs22LMYpLSIsh8Ri88UKbSffU2Ks7dTxKPT6Uv3I5ttxSFR
         VY8CzUdnyVsJ2s/A8R64aDhMLTvIZRN5bSWcVeR66w0W/plK2oh7Yiji22yGiHNaQtOJ
         KjD8Lrab1R8UY1ogbL95BbqNW6TSt4sye+i6YkpIbH4Nv1nRmQJqY9yV9/kGBr07Xc1B
         96HA==
X-Received: by 10.15.111.132 with SMTP id cj4mr6637219eeb.56.1378855736011;
        Tue, 10 Sep 2013 16:28:56 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id r48sm35440545eev.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 16:28:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <522FAAC4.2080601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234510>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 builtin/describe.c | 53 ++++++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 7d73722..bbc7159 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -6,7 +6,7 @@
 #include "exec_cmd.h"
 #include "parse-options.h"
 #include "diff.h"
-#include "hash.h"
+#include "hashmap.h"
 #include "argv-array.h"
 
 #define SEEN		(1u<<0)
@@ -25,7 +25,7 @@ static int longformat;
 static int first_parent;
 static int abbrev = -1; /* unspecified */
 static int max_candidates = 10;
-static struct hash_table names;
+static hashmap names;
 static int have_util;
 static const char *pattern;
 static int always;
@@ -38,7 +38,7 @@ static const char *diff_index_args[] = {
 
 
 struct commit_name {
-	struct commit_name *next;
+	hashmap_entry entry;
 	unsigned char peeled[20];
 	struct tag *tag;
 	unsigned prio:2; /* annotated tag = 2, tag = 1, head = 0 */
@@ -50,6 +50,11 @@ static const char *prio_names[] = {
 	"head", "lightweight", "annotated",
 };
 
+static int commit_name_cmp(struct commit_name *cn1, struct commit_name *cn2)
+{
+	return hashcmp(cn1->peeled, cn2->peeled);
+}
+
 static inline unsigned int hash_sha1(const unsigned char *sha1)
 {
 	unsigned int hash;
@@ -59,21 +64,10 @@ static inline unsigned int hash_sha1(const unsigned char *sha1)
 
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
+	hashmap_entry_init(&key, hash_sha1(peeled), 0);
+	hashcpy(key.peeled, peeled);
+	return hashmap_get(&names, &key);
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
+			hashmap_entry_init(e, hash_sha1(peeled), 0);
+			hashmap_add(&names, e);
 			e->path = NULL;
 		}
 		e->tag = tag;
@@ -292,7 +280,14 @@ static void describe(const char *arg, int last_one)
 		fprintf(stderr, _("searching to describe %s\n"), arg);
 
 	if (!have_util) {
-		for_each_hash(&names, set_util, NULL);
+		hashmap_iter iter;
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
1.8.4.8243.gbcbdefd
