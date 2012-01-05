From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Thu, 5 Jan 2012 01:07:13 +0100
Message-ID: <20120105000713.GA24220@ecki.lan>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
 <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 05 01:15:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiazX-0001PG-FU
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 01:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451Ab2AEAPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 19:15:31 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:26295 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757431Ab2AEAPa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 19:15:30 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 27AC1CDF82;
	Thu,  5 Jan 2012 01:16:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120104222649.GA14727@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187956>

On Wed, Jan 04, 2012 at 05:26:49PM -0500, Jeff King wrote:
> 
> Or is the problem the git wrapper itself, which doesn't kill its
> subprocess when it dies (which IMHO is a bug which we might want to
> fix)? In that case, couldn't we just use --pid-file to save the actual
> daemon pid, and then kill using that?

Or like this. Doesn't work with multiple children. I have yet to
check if we have those anywhere.

diff --git a/run-command.c b/run-command.c
index 1c51043..0c105e6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -65,6 +65,22 @@ static int execv_shell_cmd(const char **argv)
 #ifndef WIN32
 static int child_err = 2;
 static int child_notifier = -1;
+static struct child_process *current_cmd;
+
+static void kill_current_cmd(int signo)
+{
+	signal(signo, SIG_DFL);
+
+	if (current_cmd) {
+		if (current_cmd->pid) {
+			/* forward signal to the child process */
+			kill(current_cmd->pid, signo);
+		} else {
+			/* trigger the default signal handler */
+			raise(signo);
+		}
+	}
+}
 
 static void notify_parent(void)
 {
@@ -201,6 +217,9 @@ fail_pipe:
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
+	current_cmd = cmd;
+	signal(SIGTERM, kill_current_cmd);
+
 	cmd->pid = fork();
 	if (!cmd->pid) {
 		/*
diff --git a/t/lib-daemon.sh b/t/lib-daemon.sh
index b2ffd54..c1c41ee 100644
--- a/t/lib-daemon.sh
+++ b/t/lib-daemon.sh
@@ -41,8 +41,8 @@ stop_daemon() {
 
 	# kill git-daemon child of git
 	say >&3 "Stopping git daemon ..."
-	pkill -P "$DAEMON_PID"
-	wait "$DAEMON_PID"
+	kill "$DAEMON_PID"
+	wait "$DAEMON_PID" >&3 2>&4
 	ret=$?
 	#
 	# We signal TERM=15 to the child and expect the parent to

> As a side note, it looks like we just start the daemon with "git daemon
> &". Doesn't that create a race condition with the tests which
> immediately try to access it (i.e., the first test may run before the
> daemon actually opens the socket)?

That's correct. How would I fix that? Try connecting and sleep in a
loop until ready or timeout? Will look into that.
