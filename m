From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git daemon directory munging?
Date: Sat, 3 Jun 2006 17:42:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606031722340.5498@g5.osdl.org>
References: <E1FmgFV-0001i6-Kc@jdl.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 02:42:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmghY-00012d-OF
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 02:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWFDAml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 20:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWFDAml
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 20:42:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750948AbWFDAml (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 20:42:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k540ga2g013398
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 3 Jun 2006 17:42:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k540gZhe028094;
	Sat, 3 Jun 2006 17:42:35 -0700
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1FmgFV-0001i6-Kc@jdl.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21235>



On Sat, 3 Jun 2006, Jon Loeliger wrote:
>
> <jdl> Thus, I'd use something like:
>       --map-base=www.foo.com/pub/scm:/pub/foo/scm
>       --map-base=www.bar.com/pub/scm=/pub/bar/scm

The bigger problem is that nothing actually passes in the hostname to 
git-daemon in the first place. By the time the git-daemon is contacted, 
the hostname is long gone ;(

Now, you can just extend the git protocol to just pass in the host too. 

You can in fact do this in a backwards-compatible manner (old git-daemons 
will just ignore it, and new git daemons will automatically notice new 
clients) with something evil like the appended.

Not tested (and this actualyl doesn't make the daemon _use_ the data, it 
just adds a comment - the rest "is left as an exercise for the reader")

		Linus

---
diff --git a/connect.c b/connect.c
index 54f7bf7..36c5d04 100644
--- a/connect.c
+++ b/connect.c
@@ -374,7 +374,7 @@ static int git_tcp_connect(int fd[2], co
 
 	fd[0] = sockfd;
 	fd[1] = sockfd;
-	packet_write(sockfd, "%s %s\n", prog, path);
+	packet_write(sockfd, "%s %s%c%s%c%s\n", prog, path, 0, host, 0, port);
 	return 0;
 }
 
diff --git a/daemon.c b/daemon.c
index 776749e..61e0af9 100644
--- a/daemon.c
+++ b/daemon.c
@@ -267,7 +267,7 @@ static int upload(char *dir)
 static int execute(void)
 {
 	static char line[1000];
-	int len;
+	int len, n;
 
 	alarm(init_timeout ? init_timeout : timeout);
 	len = packet_read_line(0, line, sizeof(line));
@@ -276,6 +276,14 @@ static int execute(void)
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
+	n = strlen(line);
+	if (n != len) {
+		/* Cool, we have hidden info at the end */
+		/* Parse the hostname and the port, and */
+		/* leave some room for expansion for	*/
+		/* the future ..			*/
+	}
+
 	if (!strncmp("git-upload-pack ", line, 16))
 		return upload(line+16);
 
