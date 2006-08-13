From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add a newline before appending "Signed-off-by: " line
Date: Sun, 13 Aug 2006 15:33:49 -0700
Message-ID: <7vr6zkjmeq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 00:34:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCOX8-0007gT-E2
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 00:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWHMWdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 18:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWHMWdz
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 18:33:55 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58766 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751690AbWHMWdu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 18:33:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060813223349.HOMZ6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Aug 2006 18:33:49 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25298>

From: Franck Bui-Huu <vagabon.xyz@gmail.com>

Whef the last line of the commit log message does not end with
"^[-A-Za-z]+: [^@]+@", append a newline after it to separate
the body of the commit log message from the run of sign-off and
ack lines. e.g. "Signed-off-by: A U Thor <au.thor@example.com>" or
"Acked-by: Me <myself@example.org>".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is based on one-month old patch from Franck, which was
   not applied back then, with updates suggested by Linus, but I
   did not do "^\S+:.*@.*$", which would have caught the last
   line of the commit log body of this commit itself.  RFC2822
   "field-name" can contain anything other than controls, SP and
   colon, but I think in practice "alnum plus dash" would be a
   reasonable and safer pattern to use (and we are not dealing
   with RFC2822 headers here anyway).

   It probably is not worth to do this as a "bugfix", so it 
   is queued for "next", not for "maint".

 log-tree.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 05ede0c..031af88 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -19,7 +19,7 @@ static int append_signoff(char *buf, int
 	char *cp = buf;
 
 	/* Do we have enough space to add it? */
-	if (buf_sz - at <= strlen(signed_off_by) + signoff_len + 2)
+	if (buf_sz - at <= strlen(signed_off_by) + signoff_len + 3)
 		return at;
 
 	/* First see if we already have the sign-off by the signer */
@@ -34,6 +34,48 @@ static int append_signoff(char *buf, int
 			return at; /* we already have him */
 	}
 
+	/* Does the last line already end with "^[-A-Za-z]+: [^@]+@"?
+	 * If not, add a blank line to separate the message from
+	 * the run of Signed-off-by: and Acked-by: lines.
+	 */
+	{
+		char ch;
+		int seen_colon, seen_at, seen_name, seen_head, not_signoff;
+		seen_colon = 0;
+		seen_at = 0;
+		seen_name = 0;
+		seen_head = 0;
+		not_signoff = 0;
+		cp = buf + at;
+		while (buf <= --cp && (ch = *cp) == '\n')
+			;
+		while (!not_signoff && buf <= cp && (ch = *cp--) != '\n') {
+			if (!seen_at) {
+				if (ch == '@')
+					seen_at = 1;
+				continue;
+			}
+			if (!seen_colon) {
+				if (ch == '@')
+					not_signoff = 1;
+				else if (ch == ':')
+					seen_colon = 1;
+				else
+					seen_name = 1;
+				continue;
+			}
+			if (('A' <= ch && ch <= 'Z') ||
+			    ('a' <= ch && ch <= 'z') ||
+			    ch == '-') {
+				seen_head = 1;
+				continue;
+			}
+			not_signoff = 1;
+		}
+		if (not_signoff || !seen_head || !seen_name)
+			buf[at++] = '\n';
+	}
+
 	strcpy(buf + at, signed_off_by);
 	at += strlen(signed_off_by);
 	strcpy(buf + at, signoff);
-- 
1.4.2.g10a6
