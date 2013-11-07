From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 03/14] buitin/describe.c: use new hash map implementation
Date: Thu, 07 Nov 2013 15:35:20 +0100
Message-ID: <527BA528.60107@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:35:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQg8-0006sI-1r
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583Ab3KGOfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:35:19 -0500
Received: from mail-bk0-f52.google.com ([209.85.214.52]:38763 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab3KGOfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:35:18 -0500
Received: by mail-bk0-f52.google.com with SMTP id v10so246077bkz.25
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XFJ+tH6olX494EXYRQccDhshXWF+RwmwL9lJnGEOfb0=;
        b=1CsgETYWZCsfglLoiv9MIzpPZW3OvaWqlGU084cNx1uFVKNUADZ6284R/poLrvTboV
         B/aFxcFQq3SGhNBKw3QwgrnNA+KZsovxKs1PyMDIgE0z/7P28lQnD9EaVxI89Odt7tMI
         z0/Lpjnqttfj1Ori8d6bTHM6bXy7giT2l1yyWiVUkN91hrZMKXEj+zf0K7ao9u+UdZcd
         O+3pk+KmMfIyd4SFv3bOI9JZ5G4gTNEZ4M1POK9awTCKYgrPw59KJB7mJSzCPxx0GT7x
         YzpydIwuiNFSW5XHgJdP66NI/FQ2yDk/lw87Oy8rdQGd88cyS4oefRAPOy8M2DzEeMuL
         qYCg==
X-Received: by 10.204.127.135 with SMTP id g7mr1972692bks.42.1383834917278;
        Thu, 07 Nov 2013 06:35:17 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id zl3sm2555723bkb.4.2013.11.07.06.35.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:35:16 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237398>

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
1.8.4.msysgit.0.12.g88f5ed0
