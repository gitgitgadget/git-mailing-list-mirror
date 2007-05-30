From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Git wrapper: add --redirect-stderr option
Date: Wed, 30 May 2007 04:25:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705300407170.4011@racer.site>
References: <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com>
 <Pine.LNX.4.64.0705291305540.4648@racer.site> <465C2516.7040607@trolltech.com>
 <Pine.LNX.4.64.0705291446170.4648@racer.site> <465C3502.BE134BC9@eudaptics.com>
 <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com>
 <465C4B0E.C34795B@eudaptics.com> <465CDE61.40103@xs4all.nl>
 <Pine.LNX.4.64.0705300337510.4011@racer.site> <20070530025705.GN7044@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 30 05:27:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtEqk-0002z9-6Y
	for gcvg-git@gmane.org; Wed, 30 May 2007 05:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbXE3D1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 23:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbXE3D1n
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 23:27:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:48695 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751020AbXE3D1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 23:27:43 -0400
Received: (qmail invoked by alias); 30 May 2007 03:27:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 30 May 2007 05:27:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XV/EDsE5X7wd3nnieaAdhza8Bi3OC5ipMzG3LPM
	B78Iu20HlLQ4Ye
X-X-Sender: gene099@racer.site
In-Reply-To: <20070530025705.GN7044@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48730>


With this option, stderr is redirected to stdout. The short option is '-2'.

Alternatively, you can say '--redirect-stderr=<filename>' to redirect
stderr to a file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 29 May 2007, Shawn O. Pearce wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
	> > 
	> > BTW Almost any operation I run in git-gui fails, because cat 
	> > is not found.
	> 
	> That's the stuff that goes into a console and dumps both to
	> stdout and stderr.  E.g. fetch, push, "compress database".
	> 
	> The issue is Tcl doesn't give me a way to get a pipe to both 
	> stdout and stderr.  I cannot get two pipes, nor can I get a 
	> single pipe with both stdout+stderr redirected to that pipe.  
	> Unless I pipe it into another process.  Enter `cat`.
	> 
	> Would we consider a "--stderr-to-stdout" long option to git 
	> itself? Then I could have git-gui do:
	> 
	> 	git --stderr-to-stdout fetch
	> 
	> and bypass the pipe into cat.  Yes, I know, its crap.  Welcome 
	> to Tcl.

	How about this?

 git.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 53d81e9..72e0539 100644
--- a/git.c
+++ b/git.c
@@ -82,6 +82,20 @@ static int handle_options(const char*** argv, int* argc)
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 1);
+		} else if (!strcmp(cmd, "-2") ||
+				!strcmp(cmd, "--redirect-stderr")) {
+			if (dup2(1, 2) < 0)
+				return error("Could not redirect stderr: %s",
+					strerror(errno));
+		} else if (!prefixcmp(cmd, "--redirect-stderr=")) {
+			int fd = open(cmd + 18, O_WRONLY | O_CREAT, 0777), ret;
+			if (fd < 0)
+				return error("Could not open %s", cmd + 18);
+			ret = dup2(fd, 2);
+			close(fd);
+			if (ret < 0)
+				return error("Could not redirect stderr: %s",
+					strerror(errno));
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
-- 
1.5.2.2642.gc8bae-dirty
