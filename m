From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Fix tag following
Date: Mon, 17 Mar 2008 22:15:02 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803172211060.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 03:16:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbRMw-0006e5-3r
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 03:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbYCRCPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 22:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbYCRCPH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 22:15:07 -0400
Received: from iabervon.org ([66.92.72.58]:60755 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675AbYCRCPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 22:15:05 -0400
Received: (qmail 16878 invoked by uid 1000); 18 Mar 2008 02:15:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Mar 2008 02:15:02 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77482>

Before the second fetch-pack connection in the same process, unmark
all of the objects marked in the first connection, in order that we'll
list them as things we have instead of thinking we've already
mentioned them.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This fixes David Brownell's test case, at least as far as failing to find 
any common commits. There's still some issue I haven't been able to track 
down where it seems to list the same "have" values for refs the second 
time, despite them having been updated, but that's a much much smaller 
issue.

 builtin-fetch-pack.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 7b28024..65350ca 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -26,6 +26,8 @@ static const char fetch_pack_usage[] =
 #define SEEN		(1U << 3)
 #define POPPED		(1U << 4)
 
+static int marked;
+
 /*
  * After sending this many "have"s if we do not get any new ACK , we
  * give up traversing our history.
@@ -61,6 +63,16 @@ static int rev_list_insert_ref(const char *path, const unsigned char *sha1, int
 	return 0;
 }
 
+static int clear_marks(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct object *o = deref_tag(parse_object(sha1), path, 0);
+
+	if (o && o->type == OBJ_COMMIT)
+		clear_commit_marks((struct commit *)o,
+				   COMMON | COMMON_REF | SEEN | POPPED);
+	return 0;
+}
+
 /*
    This function marks a rev and its ancestors as common.
    In some cases, it is desirable to mark only the ancestors (for example
@@ -153,6 +165,10 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	unsigned in_vain = 0;
 	int got_continue = 0;
 
+	if (marked)
+		for_each_ref(clear_marks, NULL);
+	marked = 1;
+
 	for_each_ref(rev_list_insert_ref, NULL);
 
 	fetching = 0;
-- 
1.5.4.3.610.gea6cd
