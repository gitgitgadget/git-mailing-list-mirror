From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH 1/3] git-daemon: logging done right
Date: Wed, 13 Aug 2008 10:43:31 +0200
Message-ID: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 10:46:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTBzB-0000gm-VJ
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 10:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbYHMIne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 04:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756590AbYHMInd
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 04:43:33 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:49202 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300AbYHMInc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 04:43:32 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 2E4E65465; Wed, 13 Aug 2008 10:43:31 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92195>

Make git-daemon a proper syslogging citizen with PID-info.
Simplify the overzealous double buffering in the logroutine.
Call logerror() instead of error().

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 daemon.c |   49 +++++++++++++++++--------------------------------
 1 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/daemon.c b/daemon.c
index 1c00305..774b2ce 100644
--- a/daemon.c
+++ b/daemon.c
@@ -78,38 +78,19 @@ static struct interp interp_table[] = {
 
 static void logreport(int priority, const char *err, va_list params)
 {
-	/* We should do a single write so that it is atomic and output
-	 * of several processes do not get intermingled. */
-	char buf[1024];
-	int buflen;
-	int maxlen, msglen;
-
-	/* sizeof(buf) should be big enough for "[pid] \n" */
-	buflen = snprintf(buf, sizeof(buf), "[%ld] ", (long) getpid());
-
-	maxlen = sizeof(buf) - buflen - 1; /* -1 for our own LF */
-	msglen = vsnprintf(buf + buflen, maxlen, err, params);
-
 	if (log_syslog) {
+		char buf[1024];
+		vsnprintf(buf, sizeof(buf), err, params);
 		syslog(priority, "%s", buf);
-		return;
 	}
-
-	/* maxlen counted our own LF but also counts space given to
-	 * vsnprintf for the terminating NUL.  We want to make sure that
-	 * we have space for our own LF and NUL after the "meat" of the
-	 * message, so truncate it at maxlen - 1.
-	 */
-	if (msglen > maxlen - 1)
-		msglen = maxlen - 1;
-	else if (msglen < 0)
-		msglen = 0; /* Protect against weird return values. */
-	buflen += msglen;
-
-	buf[buflen++] = '\n';
-	buf[buflen] = '\0';
-
-	write_in_full(2, buf, buflen);
+	else {
+		/* Since stderr is set to linebuffered mode, the
+		 * logging of different processes will not overlap
+		 */
+		fprintf(stderr, "[%d] ", (int)getpid());
+		vfprintf(stderr, err, params);
+		fputc('\n', stderr);
+	}
 }
 
 static void logerror(const char *err, ...)
@@ -836,7 +817,7 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 		if (sockfd < 0)
 			continue;
 		if (sockfd >= FD_SETSIZE) {
-			error("too large socket descriptor.");
+			logerror("too large socket descriptor.");
 			close(sockfd);
 			continue;
 		}
@@ -1178,9 +1159,11 @@ int main(int argc, char **argv)
 	}
 
 	if (log_syslog) {
-		openlog("git-daemon", 0, LOG_DAEMON);
+		openlog("git-daemon", LOG_PID, LOG_DAEMON);
 		set_die_routine(daemon_die);
 	}
+	else			    /* so that logging into a file is atomic */
+		setlinebuf(stderr);
 
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
@@ -1233,8 +1216,10 @@ int main(int argc, char **argv)
 		return execute(peer);
 	}
 
-	if (detach)
+	if (detach) {
 		daemonize();
+		loginfo("Ready to rumble");
+	}
 	else
 		sanitize_stdfds();
 
