From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch--tool: fix uninitialized buffer when reading from stdin
Date: Mon, 26 Feb 2007 11:37:43 -0800
Message-ID: <7vfy8sn20o.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702261306140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702260821310.12485@woody.linux-foundation.org>
	<Pine.LNX.4.63.0702261741360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702260905420.12485@woody.linux-foundation.org>
	<Pine.LNX.4.63.0702261827510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702261003480.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:38:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlfh-0004jz-56
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbXBZThq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbXBZThp
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:37:45 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41317 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030493AbXBZTho (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:37:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070226193744.ZRMV6078.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 26 Feb 2007 14:37:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UKdj1W00x1kojtg0000000; Mon, 26 Feb 2007 14:37:44 -0500
In-Reply-To: <Pine.LNX.4.64.0702261003480.12485@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 26 Feb 2007 10:05:59 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40649>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Well, that CHUNK_SIZE is just silly. I don't see why you'd have a 
> chunk-size of a megabyte to begin with, IO doesn't really get any more 
> efficient that way. And yeah, in this case it would easily hide the bug, 
> because in practice nobody would ever test with that much input data.
>
> It might make sense to make the chunk-size smaller just from a testability 
> standpoint (not to mention that it's probably currently just wasting 
> memory for most users - although at least under Linux, if you never use a 
> page, none will be allocated for you, so the OS may hide the wastage).

How about doing this instead?

-- >8 --
[PATCH] fetch--tool: fix uninitialized buffer when reading from stdin

The original code allocates too much space and forgets to NUL
terminate the string.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 builtin-fetch--tool.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 48de08d..a068f8d 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -2,17 +2,24 @@
 #include "refs.h"
 #include "commit.h"
 
-#define CHUNK_SIZE (1048576)
+#define CHUNK_SIZE 1024
 
 static char *get_stdin(void)
 {
+	int offset = 0;
 	char *data = xmalloc(CHUNK_SIZE);
-	int offset = 0, read = 0;
-	read = xread(0, data, CHUNK_SIZE);
-	while (read == CHUNK_SIZE) {
-		offset += CHUNK_SIZE;
+
+	while (1) {
+		int cnt = xread(0, data + offset, CHUNK_SIZE);
+		if (cnt < 0)
+			die("error reading standard input: %s",
+			    strerror(errno));
+		if (cnt == 0) {
+			data[offset] = 0;
+			break;
+		}
+		offset += cnt;
 		data = xrealloc(data, offset + CHUNK_SIZE);
-		read = xread(0, data + offset, CHUNK_SIZE);
 	}
 	return data;
 }
