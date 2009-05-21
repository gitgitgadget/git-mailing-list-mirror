From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive, cygwin, and --git-dir vs --remote
Date: Thu, 21 May 2009 11:08:37 +0200
Message-ID: <4A151A15.6040609@lsrfire.ath.cx>
References: <e664dae0905180737mae29811ie4cae889b3e3904f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bob Kagy <bobkagy@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 11:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M74Gi-0000Nf-VS
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 11:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbZEUJIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 05:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbZEUJIo
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 05:08:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:49924 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbZEUJIn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 05:08:43 -0400
Received: from [10.0.1.101] (p57B7F5E9.dip.t-dialin.net [87.183.245.233])
	by india601.server4you.de (Postfix) with ESMTPSA id 55F002F8044;
	Thu, 21 May 2009 11:08:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <e664dae0905180737mae29811ie4cae889b3e3904f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119662>

Bob Kagy schrieb:
> I'm using git on cygwin, and am confused by behavior from git archive.
> 
> git --version
> git version 1.6.1.2
> 
> This command works as expected:
> git --git-dir=/cygdrive/w archive --format=tar --verbose --prefix=tmp/
> HEAD | tar -xpf -
> The latest copy is retrieved and dumped to the tmp subdirectory.
> 
> However, I first went down the path of using the --remote option, as
> described in the git-archive man page:
> git archive --format=tar --verbose --prefix=tmp/ --remote=/cygdrive/w
> HEAD | tar -xpf -
> 
> When I use the --remote branch it seems to create the same files.  But
> then rather than exiting it hangs out until I kill the process, using
> about the same CPU % as it did when creating files.

That's strange.  It seems that poll() reports that there is data to read
from the child (which is running git-upload-archive), even though it
already called exit().

The following patch works around this issue by terminating the otherwise
endless loop after read() returned nothing for the thousandth time in a
row.  I'm not sure that there's really no way to get a thousand empty
reads without the child being done, though.

 builtin-upload-archive.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 0206b41..3d7b11b 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -17,6 +17,7 @@ static const char lostchild[] =
 "git upload-archive: archiver process was lost";
 
 #define MAX_ARGS (64)
+#define MAX_EMPTY_READS (1000)
 
 static int run_upload_archive(int argc, const char **argv, const char *prefix)
 {
@@ -80,10 +81,11 @@ static void error_clnt(const char *fmt, ...)
 	die("sent error to the client: %s", buf);
 }
 
-static void process_input(int child_fd, int band)
+static void process_input(int child_fd, int band, int *empty_reads)
 {
 	char buf[16384];
 	ssize_t sz = read(child_fd, buf, sizeof(buf));
+	*empty_reads = sz ? 0 : *empty_reads + 1;
 	if (sz < 0) {
 		if (errno != EAGAIN && errno != EINTR)
 			error_clnt("read error: %s\n", strerror(errno));
@@ -96,6 +98,8 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
 	pid_t writer;
 	int fd1[2], fd2[2];
+	int empty_reads_1 = 0;
+	int empty_reads_2 = 0;
 	/*
 	 * Set up sideband subprocess.
 	 *
@@ -147,12 +151,14 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 		}
 		if (pfd[0].revents & POLLIN)
 			/* Data stream ready */
-			process_input(pfd[0].fd, 1);
+			process_input(pfd[0].fd, 1, &empty_reads_1);
 		if (pfd[1].revents & POLLIN)
 			/* Status stream ready */
-			process_input(pfd[1].fd, 2);
+			process_input(pfd[1].fd, 2, &empty_reads_2);
 		/* Always finish to read data when available */
-		if ((pfd[0].revents | pfd[1].revents) & POLLIN)
+		if (((pfd[0].revents | pfd[1].revents) & POLLIN) &&
+		    empty_reads_1 <= MAX_EMPTY_READS &&
+		    empty_reads_2 <= MAX_EMPTY_READS)
 			continue;
 
 		if (waitpid(writer, &status, 0) < 0)
