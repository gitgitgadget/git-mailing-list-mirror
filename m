From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use int instead of socklen_t
Date: Sun, 11 Sep 2005 14:01:10 -0700
Message-ID: <7v8xy3qpyh.fsf_-_@assigned-by-dhcp.cox.net>
References: <deofnh$jl0$1@sea.gmane.org>
	<7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vvf17tsoa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509111100260.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Ellson <ellson@research.att.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:01:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEYwu-0000Ow-T8
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 23:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVIKVBO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 17:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVIKVBO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 17:01:14 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:15808 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750877AbVIKVBO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 17:01:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911210112.CXCB8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 17:01:12 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509111100260.3242@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 11 Sep 2005 11:07:06 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8328>

This should work around the compilation problem Johannes Schindelin
and others had on Mac OS/X.

Quoting Linus:

    Any operating system where socklen_t is anything else than
    "int" is terminally broken. The people who introduced that
    typedef were confused, and I actually had to argue with them
    that it was fundamentally wrong: there is no other valid
    type than "int" that makes sense for it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

    Linus Torvalds <torvalds@osdl.org> writes:

    > On Sun, 11 Sep 2005, Junio C Hamano wrote:
    >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
    >> 
    >> > I have three fixes in my personal tree without which git refuses to 
    >> > compile:
    >> >
    >> > - daemon.c needs a define or typedef for socklen_t.
    >> 
    >> I still keep that patch around (the patch was end of July), but
    >> have not touched it only because I did not hear from you asking
    >> about its inclusion.
    >
    > Side note: one simple solution for "socklen_t" is to just replace it with 
    > "int".

 daemon.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

def13dbdb962069f4cb22e3d72483ae443bda6cf
diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -80,11 +80,11 @@ static unsigned int children_deleted = 0
 
 static struct child {
 	pid_t pid;
-	socklen_t addrlen;
+	int addrlen;
 	struct sockaddr_storage address;
 } live_child[MAX_CHILDREN];
 
-static void add_child(int idx, pid_t pid, struct sockaddr *addr, socklen_t addrlen)
+static void add_child(int idx, pid_t pid, struct sockaddr *addr, int addrlen)
 {
 	live_child[idx].pid = pid;
 	live_child[idx].addrlen = addrlen;
@@ -178,7 +178,7 @@ static void check_max_connections(void)
 	}
 }
 
-static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
+static void handle(int incoming, struct sockaddr *addr, int addrlen)
 {
 	pid_t pid = fork();
 
@@ -308,7 +308,7 @@ static int serve(int port)
 
 			if (FD_ISSET(sockfd, &fds)) {
 				struct sockaddr_storage ss;
-				socklen_t sslen = sizeof(ss);
+				int sslen = sizeof(ss);
 				int incoming = accept(sockfd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
