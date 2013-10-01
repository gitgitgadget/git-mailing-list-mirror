From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v3 02/11] buitin/describe.c: use new hash map implementation
Date: Tue, 01 Oct 2013 11:35:20 +0200
Message-ID: <524A9758.2040201@gmail.com>
References: <524A96FF.5090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 01 11:35:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQwMX-0003hq-Tf
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 11:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab3JAJfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 05:35:22 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:55761 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab3JAJfV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 05:35:21 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so3280568ead.35
        for <git@vger.kernel.org>; Tue, 01 Oct 2013 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZXh6rWkbZf9SbCSq2QkoPZ4vFf4CHyIVBqH13+brfq8=;
        b=i2SmGi90koV1CZ4CGCgD7NUd90oswzh6jqTCOqlwK1XOsjKMknpbrDJv4VyYVmHyiQ
         fKG65+j2muxEGPP4Pff8hU9O7KIdB5apttp5+eQ4ZR/Pmn/ETohiLrCIlMS7GVsJhbld
         8aZRLJuwIa5AJUWo9AAy5f/lfoHVwaAY31JE2k7DySxfWIAwrmIRQ5c830nn34r4CYFU
         AmA9f20WaPlOEmYtvmhvtICISUP64hT0muhb31ki3XQV/2Vkn8QDdDTVd9ToiNYkVdXW
         vJO5I6OkjXbDh75XPIRoYuV1HNFPEJ54U9r0CQpLGCsV5tKhByrEBptqlwXecyT1WNB6
         MRbA==
X-Received: by 10.14.241.74 with SMTP id f50mr45119844eer.29.1380620120516;
        Tue, 01 Oct 2013 02:35:20 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id i1sm11143842eeg.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 02:35:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <524A96FF.5090604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235646>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 builtin/describe.c | 53 ++++++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 7d73722..ae8d32c 100644
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
1.8.4.11.g4f52745.dirty
