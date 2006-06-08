From: Paul T Darga <pdarga@umich.edu>
Subject: [PATCH] check for error return from fork()
Date: Thu, 8 Jun 2006 14:14:47 -0400
Message-ID: <20060608181446.GA32089@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 08 20:15:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoP29-0006fj-1L
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 20:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWFHSOt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 14:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWFHSOt
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 14:14:49 -0400
Received: from piano.eecs.umich.edu ([141.212.110.95]:28133 "EHLO
	piano.eecs.umich.edu") by vger.kernel.org with ESMTP
	id S964862AbWFHSOs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 14:14:48 -0400
Received: from piano.eecs.umich.edu (localhost.localdomain [127.0.0.1])
	by piano.eecs.umich.edu (8.13.6/8.13.6) with ESMTP id k58IElNq032099
	for <git@vger.kernel.org>; Thu, 8 Jun 2006 14:14:47 -0400
Received: (from pdarga@localhost)
	by piano.eecs.umich.edu (8.13.6/8.13.6/Submit) id k58IElIv032098
	for git@vger.kernel.org; Thu, 8 Jun 2006 14:14:47 -0400
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21503>

Trivial fixup for fork() callsites which do not check for errors.

Signed-off-by: Paul T Darga <pdarga@umich.edu>
---
 connect.c   |    2 ++
 imap-send.c |    6 +++++-
 rsh.c       |    6 +++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index eca94f7..52d709e 100644
--- a/connect.c
+++ b/connect.c
@@ -657,6 +657,8 @@ int git_connect(int fd[2], char *url, co
 	if (pipe(pipefd[0]) < 0 || pipe(pipefd[1]) < 0)
 		die("unable to create pipe pair for communication");
 	pid = fork();
+	if (pid < 0)
+		die("unable to fork");
 	if (!pid) {
 		snprintf(command, sizeof(command), "%s %s", prog,
 			 sq_quote(path));
diff --git a/imap-send.c b/imap-send.c
index 52e2400..285ad29 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -924,6 +924,7 @@ imap_open_store( imap_server_conf_t *srv
 	struct hostent *he;
 	struct sockaddr_in addr;
 	int s, a[2], preauth;
+	pid_t pid;
 
 	ctx = xcalloc( sizeof(*ctx), 1 );
 
@@ -941,7 +942,10 @@ imap_open_store( imap_server_conf_t *srv
 			exit( 1 );
 		}
 
-		if (fork() == 0) {
+		pid = fork();
+		if (pid < 0)
+			_exit( 127 );
+		if (!pid) {
 			if (dup2( a[0], 0 ) == -1 || dup2( a[0], 1 ) == -1)
 				_exit( 127 );
 			close( a[0] );
diff --git a/rsh.c b/rsh.c
index d665269..07166ad 100644
--- a/rsh.c
+++ b/rsh.c
@@ -48,6 +48,7 @@ int setup_connection(int *fd_in, int *fd
 	int sizen;
 	int of;
 	int i;
+	pid_t pid;
 
 	if (!strcmp(url, "-")) {
 		*fd_in = 0;
@@ -91,7 +92,10 @@ int setup_connection(int *fd_in, int *fd
 	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv))
 		return error("Couldn't create socket");
 
-	if (!fork()) {
+	pid = fork();
+	if (pid < 0)
+		return error("Couldn't fork");
+	if (!pid) {
 		const char *ssh, *ssh_basename;
 		ssh = getenv("GIT_SSH");
 		if (!ssh) ssh = "ssh";
-- 
1.4.0.rc2


-- 
Paul T. Darga - pdarga@umich.edu - http://www.eecs.umich.edu/~pdarga/
"When I gave food to the poor, they called me a saint. When I asked
why the poor were hungry, they called me a communist."
    -- Dom Helder Camara, Brazilian Bishop, Nobel Peace Prize nominee
