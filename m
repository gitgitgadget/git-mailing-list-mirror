From: Jason Wright <jason@thought.net>
Subject: execlp sentinel
Date: Wed, 15 Jun 2005 11:33:55 -0400
Message-ID: <20050615153355.GE12393@thought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 15 17:29:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiZpe-0005bS-CK
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 17:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVFOPej (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 11:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFOPej
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 11:34:39 -0400
Received: from anything.thought.net ([192.148.252.38]:32816 "EHLO
	anything.thought.net") by vger.kernel.org with ESMTP
	id S261175AbVFOPef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 11:34:35 -0400
Received: from anything.thought.net (jason@localhost.thought.net [127.0.0.1])
	by anything.thought.net (8.13.4/8.13.0) with ESMTP id j5FFXtQc026594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 15 Jun 2005 11:33:55 -0400 (EDT)
Received: (from jason@localhost)
	by anything.thought.net (8.13.4/8.13.0/Submit) id j5FFXtYs014982
	for git@vger.kernel.org; Wed, 15 Jun 2005 11:33:55 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Another thing I ran into when porting cogito-0.11.3 to OpenBSD...  the
NULL last argument to execlp() must be cast to a pointer type (NULL
is an integer type on OpenBSD) in order for it to match as being
a proper sentinel value.

--Jason L. Wright

--- diff.c.orig	Thu Jun  9 05:15:09 2005
+++ diff.c	Wed Jun 15 11:20:08 2005
@@ -157,7 +157,7 @@ static void builtin_diff(const char *nam
 			exit(0);
 	}
 	fflush(NULL);
-	execlp("/bin/sh","sh", "-c", cmd, NULL);
+	execlp("/bin/sh","sh", "-c", cmd, (void *)NULL);
 }
 
 struct diff_filespec *alloc_filespec(const char *path)
@@ -518,7 +518,7 @@ static void run_external_diff(const char
 				execvp(pgm, (char *const*) exec_arg);
 			}
 			else
-				execlp(pgm, pgm, name, NULL);
+				execlp(pgm, pgm, name, (void *)NULL);
 		}
 		/*
 		 * otherwise we use the built-in one.
--- merge-cache.c.orig	Tue Jun 14 17:07:44 2005
+++ merge-cache.c	Tue Jun 14 17:07:50 2005
@@ -23,7 +23,7 @@ static void run_program(void)
 			    arguments[5],
 			    arguments[6],
 			    arguments[7],
-			    NULL);
+			    (void *)NULL);
 		die("unable to execute '%s'", pgm);
 	}
 	if (waitpid(pid, &status, 0) < 0 || !WIFEXITED(status) || WEXITSTATUS(status)) {
--- rsh.c.orig	Wed Jun 15 11:21:57 2005
+++ rsh.c	Wed Jun 15 11:22:08 2005
@@ -57,7 +57,7 @@ int setup_connection(int *fd_in, int *fd
 		close(sv[1]);
 		dup2(sv[0], 0);
 		dup2(sv[0], 1);
-		execlp("ssh", "ssh", host, command, NULL);
+		execlp("ssh", "ssh", host, command, (void *)NULL);
 	}
 	close(sv[0]);
 	*fd_in = sv[1];
