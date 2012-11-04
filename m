From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/5] combine_notes_cat_sort_uniq(): sort and dedup lines all at once
Date: Sun,  4 Nov 2012 08:07:08 +0100
Message-ID: <1352012830-13591-4-git-send-email-mhagger@alum.mit.edu>
References: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:08:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUuJK-0001EE-AM
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 08:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab2KDHHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 02:07:36 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:60983 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750951Ab2KDHHe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 02:07:34 -0500
X-AuditID: 1207440f-b7fde6d00000095c-65-50961435a42b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 40.23.02396.53416905; Sun,  4 Nov 2012 02:07:33 -0500 (EST)
Received: from michael.fritz.box (p57A25973.dip.t-dialin.net [87.162.89.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA477Hw6028486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Nov 2012 02:07:32 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqGsqMi3AYMJyDYuuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xqvn5xkL
	/glXXNm5ibWBsVmgi5GTQ0LARGLhrrnMELaYxIV769m6GLk4hAQuM0rs6wFJgDhnmCRWHp3I
	BFLFJqArsainGcwWEZCV+H54IyOIzSyQK7H43W12EFtYIETiePMtFhCbRUBV4snsL2A2r4CL
	xJvVS9ggtslJfNjzCKyeU8BVYsOVNqAaDqBlLhKdb+snMPIuYGRYxSiXmFOaq5ubmJlTnJqs
	W5ycmJeXWqRropebWaKXmlK6iRESPvw7GLvWyxxiFOBgVOLhXbhsaoAQa2JZcWXuIUZJDiYl
	UV5PgWkBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4t3wGKudNSaysSi3Kh0lJc7AoifOqL1H3
	ExJITyxJzU5NLUgtgsnKcHAoSfAWCQMNFSxKTU+tSMvMKUFIM3FwgggukA08QBsqQAp5iwsS
	c4sz0yGKTjEqSonzGoEkBEASGaV5cANgkf6KURzoH2HecpAqHmCSgOt+BTSYCWjw9ktTQAaX
	JCKkpBoYtZvqXsfuen+S++S6DyvPf/u3vU/s0PvUd/1H12j2xfKUcR2ZquOjycBmPj8zTU26
	y3613ZrtU24y+5/zN/fJnLLzvvQ+xkuHSrNstFR2zIrvLzo0K9OJp3n+z8zXOVeFA5de3mRT
	92JOg/tPnd/VTGumhf7LNMwPYNx8ssHs6L5na9yP5fH3KrEUZyQaajEXFScCALuM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209018>

Instead of reading lines one by one and insertion-sorting them into a
string_list, read all of the lines, sort them, then remove duplicates.
Aside from being less code, this reduces the complexity from O(N^2) to
O(N lg N) in the total number of lines.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/notes.c b/notes.c
index 8652f8f..62f8f6f 100644
--- a/notes.c
+++ b/notes.c
@@ -848,15 +848,16 @@ int combine_notes_ignore(unsigned char *cur_sha1,
 	return 0;
 }
 
-static int string_list_add_note_lines(struct string_list *sort_uniq_list,
+/*
+ * Add the lines from the named object to list, with trailing
+ * newlines removed.
+ */
+static int string_list_add_note_lines(struct string_list *list,
 				      const unsigned char *sha1)
 {
 	char *data;
 	unsigned long len;
 	enum object_type t;
-	struct strbuf buf = STRBUF_INIT;
-	struct strbuf **lines = NULL;
-	int i, list_index;
 
 	if (is_null_sha1(sha1))
 		return 0;
@@ -868,24 +869,14 @@ static int string_list_add_note_lines(struct string_list *sort_uniq_list,
 		return t != OBJ_BLOB || !data;
 	}
 
-	strbuf_attach(&buf, data, len, len + 1);
-	lines = strbuf_split(&buf, '\n');
-
-	for (i = 0; lines[i]; i++) {
-		if (lines[i]->buf[lines[i]->len - 1] == '\n')
-			strbuf_setlen(lines[i], lines[i]->len - 1);
-		if (!lines[i]->len)
-			continue; /* skip empty lines */
-		list_index = string_list_find_insert_index(sort_uniq_list,
-							   lines[i]->buf, 0);
-		if (list_index < 0)
-			continue; /* skip duplicate lines */
-		string_list_insert_at_index(sort_uniq_list, list_index,
-					    lines[i]->buf);
-	}
-
-	strbuf_list_free(lines);
-	strbuf_release(&buf);
+	/*
+	 * If the last line of the file is EOL-terminated, this will
+	 * add an empty string to the list.  But it will be removed
+	 * later, along with any empty strings that came from empty
+	 * lines within the file.
+	 */
+	string_list_split(list, data, '\n', -1);
+	free(data);
 	return 0;
 }
 
@@ -910,6 +901,9 @@ int combine_notes_cat_sort_uniq(unsigned char *cur_sha1,
 		goto out;
 	if (string_list_add_note_lines(&sort_uniq_list, new_sha1))
 		goto out;
+	string_list_remove_empty_items(&sort_uniq_list, 0);
+	sort_string_list(&sort_uniq_list);
+	string_list_remove_duplicates(&sort_uniq_list, 0);
 
 	/* create a new blob object from sort_uniq_list */
 	if (for_each_string_list(&sort_uniq_list,
-- 
1.8.0
