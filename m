From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/12] refs: wrap the packed refs cache in a level of indirection
Date: Tue, 11 Jun 2013 23:48:23 +0200
Message-ID: <1370987312-6761-4-git-send-email-mhagger@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:49:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWR6-0003kk-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519Ab3FKVs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:48:58 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50736 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753253Ab3FKVs4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:48:56 -0400
X-AuditID: 12074413-b7f136d000006de1-a1-51b79b48cc97
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.45.28129.84B97B15; Tue, 11 Jun 2013 17:48:56 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BLmbir015717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 17:48:55 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqOsxe3ugweEdChZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvj5e0+loJzohXvj55laWA8ItjFyMEhIWAiceK9RRcjJ5ApJnHh3nq2LkYuDiGBy4wS
	Z+7fZodwLjBJ/L3+iR2kik1AV2JRTzMTiC0ioCYxse0QC0gRs0A7o8S75n3MIAlhgUCJv8/W
	sIBsYBFQlZi9ox4kzCvgLHHxzBxWiG1yEu/v7GIBsTkFXCQ2bt4M1ioEVPO9p4lxAiPvAkaG
	VYxyiTmlubq5iZk5xanJusXJiXl5qUW65nq5mSV6qSmlmxghISW8g3HXSblDjAIcjEo8vBKW
	2wOFWBPLiitzDzFKcjApifKyTQMK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHVzQXK8aYkVlal
	FuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeENmATUKFqWmp1akZeaUIKSZODhB
	hnNJiRSn5qWkFiWWlmTEgyIjvhgYGyApHqC9fCDtvMUFiblAUYjWU4y6HJvPT37HKMSSl5+X
	KiXOmwJSJABSlFGaB7cClkBeMYoDfSzM6w1SxQNMPnCTXgEtYQJaUpQBtqQkESEl1cDY6yGS
	H9G7vryY5eMr4bJm3i/Xe54z7J4elrJCcNVnl8xJst3SO2xq6huv6guUWDa8+BDmtJx7uxn7
	Ic7ixM+nZafIm8QpnvjH1B07m9PWMrY6fqY9r5JlT1j7nfj9v+YUqGZev/DnSlba 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227521>

As we know, we can solve any problem in this manner.  In this case,
the problem is to avoid freeing a packed refs cache while somebody is
using it.  So add a level of indirection as a prelude to
reference-counting the packed refs cache.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index bb3640f..4cee36b 100644
--- a/refs.c
+++ b/refs.c
@@ -802,6 +802,10 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 	return 1;
 }
 
+struct packed_ref_cache {
+	struct ref_entry *root;
+};
+
 /*
  * Future: need to be in "struct repository"
  * when doing a full libification.
@@ -809,7 +813,7 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 static struct ref_cache {
 	struct ref_cache *next;
 	struct ref_entry *loose;
-	struct ref_entry *packed;
+	struct packed_ref_cache *packed;
 	/*
 	 * The submodule name, or "" for the main repo.  We allocate
 	 * length 1 rather than FLEX_ARRAY so that the main ref_cache
@@ -821,7 +825,8 @@ static struct ref_cache {
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
 	if (refs->packed) {
-		free_ref_entry(refs->packed);
+		free_ref_entry(refs->packed->root);
+		free(refs->packed);
 		refs->packed = NULL;
 	}
 }
@@ -992,24 +997,39 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	}
 }
 
-static struct ref_dir *get_packed_refs(struct ref_cache *refs)
+/*
+ * Get the packed_ref_cache for the specified ref_cache, creating it
+ * if necessary.
+ */
+static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
 {
 	if (!refs->packed) {
 		const char *packed_refs_file;
 		FILE *f;
 
-		refs->packed = create_dir_entry(refs, "", 0, 0);
+		refs->packed = xcalloc(1, sizeof(*refs->packed));
+		refs->packed->root = create_dir_entry(refs, "", 0, 0);
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
 			packed_refs_file = git_path("packed-refs");
 		f = fopen(packed_refs_file, "r");
 		if (f) {
-			read_packed_refs(f, get_ref_dir(refs->packed));
+			read_packed_refs(f, get_ref_dir(refs->packed->root));
 			fclose(f);
 		}
 	}
-	return get_ref_dir(refs->packed);
+	return refs->packed;
+}
+
+static struct ref_dir *get_packed_ref_dir(struct packed_ref_cache *packed_ref_cache)
+{
+	return get_ref_dir(packed_ref_cache->root);
+}
+
+static struct ref_dir *get_packed_refs(struct ref_cache *refs)
+{
+	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
 void add_packed_ref(const char *refname, const unsigned char *sha1)
-- 
1.8.3
