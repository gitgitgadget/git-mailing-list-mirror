From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/12] refs: wrap the packed refs cache in a level of indirection
Date: Thu, 20 Jun 2013 10:37:45 +0200
Message-ID: <1371717474-28942-4-git-send-email-mhagger@alum.mit.edu>
References: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:43:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaT5-0000qC-Sg
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935383Ab3FTIn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:43:26 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57456 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756136Ab3FTIiM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:12 -0400
X-AuditID: 12074413-b7f136d000006de1-73-51c2bf7318f7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 09.03.28129.37FB2C15; Thu, 20 Jun 2013 04:38:12 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0sB001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:10 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqFuy/1CgwdTtjBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLXZPW8DmwObx9/0HJo9LL7+zeTzr3cPocfGSssfjiSdYPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzmhfeZu14KJoxZlzjxkbGI8LdjFyckgImEg8uTONFcIWk7hwbz1b
	FyMXh5DAZUaJxgs9jBDOOSaJf/efMIFUsQnoSizqaQazRQTUJCa2HWIBKWIW2M0osfz0KXaQ
	hLBAiERL90MWEJtFQFWiZeNTsDivgIvEk3V7mSDWKUhMefieGcTmFHCVeHN4DtgZQkA1W3ft
	YJ3AyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkioCe9g3HVS7hCj
	AAejEg+v5uWDgUKsiWXFlbmHGCU5mJREeefuOxQoxJeUn1KZkVicEV9UmpNafIhRgoNZSYQ3
	dQ5QjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwZsGMlSwKDU9tSIt
	M6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFB3xxcD4AEnxAO1dBtLOW1yQmAsUhWg9xajLMfns
	lveMQix5+XmpUuK8q0CKBECKMkrz4FbAEssrRnGgj4V5o0GqeIBJCW7SK6AlTEBL9qwGW1KS
	iJCSamBc9dCC++o827RsvVeb06Z8+RfhtObJdDsHR2WP+XtZm4RWsid/eJKXuciKZeOVnR9t
	Hu5aIzOxI99LVWP9DTZlk74pN1dWngoQsi8IuyMbd3DVn2Jn1giHhs3pJWdkg07s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228462>

As we know, we can solve any problem in this manner.  In this case,
the problem is to avoid freeing a packed refs cache while somebody is
using it.  So add a level of indirection as a prelude to
reference-counting the packed refs cache.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 9f1a007..373d95b 100644
--- a/refs.c
+++ b/refs.c
@@ -806,6 +806,10 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 	return 1;
 }
 
+struct packed_ref_cache {
+	struct ref_entry *root;
+};
+
 /*
  * Future: need to be in "struct repository"
  * when doing a full libification.
@@ -813,7 +817,7 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 static struct ref_cache {
 	struct ref_cache *next;
 	struct ref_entry *loose;
-	struct ref_entry *packed;
+	struct packed_ref_cache *packed;
 	/*
 	 * The submodule name, or "" for the main repo.  We allocate
 	 * length 1 rather than FLEX_ARRAY so that the main ref_cache
@@ -825,7 +829,8 @@ static struct ref_cache {
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
 	if (refs->packed) {
-		free_ref_entry(refs->packed);
+		free_ref_entry(refs->packed->root);
+		free(refs->packed);
 		refs->packed = NULL;
 	}
 }
@@ -996,24 +1001,39 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
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
1.8.3.1
