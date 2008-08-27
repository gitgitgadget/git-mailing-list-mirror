From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH v4] make git-shell paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 17:20:35 +0200
Message-ID: <E1KYMtm-0007Cd-Gt@fencepost.gnu.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <20080826074044.GA22694@cuci.nl> <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com> <20080827091800.GB484@cuci.nl> <48B54A3D.3080708@gnu.org>
Cc: <srb@cuci.nl>, <quarl@cs.berkeley.edu>, <gitster@pobox.com>,
	<j.sixt@viscovery.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 17:32:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYMwM-0003pS-A1
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 17:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbYH0P1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 11:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753544AbYH0P1E
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 11:27:04 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60712 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbYH0P1C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 11:27:02 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1KYMtm-0007Cd-Gt; Wed, 27 Aug 2008 11:25:30 -0400
In-Reply-To: <48B54A3D.3080708@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93896>

It is in general unsafe to start a program with one or more of file
descriptors 0/1/2 closed.  Karl Chen for example noticed that stat_command
does this in order to rename a pipe file descriptor to 0:

    dup2(from, 0);
    close(from);

... but if stdin was closed (for example) from == 0, so that

    dup2(0, 0);
    close(0);

just ends up closing the pipe.  Another extremely rare but nasty problem
would occur if an "important" file ends up in file descriptor 2, and is
corrupted by a call to die().

Fixing this in git was considered to be overkill, so this patch works
around it only for git-shell.  The fix is simply to open all the "low"
descriptors to /dev/null in main.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 shell.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/shell.c b/shell.c
index 0f6a727..e339369 100644
--- a/shell.c
+++ b/shell.c
@@ -48,6 +48,19 @@ int main(int argc, char **argv)
 {
 	char *prog;
 	struct commands *cmd;
+	int devnull_fd;
+
+	/*
+	 * Always open file descriptors 0/1/2 to avoid clobbering files
+	 * in die().  It also avoids not messing up when the pipes are
+	 * dup'ed onto stdin/stdout/stderr in the child processes we spawn.
+	 */
+	devnull_fd = open("/dev/null", O_RDWR);
+	while (devnull_fd >= 0 && devnull_fd <= 2)
+		devnull_fd = dup(devnull_fd);
+	if (devnull_fd == -1)
+		die("opening /dev/null failed (%s)", strerror(errno));
+	close (devnull_fd);
 
 	/*
 	 * Special hack to pretend to be a CVS server
-- 
1.5.5
