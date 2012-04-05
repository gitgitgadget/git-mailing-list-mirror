From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] compat/mingw.[ch]: Change return type of exec functions to
 int
Date: Thu, 05 Apr 2012 18:48:46 +0100
Message-ID: <4F7DDAFE.1060902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 19:50:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFqpa-0003zP-Rm
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 19:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab2DERug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 13:50:36 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:44377 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753224Ab2DERuf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 13:50:35 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SFqpN-0002LN-iZ; Thu, 05 Apr 2012 17:50:34 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194791>


The POSIX standard specifies a return type of int for all six exec
functions. In addition, all exec functions return -1 on error, and
simply do not return on success. However, the current emulation of
the exec functions on mingw are declared with a void return type.

This would cause a problem should any code attempt to call the
exec function in a non-void context. In particular, if an exec
function were used in a conditional it would fail to compile.

In order to improve the fidelity of the emulation, we change the
return type of the mingw_execv[p] functions to int and return -1
on error.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

Since commit b0984f82 ("run-command: treat inaccessible directories
as ENOENT", 30-03-2012), the mingw build fails as follows:

        CC run-command.o
    run-command.c: In function 'sane_execvp':
    run-command.c:124: error: invalid use of void expression
    make: *** [run-command.o] Error 1

My first reaction was to simply remove the conditional since, if execvp()
returns at all, the result will always be -1 and so the condition will
always be false. ie. the conditional is pointless.

However, I found the incorrect return type of the mingw_execv[p]() to be
a gratuitous incompatibility, so ... :-P

Could you (or Junio?) add this patch prior to your patch on this branch ?
Thanks in advance!

I will let you decide if you want to remove the conditional as well ...

ATB,
Ramsay Jones

 compat/mingw.c |    6 ++++--
 compat/mingw.h |    4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a0ac487..afc892d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1003,7 +1003,7 @@ static void mingw_execve(const char *cmd, char *const *argv, char *const *env)
 	}
 }
 
-void mingw_execvp(const char *cmd, char *const *argv)
+int mingw_execvp(const char *cmd, char *const *argv)
 {
 	char **path = get_path_split();
 	char *prog = path_lookup(cmd, path, 0);
@@ -1015,11 +1015,13 @@ void mingw_execvp(const char *cmd, char *const *argv)
 		errno = ENOENT;
 
 	free_path_split(path);
+	return -1;
 }
 
-void mingw_execv(const char *cmd, char *const *argv)
+int mingw_execv(const char *cmd, char *const *argv)
 {
 	mingw_execve(cmd, argv, environ);
+	return -1;
 }
 
 int mingw_kill(pid_t pid, int sig)
diff --git a/compat/mingw.h b/compat/mingw.h
index 0ff1e04..ef5b150 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -274,9 +274,9 @@ int mingw_utime(const char *file_name, const struct utimbuf *times);
 pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
 		     const char *dir,
 		     int fhin, int fhout, int fherr);
-void mingw_execvp(const char *cmd, char *const *argv);
+int mingw_execvp(const char *cmd, char *const *argv);
 #define execvp mingw_execvp
-void mingw_execv(const char *cmd, char *const *argv);
+int mingw_execv(const char *cmd, char *const *argv);
 #define execv mingw_execv
 
 static inline unsigned int git_ntohl(unsigned int x)
-- 
1.7.9
