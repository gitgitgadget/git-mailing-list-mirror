From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 19/56] append_matching_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:45 +0000
Message-ID: <1432579162-411464-20-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKX-0001xX-Uk
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbbEYSm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:27 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50646 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751375AbbEYSkO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:14 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 36BA328093;
	Mon, 25 May 2015 18:40:13 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269895>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-branch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index cf918f4..b06f966 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -440,7 +440,8 @@ static int count_slash(const char *s)
 	return cnt;
 }
 
-static int append_matching_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_matching_ref(const char *refname, const struct object_id *oid,
+			       int flag, void *cb_data)
 {
 	/* we want to allow pattern hold/<asterisk> to show all
 	 * branches under refs/heads/hold/, and v0.99.9? to show
@@ -456,10 +457,10 @@ static int append_matching_ref(const char *refname, const unsigned char *sha1, i
 	if (wildmatch(match_ref_pattern, tail, 0, NULL))
 		return 0;
 	if (starts_with(refname, "refs/heads/"))
-		return append_head_ref(refname, sha1, flag, cb_data);
+		return append_head_ref(refname, oid->hash, flag, cb_data);
 	if (starts_with(refname, "refs/tags/"))
-		return append_tag_ref(refname, sha1, flag, cb_data);
-	return append_ref(refname, sha1, 0);
+		return append_tag_ref(refname, oid->hash, flag, cb_data);
+	return append_ref(refname, oid->hash, 0);
 }
 
 static void snarf_refs(int head, int remotes)
@@ -544,12 +545,10 @@ static void append_one_rev(const char *av)
 	if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
 		/* glob style match */
 		int saved_matches = ref_name_cnt;
-		struct each_ref_fn_sha1_adapter wrapped_append_matching_ref =
-			{append_matching_ref, NULL};
 
 		match_ref_pattern = av;
 		match_ref_slash = count_slash(av);
-		for_each_ref(each_ref_fn_adapter, &wrapped_append_matching_ref);
+		for_each_ref(append_matching_ref, NULL);
 		if (saved_matches == ref_name_cnt &&
 		    ref_name_cnt < MAX_REVS)
 			error("no matching refs with %s", av);
-- 
2.4.0
