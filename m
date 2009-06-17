From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] upload-archive: fix infinite loop on Cygwin
Date: Wed, 17 Jun 2009 12:11:10 +0200
Message-ID: <4A38C13E.6050800@lsrfire.ath.cx>
References: <e664dae0905180737mae29811ie4cae889b3e3904f@mail.gmail.com> <4A151A15.6040609@lsrfire.ath.cx> <alpine.LSU.2.00.0905211431060.23478@hermes-2.csi.cam.ac.uk> <4A156556.900@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tony Finch <dot@dotat.at>, Bob Kagy <bobkagy@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 12:11:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGs74-0001MS-1a
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 12:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756275AbZFQKLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 06:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbZFQKLP
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 06:11:15 -0400
Received: from india601.server4you.de ([85.25.151.105]:59794 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbZFQKLP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 06:11:15 -0400
Received: from [10.0.1.101] (p57B7DCAF.dip.t-dialin.net [87.183.220.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 2B95D2F8040;
	Wed, 17 Jun 2009 12:11:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A156556.900@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121732>

On Cygwin, poll() reports POLLIN even for file descriptors that have
reached their end.  This caused git upload-archive to be stuck in an
infinite loop, as it only looked at the POLLIN flag.

In addition to POLLIN, check if read() returned 0, which indicates
end-of-file, and keep looping only as long as at least one of the file
descriptors has input.  This lets the following command finish on its
own when run in a git repository on Cygwin, instead of it getting stuck
after printing all file names:

	$ git archive -v --remote . HEAD >/dev/null

Reported-by: Bob Kagy <bobkagy@gmail.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
This version of the patch has been cleaned up a bit compared to the
previous one and is slightly shorter, but does the same.

 builtin-upload-archive.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 0206b41..c4cd1e1 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -80,16 +80,17 @@ static void error_clnt(const char *fmt, ...)
 	die("sent error to the client: %s", buf);
 }
 
-static void process_input(int child_fd, int band)
+static ssize_t process_input(int child_fd, int band)
 {
 	char buf[16384];
 	ssize_t sz = read(child_fd, buf, sizeof(buf));
 	if (sz < 0) {
 		if (errno != EAGAIN && errno != EINTR)
 			error_clnt("read error: %s\n", strerror(errno));
-		return;
+		return sz;
 	}
 	send_sideband(1, band, buf, sz, LARGE_PACKET_MAX);
+	return sz;
 }
 
 int cmd_upload_archive(int argc, const char **argv, const char *prefix)
@@ -131,6 +132,7 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 
 	while (1) {
 		struct pollfd pfd[2];
+		ssize_t processed[2] = { 0, 0 };
 		int status;
 
 		pfd[0].fd = fd1[0];
@@ -147,12 +149,12 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 		}
 		if (pfd[0].revents & POLLIN)
 			/* Data stream ready */
-			process_input(pfd[0].fd, 1);
+			processed[0] = process_input(pfd[0].fd, 1);
 		if (pfd[1].revents & POLLIN)
 			/* Status stream ready */
-			process_input(pfd[1].fd, 2);
+			processed[1] = process_input(pfd[1].fd, 2);
 		/* Always finish to read data when available */
-		if ((pfd[0].revents | pfd[1].revents) & POLLIN)
+		if (processed[0] || processed[1])
 			continue;
 
 		if (waitpid(writer, &status, 0) < 0)
-- 
1.6.3.2.307.g21cd0
