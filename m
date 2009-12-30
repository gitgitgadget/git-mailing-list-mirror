From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] run-command: convert simple callsites to use_shell
Date: Wed, 30 Dec 2009 05:53:57 -0500
Message-ID: <20091230105357.GB22959@coredump.intra.peff.net>
References: <20091230095634.GA16349@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 11:54:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPwBq-0002QR-RU
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 11:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbZL3KyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 05:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbZL3KyC
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 05:54:02 -0500
Received: from peff.net ([208.65.91.99]:37127 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbZL3KyA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 05:54:00 -0500
Received: (qmail 5144 invoked by uid 107); 30 Dec 2009 10:58:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Dec 2009 05:58:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2009 05:53:57 -0500
Content-Disposition: inline
In-Reply-To: <20091230095634.GA16349@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135882>

Now that we have the use_shell feature, these callsites can
all be converted with small changes.

Signed-off-by: Jeff King <peff@peff.net>
---
These should be non-controversial.

 convert.c   |    3 ++-
 imap-send.c |    8 ++------
 ll-merge.c  |    6 +++---
 pager.c     |    5 +++--
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/convert.c b/convert.c
index 491e714..950b1f9 100644
--- a/convert.c
+++ b/convert.c
@@ -249,10 +249,11 @@ static int filter_buffer(int fd, void *data)
 	struct child_process child_process;
 	struct filter_params *params = (struct filter_params *)data;
 	int write_err, status;
-	const char *argv[] = { "sh", "-c", params->cmd, NULL };
+	const char *argv[] = { params->cmd, NULL };
 
 	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
+	child_process.use_shell = 1;
 	child_process.in = -1;
 	child_process.out = fd;
 
diff --git a/imap-send.c b/imap-send.c
index de8114b..51f371b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -965,17 +965,13 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	/* open connection to IMAP server */
 
 	if (srvc->tunnel) {
-		const char *argv[4];
+		const char *argv[] = { srvc->tunnel, NULL };
 		struct child_process tunnel = {0};
 
 		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
 
-		argv[0] = "sh";
-		argv[1] = "-c";
-		argv[2] = srvc->tunnel;
-		argv[3] = NULL;
-
 		tunnel.argv = argv;
+		tunnel.use_shell = 1;
 		tunnel.in = -1;
 		tunnel.out = -1;
 		if (start_command(&tunnel))
diff --git a/ll-merge.c b/ll-merge.c
index 2d6b6d6..18511e2 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -175,7 +175,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 		{ "B", temp[2] },
 		{ NULL }
 	};
-	const char *args[] = { "sh", "-c", NULL, NULL };
+	const char *args[] = { NULL, NULL };
 	int status, fd, i;
 	struct stat st;
 
@@ -190,8 +190,8 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 
 	strbuf_expand(&cmd, fn->cmdline, strbuf_expand_dict_cb, &dict);
 
-	args[2] = cmd.buf;
-	status = run_command_v_opt(args, 0);
+	args[0] = cmd.buf;
+	status = run_command_v_opt(args, RUN_USING_SHELL);
 	fd = open(temp[1], O_RDONLY);
 	if (fd < 0)
 		goto bad;
diff --git a/pager.c b/pager.c
index 92c03f6..2c7e8ec 100644
--- a/pager.c
+++ b/pager.c
@@ -28,7 +28,7 @@ static void pager_preexec(void)
 }
 #endif
 
-static const char *pager_argv[] = { "sh", "-c", NULL, NULL };
+static const char *pager_argv[] = { NULL, NULL };
 static struct child_process pager_process;
 
 static void wait_for_pager(void)
@@ -81,7 +81,8 @@ void setup_pager(void)
 	spawned_pager = 1; /* means we are emitting to terminal */
 
 	/* spawn the pager */
-	pager_argv[2] = pager;
+	pager_argv[0] = pager;
+	pager_process.use_shell = 1;
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
 	if (!getenv("LESS")) {
-- 
1.6.6.65.g050d2.dirty
