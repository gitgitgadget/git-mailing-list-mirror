From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] daemon: Set SO_REUSEADDR on listening sockets.
Date: Sat, 04 Feb 2006 00:49:47 -0800
Message-ID: <7vfymz33v8.fsf@assigned-by-dhcp.cox.net>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
	<20060203202704.1895.18383.stgit@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 09:49:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5J7D-0005ZW-2W
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 09:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWBDItt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 03:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWBDItt
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 03:49:49 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:50614 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750855AbWBDItt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 03:49:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204084649.NGYR17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 03:46:49 -0500
To: Mark Wooding <mdw@distorted.org.uk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15579>

Mark Wooding <mdw@distorted.org.uk> writes:

> From: Mark Wooding <mdw@distorted.org.uk>
>
> Without this, you can silently lose the ability to receive IPv4
> connections if you stop and restart the daemon.
>
> Signed-off-by: Mark Wooding <mdw@distorted.org.uk>

But with that, you expose yourself to the confusion TIME_WAIT
was designed to protect you from, so how about making it
optional like this?

Tested, of course ;-).

-- >8 --
From nobody Mon Sep 17 00:00:00 2001
From: Mark Wooding <mdw@distorted.org.uk>
Date: Fri Feb 3 20:27:04 2006 +0000
Subject: [PATCH] daemon: Set SO_REUSEADDR on listening sockets.

Without this, you can silently lose the ability to receive IPv4
connections if you stop and restart the daemon.

[jc: tweaked code organization a bit and made this controllable
 from a command line option.]

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 daemon.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

bb1527c884bbb9bf6a5d06c1dd409ea6c2045a91
diff --git a/daemon.c b/daemon.c
index 324bb04..dab8c2c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -13,11 +13,12 @@
 
 static int log_syslog;
 static int verbose;
+static int reuseaddr;
 
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
-"           [--base-path=path] [directory...]";
+"           [--base-path=path] [--reuseaddr] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths = NULL;
@@ -451,6 +452,16 @@ static void child_handler(int signo)
 	}
 }
 
+static int set_reuse_addr(int sockfd)
+{
+	int on = 1;
+
+	if (!reuseaddr)
+		return 0;
+	return setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR,
+			  &on, sizeof(on));
+}
+
 #ifndef NO_IPV6
 
 static int socksetup(int port, int **socklist_p)
@@ -495,6 +506,11 @@ static int socksetup(int port, int **soc
 		}
 #endif
 
+		if (set_reuse_addr(sockfd)) {
+			close(sockfd);
+			return 0;	/* not fatal */
+		}
+
 		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
 			close(sockfd);
 			continue;	/* not fatal */
@@ -537,6 +553,11 @@ static int socksetup(int port, int **soc
 	sin.sin_addr.s_addr = htonl(INADDR_ANY);
 	sin.sin_port = htons(port);
 
+	if (set_reuse_addr(sockfd)) {
+		close(sockfd);
+		return 0;
+	}
+
 	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
 		close(sockfd);
 		return 0;
@@ -663,6 +684,10 @@ int main(int argc, char **argv)
 			base_path = arg+12;
 			continue;
 		}
+		if (!strcmp(arg, "--reuseaddr")) {
+			reuseaddr = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
-- 
1.1.6.gf7ef
