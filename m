From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Allow diff and index commands to be interrupted
Date: Wed, 01 Feb 2006 00:40:33 +0100
Message-ID: <20060131234033.16288.34502.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 00:40:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F456o-00085n-U0
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 00:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWAaXkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 18:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWAaXkR
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 18:40:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:11710 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932154AbWAaXkP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 18:40:15 -0500
Received: (qmail 16310 invoked from network); 1 Feb 2006 00:40:33 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 00:40:33 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15365>

So far, e.g. git-update-index --refresh was basically uninterruptable
by ctrl-c, since it hooked the SIGINT handler, but that handler would
only unlink the lockfile but not actually quit. This makes it propagate
the signal to the default handler.

Note that I expected it to work without resetting the signal handler to
SIG_DFL, but without that it ended in an infinite loop of tgkill()s -
is my glibc violating SUS or what?

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 diff.c  |    2 ++
 index.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 8ae6dbc..ec51e7d 100644
--- a/diff.c
+++ b/diff.c
@@ -555,6 +555,8 @@ static void remove_tempfile(void)
 static void remove_tempfile_on_signal(int signo)
 {
 	remove_tempfile();
+	signal(SIGINT, SIG_DFL);
+	raise(signo);
 }
 
 /* An external diff command takes:
diff --git a/index.c b/index.c
index ad0eafe..f92b960 100644
--- a/index.c
+++ b/index.c
@@ -18,6 +18,8 @@ static void remove_lock_file(void)
 static void remove_lock_file_on_signal(int signo)
 {
 	remove_lock_file();
+	signal(SIGINT, SIG_DFL);
+	raise(signo);
 }
 
 int hold_index_file_for_update(struct cache_file *cf, const char *path)
