From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Tweak git-diff-tree -v output further (take 2).
Date: Fri, 06 May 2005 12:37:00 -0700
Message-ID: <7vbr7ocfj7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 21:31:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU8Wz-0007Hq-2Z
	for gcvg-git@gmane.org; Fri, 06 May 2005 21:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVEFThR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 15:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVEFThR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 15:37:17 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:1259 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261278AbVEFThC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 15:37:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050506193701.POZY19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 May 2005 15:37:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(This one is simpler than the previous one I just sent out)

The first hunk of this is a pure bugfix---it guards us against a
commit message that does not end with a newline.

This adds the full header information to git-diff-tree -v output
in addition to the log message it already produces.  It also
stops indenting the log message to match what git-export does.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-tree.c |   22 ++++++++++++----------
1 files changed, 12 insertions(+), 10 deletions(-)

# - linus-mirror: diff-tree: add "verbose header" mode
# + (working tree)
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -278,7 +278,7 @@ static int get_one_line(const char *msg,
 
 	while (len--) {
 		ret++;
-		if (*msg++ == '\n')
+		if (!*msg || *msg++ == '\n')
 			break;
 	}
 	return ret;
@@ -287,12 +287,14 @@ static int get_one_line(const char *msg,
 static char *generate_header(const char *commit, const char *parent, const char *msg, unsigned long len)
 {
 	static char this_header[1000];
-	int offset;
 
-	offset = sprintf(this_header, "%s%s (from %s)\n", header_prefix, commit, parent);
-	if (verbose_header) {
+	if (!verbose_header)
+		sprintf(this_header, "%s%s (from %s)\n", header_prefix,
+			commit, parent);
+	else {
+		int offset;
 		int hdr = 1;
-
+		offset = sprintf(this_header, "Id: %s\n", commit);
 		for (;;) {
 			const char *line = msg;
 			int linelen = get_one_line(msg, len);
@@ -306,11 +308,11 @@ static char *generate_header(const char 
 			len -= linelen;
 			if (linelen == 1)
 				hdr = 0;
-			if (hdr)
-				continue;
-			memset(this_header + offset, ' ', 4);
-			memcpy(this_header + offset + 4, line, linelen);
-			offset += linelen + 4;
+			memcpy(this_header + offset, line, linelen);
+			if (hdr && !strncmp(line, "parent ", 7) &&
+			    !strncmp(line+7, parent, 40))
+				this_header[offset + 6] = '*';
+			offset += linelen;
 		}
 		this_header[offset++] = '\n';
 		this_header[offset] = 0;

