From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 3/3] upload-archive: use start_command instead of fork
Date: Tue, 15 Nov 2011 13:11:46 +0100
Message-ID: <201111151311.46832.trast@student.ethz.ch>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com> <201111151122.48378.trast@student.ethz.ch> <20111115102807.GA18649@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>, <git@vger.kernel.org>,
	<gitster@pobox.com>, <j6t@kdbg.org>, <rene.scharfe@lsrfire.ath.cx>
To: Jeff King <peff@peff.net>, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 13:11:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQHro-0000qS-Fy
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 13:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274Ab1KOMLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 07:11:50 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:35210 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab1KOMLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 07:11:49 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 15 Nov
 2011 13:11:43 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 15 Nov
 2011 13:11:46 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-47-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20111115102807.GA18649@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185455>

Jeff King wrote:
> On Tue, Nov 15, 2011 at 11:22:48AM +0100, Thomas Rast wrote:
> > 
> > I see valgrind failures bisecting to this commit, like so:
> > 
> > ==19125== Syscall param execve(argv[i]) points to unaddressable byte(s)
> > ==19125==    at 0x5303CB7: execve (in /lib64/libc-2.11.3.so)
> > ==19125==    by 0x53045A5: execvpe (in /lib64/libc-2.11.3.so)
> > ==19125==    by 0x4B183C: execv_git_cmd (exec_cmd.c:137)
> > ==19125==    by 0x4F305E: start_command (run-command.c:277)
> > ==19125==    by 0x47F5C9: cmd_upload_archive (upload-archive.c:98)
> > ==19125==    by 0x4051F4: run_builtin (git.c:308)
> > ==19125==    by 0x40538F: handle_internal_command (git.c:466)
> > ==19125==    by 0x405556: main (git.c:553)
> > ==19125==  Address 0x7feffe7d0 is not stack'd, malloc'd or (recently) free'd
> > 
> > when running 'make valgrind' in current master.  Let me know if you
> > need more information.
> 
> With which test, and on what OS? I couldn't replicate running
> t5000 on Linux.

11, and many others after it, on a pretty vanilla opensuse 11.4 VM I
use almost exclusively for the valgrind runs.  I used a pre-3.7 SVN
valgrind build, but 3.6.1 (shipped with opensuse) finds the same.

But after a closer look I think this patch just prodded it enough to
unearth long-existing undefined behaviour: prepare_argv() summarizes
to something like

static void prepare_argv(const char **sent_argv, const char **argv)
{
	char *p, buf[4096];

	for (p = buf;;) {
		len = packet_read_line(0, p, (buf + sizeof buf) - p);
		/* ... p always points into buf ... */
		sent_argv[sent_argc++] = p;
		p += len;
		*p++ = 0;
	}
	sent_argv[sent_argc] = NULL;
}

The code appears to have looked like this ever since the addition of
that file back in 39345a2 (Add git-upload-archive, 2006-09-07).  So
the elements of sent_argv have apparently always pointed into the
stack-allocated 'buf'.

(This correlates with the "Address 0x7feffe7d0 is not stack'd", even
though it's pretty clearly an address into the stack.)

A quick band-aid would be to heap-allocate it instead:

diff --git i/builtin/upload-archive.c w/builtin/upload-archive.c
index c57e8bd..6ab50d3 100644
--- i/builtin/upload-archive.c
+++ w/builtin/upload-archive.c
@@ -22,9 +22,10 @@ static const char lostchild[] =
 static void prepare_argv(const char **sent_argv, const char **argv)
 {
 	const char *arg_cmd = "argument ";
-	char *p, buf[4096];
+	char *p, *buf;
 	int sent_argc;
 	int len;
+	buf = xmalloc(4096);
 
 	/* put received options in sent_argv[] */
 	sent_argc = 2;
@@ -32,7 +33,7 @@ static void prepare_argv(const char **sent_argv, const char **argv)
 	sent_argv[1] = "--remote-request";
 	for (p = buf;;) {
 		/* This will die if not enough free space in buf */
-		len = packet_read_line(0, p, (buf + sizeof buf) - p);
+		len = packet_read_line(0, p, (buf + 4096) - p);
 		if (len == 0)
 			break;	/* got a flush */
 		if (sent_argc > MAX_ARGS - 2)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
