From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 06/56] append_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:32 +0000
Message-ID: <1432579162-411464-7-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIY-0000s9-97
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbbEYSkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:17 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50602 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751262AbbEYSkH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:07 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 111F928097;
	Mon, 25 May 2015 18:40:07 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269852>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/branch.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b27adcb..0d3b9af 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -328,7 +328,7 @@ static int match_patterns(const char **pattern, const char *refname)
 	return 0;
 }
 
-static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+static int append_ref(const char *refname, const struct object_id *oid, int flags, void *cb_data)
 {
 	struct append_ref_cb *cb = (struct append_ref_cb *)(cb_data);
 	struct ref_list *ref_list = cb->ref_list;
@@ -365,7 +365,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 
 	commit = NULL;
 	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
-		commit = lookup_commit_reference_gently(sha1, 1);
+		commit = lookup_commit_reference_gently(oid->hash, 1);
 		if (!commit) {
 			cb->ret = error(_("branch '%s' does not point at a commit"), refname);
 			return 0;
@@ -631,8 +631,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	int i;
 	struct append_ref_cb cb;
 	struct ref_list ref_list;
-	struct each_ref_fn_sha1_adapter wrapped_append_ref =
-		{append_ref, &cb};
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
@@ -644,7 +642,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	cb.ref_list = &ref_list;
 	cb.pattern = pattern;
 	cb.ret = 0;
-	for_each_rawref(each_ref_fn_adapter, &wrapped_append_ref);
+	for_each_rawref(append_ref, &cb);
 	if (merge_filter != NO_FILTER) {
 		struct commit *filter;
 		filter = lookup_commit_reference_gently(merge_filter_ref, 0);
-- 
2.4.0
