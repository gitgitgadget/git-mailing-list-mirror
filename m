From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] compat/setenv: do not free what we fed putenv(3).
Date: Sun, 04 Dec 2005 15:01:52 -0800
Message-ID: <7vlkz0eaan.fsf@assigned-by-dhcp.cox.net>
References: <28409.1133564908@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 05 00:03:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej2sH-0006Xa-Gz
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 00:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVLDXB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 18:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVLDXBz
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 18:01:55 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:44989 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932368AbVLDXBy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 18:01:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051204230155.BELP25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Dec 2005 18:01:55 -0500
To: git@vger.kernel.org
In-Reply-To: <28409.1133564908@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Fri, 02 Dec 2005 15:08:28 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13195>


Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 compat/setenv.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

3a2674337c12e958f8c697af991a0ef6c06ddd4d
diff --git a/compat/setenv.c b/compat/setenv.c
index 94acd2d..b7d7678 100644
--- a/compat/setenv.c
+++ b/compat/setenv.c
@@ -16,7 +16,7 @@ int gitsetenv(const char *name, const ch
 
 	namelen = strlen(name);
 	valuelen = strlen(value);
-	envstr = malloc((namelen + valuelen + 2) * sizeof(char));
+	envstr = malloc((namelen + valuelen + 2));
 	if (!envstr) return -1;
 
 	memcpy(envstr, name, namelen);
@@ -25,7 +25,11 @@ int gitsetenv(const char *name, const ch
 	envstr[namelen + valuelen + 1] = 0;
 
 	out = putenv(envstr);
+	/* putenv(3) makes the argument string part of the environment,
+	 * and changing that string modifies the environment --- which
+	 * means we do not own that storage anymore.  Do not free
+	 * envstr.
+	 */
 
-	free(envstr);
 	return out;
 }
-- 
0.99.9.GIT
