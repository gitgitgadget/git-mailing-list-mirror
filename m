From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git grep: be careful to use mutices only when they are
 initialized
Date: Tue, 25 Oct 2011 12:25:20 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Tue Oct 25 19:25:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIkki-0004U2-KN
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 19:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab1JYRZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 13:25:24 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:46063 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751827Ab1JYRZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 13:25:23 -0400
Received: (qmail invoked by alias); 25 Oct 2011 17:25:20 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp052) with SMTP; 25 Oct 2011 19:25:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IOSUI34wIie3hnH+WV6Tdw1hcSfkT2ZSLxslB90
	xYNH5fnbUZkrlY
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184227>


Rather nasty things happen when a mutex is not initialized but locked
nevertheless. Now, when we're not running in a threaded manner, the mutex
is not initialized, which is correct. But then we went and used the mutex
anyway, which -- at least on Windows -- leads to a hard crash (ordinarily
it would be called a segmentation fault, but in Windows speak it is an
access violation).

This problem was identified by our faithful tests when run in the msysGit
environment.

To avoid having to wrap the line due to the 80 column limit, we use
the name "WHEN_THREADED" instead of "IF_USE_THREADS" because it is one
character shorter. Which is all we need in this case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I looked around a bit but ran out of time to identify the reason why
	this was not caught earlier.

 builtin/grep.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 92eeada..e94c5fe 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -78,10 +78,11 @@ static pthread_mutex_t grep_mutex;
 /* Used to serialize calls to read_sha1_file. */
 static pthread_mutex_t read_sha1_mutex;
 
-#define grep_lock() pthread_mutex_lock(&grep_mutex)
-#define grep_unlock() pthread_mutex_unlock(&grep_mutex)
-#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
-#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
+#define WHEN_THREADED(x) do { if (use_threads) (x); } while (0)
+#define grep_lock() WHEN_THREADED(pthread_mutex_lock(&grep_mutex))
+#define grep_unlock() WHEN_THREADED(pthread_mutex_unlock(&grep_mutex))
+#define read_sha1_lock() WHEN_THREADED(pthread_mutex_lock(&read_sha1_mutex))
+#define read_sha1_unlock() WHEN_THREADED(pthread_mutex_unlock(&read_sha1_mutex))
 
 /* Signalled when a new work_item is added to todo. */
 static pthread_cond_t cond_add;
-- 
1.7.5.3.4540.g15f89
