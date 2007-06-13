From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: (unknown)
Date: Wed, 13 Jun 2007 12:17:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131214010.4059@racer.site>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site>
 <7vr6ogh2w7.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 13:21:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyQuH-00068Y-Jw
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 13:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253AbXFMLU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 07:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757232AbXFMLU4
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 07:20:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:52503 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756675AbXFMLUz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 07:20:55 -0400
Received: (qmail invoked by alias); 13 Jun 2007 11:20:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 13 Jun 2007 13:20:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Y+LdyuNFYJGnsKjOQz5dlYrOHrL9oOeIXFA5iLH
	GdOMy6bisNZtIC
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6ogh2w7.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50047>

[PATCH] Interpret :/<pattern> as a regular expression

Earlier, Git interpreted the pattern as a strict prefix, which made
the operator unsuited in many cases.

Now, the pattern is interpreted as a regular expression, on the whole
message, so that you can say

	git diff :/.*^Signed-off-by:.Zack.Brown

to see the diff against the most recent reachable commit which was
signed off by Zack, whose Kernel Cousin I miss very much.

If you want to match just the oneline, but with a regular expression,
say something like

	git diff ':/[^
]*intelligent'

Since it makes more sense to match the beginning of a message (otherwise,
a pattern like ':/git-gui: Improve' would match the _merge_ commit, 
pulling in the commit you are likely to want), the implementation uses the 
regmatch parameter of regexec() to anchor the pattern there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Anyone who can teach me how to match / not-match a newline
	using a more elegant syntax, please do so, by all means.

 Documentation/git-rev-parse.txt |    6 +++---
 sha1_name.c                     |   31 +++++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 6380676..56e1561 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -194,9 +194,9 @@ blobs contained in a commit.
   found.
 
 * A colon, followed by a slash, followed by a text: this names
-  a commit whose commit message starts with the specified text.
-  This name returns the youngest matching commit which is
-  reachable from any ref.  If the commit message starts with a
+  a commit whose commit message starts with the specified regular
+  expression.  This name returns the youngest matching commit which
+  is reachable from any ref.  If the commit message starts with a
   '!', you have to repeat that;  the special sequence ':/!',
   followed by something else than '!' is reserved for now.
 
diff --git a/sha1_name.c b/sha1_name.c
index d9188ed..988d599 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -599,8 +599,8 @@ static int handle_one_ref(const char *path,
 
 /*
  * This interprets names like ':/Initial revision of "git"' by searching
- * through history and returning the first commit whose message starts
- * with the given string.
+ * through history and returning the first commit whose message matches
+ * the given regular expression.
  *
  * For future extension, ':/!' is reserved. If you want to match a message
  * beginning with a '!', you have to repeat the exclamation mark.
@@ -611,34 +611,53 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 {
 	struct commit_list *list = NULL, *backup = NULL, *l;
 	int retval = -1;
+	regex_t regexp;
+	regmatch_t regmatch[1];
+	char *temp_commit_buffer = NULL;
 
 	if (prefix[0] == '!') {
 		if (prefix[1] != '!')
 			die ("Invalid search pattern: %s", prefix);
 		prefix++;
 	}
-	if (!save_commit_buffer)
-		return error("Could not expand oneline-name.");
 	for_each_ref(handle_one_ref, &list);
 	for (l = list; l; l = l->next)
 		commit_list_insert(l->item, &backup);
+	if (regcomp(&regexp, prefix, 0))
+		return error("invalid regexp: %s", prefix);
 	while (list) {
 		char *p;
 		struct commit *commit;
+		enum object_type type;
+		unsigned long size;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
 		parse_object(commit->object.sha1);
-		if (!commit->buffer || !(p = strstr(commit->buffer, "\n\n")))
+		if (temp_commit_buffer)
+			free(temp_commit_buffer);
+		if (commit->buffer)
+			p = commit->buffer;
+		else {
+			p = read_sha1_file(commit->object.sha1, &type, &size);
+			if (!p)
+				continue;
+			temp_commit_buffer = p;
+		}
+		if (!(p = strstr(p, "\n\n")))
 			continue;
-		if (!prefixcmp(p + 2, prefix)) {
+		if (!regexec(&regexp, p + 2, 1, regmatch, 0) &&
+				regmatch[0].rm_so == 0) {
 			hashcpy(sha1, commit->object.sha1);
 			retval = 0;
 			break;
 		}
 	}
+	if (temp_commit_buffer)
+		free(temp_commit_buffer);
 	free_commit_list(list);
 	for (l = backup; l; l = l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
+	regfree(&regexp);
 	return retval;
 }
 
-- 
1.5.2.1.2827.gba84a8-dirty
