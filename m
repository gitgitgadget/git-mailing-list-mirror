From: mhagger@alum.mit.edu
Subject: [PATCH 28/30] read_loose_refs(): access ref_cache via the ref_dir field
Date: Wed, 25 Apr 2012 00:45:34 +0200
Message-ID: <1335307536-26914-29-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMofj-00005X-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758496Ab2DXW5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:20 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60976 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758463Ab2DXW5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:57:00 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id F0DEB24817A;
	Wed, 25 Apr 2012 00:46:26 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196268>

From: Michael Haggerty <mhagger@alum.mit.edu>

This means that all we need to read loose references is the ref_entry
that will receive them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 0f5aab2..4eca965 100644
--- a/refs.c
+++ b/refs.c
@@ -791,7 +791,7 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
 /*
  * Read the loose references for direntry in refs.
  */
-static void read_loose_refs(struct ref_cache *refs, struct ref_entry *direntry)
+static void read_loose_refs(struct ref_entry *direntry)
 {
 	DIR *d;
 	const char *path;
@@ -799,9 +799,11 @@ static void read_loose_refs(struct ref_cache *refs, struct ref_entry *direntry)
 	const char *dirname = direntry->name;
 	int dirnamelen = strlen(dirname);
 	struct strbuf refname;
+	struct ref_cache *refs;
 
 	assert(direntry->flag & REF_DIR);
 
+	refs = direntry->u.subdir.ref_cache;
 	if (*refs->name)
 		path = git_path_submodule(refs->name, "%s", dirname);
 	else
@@ -832,8 +834,7 @@ static void read_loose_refs(struct ref_cache *refs, struct ref_entry *direntry)
 			/* Silently ignore. */
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
-			read_loose_refs(refs,
-					search_for_subdir(direntry,
+			read_loose_refs(search_for_subdir(direntry,
 							  refname.buf, 1));
 		} else {
 			if (*refs->name) {
@@ -860,8 +861,7 @@ static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
 		refs->loose = create_dir_entry(refs, "");
-		read_loose_refs(refs,
-				search_for_subdir(refs->loose, "refs/", 1));
+		read_loose_refs(search_for_subdir(refs->loose, "refs/", 1));
 	}
 	return refs->loose;
 }
-- 
1.7.10
