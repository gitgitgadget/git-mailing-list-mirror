From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] cast pid_t to long for printing
Date: Mon, 26 Jun 2006 10:26:06 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060626082606.GC3646@informatik.uni-freiburg.de>
References: <20060626080912.GA3646@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 26 10:26:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FumQ8-0004PU-56
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 10:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWFZI0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 04:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWFZI0J
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 04:26:09 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:31192 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S964871AbWFZI0I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 04:26:08 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FumQ2-0006JB-Jf
	for git@vger.kernel.org; Mon, 26 Jun 2006 10:26:06 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k5Q8Q6J12392
	for git@vger.kernel.org; Mon, 26 Jun 2006 10:26:06 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060626080912.GA3646@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22660>

This fixes warnings on Solaris 8.

Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

---

While fixing daemon.c, I saw that there is a call to syslog using %d for
pid_t, too.  I fixed that in the same way without further testing and
manual reading. I assume that's OK.

 daemon.c      |    9 ++++++---
 upload-pack.c |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

b339b05462efea5fee9f2b9bf70de03897a5e4ab
diff --git a/daemon.c b/daemon.c
index 1ba4d66..8641b13 100644
--- a/daemon.c
+++ b/daemon.c
@@ -368,7 +368,7 @@ static void remove_child(pid_t pid, unsi
 		struct child m;
 		deleted = (deleted + 1) % MAX_CHILDREN;
 		if (deleted == spawned)
-			die("could not find dead child %d\n", pid);
+			die("could not find dead child %ld\n", (long)pid);
 		m = live_child[deleted];
 		live_child[deleted] = n;
 		if (m.pid == pid)
@@ -476,9 +476,12 @@ static void child_handler(int signo)
 				if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
 					dead = " (with error)";
 				if (log_syslog)
-					syslog(LOG_INFO, "[%d] Disconnected%s", pid, dead);
+					syslog(LOG_INFO, "[%ld] Disconnected%s",
+					       (long)pid, dead);
 				else
-					fprintf(stderr, "[%d] Disconnected%s\n", pid, dead);
+					fprintf(stderr,
+						"[%ld] Disconnected%s\n",
+						(long)pid, dead);
 			}
 			continue;
 		}
diff --git a/upload-pack.c b/upload-pack.c
index 7b86f69..fdfef39 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -274,7 +274,7 @@ static void create_pack_file(void)
 					goto fail;
 				}
 				error("git-upload-pack: we weren't "
-				      "waiting for %d", pid);
+				      "waiting for %ld", (long)pid);
 				continue;
 			}
 			if (!WIFEXITED(status) || WEXITSTATUS(status) > 0) {
-- 
1.1.6.g7d80e

-- 
Uwe Zeisberger

exit vi, lesson V:
o : q ! CTRL-V <CR> <Esc> " d d d @ d
