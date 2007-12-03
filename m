From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Allow ':/<oneline-prefix>' syntax to work with save_commit_buffer
 == 0
Date: Mon, 3 Dec 2007 18:42:39 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031841520.27959@racer.site>
References: <20071203043258.GA16658@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712031052410.27959@racer.site> <20071203173022.GA19219@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:43:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzGGK-0000Lv-TI
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbXLCSnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbXLCSnE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:43:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:35401 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752707AbXLCSnC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:43:02 -0500
Received: (qmail invoked by alias); 03 Dec 2007 18:43:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 03 Dec 2007 19:43:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xjhVvo6JxLrvO2eacx2bN+BQPzNwDxd2g5HdLQG
	o87VHqw49QVkaG
X-X-Sender: gene099@racer.site
In-Reply-To: <20071203173022.GA19219@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66946>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 3 Dec 2007, Jeff King wrote:

	> On Mon, Dec 03, 2007 at 10:55:15AM +0000, Johannes Schindelin wrote:
	> 
	> > But then, my patch also works when save_commit_buffer == 0.  
	> > But I can refactor this into its own patch, since it really is 
	> > a separate issue.
	> 
	> Agreed.

	Here we go.

 sha1_name.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index e78b2b9..da1aad1 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -601,24 +601,35 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 {
 	struct commit_list *list = NULL, *backup = NULL, *l;
 	int retval = -1;
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
 		if (!prefixcmp(p + 2, prefix)) {
 			hashcpy(sha1, commit->object.sha1);
@@ -626,6 +637,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 			break;
 		}
 	}
+	if (temp_commit_buffer)
+		free(temp_commit_buffer);
 	free_commit_list(list);
 	for (l = backup; l; l = l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
-- 
1.5.3.7.2119.g774e1
