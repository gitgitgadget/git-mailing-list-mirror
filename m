From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Restore SIGCHLD to SIG_DFL where we care about waitpid().
Date: Mon, 19 Jun 2006 20:11:40 -0700
Message-ID: <7vslm04j2r.fsf@assigned-by-dhcp.cox.net>
References: <7vwtbc7ll6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606191654590.5498@g5.osdl.org>
	<7vfyi07jf2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606191742470.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 05:11:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsWeY-0001tw-SW
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 05:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWFTDLn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 23:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbWFTDLn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 23:11:43 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:23691 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965249AbWFTDLm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 23:11:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620031141.QCOL12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 23:11:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22160>

It was reported that under one implementation of socks client,
"git clone" fails with "error: waitpid failed (No child
processes)", because "git" is spawned after setting SIGCHLD to
SIG_IGN.

Arguably it may be a broken setting, but we should protect
ourselves so that we can get reliable results from waitpid() for
the children we care about.

This patch resets SIGCHLD to SIG_DFL in three places:

 - connect.c::git_connect() - initiators of git native
   protocol transfer are covered with this.

 - daemon.c::main() - obviously.

 - merge-index.c::main() - obviously.

There are other programs that do fork() but do not waitpid():
http-push, imap-send.  upload-pack does not either, but in the
case of that program, each of the forked halves runs exec()
another program, so this change would not have much effect
there.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Linus Torvalds <torvalds@osdl.org> writes:

  > On Mon, 19 Jun 2006, Junio C Hamano wrote:
  >
  >> I do not offhand think of a place where we do fork() but not
  >> waitpid(), and it is very tempting to cheat and do that in the
  >> main(), since I do not see a downside to it.
  >
  > Yeah, it probably does make sense. That said, there are several "main()" 
  > functions, so you'd still end up having to verify that we catch all the 
  > paths.. Are all users of fork() built-in by now? 
 
  Not really.  But git native protocol initiators all use
  git_connect() so they are easy, and there are only few
  remaining ones that matter.

 connect.c     |    5 +++++
 daemon.c      |    5 +++++
 merge-index.c |    5 +++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/connect.c b/connect.c
index 52d709e..db7342e 100644
--- a/connect.c
+++ b/connect.c
@@ -581,6 +581,11 @@ int git_connect(int fd[2], char *url, co
 	enum protocol protocol = PROTO_LOCAL;
 	int free_path = 0;
 
+	/* Without this we cannot rely on waitpid() to tell
+	 * what happened to our children.
+	 */
+	signal(SIGCHLD, SIG_DFL);
+
 	host = strstr(url, "://");
 	if(host) {
 		*host = '\0';
diff --git a/daemon.c b/daemon.c
index 2f03f99..1067004 100644
--- a/daemon.c
+++ b/daemon.c
@@ -671,6 +671,11 @@ int main(int argc, char **argv)
 	int inetd_mode = 0;
 	int i;
 
+	/* Without this we cannot rely on waitpid() to tell
+	 * what happened to our children.
+	 */
+	signal(SIGCHLD, SIG_DFL);
+
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
diff --git a/merge-index.c b/merge-index.c
index 024196e..190e12f 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -99,6 +99,11 @@ int main(int argc, char **argv)
 {
 	int i, force_file = 0;
 
+	/* Without this we cannot rely on waitpid() to tell
+	 * what happened to our children.
+	 */
+	signal(SIGCHLD, SIG_DFL);
+
 	if (argc < 3)
 		usage("git-merge-index [-o] [-q] <merge-program> (-a | <filename>*)");
 
-- 
1.4.0.g275f
