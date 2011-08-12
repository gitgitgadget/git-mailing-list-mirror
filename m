From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/6] Change the signature of read_packed_refs()
Date: Sat, 13 Aug 2011 00:36:26 +0200
Message-ID: <1313188589-2330-4-git-send-email-mhagger@alum.mit.edu>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 00:37:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs0ME-0005Rz-Ri
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 00:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab1HLWhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 18:37:34 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41156 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab1HLWhd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 18:37:33 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CMaXJQ010513;
	Sat, 13 Aug 2011 00:37:14 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179262>

Change it to return a (struct ref_list *) instead of writing into
a cached_refs structure.  (This removes the need to create a
cached_refs structure in resolve_gitlink_packed_ref(), where it
is otherwise unneeded.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 89840d7..e043555 100644
--- a/refs.c
+++ b/refs.c
@@ -203,7 +203,7 @@ static void invalidate_cached_refs(void)
 	clear_cached_refs(get_cached_refs(NULL));
 }
 
-static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
+static struct ref_list *read_packed_refs(FILE *f)
 {
 	struct ref_list *list = NULL;
 	struct ref_list *last = NULL;
@@ -235,7 +235,7 @@ static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
 		    !get_sha1_hex(refline + 1, sha1))
 			hashcpy(last->peeled, sha1);
 	}
-	cached_refs->packed = sort_ref_list(list);
+	return sort_ref_list(list);
 }
 
 void add_extra_ref(const char *name, const unsigned char *sha1, int flag)
@@ -262,7 +262,7 @@ static struct ref_list *get_packed_refs(const char *submodule)
 		FILE *f = fopen(packed_refs_file, "r");
 		refs->packed = NULL;
 		if (f) {
-			read_packed_refs(f, refs);
+			refs->packed = read_packed_refs(f);
 			fclose(f);
 		}
 		refs->did_packed = 1;
@@ -389,7 +389,7 @@ static struct ref_list *get_loose_refs(const char *submodule)
 static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refname, unsigned char *result)
 {
 	FILE *f;
-	struct cached_refs refs;
+	struct ref_list *packed_refs;
 	struct ref_list *ref;
 	int retval;
 
@@ -397,9 +397,9 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refna
 	f = fopen(name, "r");
 	if (!f)
 		return -1;
-	read_packed_refs(f, &refs);
+	packed_refs = read_packed_refs(f);
 	fclose(f);
-	ref = refs.packed;
+	ref = packed_refs;
 	retval = -1;
 	while (ref) {
 		if (!strcmp(ref->name, refname)) {
@@ -409,7 +409,7 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refna
 		}
 		ref = ref->next;
 	}
-	free_ref_list(refs.packed);
+	free_ref_list(packed_refs);
 	return retval;
 }
 
-- 
1.7.6.8.gd2879
