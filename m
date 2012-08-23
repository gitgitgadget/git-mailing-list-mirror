From: mhagger@alum.mit.edu
Subject: [PATCH 12/17] filter_refs(): compress unmatched refs in heads array
Date: Thu, 23 Aug 2012 10:10:37 +0200
Message-ID: <1345709442-16046-13-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:19:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Sdo-0001fQ-50
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933734Ab2HWITl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:19:41 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:55521 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030238Ab2HWITS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:19:18 -0400
X-AuditID: 12074414-b7f846d0000008b8-b4-5035e5b68142
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.52.02232.6B5E5305; Thu, 23 Aug 2012 04:11:34 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkVC030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:33 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLvtqWmAwcEtFhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujAPzulgK
	HspW/J/s2MDYI97FyMkhIWAi8ftIByuELSZx4d56NhBbSOAyo8TW3ZldjFxA9lkmiZ0/zoEl
	2ASkJF429rCD2CICahIT2w6xgNjMAikSHc+7GUFsYQEfiWv9T8BqWARUJRb0fQdbwCvgKnH8
	5VI2iGWKEj++r2EGsTmB4gu+b2KEWOwi8bHxJvMERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT
	8/JSi3Qt9HIzS/RSU0o3MUKCR2QH45GTcocYBTgYlXh4X5ibBgixJpYVV+YeYpTkYFIS5f33
	CCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDd8HlCONyWxsiq1KB8mJc3BoiTO+22xup+QQHpi
	SWp2ampBahFMVoaDQ0mCNxQYJUKCRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoLiI
	LwZGBkiKB2ivIkg7b3FBYi5QFKL1FKMux/+TJ+8yCrHk5eelSonzmoAUCYAUZZTmwa2ApYpX
	jOJAHwvzuoNU8QDTDNykV0BLmICWqF01BllSkoiQkmpg7HT4FcBpkqXhuW/DTY7TrwTipr96
	yPb14YqOFcxhT8Nktpg1Pt4d0Hf6ocZdy73BrN89r+zv2XWN4cPvqXtOL1o0k1Pb6c8v/Wle
	Uht281W8Nz8z98TNl6w8y7+8Z1MOcX/1pTLyHFe9fzGHx8uLsvtOXwjTET+R+UIg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204132>

From: Michael Haggerty <mhagger@alum.mit.edu>

Remove any references that were received from the remote from the list
(*nr_heads, heads) of requested references by squeezing them out of
the list (rather than overwriting their names with NUL characters, as
before).  On exit, *nr_heads is the number of requested references
that were not received.

Document this aspect of fetch_pack() in a comment in the header file.
(More documentation is obviously still needed.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 21 +++++++++++++--------
 fetch-pack.h         |  6 ++++++
 transport.c          |  3 ++-
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 8366012..cc9af80 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -527,7 +527,7 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
-	int match_pos = 0, matched = 0;
+	int match_pos = 0, matched = 0, unmatched = 0;
 
 	if (*nr_heads && !args.fetch_all)
 		return_refs = xcalloc(*nr_heads, sizeof(struct ref *));
@@ -554,11 +554,12 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 					break;
 				else if (cmp == 0) { /* definitely have it */
 					return_refs[matched++] = ref;
-					heads[match_pos++][0] = '\0';
+					match_pos++;
 					break;
 				}
-				else /* might have it; keep looking */
-					match_pos++;
+				else { /* might have it; keep looking */
+					heads[unmatched++] = heads[match_pos++];
+				}
 			}
 			if (!cmp)
 				continue; /* we will link it later */
@@ -568,6 +569,12 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 
 	if (!args.fetch_all) {
 		int i;
+
+		/* copy remaining unmatched heads: */
+		while (match_pos < *nr_heads)
+			heads[unmatched++] = heads[match_pos++];
+		*nr_heads = unmatched;
+
 		for (i = 0; i < matched; i++) {
 			ref = return_refs[i];
 			*newtail = ref;
@@ -1028,10 +1035,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		 * silently succeed without issuing an error.
 		 */
 		for (i = 0; i < nr_heads; i++)
-			if (heads[i] && heads[i][0]) {
-				error("no such remote ref %s", heads[i]);
-				ret = 1;
-			}
+			error("no such remote ref %s", heads[i]);
+		ret = 1;
 	}
 	while (ref) {
 		printf("%s %s\n",
diff --git a/fetch-pack.h b/fetch-pack.h
index a9d505b..915858e 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -17,6 +17,12 @@ struct fetch_pack_args {
 		stateless_rpc:1;
 };
 
+/*
+ * (*nr_heads, heads) is an array of pointers to the full names of
+ * remote references that should be updated from.  On return, both
+ * will have been changed to list only the names that were not found
+ * on the remote.
+ */
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
diff --git a/transport.c b/transport.c
index f7bbf58..3c38d44 100644
--- a/transport.c
+++ b/transport.c
@@ -520,6 +520,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct git_transport_data *data = transport->data;
 	char **heads = xmalloc(nr_heads * sizeof(*heads));
 	char **origh = xmalloc(nr_heads * sizeof(*origh));
+	int orig_nr_heads = nr_heads;
 	const struct ref *refs;
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
@@ -558,7 +559,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	free_refs(refs_tmp);
 
-	for (i = 0; i < nr_heads; i++)
+	for (i = 0; i < orig_nr_heads; i++)
 		free(origh[i]);
 	free(origh);
 	free(heads);
-- 
1.7.11.3
