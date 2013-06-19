From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/12] refs: wrap the packed refs cache in a level of indirection
Date: Wed, 19 Jun 2013 09:51:24 +0200
Message-ID: <1371628293-28824-4-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:52:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDC8-0003fT-LF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933995Ab3FSHwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:52:34 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45880 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756629Ab3FSHvx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:51:53 -0400
X-AuditID: 1207440f-b7f786d000001f20-04-51c16318c737
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 52.49.07968.81361C15; Wed, 19 Jun 2013 03:51:52 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWV002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:51:51 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqCuRfDDQ4PZKNYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFrunLWBzYPP4+/4Dk8ell9/ZPJ717mH0uHhJ2ePxxBOsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ7SvvM1acFG04sy5x4wNjMcFuxg5OSQETCQ2zDzCDmGLSVy4t56t
	i5GLQ0jgMqPE1K87mSGc20wS/Q/awKrYBHQlFvU0M4HYIgJqEhPbDrGAFDEL7GaUWH76FFAR
	B4ewQIjEtVdsIDUsAqoSh+8+YwSxeQVcJDadXsYGsU1BYsrD98wg5ZwCrhJnl3mChIWASuad
	msw6gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdE73czBK91JTSTYyQMOPfwdi1XuYQ
	owAHoxIPr+G6A4FCrIllxZW5hxglOZiURHnZkw4GCvEl5adUZiQWZ8QXleakFh9ilOBgVhLh
	1XMAyvGmJFZWpRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHjFQIYKFqWmp1ak
	ZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyIjvhgYGyApHqC9RxJB9hYXJOYCRSFaTzHqckw+
	u+U9oxBLXn5eqpQ47z2QIgGQoozSPLgVsKTyilEc6GNhXlaQS3iACQlu0iugJUxAS4S+7wNZ
	UpKIkJJqYJRwWvFg0p4nLPvsNxV+MNVMiK/cGyTe7Xz/W7ki44r3upxu7s6bGSZsiQmwUvrw
	037aurwM74CE99tfuL8XSNHftF4v+cdMA8W8exKXU6ftvLBvg/yijWJMG76JOelO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228366>

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
