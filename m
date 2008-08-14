From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH 2/4] git-daemon: use LOG_PID, simplify logging code
Date: Thu, 14 Aug 2008 20:02:20 +0200
Message-ID: <20080814180220.15729.85509.stgit@aristoteles.cuci.nl>
References: <20080814180220.15729.34048.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 20:03:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KThAn-0005Fp-Fa
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 20:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759555AbYHNSCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 14:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759537AbYHNSCX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 14:02:23 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:47462 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759504AbYHNSCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 14:02:21 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 613B45464; Thu, 14 Aug 2008 20:02:20 +0200 (CEST)
In-Reply-To: <20080814180220.15729.34048.stgit@aristoteles.cuci.nl>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92381>

Make git-daemon use LOG_PID like most daemons.
Cleanup buffering code for logging.
Use linebuffering for stderr when logging to files.
Log message at startup.

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 daemon.c |   47 ++++++++++++++++-------------------------------
 1 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/daemon.c b/daemon.c
index 93e1106..2f86671 100644
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
 
