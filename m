From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 6/8] longest_ancestor_length(): use string_list_longest_prefix()
Date: Wed, 26 Sep 2012 21:34:48 +0200
Message-ID: <1348688090-13648-7-git-send-email-mhagger@alum.mit.edu>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:35:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxOi-0004jo-VY
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758332Ab2IZTfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:35:42 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:47842 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758328Ab2IZTfi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 15:35:38 -0400
X-AuditID: 1207440e-b7f036d0000008b5-76-506359097e01
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 67.E5.02229.90953605; Wed, 26 Sep 2012 15:35:37 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8QJZFfk010704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Sep 2012 15:35:36 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqMsZmRxgsH6zuUXXlW4mi4beK8wW
	R09ZWNxeMZ/ZYv27q8wOrB5/339g8tg56y67x8VLyh6fN8kFsERx2yQllpQFZ6bn6dslcGe8
	mH6cuaCVq+LFgq9MDYyTOLoYOTkkBEwkpk9ZyQxhi0lcuLeeDcQWErjMKHH9s2IXIxeQfYZJ
	4tqZhawgCTYBXYlFPc1MILaIgJrExLZDLCBFzAKTGCV6NjxgB0kICwRIrNj9CsxmEVCV2PLx
	JlgDr4CLxK7L95ggtilK/Pi+Bmwzp4CrxJcNF6A2u0gcfnWLeQIj7wJGhlWMcok5pbm6uYmZ
	OcWpybrFyYl5ealFusZ6uZkleqkppZsYIYHEt4Oxfb3MIUYBDkYlHl4Ph+QAIdbEsuLK3EOM
	khxMSqK81mFAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8z7KSAoR4UxIrq1KL8mFS0hwsSuK8
	akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8y8OBhgoWpaanVqRl5pQgpJk4OEEEF8gGHqANwhFA
	hbzFBYm5xZnpEEWnGBWlxHn/gUwQAElklObBDYDF/CtGcaB/hHnngFTxANMFXPcroMFMQIOX
	bgI5vbgkESEl1cC46a9AVHrIIofK1HWLGUqesqk9XPxF69yVq32GrssKZ/Tv2Hv6cIP/v4hj
	8t1Vs3b9NRKsZa6Le2LWNPen+tOtLTrtIQzHjkq03Z/063Tu2vqZj+x9M2euEVrgdXXizrq3
	FU8NI5dvvb6Dx6ljlUHIytmaPE4irSrvH938mXi9wff69A1HvLhTlFiKMxINtZiL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206439>

Use string_list_longest_prefix() in the implementation of
longest_ancestor_length(), instead of an equivalent loop.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/path.c b/path.c
index 90ef53d..5cace83 100644
--- a/path.c
+++ b/path.c
@@ -605,23 +605,16 @@ static int normalize_path_callback(struct string_list_item *item, void *cb_data)
 int longest_ancestor_length(const char *path, const char *prefix_list)
 {
 	struct string_list prefixes = STRING_LIST_INIT_DUP;
-	int i, max_len = -1;
+	int max_len;
+	const char *longest_prefix;
 
 	if (prefix_list == NULL || !strcmp(path, "/"))
 		return -1;
 
 	string_list_split(&prefixes, prefix_list, PATH_SEP, -1);
 	filter_string_list(&prefixes, 0, normalize_path_callback, NULL);
-
-	for (i = 0; i < prefixes.nr; i++) {
-		const char *ceil = prefixes.items[i].string;
-		int len = strlen(ceil);
-
-		if (!strncmp(path, ceil, len) &&
-		    len - 1 > max_len) {
-			max_len = len - 1;
-		}
-	}
+	longest_prefix = string_list_longest_prefix(&prefixes, path);
+	max_len = longest_prefix ? strlen(longest_prefix) - 1 : -1;
 
 	string_list_clear(&prefixes, 0);
 	return max_len;
-- 
1.7.11.3
