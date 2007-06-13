From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Interpret :/<pattern> as a regular expression
Date: Wed, 13 Jun 2007 01:50:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706130148080.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 02:53:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyH7N-0008CQ-38
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 02:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949AbXFMAxo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 20:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbXFMAxo
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 20:53:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:57205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754732AbXFMAxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 20:53:43 -0400
Received: (qmail invoked by alias); 13 Jun 2007 00:53:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 13 Jun 2007 02:53:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8UC0CuOL88BfeieVTWJvqOMvzYXyijg9obqZpVv
	nrVG4euzJOQ44W
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50010>


Earlier, Git interpreted the pattern as a strict prefix, which made
the operator unsuited in many cases.

Now, the pattern is interpreted as a regular expression (which does not 
change the behaviour too much, since few onelines contain special regex 
characters), so that you can say

	git diff :/.*^Signed-off-by:.Zack.Brown

to see the diff against the most recent reachable commit which was
signed off by Zack, whose Kernel Cousin I miss very much.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	For fun, you can see which committer signed himself off:

		git show :/.*^Signed-off:

	*grin*

 sha1_name.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index d9188ed..f1ba194 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -611,6 +611,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 {
 	struct commit_list *list = NULL, *backup = NULL, *l;
 	int retval = -1;
+	regex_t regexp;
+	regmatch_t regmatch[1];
 
 	if (prefix[0] == '!') {
 		if (prefix[1] != '!')
@@ -622,6 +624,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	for_each_ref(handle_one_ref, &list);
 	for (l = list; l; l = l->next)
 		commit_list_insert(l->item, &backup);
+	if (regcomp(&regexp, prefix, REG_EXTENDED))
+		return error("invalid regexp: %s", prefix);
 	while (list) {
 		char *p;
 		struct commit *commit;
@@ -630,7 +634,9 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 		parse_object(commit->object.sha1);
 		if (!commit->buffer || !(p = strstr(commit->buffer, "\n\n")))
 			continue;
-		if (!prefixcmp(p + 2, prefix)) {
+		if (!regexec(&regexp, p + 2, 1, regmatch, 0) &&
+				printf("match: %d\n", regmatch[0].rm_so) &&
+				regmatch[0].rm_so == 0) {
 			hashcpy(sha1, commit->object.sha1);
 			retval = 0;
 			break;
@@ -639,6 +645,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	free_commit_list(list);
 	for (l = backup; l; l = l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
+	regfree(&regexp);
 	return retval;
 }
 
-- 
1.5.2.1.2827.gba84a8-dirty
