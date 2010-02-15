From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] fix threaded grep for machines with only one cpu
Date: Mon, 15 Feb 2010 23:50:02 +0100
Message-ID: <20100215225001.GA944@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 23:50:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh9le-0000xH-Gt
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 23:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620Ab0BOWuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 17:50:07 -0500
Received: from darksea.de ([83.133.111.250]:35547 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756574Ab0BOWuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 17:50:06 -0500
Received: (qmail 13693 invoked from network); 15 Feb 2010 23:50:02 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 15 Feb 2010 23:50:02 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140040>

In case the machine has only one cpu the initialization was
skipped.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 builtin-grep.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 26d4deb..644051c 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -220,12 +220,6 @@ static void start_threads(struct grep_opt *opt)
 {
 	int i;
 
-	pthread_mutex_init(&grep_mutex, NULL);
-	pthread_mutex_init(&read_sha1_mutex, NULL);
-	pthread_cond_init(&cond_add, NULL);
-	pthread_cond_init(&cond_write, NULL);
-	pthread_cond_init(&cond_result, NULL);
-
 	for (i = 0; i < ARRAY_SIZE(todo); i++) {
 		strbuf_init(&todo[i].out, 0);
 	}
@@ -880,6 +874,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (online_cpus() == 1 || !grep_threads_ok(&opt))
 		use_threads = 0;
 
+	pthread_mutex_init(&grep_mutex, NULL);
+	pthread_mutex_init(&read_sha1_mutex, NULL);
+	pthread_cond_init(&cond_add, NULL);
+	pthread_cond_init(&cond_write, NULL);
+	pthread_cond_init(&cond_result, NULL);
+
 	if (use_threads)
 		start_threads(&opt);
 #else
-- 
1.7.0.rc1.7.gc0da5
