From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/6] Access reference caches only through new function get_cached_refs().
Date: Sat, 13 Aug 2011 00:36:25 +0200
Message-ID: <1313188589-2330-3-git-send-email-mhagger@alum.mit.edu>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 00:37:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs0M9-0005P6-BV
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 00:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab1HLWh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 18:37:27 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41150 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab1HLWh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 18:37:26 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CMaXJP010513;
	Sat, 13 Aug 2011 00:37:05 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179261>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   54 +++++++++++++++++++++++++++++++-----------------------
 1 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/refs.c b/refs.c
index b0c8308..89840d7 100644
--- a/refs.c
+++ b/refs.c
@@ -181,9 +181,26 @@ static void clear_cached_refs(struct cached_refs *ca)
 	ca->did_loose = ca->did_packed = 0;
 }
 
+/*
+ * Return a pointer to a cached_refs for the specified submodule. For
+ * the main repository, use submodule==NULL. The returned structure
+ * will be allocated and initialized but not necessarily populated; it
+ * should not be freed.
+ */
+static struct cached_refs *get_cached_refs(const char *submodule)
+{
+	if (! submodule)
+		return &cached_refs;
+	else {
+		/* For now, don't reuse the refs cache for submodules. */
+		clear_cached_refs(&submodule_refs);
+		return &submodule_refs;
+	}
+}
+
 static void invalidate_cached_refs(void)
 {
-	clear_cached_refs(&cached_refs);
+	clear_cached_refs(get_cached_refs(NULL));
 }
 
 static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
@@ -234,19 +251,14 @@ void clear_extra_refs(void)
 
 static struct ref_list *get_packed_refs(const char *submodule)
 {
-	const char *packed_refs_file;
-	struct cached_refs *refs;
+	struct cached_refs *refs = get_cached_refs(submodule);
 
-	if (submodule) {
-		packed_refs_file = git_path_submodule(submodule, "packed-refs");
-		refs = &submodule_refs;
-		free_ref_list(refs->packed);
-	} else {
-		packed_refs_file = git_path("packed-refs");
-		refs = &cached_refs;
-	}
-
-	if (!refs->did_packed || submodule) {
+	if (!refs->did_packed) {
+		const char *packed_refs_file;
+		if (submodule)
+			packed_refs_file = git_path_submodule(submodule, "packed-refs");
+		else
+			packed_refs_file = git_path("packed-refs");
 		FILE *f = fopen(packed_refs_file, "r");
 		refs->packed = NULL;
 		if (f) {
@@ -361,17 +373,13 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 
 static struct ref_list *get_loose_refs(const char *submodule)
 {
-	if (submodule) {
-		free_ref_list(submodule_refs.loose);
-		submodule_refs.loose = get_ref_dir(submodule, "refs", NULL);
-		return submodule_refs.loose;
-	}
+	struct cached_refs *refs = get_cached_refs(submodule);
 
-	if (!cached_refs.did_loose) {
-		cached_refs.loose = get_ref_dir(NULL, "refs", NULL);
-		cached_refs.did_loose = 1;
+	if (!refs->did_loose) {
+		refs->loose = get_ref_dir(submodule, "refs", NULL);
+		refs->did_loose = 1;
 	}
-	return cached_refs.loose;
+	return refs->loose;
 }
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
-- 
1.7.6.8.gd2879
