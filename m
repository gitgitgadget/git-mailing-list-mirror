From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] log_ref_write() --
 do not chomp reflog message at the first LF
Date: Sat, 28 Jul 2007 18:10:23 -0700
Message-ID: <7vvec4nhfk.fsf_-_@assigned-by-dhcp.cox.net>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
	<7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
	<20070728083536.540e471d.seanlkml@sympatico.ca>
	<7vodhwptba.fsf@assigned-by-dhcp.cox.net>
	<20070728092914.48f6305c.seanlkml@sympatico.ca>
	<7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
	<20070728101156.20304d11.seanlkml@sympatico.ca>
	<7vd4ycp8ff.fsf@assigned-by-dhcp.cox.net>
	<7vzm1gnhin.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jul 29 03:10:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IExIh-00016o-SL
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 03:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758630AbXG2BKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 21:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758600AbXG2BKZ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 21:10:25 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58815 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757309AbXG2BKY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 21:10:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070729011024.GUNI23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 28 Jul 2007 21:10:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VDAP1X00A1kojtg0000000; Sat, 28 Jul 2007 21:10:23 -0400
In-Reply-To: <7vzm1gnhin.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 28 Jul 2007 18:08:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54071>

A reflog file is organized as one-line-per-entry records, and we
enforced the file format integrity by chomping the given message
at the first LF.  This changes it to convert them to SP, which
is more in line with the --pretty=oneline format.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c |   44 ++++++++++++++++++++++++++++----------------
 1 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 2694e70..fac6548 100644
--- a/refs.c
+++ b/refs.c
@@ -1036,6 +1036,32 @@ void unlock_ref(struct ref_lock *lock)
 	free(lock);
 }
 
+/*
+ * copy the reflog message msg to buf, which has been allocated sufficiently
+ * large, while cleaning up the whitespaces.  Especially, convert LF to space,
+ * because reflog file is one line per entry.
+ */
+static int copy_msg(char *buf, const char *msg)
+{
+	char *cp = buf;
+	char c;
+	int wasspace = 1;
+
+	*cp++ = '\t';
+	while ((c = *msg++)) {
+		if (wasspace && isspace(c))
+			continue;
+		wasspace = isspace(c);
+		if (wasspace)
+			c = ' ';
+		*cp++ = c;
+	}
+	while (buf < cp && isspace(cp[-1]))
+		cp--;
+	*cp++ = '\n';
+	return cp - buf;
+}
+
 static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
@@ -1080,21 +1106,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 
 	adjust_shared_perm(log_file);
 
-	msglen = 0;
-	if (msg) {
-		/* clean up the message and make sure it is a single line */
-		for ( ; *msg; msg++)
-			if (!isspace(*msg))
-				break;
-		if (*msg) {
-			const char *ep = strchr(msg, '\n');
-			if (ep)
-				msglen = ep - msg;
-			else
-				msglen = strlen(msg);
-		}
-	}
-
+	msglen = msg ? strlen(msg) : 0;
 	committer = git_committer_info(-1);
 	maxlen = strlen(committer) + msglen + 100;
 	logrec = xmalloc(maxlen);
@@ -1103,7 +1115,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 		      sha1_to_hex(new_sha1),
 		      committer);
 	if (msglen)
-		len += sprintf(logrec + len - 1, "\t%.*s\n", msglen, msg) - 1;
+		len += copy_msg(logrec + len - 1, msg) - 1;
 	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
 	free(logrec);
 	if (close(logfd) != 0 || written != len)
-- 
1.5.3.rc3.24.g83b3d
