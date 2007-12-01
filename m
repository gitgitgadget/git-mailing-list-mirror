From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] transport.c: call dash-less form of receive-pack and
 upload-pack on remote
Date: Sat, 1 Dec 2007 23:03:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712012300440.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
 <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
 <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
 <Pine.LNX.4.64.0711301207020.27959@racer.site> <7vlk8f9m52.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712010959180.27959@racer.site> <7vzlwu43i4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
	Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 00:04:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IybNm-0008Q7-Hh
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 00:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbXLAXD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 18:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbXLAXD7
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 18:03:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:48694 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750981AbXLAXD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 18:03:58 -0500
Received: (qmail invoked by alias); 01 Dec 2007 23:03:56 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp006) with SMTP; 02 Dec 2007 00:03:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199z0Fd6wB9r+ZHMK7782aU9qFpJhUGkHDEtPYnU9
	y0/orzAzyrv3og
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzlwu43i4.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66743>

Hi,

On Sat, 1 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I only eyeball-tested it and looks Okay, but that does not assure us
> >> much ;-).  Is this change easy to test using local transport?
> >
> > Seems like it breaks down with git-shell.  But then, I think that we just 
> > have to fix execv_git_cmd() to call builtins via "git" instead.
> 
> So in execv_git_cmd(), instead of doing the strbuf_addf(), we do
> something like this (and drop your patch)?

You know what is really funny?  I have this in my stash:

-- snip --
 exec_cmd.c      |   30 ++++++++++++------------------
 t/t0020-crlf.sh |    2 +-
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 2d0a758..7d022a2 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -65,31 +65,25 @@ void setup_path(const char *cmd_path)
 
 int execv_git_cmd(const char **argv)
 {
-	struct strbuf cmd;
-	const char *tmp;
+	int i;
+	char **new_argv;
 
-	strbuf_init(&cmd, 0);
-	strbuf_addf(&cmd, "git-%s", argv[0]);
+	for (i = 0; argv[i]; i++)
+		; /* do nothing */
+	new_argv = xmalloc((i + 2) * sizeof(*new_argv));
+	new_argv[0] = "git";
+	for (i = 0; argv[i]; i++)
+		new_argv[i + 1] = (char *)argv[i];
+	new_argv[i] = NULL;
 
-	/*
-	 * argv[0] must be the git command, but the argv array
-	 * belongs to the caller, and may be reused in
-	 * subsequent loop iterations. Save argv[0] and
-	 * restore it on error.
-	 */
-	tmp = argv[0];
-	argv[0] = cmd.buf;
-
-	trace_argv_printf(argv, -1, "trace: exec:");
+	trace_argv_printf((const char **)new_argv, -1, "trace: exec:");
 
 	/* execvp() can only ever return if it fails */
-	execvp(cmd.buf, (char **)argv);
+	execvp(new_argv[0], new_argv);
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
-	argv[0] = tmp;
-
-	strbuf_release(&cmd);
+	free(new_argv);
 
 	return -1;
 }
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 62bc4bb..275379d 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -36,7 +36,7 @@ test_expect_success setup '
 
 	for w in Some extra lines here; do echo $w; done >>one &&
 	git diff >patch.file &&
-	patched=`git hash-object --stdin <one` &&
+	patched=`GIT_TRACE=2 git hash-object --stdin <one` &&
 	git read-tree --reset -u HEAD &&
 
 	echo happy.
-- snap --

Which looks awfully like your patch (except that I called it new_argv, I 
think).

Now you might ask why there is such a funny patch to t0020?  Well, the 
patch does not work as-is.

Will investigate right now,
Dscho
