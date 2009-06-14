From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] daemon: send stderr of service programs to the syslog
Date: Sun, 14 Jun 2009 22:38:51 +0200
Message-ID: <200906142238.51725.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 22:39:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFwTn-0006bE-GB
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 22:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759354AbZFNUiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 16:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757443AbZFNUiy
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 16:38:54 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:64272 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756114AbZFNUix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 16:38:53 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B9211CDF84;
	Sun, 14 Jun 2009 22:38:52 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 00FFC4275E;
	Sun, 14 Jun 2009 22:38:52 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121562>

If git-daemon is run with --detach or --inetd, then stderr is explicitly
redirected to /dev/null. But notice that the service programs were spawned
via execl_git_cmd(), in particular, the stderr channel is inherited from
the daemon. This means that errors that the programs wrote to stderr (for
example, via die()), went to /dev/null.

This patch arranges that the daemon does not merely exec the service
program, but forks it and monitors stderr of the child; it writes the
errors that it produces to the daemons log via logerror().

A consequence is that the daemon process remains in memory for the full
duration of the service program, but this cannot be avoided.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I don't know whether service programs like upload-archive or upload-pack
 write progress report to stderr or not, for example, if a client does not
 support side-bands. In this case this patch is probably not enough since
 this would fill the log with unneeded progress information. Any hints
 are appreciated.

 I intend to follow-up this patch with another one that integrates
 run_service_command() in execute() in order to streamline how the
 'incoming' fd is inherited to the service programs. But I haven't
 even begun this change, yet, because I'd like to know first how this
 one is received.

 -- Hannes

 daemon.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/daemon.c b/daemon.c
index d7ceca4..3e1a354 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pkt-line.h"
-#include "exec_cmd.h"
+#include "run-command.h"
+#include "strbuf.h"
 
 #include <syslog.h>
 
@@ -343,28 +344,66 @@ static int run_service(char *dir, const struct daemon_service *service)
 	return service->fn();
 }
 
+static void copy_to_log(int fd)
+{
+	struct strbuf line = STRBUF_INIT;
+	FILE *fp;
+
+	fp = fdopen(fd, "r");
+	if (fp == NULL) {
+		logerror("fdopen of error channel failed");
+		close(fd);
+		return;
+	}
+
+	while (strbuf_getline(&line, fp, '\n') != EOF) {
+		logerror("%s", line.buf);
+		strbuf_setlen(&line, 0);
+	}
+	
+	strbuf_release(&line);
+	fclose(fp);
+}
+
+static int run_service_command(const char **argv)
+{
+	struct child_process cld;
+
+	memset(&cld, 0, sizeof(cld));
+	cld.argv = argv;
+	cld.git_cmd = 1;
+	cld.err = -1;
+	if (start_command(&cld))
+		return -1;
+
+	close(0);
+	close(1);
+
+	copy_to_log(cld.err);
+
+	return finish_command(&cld);
+}
+
 static int upload_pack(void)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
+	const char *argv[] = { "upload-pack", "--strict", timeout_buf, ".", NULL };
 
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
-
-	/* git-upload-pack only ever reads stuff, so this is safe */
-	execl_git_cmd("upload-pack", "--strict", timeout_buf, ".", NULL);
-	return -1;
+	return run_service_command(argv);
 }
 
 static int upload_archive(void)
 {
-	execl_git_cmd("upload-archive", ".", NULL);
-	return -1;
+	static const char *argv[] = { "upload-archive", ".", NULL };
+	return run_service_command(argv);
 }
 
 static int receive_pack(void)
 {
-	execl_git_cmd("receive-pack", ".", NULL);
-	return -1;
+	static const char *argv[] = { "receive-pack", ".", NULL };
+	return run_service_command(argv);
 }
 
 static struct daemon_service daemon_service[] = {
-- 
1.6.3.17.g1665f
