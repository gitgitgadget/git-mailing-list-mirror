From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Add sideband status report to git-archive protocol
Date: Tue, 12 Sep 2006 00:24:39 -0700
Message-ID: <7vzmd5eedk.fsf@assigned-by-dhcp.cox.net>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
	<45053BA2.6050502@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 12 09:23:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GN2cW-0006pQ-D7
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 09:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWILHXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 03:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWILHXp
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 03:23:45 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22979 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751404AbWILHXo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 03:23:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060912072343.FTEW13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Tue, 12 Sep 2006 03:23:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id MKPk1V00G1kojtg0000000
	Tue, 12 Sep 2006 03:23:45 -0400
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <45053BA2.6050502@innova-card.com> (Franck Bui-Huu's message of
	"Mon, 11 Sep 2006 12:34:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26882>

Franck Bui-Huu <vagabon.xyz@gmail.com> writes:

> I get a lot of "Hmph, HUP?" messages when testing "git-archive
> --remote" command. One guess: this can be due to the fact that when
> the writer process exits, it first closes its fd but do not send a
> SIGCHLD signal right after to its parent.

It does not reproduce for me, but the code I have is obviously
bogus in a few places.

 - When POLLHUP is set, it goes ahead and reads the file
   descriptor.  Worse yet, it does not check the return value of
   read() for errors when it does.

 - When we processed one POLLIN, we should just go back and see
   if any more data is available.  We can check if the child is
   still there when poll gave control back at us but without any
   actual input as you said.

I was uncomfortable letting waitpid() there to wait forever.
When does poll() return?  (1) we have data ready in which case
we process; (2) the child somehow closed the pipe but without
dying, which is an error in the child.  In the latter case even
not hanging in waitpid() and retrying the poll would not give
any useful input so that would not help either.

So I think your patch is a correct fix, except that I think we
should let the remote side know why we stopped talking to them
instead of calling die() there.

We should also check when read() returns an error, so how about
this on top of your patch?

diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 2ebe9a0..a53cfee 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -16,6 +16,9 @@ static const char upload_archive_usage[]
 static const char deadchild[] =
 "git-upload-archive: archiver died with error";
 
+static const char lostchild[] =
+"git-upload-archive: archiver process was lost";
+
 
 static int run_upload_archive(int argc, const char **argv, const char *prefix)
 {
@@ -73,6 +76,31 @@ static int run_upload_archive(int argc, 
 	return ar.write_archive(&ar.args);
 }
 
+static void error_clnt(const char *fmt, ...)
+{
+	char buf[1024];
+	va_list params;
+	int len;
+
+	va_start(params, fmt);
+	len = vsprintf(buf, fmt, params);
+	va_end(params);
+	send_sideband(1, 3, buf, len, LARGE_PACKET_MAX);
+	die("sent error to the client: %s", buf);
+}
+
+static void process_input(int child_fd, int band)
+{
+	char buf[16384];
+	ssize_t sz = read(child_fd, buf, sizeof(buf));
+	if (sz < 0) {
+		if (errno != EINTR)
+			error_clnt("read error: %s\n", strerror(errno));
+	}
+	else if (sz)
+		send_sideband(1, band, buf, sz, LARGE_PACKET_MAX);
+}
+
 int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
 	pid_t writer;
@@ -112,8 +140,6 @@ int cmd_upload_archive(int argc, const c
 
 	while (1) {
 		struct pollfd pfd[2];
-		char buf[16384];
-		ssize_t sz;
 		int status;
 
 		pfd[0].fd = fd1[0];
@@ -128,26 +154,19 @@ int cmd_upload_archive(int argc, const c
 			}
 			continue;
 		}
-		if (pfd[0].revents & (POLLIN|POLLHUP)) {
+		if (pfd[0].revents & POLLIN)
 			/* Data stream ready */
-			sz = read(pfd[0].fd, buf, sizeof(buf));
-			send_sideband(1, 1, buf, sz, LARGE_PACKET_MAX);
-		}
-		if (pfd[1].revents & (POLLIN|POLLHUP)) {
+			process_input(pfd[0].fd, 1);
+		if (pfd[1].revents & POLLIN)
 			/* Status stream ready */
-			sz = read(pfd[1].fd, buf, sizeof(buf));
-			send_sideband(1, 2, buf, sz, LARGE_PACKET_MAX);
-		}
-
+			process_input(pfd[1].fd, 2);
 		if ((pfd[0].revents | pfd[1].revents) == POLLIN)
 			continue;
 
-		if (waitpid(writer, &status, 0) < 0) {
-			die("waitpid failed: %s", strerror(errno));
-		}
-		if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
-			send_sideband(1, 3, deadchild, strlen(deadchild),
-				      LARGE_PACKET_MAX);
+		if (waitpid(writer, &status, 0) < 0)
+			error_clnt("%s", lostchild);
+		else if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
+			error_clnt("%s", deadchild);
 		packet_flush(1);
 		break;
 	}
