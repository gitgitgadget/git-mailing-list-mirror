From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v4 3/3] upload-archive: use start_command instead of fork
Date: Tue, 15 Nov 2011 19:53:01 +0100
Message-ID: <m2hb25cj5e.fsf@igel.home>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
	<201111151122.48378.trast@student.ethz.ch>
	<20111115102807.GA18649@sigill.intra.peff.net>
	<201111151311.46832.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, <git@vger.kernel.org>,
	<gitster@pobox.com>, <j6t@kdbg.org>, <rene.scharfe@lsrfire.ath.cx>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Nov 15 19:53:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQO8B-0004LB-Bp
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 19:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158Ab1KOSxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 13:53:09 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:59418 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986Ab1KOSxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 13:53:08 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id EEECB1C02FAF;
	Tue, 15 Nov 2011 19:53:03 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id E2B761C047AA;
	Tue, 15 Nov 2011 19:53:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id h42SJt+ljj8F; Tue, 15 Nov 2011 19:53:03 +0100 (CET)
Received: from igel.home (ppp-88-217-117-0.dynamic.mnet-online.de [88.217.117.0])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue, 15 Nov 2011 19:53:02 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id C9EABCA29C; Tue, 15 Nov 2011 19:53:01 +0100 (CET)
X-Yow: Okay, BARBRA STREISAND, I recognize you now!!  Also EFREM ZIMBALIST,
 JUNIOR!!  And BEAUMONT NEWHALL!!  Everybody into th' BATHROOM!
In-Reply-To: <201111151311.46832.trast@student.ethz.ch> (Thomas Rast's message
	of "Tue, 15 Nov 2011 13:11:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185479>

Thomas Rast <trast@student.ethz.ch> writes:

> But after a closer look I think this patch just prodded it enough to
> unearth long-existing undefined behaviour: prepare_argv() summarizes
> to something like
>
> static void prepare_argv(const char **sent_argv, const char **argv)
> {
> 	char *p, buf[4096];
>
> 	for (p = buf;;) {
> 		len = packet_read_line(0, p, (buf + sizeof buf) - p);
> 		/* ... p always points into buf ... */
> 		sent_argv[sent_argc++] = p;
> 		p += len;
> 		*p++ = 0;
> 	}
> 	sent_argv[sent_argc] = NULL;
> }
>
> The code appears to have looked like this ever since the addition of
> that file back in 39345a2 (Add git-upload-archive, 2006-09-07).  So
> the elements of sent_argv have apparently always pointed into the
> stack-allocated 'buf'.
>
> (This correlates with the "Address 0x7feffe7d0 is not stack'd", even
> though it's pretty clearly an address into the stack.)
>
> A quick band-aid would be to heap-allocate it instead:

Or allocate it in the caller:

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index c57e8bd..f0f843e 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -18,11 +18,12 @@ static const char lostchild[] =
 "git upload-archive: archiver process was lost";
 
 #define MAX_ARGS (64)
+#define ARGV_BUF_SIZE 4096
 
-static void prepare_argv(const char **sent_argv, const char **argv)
+static void prepare_argv(const char **sent_argv, char *buf, const char **argv)
 {
 	const char *arg_cmd = "argument ";
-	char *p, buf[4096];
+	char *p;
 	int sent_argc;
 	int len;
 
@@ -32,7 +33,7 @@ static void prepare_argv(const char **sent_argv, const char **argv)
 	sent_argv[1] = "--remote-request";
 	for (p = buf;;) {
 		/* This will die if not enough free space in buf */
-		len = packet_read_line(0, p, (buf + sizeof buf) - p);
+		len = packet_read_line(0, p, (buf + ARGV_BUF_SIZE) - p);
 		if (len == 0)
 			break;	/* got a flush */
 		if (sent_argc > MAX_ARGS - 2)
@@ -85,6 +86,7 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
 	const char *sent_argv[MAX_ARGS];
 	struct child_process cld = { sent_argv };
+	char argv_buf[ARGV_BUF_SIZE];
 	cld.out = cld.err = -1;
 	cld.git_cmd = 1;
 
@@ -94,7 +96,7 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 	if (!enter_repo(argv[1], 0))
 		die("'%s' does not appear to be a git repository", argv[1]);
 
-	prepare_argv(sent_argv, argv);
+	prepare_argv(sent_argv, argv_buf, argv);
 	if (start_command(&cld)) {
 		int err = errno;
 		packet_write(1, "NACK fork failed on the remote side\n");
-- 
1.7.7.3


Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
