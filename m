From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Tue, 26 Aug 2008 08:48:35 +0200
Message-ID: <E1KXsL9-0004ef-Co@fencepost.gnu.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
Cc: Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 08:50:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXsNe-0002YF-3e
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 08:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbYHZGtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 02:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbYHZGtN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 02:49:13 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:58580 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbYHZGtN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 02:49:13 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1KXsL9-0004ef-Co; Tue, 26 Aug 2008 02:47:43 -0400
In-Reply-To: <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93717>

It is in general unsafe to start git with one or more of file descriptors
0/1/2 closed.  Karl Chen for example noticed that stat_command does this
in order to rename a pipe file descriptor to 0:

    dup2(from, 0);
    close(from);

... but if stdin was closed (for example) from == 0, so that

    dup2(0, 0);
    close(0);

just ends up closing the pipe.  Another extremely rare but nasty problem
would occur if an "important" file ends up in file descriptor 2, and is
corrupted by a call to die().

This patch fixes these problems by opening all of the "low" descriptors
to /dev/null in main.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 git.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 89e4645..be227b2 100644
--- a/git.c
+++ b/git.c
@@ -420,6 +420,19 @@ int main(int argc, const char **argv)
 	const char *cmd = argv[0] && *argv[0] ? argv[0] : "git-help";
 	char *slash = (char *)cmd + strlen(cmd);
 	int done_alias = 0;
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
 	 * Take the basename of argv[0] as the command
-- 
1.5.5
