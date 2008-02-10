From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix "git clone" for git:// protocol
Date: Sun, 10 Feb 2008 03:06:57 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802100302050.11591@racer.site>
References: <alpine.LSU.1.00.0802091657000.11591@racer.site> <alpine.LNX.1.00.0802091205530.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 04:07:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO2Xa-0008UA-T1
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 04:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332AbYBJDG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 22:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbYBJDG4
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 22:06:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:55049 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754105AbYBJDGz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 22:06:55 -0500
Received: (qmail invoked by alias); 10 Feb 2008 03:06:53 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp049) with SMTP; 10 Feb 2008 04:06:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+SkRjUNz+0g1D/6oerH7GZ+Qby3s388k/5DHQ/P
	m0I6hmOe8iCDWt
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802091205530.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73300>


In ba227857(Reduce the number of connects when fetching), we checked
the return value of git_connect() to see if the connection was
successful.

However, for the git:// protocol, there is no need to have another
process, so the return value was NULL.

Now, it makes sense to assume the rule that git_connect() will return
NULL if it fails (at the moment, it die()s if it fails), so return
a dummy child process.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	
	On Sat, 9 Feb 2008, Daniel Barkalow wrote:

	> On Sat, 9 Feb 2008, Johannes Schindelin wrote:
	> 
	> > In the commit "Reduce the number of connects when fetching", 
	> > we checked the return value of git_connect() to see if the 
	> > connection was successful.
	> > 
	> > However, for the git:// protocol, there is no need to have 
	> > another process, so the return value is NULL.
	> > 
	> > The thing is: git_connect() does not return at all if it 
	> > fails, so we need not check the return value of git_connect().
	> 
	> Huh. Sure enough. Actually, there's a similar problem in 
	> transport.c, where it assumes that the return value of 
	> git_connect is non-zero, which makes it not reuse the connection 
	> (not that you can really tell). It might be good to roll in a 
	> fix for that. Or maybe git_connect should return a pointer to a 
	> static struct child_process if it doesn't need a subprocess, 
	> just to distinguish "we're doing it ourselves" from "it's not 
	> being done"? If not, maybe the variables that store the return 
	> from git_connect should be renamed to "subproc" or something 
	> that doesn't suggest they can't be NULL if you're actually 
	> connected.

	How about this?

 connect.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/connect.c b/connect.c
index 3aefd4a..700ceba 100644
--- a/connect.c
+++ b/connect.c
@@ -472,14 +472,18 @@ char *get_port(char *host)
 	return NULL;
 }
 
+static struct child_process no_fork;
+
 /*
- * This returns NULL if the transport protocol does not need fork(2), or a
- * struct child_process object if it does.  Once done, finish the connection
- * with finish_connect() with the value returned from this function
- * (it is safe to call finish_connect() with NULL to support the former
- * case).
+ * This returns a dummy child_process if the transport protocol does not
+ * need fork(2), or a struct child_process object if it does.  Once done,
+ * finish the connection with finish_connect() with the value returned from
+ * this function (it is safe to call finish_connect() with NULL to support
+ * the former case).
  *
- * If it returns, the connect is successful; it just dies on errors.
+ * If it returns, the connect is successful; it just dies on errors (this
+ * will hopefully be changed in a libification effort, to return NULL when
+ * the connection failed).
  */
 struct child_process *git_connect(int fd[2], const char *url_orig,
 				  const char *prog, int flags)
@@ -577,7 +581,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		free(url);
 		if (free_path)
 			free(path);
-		return NULL;
+		return &no_fork;
 	}
 
 	conn = xcalloc(1, sizeof(*conn));
@@ -635,7 +639,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 int finish_connect(struct child_process *conn)
 {
 	int code;
-	if (!conn)
+	if (!conn || conn == &no_fork)
 		return 0;
 
 	code = finish_command(conn);
-- 
1.5.4.1264.g42770c
