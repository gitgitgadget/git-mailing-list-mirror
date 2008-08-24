From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] daemon.c: minor style fixup
Date: Sun, 24 Aug 2008 13:27:10 -0700
Message-ID: <7vsksukvkx.fsf_-_@gitster.siamese.dyndns.org>
References: <7v1w0ft750.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808241955550.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vd4jymdfn.fsf@gitster.siamese.dyndns.org>
 <7vwsi6kvow.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Aug 24 22:28:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXMCE-00018t-Ok
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 22:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbYHXU1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 16:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbYHXU1S
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 16:27:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbYHXU1R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 16:27:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B13A666BCF;
	Sun, 24 Aug 2008 16:27:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 325FA66BCC; Sun, 24 Aug 2008 16:27:11 -0400 (EDT)
In-Reply-To: <7vwsi6kvow.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 24 Aug 2008 13:24:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B1D7DAC-721B-11DD-97D8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93559>

 * "else" on the same line as "}" that closes corresponding "if (...) {";

 * multi-line comments begin with "/*\n";

 * sizeof, even it is not a function, is written as "sizeof(...)";

 * no need to check x?alloc() return value -- it would have died;

 * "if (...) { ... }" that covers the whole function body can be dedented
   by returning from the function early with "if (!...) return;";

 * SP on each side of an operator, i.e. "a > 0", not "a>0";

Also removes stale comment describing how remove_child() used to do its
thing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>:
---

Junio C Hamano <gitster@pobox.com> writes:

> I however do have one issue with the logic, though.
>
> It seems that kill_some_child() will not kill anything if nobody else is
> coming from the same address, while the old code did kill some.  Is this
> intended?
>
> By the way, add_child() compares the whole "struct sockaddr_storage" in
> order to queue the newborn in front of an existing connection from the
> same address, and kill_some_child() takes advanrage of this to kill the
> newest connection ("We kill the newest" comment should probably be moved
> to add_child() to describe why the queuing is done this way).  If you
> simplify add_child() to queue the newborn always at the front of the list,
> your kill_some_child() will continue to do so, so I do not see the point
> of the loop in add_child().  Am I mistaken?

So here is a three-patch series on top.  I am not sure about the last one.

 daemon.c |   72 +++++++++++++++++++++++++------------------------------------
 1 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/daemon.c b/daemon.c
index 79f0388..35bd34a 100644
--- a/daemon.c
+++ b/daemon.c
@@ -81,9 +81,9 @@ static void logreport(int priority, const char *err, va_list params)
 		char buf[1024];
 		vsnprintf(buf, sizeof(buf), err, params);
 		syslog(priority, "%s", buf);
-	}
-	else {
-		/* Since stderr is set to linebuffered mode, the
+	} else {
+		/*
+		 * Since stderr is set to linebuffered mode, the
 		 * logging of different processes will not overlap
 		 */
 		fprintf(stderr, "[%d] ", (int)getpid());
@@ -596,31 +596,20 @@ static struct child {
 
 static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
 {
-	struct child *newborn;
-	newborn = xcalloc(1, sizeof *newborn);
-	if (newborn) {
-		struct child **cradle;
-
-		live_children++;
-		newborn->pid = pid;
-		memcpy(&newborn->address, addr, addrlen);
-		for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
-			if (!memcmp(&(*cradle)->address, &newborn->address,
-				   sizeof newborn->address))
-				break;
-		newborn->next = *cradle;
-		*cradle = newborn;
-	}
-	else
-		logerror("Out of memory spawning new child");
+	struct child *newborn, **cradle;
+	newborn = xcalloc(1, sizeof(*newborn));
+
+	live_children++;
+	newborn->pid = pid;
+	memcpy(&newborn->address, addr, addrlen);
+	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
+		if (!memcmp(&(*cradle)->address, &newborn->address,
+			    sizeof(newborn->address)))
+			break;
+	newborn->next = *cradle;
+	*cradle = newborn;
 }
 
-/*
- * Walk from "deleted" to "spawned", and remove child "pid".
- *
- * We move everything up by one, since the new "deleted" will
- * be one higher.
- */
 static void remove_child(pid_t pid)
 {
 	struct child **cradle, *blanket;
@@ -642,18 +631,17 @@ static void remove_child(pid_t pid)
  */
 static void kill_some_child(void)
 {
-	const struct child *blanket;
+	const struct child *blanket, *next;
 
-	if ((blanket = firstborn)) {
-		const struct child *next;
+	if (!(blanket = firstborn))
+		return;
 
-		for (; (next = blanket->next); blanket = next)
-			if (!memcmp(&blanket->address, &next->address,
-				   sizeof next->address)) {
-				kill(blanket->pid, SIGTERM);
-				break;
-			}
-	}
+	for (; (next = blanket->next); blanket = next)
+		if (!memcmp(&blanket->address, &next->address,
+			    sizeof(next->address))) {
+			kill(blanket->pid, SIGTERM);
+			break;
+		}
 }
 
 static void check_dead_children(void)
@@ -661,10 +649,10 @@ static void check_dead_children(void)
 	int status;
 	pid_t pid;
 
-	while ((pid = waitpid(-1, &status, WNOHANG))>0) {
+	while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
 		const char *dead = "";
 		remove_child(pid);
-		if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
+		if (!WIFEXITED(status) || (WEXITSTATUS(status) > 0))
 			dead = " (with error)";
 		loginfo("[%d] Disconnected%s", (int)pid, dead);
 	}
@@ -676,7 +664,7 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 
 	if (max_connections && live_children >= max_connections) {
 		kill_some_child();
-		sleep(1);			 /* give it some time to die */
+		sleep(1);  /* give it some time to die */
 		check_dead_children();
 		if (live_children >= max_connections) {
 			close(incoming);
@@ -705,7 +693,8 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 
 static void child_handler(int signo)
 {
-	/* Otherwise empty handler because systemcalls will get interrupted
+	/*
+	 * Otherwise empty handler because systemcalls will get interrupted
 	 * upon signal receipt
 	 * SysV needs the handler to be rearmed
 	 */
@@ -1089,8 +1078,7 @@ int main(int argc, char **argv)
 	if (log_syslog) {
 		openlog("git-daemon", LOG_PID, LOG_DAEMON);
 		set_die_routine(daemon_die);
-	}
-	else
+	} else
 		setlinebuf(stderr); /* avoid splitting a message in the middle */
 
 	if (inetd_mode && (group_name || user_name))
-- 
1.6.0.129.ge10d2
