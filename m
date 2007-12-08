From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] shortlog: code restruturing and clean-up
Date: Fri,  7 Dec 2007 17:32:53 -0800
Message-ID: <1197077573-14945-2-git-send-email-gitster@pobox.com>
References: <1197077573-14945-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 02:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0oZA-0000Hp-Is
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 02:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbXLHBc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 20:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbXLHBc5
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 20:32:57 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62611 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107AbXLHBcz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 20:32:55 -0500
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20071208013255.BBES27415.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Fri, 7 Dec 2007 20:32:55 -0500
Received: from localhost ([68.225.240.77])
	by fed1rmimpo03.cox.net with bizsmtp
	id N1Ys1Y00A1gtr5g0000000; Fri, 07 Dec 2007 20:32:52 -0500
X-Mailer: git-send-email 1.5.3.7-2182-g108b
In-Reply-To: <1197077573-14945-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67493>

The code tried to parse and clean-up the author name and the one line
information in three places (two callers of insert_author_oneline() and
the called function itself), whihc was a mess.

This renames the callee to insert_one_record() and make it responsible
for cleaning up the author name and one line information.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-shortlog.c |  165 +++++++++++++++++++--------------------------------
 1 files changed, 62 insertions(+), 103 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 3fe7546..b9cc134 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -27,45 +27,60 @@ static int compare_by_number(const void *a1, const void *a2)
 
 static struct path_list mailmap = {NULL, 0, 0, 0};
 
-static void insert_author_oneline(struct path_list *list,
-		const char *author, int authorlen,
-		const char *oneline, int onelinelen)
+static void insert_one_record(struct path_list *list,
+			      const char *author,
+			      const char *oneline)
 {
 	const char *dot3 = common_repo_prefix;
 	char *buffer, *p;
 	struct path_list_item *item;
 	struct path_list *onelines;
+	char namebuf[1024];
+	size_t len;
+	const char *eol;
+	const char *boemail, *eoemail;
+
+	boemail = strchr(author, '<');
+	if (!boemail)
+		return;
+	eoemail = strchr(boemail, '>');
+	if (!eoemail)
+		return;
+	if (!map_email(&mailmap, boemail+1, namebuf, sizeof(namebuf))) {
+		while (author < boemail && isspace(*author))
+			author++;
+		for (len = 0;
+		     len < sizeof(namebuf) - 1 && author + len < boemail;
+		     len++)
+			namebuf[len] = author[len];
+		while (0 < len && isspace(namebuf[len-1]))
+			len--;
+		namebuf[len] = '\0';
+	}
 
-	while (authorlen > 0 && isspace(author[authorlen - 1]))
-		authorlen--;
-
-	buffer = xmemdupz(author, authorlen);
+	buffer = xstrdup(namebuf);
 	item = path_list_insert(buffer, list);
 	if (item->util == NULL)
 		item->util = xcalloc(1, sizeof(struct path_list));
 	else
 		free(buffer);
 
+	eol = strchr(oneline, '\n');
+	if (!eol)
+		eol = oneline + strlen(oneline);
+	while (*oneline && isspace(*oneline) && *oneline != '\n')
+		oneline++;
 	if (!prefixcmp(oneline, "[PATCH")) {
 		char *eob = strchr(oneline, ']');
-
-		if (eob) {
-			while (isspace(eob[1]) && eob[1] != '\n')
-				eob++;
-			if (eob - oneline < onelinelen) {
-				onelinelen -= eob - oneline;
-				oneline = eob;
-			}
-		}
+		if (eob && (!eol || eob < eol))
+			oneline = eob + 1;
 	}
-
-	while (onelinelen > 0 && isspace(oneline[0])) {
+	while (*oneline && isspace(*oneline) && *oneline != '\n')
 		oneline++;
-		onelinelen--;
-	}
-	while (onelinelen > 0 && isspace(oneline[onelinelen - 1]))
-		onelinelen--;
-	buffer = xmemdupz(oneline, onelinelen);
+	len = eol - oneline;
+	while (len && isspace(oneline[len-1]))
+		len--;
+	buffer = xmemdupz(oneline, len);
 
 	if (dot3) {
 		int dot3len = strlen(dot3);
@@ -92,55 +107,32 @@ static void insert_author_oneline(struct path_list *list,
 
 static void read_from_stdin(struct path_list *list)
 {
-	char buffer[1024];
-
-	while (fgets(buffer, sizeof(buffer), stdin) != NULL) {
-		char *bob;
-		if ((buffer[0] == 'A' || buffer[0] == 'a') &&
-				!prefixcmp(buffer + 1, "uthor: ") &&
-				(bob = strchr(buffer + 7, '<')) != NULL) {
-			char buffer2[1024], offset = 0;
-
-			if (map_email(&mailmap, bob + 1, buffer, sizeof(buffer)))
-				bob = buffer + strlen(buffer);
-			else {
-				offset = 8;
-				while (buffer + offset < bob &&
-				       isspace(bob[-1]))
-					bob--;
-			}
-
-			while (fgets(buffer2, sizeof(buffer2), stdin) &&
-					buffer2[0] != '\n')
-				; /* chomp input */
-			if (fgets(buffer2, sizeof(buffer2), stdin)) {
-				int l2 = strlen(buffer2);
-				int i;
-				for (i = 0; i < l2; i++)
-					if (!isspace(buffer2[i]))
-						break;
-				insert_author_oneline(list,
-						buffer + offset,
-						bob - buffer - offset,
-						buffer2 + i, l2 - i);
-			}
-		}
+	char author[1024], oneline[1024];
+
+	while (fgets(author, sizeof(author), stdin) != NULL) {
+		if (!(author[0] == 'A' || author[0] == 'a') ||
+		    prefixcmp(author + 1, "uthor: "))
+			continue;
+		while (fgets(oneline, sizeof(oneline), stdin) &&
+		       oneline[0] != '\n')
+			; /* discard headers */
+		while (fgets(oneline, sizeof(oneline), stdin) &&
+		       oneline[0] == '\n')
+			; /* discard blanks */
+		insert_one_record(list, author + 8, oneline);
 	}
 }
 
 static void get_from_rev(struct rev_info *rev, struct path_list *list)
 {
-	char scratch[1024];
 	struct commit *commit;
 
 	prepare_revision_walk(rev);
 	while ((commit = get_revision(rev)) != NULL) {
-		const char *author = NULL, *oneline, *buffer;
-		int authorlen = authorlen, onelinelen;
+		const char *author = NULL, *buffer;
 
-		/* get author and oneline */
-		for (buffer = commit->buffer; buffer && *buffer != '\0' &&
-				*buffer != '\n'; ) {
+		buffer = commit->buffer;
+		while (*buffer && *buffer != '\n') {
 			const char *eol = strchr(buffer, '\n');
 
 			if (eol == NULL)
@@ -148,50 +140,17 @@ static void get_from_rev(struct rev_info *rev, struct path_list *list)
 			else
 				eol++;
 
-			if (!prefixcmp(buffer, "author ")) {
-				char *bracket = strchr(buffer, '<');
-
-				if (bracket == NULL || bracket > eol)
-					die("Invalid commit buffer: %s",
-					    sha1_to_hex(commit->object.sha1));
-
-				if (map_email(&mailmap, bracket + 1, scratch,
-							sizeof(scratch))) {
-					author = scratch;
-					authorlen = strlen(scratch);
-				} else {
-					if (bracket[-1] == ' ')
-						bracket--;
-
-					author = buffer + 7;
-					authorlen = bracket - buffer - 7;
-				}
-			}
+			if (!prefixcmp(buffer, "author "))
+				author = buffer + 7;
 			buffer = eol;
 		}
-
-		if (author == NULL)
-			die ("Missing author: %s",
-					sha1_to_hex(commit->object.sha1));
-
-		if (buffer == NULL || *buffer == '\0') {
-			oneline = "<none>";
-			onelinelen = sizeof(oneline) + 1;
-		} else {
-			char *eol;
-
-			oneline = buffer + 1;
-			eol = strchr(oneline, '\n');
-			if (eol == NULL)
-				onelinelen = strlen(oneline);
-			else
-				onelinelen = eol - oneline;
-		}
-
-		insert_author_oneline(list,
-				author, authorlen, oneline, onelinelen);
+		if (!author)
+			die("Missing author: %s",
+			    sha1_to_hex(commit->object.sha1));
+		if (*buffer)
+			buffer++;
+		insert_one_record(list, author, !*buffer ? "<none>" : buffer);
 	}
-
 }
 
 static int parse_uint(char const **arg, int comma)
-- 
1.5.3.7-2182-g108b
