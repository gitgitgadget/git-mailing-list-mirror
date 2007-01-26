From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-merge: make it usable as the first class UI again.
Date: Fri, 26 Jan 2007 02:24:29 -0800
Message-ID: <7vd552ytk2.fsf@assigned-by-dhcp.cox.net>
References: <7v4pqe16ix.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 11:24:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAOG2-0000ue-E5
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 11:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbXAZKYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 05:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbXAZKYb
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 05:24:31 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37650 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161033AbXAZKYa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 05:24:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126102430.YWWY19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 05:24:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FmPY1W00A1kojtg0000000; Fri, 26 Jan 2007 05:23:32 -0500
In-Reply-To: <7v4pqe16ix.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 26 Jan 2007 01:28:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37833>

Junio C Hamano <junkio@cox.net> writes:

> reflog wants to have a short-and-sweet single line message, but
> its set_reflog_action was slurping the whole command line arguments.
> When given a multi-line commit message from the command line, reflog
> code refused to update the ref with the resulting commit.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Actually, let's rescind that one -- it was very silly of me.
We should do this instead.

-- >8 --
[PATCH] Make sure we do not write bogus reflog entries.

The file format dictates that entries are LF terminated so
the message cannot have one in it.  Chomp the message to make
sure it only has a single line if necessary, while removing the
leading whitespace.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-update-ref.c |    2 --
 refs.c               |   39 +++++++++++++++++++++++----------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index b34e598..f2506fa 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -23,8 +23,6 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 			msg = argv[++i];
 			if (!*msg)
 				die("Refusing to perform update with empty message.");
-			if (strchr(msg, '\n'))
-				die("Refusing to perform update with \\n in message.");
 			continue;
 		}
 		if (!strcmp("-d", argv[i])) {
diff --git a/refs.c b/refs.c
index 4323e9a..0840b3b 100644
--- a/refs.c
+++ b/refs.c
@@ -925,6 +925,7 @@ static int log_ref_write(struct ref_lock *lock,
 {
 	int logfd, written, oflags = O_APPEND | O_WRONLY;
 	unsigned maxlen, len;
+	int msglen;
 	char *logrec;
 	const char *committer;
 
@@ -958,24 +959,30 @@ static int log_ref_write(struct ref_lock *lock,
 				     lock->log_file, strerror(errno));
 	}
 
-	committer = git_committer_info(-1);
+	msglen = 0;
 	if (msg) {
-		maxlen = strlen(committer) + strlen(msg) + 2*40 + 5;
-		logrec = xmalloc(maxlen);
-		len = snprintf(logrec, maxlen, "%s %s %s\t%s\n",
-			sha1_to_hex(lock->old_sha1),
-			sha1_to_hex(sha1),
-			committer,
-			msg);
-	}
-	else {
-		maxlen = strlen(committer) + 2*40 + 4;
-		logrec = xmalloc(maxlen);
-		len = snprintf(logrec, maxlen, "%s %s %s\n",
-			sha1_to_hex(lock->old_sha1),
-			sha1_to_hex(sha1),
-			committer);
+		/* clean up the message and make sure it is a single line */
+		for ( ; *msg; msg++)
+			if (!isspace(*msg))
+				break;
+		if (*msg) {
+			const char *ep = strchr(msg, '\n');
+			if (ep)
+				msglen = ep - msg;
+			else
+				msglen = strlen(msg);
+		}
 	}
+
+	committer = git_committer_info(-1);
+	maxlen = strlen(committer) + msglen + 100;
+	logrec = xmalloc(maxlen);
+	len = sprintf(logrec, "%s %s %s\n",
+		      sha1_to_hex(lock->old_sha1),
+		      sha1_to_hex(sha1),
+		      committer);
+	if (msglen)
+		len += sprintf(logrec + len - 1, "\t%.*s\n", msglen, msg) - 1;
 	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
 	free(logrec);
 	close(logfd);
