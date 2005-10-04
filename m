From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Limit the number of requests outstanding in ssh-fetch.
Date: Tue, 4 Oct 2005 00:24:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510040016110.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Dan Aloni <da-x@monatomic.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 06:21:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMeHt-0008A2-3u
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 06:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVJDEUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 00:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVJDEUO
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 00:20:14 -0400
Received: from iabervon.org ([66.92.72.58]:3598 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751178AbVJDEUO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 00:20:14 -0400
Received: (qmail 31497 invoked by uid 1000); 4 Oct 2005 00:24:55 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Oct 2005 00:24:55 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9660>

This completes fetches if there are more than 100 outstanding requests
and there are more to prefetch.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

Lightly tested; I reduced the limit to 5, and pulled a small tree 
successfully with some of the requests being completed early. I didn't 
have the test case to verify that a limit of 100 is sufficiently low, but 
handwaving suggests that it should be.

 ssh-fetch.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

528f784890df88a5c054913136bbc53b164ebb94
diff --git a/ssh-fetch.c b/ssh-fetch.c
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -36,12 +36,26 @@ static ssize_t force_write(int fd, void 
 	return ret;
 }
 
+static int prefetches = 0;
+
+static struct object_list *in_transit = NULL;
+static struct object_list **end_of_transit = &in_transit;
+
 void prefetch(unsigned char *sha1)
 {
 	char type = 'o';
+	struct object_list *node;
+	if (prefetches > 100) {
+		fetch(in_transit->item->sha1);
+	}
+	node = xmalloc(sizeof(struct object_list));
+	node->next = NULL;
+	node->item = lookup_unknown_object(sha1);
+	*end_of_transit = node;
+	end_of_transit = &node->next;
 	force_write(fd_out, &type, 1);
 	force_write(fd_out, sha1, 20);
-	//memcpy(requested + 20 * prefetches++, sha1, 20);
+	prefetches++;
 }
 
 static char conn_buf[4096];
@@ -51,6 +65,18 @@ int fetch(unsigned char *sha1)
 {
 	int ret;
 	signed char remote;
+	struct object_list *temp;
+
+	if (memcmp(sha1, in_transit->item->sha1, 20)) {
+		// we must have already fetched it to clean the queue
+		return has_sha1_file(sha1) ? 0 : -1;
+	}
+	prefetches--;
+	temp = in_transit;
+	in_transit = in_transit->next;
+	if (!in_transit)
+		end_of_transit = &in_transit;
+	free(temp);
 
 	if (conn_buf_posn) {
 		remote = conn_buf[0];
