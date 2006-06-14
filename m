From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fix git alias
Date: Wed, 14 Jun 2006 06:01:05 -0700
Message-ID: <7vu06nevse.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 14 15:01:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqUzg-0002Fr-53
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 15:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWFNNBI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 09:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWFNNBI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 09:01:08 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:21981 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964903AbWFNNBG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 09:01:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060614130106.LCFX11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Jun 2006 09:01:06 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21842>

When extra command line arguments are given to a command that
was alias-expanded, the code generated a wrong argument list,
leaving the original alias in the result, and forgetting to
terminate the new argv list.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This would make "git l -n 4" work when you have "alias.l =
   log -M" in your configuration.  The original code generated
   an equivalent of "git log -M l -n 4".

   There is another more grave problem I seem to be hitting but
   haven't figured out (and will probably not figure out while
   away); I'd appreciate if you can track it down.  With
   "alias.wh = whatchanged --patch-with-stat", "git wh HEAD --
   mailinfo.c" segfaults at fclose() in git_config_from_file()
   when it reads the configuration for the second time (the
   first time being getting the alias).  The second call comes
   via init_revisions() calling setup_git_directory().  Oddly
   I do not seem to be able to reproduce this segfault on amd64.

diff --git a/git.c b/git.c
index 9469d44..329ebec 100644
--- a/git.c
+++ b/git.c
@@ -122,9 +122,9 @@ static int handle_alias(int *argcp, cons
 			/* insert after command name */
 			if (*argcp > 1) {
 				new_argv = realloc(new_argv, sizeof(char*) *
-						(count + *argcp - 1));
-				memcpy(new_argv + count, *argv, sizeof(char*) *
-						(*argcp - 1));
+						   (count + *argcp));
+				memcpy(new_argv + count, *argv + 1,
+				       sizeof(char*) * *argcp);
 			}
 
 			*argv = new_argv;
