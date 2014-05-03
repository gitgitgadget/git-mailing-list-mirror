From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 5/9] branch.c: convert to use struct object_id
Date: Sat,  3 May 2014 20:12:18 +0000
Message-ID: <1399147942-165308-6-git-send-email-sandals@crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 22:12:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WggIf-0004K5-GZ
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbaECUMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:12:33 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47531 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752193AbaECUMa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 16:12:30 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 01CDE28088
	for <git@vger.kernel.org>; Sat,  3 May 2014 20:12:29 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248050>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 branch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..8dc0d49 100644
--- a/branch.c
+++ b/branch.c
@@ -184,9 +184,9 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 
 	if (!attr_only) {
 		const char *head;
-		unsigned char sha1[20];
+		struct object_id sha1;
 
-		head = resolve_ref_unsafe("HEAD", sha1, 0, NULL);
+		head = resolve_ref_unsafe("HEAD", sha1.oid, 0, NULL);
 		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
 			die(_("Cannot force update the current branch."));
 	}
@@ -228,7 +228,7 @@ void create_branch(const char *head,
 {
 	struct ref_lock *lock = NULL;
 	struct commit *commit;
-	unsigned char sha1[20];
+	struct object_id sha1;
 	char *real_ref, msg[PATH_MAX + 20];
 	struct strbuf ref = STRBUF_INIT;
 	int forcing = 0;
@@ -248,7 +248,7 @@ void create_branch(const char *head,
 	}
 
 	real_ref = NULL;
-	if (get_sha1(start_name, sha1)) {
+	if (get_sha1(start_name, sha1.oid)) {
 		if (explicit_tracking) {
 			if (advice_set_upstream_failure) {
 				error(_(upstream_missing), start_name);
@@ -260,7 +260,7 @@ void create_branch(const char *head,
 		die(_("Not a valid object name: '%s'."), start_name);
 	}
 
-	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
+	switch (dwim_ref(start_name, strlen(start_name), sha1.oid, &real_ref)) {
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
@@ -281,9 +281,9 @@ void create_branch(const char *head,
 		break;
 	}
 
-	if ((commit = lookup_commit_reference(sha1)) == NULL)
+	if ((commit = lookup_commit_reference(sha1.oid)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
-	hashcpy(sha1, commit->object.sha1);
+	hashcpy(sha1.oid, commit->object.sha1);
 
 	if (!dont_change_ref) {
 		lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
@@ -305,7 +305,7 @@ void create_branch(const char *head,
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
 	if (!dont_change_ref)
-		if (write_ref_sha1(lock, sha1, msg) < 0)
+		if (write_ref_sha1(lock, sha1.oid, msg) < 0)
 			die_errno(_("Failed to write ref"));
 
 	strbuf_release(&ref);
-- 
2.0.0.rc0
