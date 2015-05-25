From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 41/56] submodule: rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:39:07 +0000
Message-ID: <1432579162-411464-42-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIt-00013c-6V
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbbEYSkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:42 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50728 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751266AbbEYSk3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:29 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 870152809B;
	Mon, 25 May 2015 18:40:27 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269866>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 submodule.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/submodule.c b/submodule.c
index f0f34b6..e4c59df 100644
--- a/submodule.c
+++ b/submodule.c
@@ -422,20 +422,18 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
-static int has_remote(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+static int has_remote(const char *refname, const struct object_id *oid,
+		      int flags, void *cb_data)
 {
 	return 1;
 }
 
 static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
 {
-	struct each_ref_fn_sha1_adapter wrapped_has_remote =
-		{has_remote, NULL};
-
 	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
 		return 0;
 
-	if (for_each_remote_ref_submodule(path, each_ref_fn_adapter, &wrapped_has_remote) > 0) {
+	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
 		struct strbuf buf = STRBUF_INIT;
@@ -522,13 +520,10 @@ int find_unpushed_submodules(unsigned char new_sha1[20],
 
 static int push_submodule(const char *path)
 {
-	struct each_ref_fn_sha1_adapter wrapped_has_remote =
-		{has_remote, NULL};
-
 	if (add_submodule_odb(path))
 		return 1;
 
-	if (for_each_remote_ref_submodule(path, each_ref_fn_adapter, &wrapped_has_remote) > 0) {
+	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		const char *argv[] = {"push", NULL};
 
@@ -622,20 +617,17 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 	}
 }
 
-static int add_sha1_to_array(const char *ref, const unsigned char *sha1,
+static int add_sha1_to_array(const char *ref, const struct object_id *oid,
 			     int flags, void *data)
 {
-	sha1_array_append(data, sha1);
+	sha1_array_append(data, oid->hash);
 	return 0;
 }
 
 void check_for_new_submodule_commits(unsigned char new_sha1[20])
 {
 	if (!initialized_fetch_ref_tips) {
-		struct each_ref_fn_sha1_adapter wrapped_add_sha1_to_array =
-			{add_sha1_to_array, &ref_tips_before_fetch};
-
-		for_each_ref(each_ref_fn_adapter, &wrapped_add_sha1_to_array);
+		for_each_ref(add_sha1_to_array, &ref_tips_before_fetch);
 		initialized_fetch_ref_tips = 1;
 	}
 
-- 
2.4.0
