From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 1/5] hashmap: add enum for hashmap free_entries option
Date: Thu, 5 Jun 2014 08:06:40 +0200
Message-ID: <20140605060640.GB23874@sandbox-ub>
References: <20140605060425.GA23874@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 08:06:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsQp7-0007Af-RR
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 08:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbaFEGGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 02:06:45 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:37899 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbaFEGGp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 02:06:45 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WsQoz-0003lR-H3; Thu, 05 Jun 2014 08:06:41 +0200
Content-Disposition: inline
In-Reply-To: <20140605060425.GA23874@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250813>

This allows a reader to immediately know which options can be used and
what this parameter is about.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/technical/api-hashmap.txt | 2 +-
 diffcore-rename.c                       | 2 +-
 hashmap.c                               | 2 +-
 hashmap.h                               | 8 +++++++-
 name-hash.c                             | 4 ++--
 test-hashmap.c                          | 6 +++---
 6 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index b977ae8..b04bb40 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -187,7 +187,7 @@ void long2double_init(void)
 
 void long2double_free(void)
 {
-	hashmap_free(&map, 1);
+	hashmap_free(&map, HASHMAP_FREE_ENTRIES);
 }
 
 static struct long2double *find_entry(long key)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 749a35d..f30239a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -335,7 +335,7 @@ static int find_exact_renames(struct diff_options *options)
 		renames += find_identical_files(&file_table, i, options);
 
 	/* Free the hash data structure and entries */
-	hashmap_free(&file_table, 1);
+	hashmap_free(&file_table, HASHMAP_FREE_ENTRIES);
 
 	return renames;
 }
diff --git a/hashmap.c b/hashmap.c
index d1b8056..9a3555a 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -135,7 +135,7 @@ void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 	alloc_table(map, size);
 }
 
-void hashmap_free(struct hashmap *map, int free_entries)
+void hashmap_free(struct hashmap *map, enum hashmap_free_options free_entries)
 {
 	if (!map || !map->table)
 		return;
diff --git a/hashmap.h b/hashmap.h
index a816ad4..6c558df 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -1,6 +1,11 @@
 #ifndef HASHMAP_H
 #define HASHMAP_H
 
+enum hashmap_free_options {
+	HASHMAP_NO_FREE_ENTRIES = 0,
+	HASHMAP_FREE_ENTRIES = 1,
+};
+
 /*
  * Generic implementation of hash-based key-value mappings.
  * See Documentation/technical/api-hashmap.txt.
@@ -39,7 +44,8 @@ struct hashmap_iter {
 
 extern void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 		size_t initial_size);
-extern void hashmap_free(struct hashmap *map, int free_entries);
+extern void hashmap_free(struct hashmap *map,
+			 enum hashmap_free_options free_entries);
 
 /* hashmap_entry functions */
 
diff --git a/name-hash.c b/name-hash.c
index 97444d0..be7c4ae 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -233,6 +233,6 @@ void free_name_hash(struct index_state *istate)
 		return;
 	istate->name_hash_initialized = 0;
 
-	hashmap_free(&istate->name_hash, 0);
-	hashmap_free(&istate->dir_hash, 1);
+	hashmap_free(&istate->name_hash, HASHMAP_NO_FREE_ENTRIES);
+	hashmap_free(&istate->dir_hash, HASHMAP_FREE_ENTRIES);
 }
diff --git a/test-hashmap.c b/test-hashmap.c
index f5183fb..ac8d6a2 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -100,7 +100,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 				hashmap_add(&map, entries[i]);
 			}
 
-			hashmap_free(&map, 0);
+			hashmap_free(&map, HASHMAP_NO_FREE_ENTRIES);
 		}
 	} else {
 		/* test map lookups */
@@ -121,7 +121,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 			}
 		}
 
-		hashmap_free(&map, 0);
+		hashmap_free(&map, HASHMAP_NO_FREE_ENTRIES);
 	}
 }
 
@@ -250,6 +250,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	hashmap_free(&map, 1);
+	hashmap_free(&map, HASHMAP_FREE_ENTRIES);
 	return 0;
 }
-- 
2.0.0
