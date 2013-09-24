From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 2/5] buitin/describe.c: use new hash map implementation
Date: Tue, 24 Sep 2013 11:52:16 +0200
Message-ID: <524160D0.2010907@gmail.com>
References: <522FAAC4.2080601@gmail.com> <52416058.90008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 24 11:52:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOPI7-0003q3-10
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 11:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999Ab3IXJwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 05:52:19 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:51478 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3IXJwS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 05:52:18 -0400
Received: by mail-we0-f169.google.com with SMTP id t60so4351942wes.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=xsT6bh/x+xtF5HX4OVtRkqTnrCR1egayrxKJBQ4T2Mo=;
        b=IYyg+m/ln8FpFf4Mlx9S7ltSfxA0/uIiRLKpW/DAZoRzzvTx2xXxpjug95kwsQNcID
         UbEkO5tJ2q4ujX3HjAtDWROdivsVajzxVSU42b2vlw2ZW/Khd0vRY78dtZX3IpNOyVsH
         Zg6tOAhwdwexfv1YqwyTKvopSOl1vmE4+M4GOpxtNxHGTIwSlGV32nkEMYBMJ0nruPFQ
         FbIeuDo7m6jGn6Rumx0rZ2ByQZziEBqgKc7lq8LtuKrg0L3yr70bJJA7QpZjassiBx8z
         9MvDQCOZboEFafMZa1nnpbd508huR801UxJsm/0DrQU7Zgl43hiyutDIW3DE3rb1/89v
         L5QQ==
X-Received: by 10.194.60.73 with SMTP id f9mr388372wjr.65.1380016336808;
        Tue, 24 Sep 2013 02:52:16 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ey4sm5780442wic.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 02:52:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <52416058.90008@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235292>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 builtin/describe.c | 53 ++++++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 7d73722..5db5d89 100644
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
+static struct hashmap names;
 static int have_util;
 static const char *pattern;
 static int always;
@@ -38,7 +38,7 @@ static const char *diff_index_args[] = {
 
 
 struct commit_name {
-	struct commit_name *next;
+	struct hashmap_entry entry;
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
1.8.4.5.gef01589.dirty
