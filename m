From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Verbose git-daemon logging
Date: Thu, 22 Sep 2005 11:25:28 +0200
Message-ID: <20050922092528.GB21019@pasky.or.cz>
References: <20050921213933.GB10575@pasky.or.cz> <7vwtl9mqm5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 11:27:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EINKl-0006Tb-HU
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 11:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbVIVJZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 05:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVIVJZb
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 05:25:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32473 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030235AbVIVJZa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 05:25:30 -0400
Received: (qmail 25449 invoked by uid 2001); 22 Sep 2005 11:25:28 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtl9mqm5.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9098>

Dear diary, on Thu, Sep 22, 2005 at 10:52:18AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> > +static void logreport(const char *err, va_list params)
> > +{
> > +	/* We should do a single write so that it is atomic and output
> > +	 * of several threads does not get intermangled. */
> 
> "threads"?  Nevertheless yes it is nicer to do a single write.

Ok, perhaps the "threads" name is not so appropriate after all. It
looked so cute in the sentence... ;-)

> > +	char buf[1024];
> > +	int buflen;
> > +
> > +	buflen = snprintf(buf, 1024, "[%d] ", getpid());
> 
> sizeof(buf)?

Ack.

> > +	buflen += vsnprintf(buf + buflen, 1024 - buflen, err, params);
> 
> vsnprintf() would return number of characters that would have
> been written if the buffer were sufficiently long, so buflen can
> grow outside buf[].  I could ask for a deeeeeeeeeeep directory
> to git-daemon, have it say "Request for 'diiiiiiiiiiiiii....r'",
> and have this code
> 
> > +	buf[buflen++] = '\n';
> > +	buf[buflen] = '\0';
> 
> overwrite the stack with these two bytes; overwriting with
> constant bytes may or may not be exploitable, though.

Whoops.

Hm, the vsnprintf() code ended up more complicated that I'd have liked.
Well, I hope I got it right now. :-)

> Also the man page says glibc 2.0.6 returned -1 upon output
> truncation.  Do we care?

If we do, there seems to be like 10 other places in the code where we
need to fix that.

> > @@ -212,6 +275,9 @@ static void child_handler(int signo)
> >  			unsigned reaped = children_reaped;
> >  			dead_child[reaped % MAX_CHILDREN] = pid;
> >  			children_reaped = reaped + 1;
> > +			/* XXX: Custom logging, since we don't wanna getpid() */
> > +			if (verbose)
> > +				fprintf(stderr, "[%d] Disconnected\n", pid);
> 
> "we don't wanna getpid()" because the guy reporting is the
> parent?  I would presume knowing parent PID would also useful,
> so maybe we could say "[1012] child 1014 disconnected\n" for
> parent 1012 reaping chilid 1014? 

What would be knowing parent PID be useful for? (It's not really the PID
number that's useful anyway (at least mostly), it's just a good unique
identifier to distinguish between several simultaneous sessions.)

The way it is now, it is consistent and all messages concerning lifetime
of one session have that session ID prepended. Otherwise not only a
mechanical parser would be more complicated, but also visual inspection
would be more demanding.


Fixed up patch follows.

--

[PATCH] Verbose git-daemon logging

This patch makes git-daemon --verbose log some useful things on stderr -
in particular connects, disconnects and upload requests, and in such a
way to be able to trace a particular session. Some more errors are now
also logged (even when --verbose is not passed). It is still not perfect
since messages produced by the non-daemon-specific code are obviously
not formatted properly.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
commit ebb97336b876ebc56b60fe8381c8d0145c0e47d0
tree e2234a568608743889a36750ae11ea4d00e9a7b4
parent ff0b3368b45a07ac080574eb721a607892413b99
author Petr Baudis <pasky@suse.cz> Thu, 22 Sep 2005 11:24:07 +0200
committer Petr Baudis <xpasky@machine.(none)> Thu, 22 Sep 2005 11:24:07 +0200

 daemon.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -6,13 +6,63 @@
 #include <sys/time.h>
 #include <netdb.h>
 #include <netinet/in.h>
+#include <arpa/inet.h>
+
+static int verbose;
+
+static const char daemon_usage[] = "git-daemon [--verbose] [--inetd | --port=n]";
+
+
+static void logreport(const char *err, va_list params)
+{
+	/* We should do a single write so that it is atomic and output
+	 * of several processes does not get intermangled. */
+	char buf[1024];
+	int buflen;
+	int maxlen, msglen;
+
+	buflen = snprintf(buf, sizeof(buf), "[%d] ", getpid());
+
+	maxlen = sizeof(buf) - buflen - 1;
+	msglen = vsnprintf(buf + buflen, maxlen, err, params);
+	if (msglen > maxlen)
+		msglen = maxlen;
+	else if (msglen < 0)
+		msglen = -1; /* Protect against weird return values. */
+	buflen += msglen;
+
+	buf[buflen++] = '\n';
+	buf[buflen] = '\0';
+
+	fputs(buf, stderr);
+}
+
+void logerror(const char *err, ...)
+{
+	va_list params;
+	va_start(params, err);
+	logreport(err, params);
+	va_end(params);
+}
+
+void lognotice(const char *err, ...)
+{
+	va_list params;
+	if (!verbose)
+		return;
+	va_start(params, err);
+	logreport(err, params);
+	va_end(params);
+}
 
-static const char daemon_usage[] = "git-daemon [--inetd | --port=n]";
 
 static int upload(char *dir, int dirlen)
 {
-	if (chdir(dir) < 0)
+	lognotice("Request for '%s'", dir);
+	if (chdir(dir) < 0) {
+		logerror("Cannot chdir('%s'): %s", dir, strerror(errno));
 		return -1;
+	}
 	chdir(".git");
 
 	/*
@@ -24,8 +74,10 @@ static int upload(char *dir, int dirlen)
 	 */
 	if (access("git-daemon-export-ok", F_OK) ||
 	    access("objects/00", X_OK) ||
-	    access("HEAD", R_OK))
+	    access("HEAD", R_OK)) {
+		logerror("Not a valid gitd-enabled repository: '%s'", dir);
 		return -1;
+	}
 
 	/*
 	 * We'll ignore SIGTERM from now on, we have a
@@ -51,7 +103,7 @@ static int execute(void)
 	if (!strncmp("git-upload-pack /", line, 17))
 		return upload(line + 16, len - 16);
 
-	fprintf(stderr, "got bad connection '%s'\n", line);
+	logerror("Protocol error: '%s'", line);
 	return -1;
 }
 
@@ -181,6 +233,8 @@ static void check_max_connections(void)
 static void handle(int incoming, struct sockaddr *addr, int addrlen)
 {
 	pid_t pid = fork();
+	char addrbuf[256] = "";
+	int port = -1;
 
 	if (pid) {
 		unsigned idx;
@@ -200,6 +254,24 @@ static void handle(int incoming, struct 
 	dup2(incoming, 0);
 	dup2(incoming, 1);
 	close(incoming);
+
+	if (addr->sa_family == AF_INET) {
+		struct sockaddr_in *sin_addr = (void *) addr;
+		inet_ntop(AF_INET, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
+		port = sin_addr->sin_port;
+
+	} else if (addr->sa_family == AF_INET6) {
+		struct sockaddr_in6 *sin6_addr = (void *) addr;
+
+		char *buf = addrbuf;
+		*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
+		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1);
+		strcat(buf, "]");
+
+		port = sin6_addr->sin6_port;
+	}
+	lognotice("Connection from %s:%d", addrbuf, port);
+
 	exit(execute());
 }
 
@@ -212,6 +284,9 @@ static void child_handler(int signo)
 			unsigned reaped = children_reaped;
 			dead_child[reaped % MAX_CHILDREN] = pid;
 			children_reaped = reaped + 1;
+			/* XXX: Custom logging, since we don't wanna getpid() */
+			if (verbose)
+				fprintf(stderr, "[%d] Disconnected\n", pid);
 			continue;
 		}
 		break;
@@ -349,6 +424,10 @@ int main(int argc, char **argv)
 			inetd_mode = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--verbose")) {
+			verbose = 1;
+			continue;
+		}
 
 		usage(daemon_usage);
 	}


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
