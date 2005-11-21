From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Mon, 21 Nov 2005 01:28:07 -0800
Message-ID: <7vfypquz88.fsf@assigned-by-dhcp.cox.net>
References: <20051117193714.428785C7FA@nox.op5.se>
	<7voe4ird8v.fsf@assigned-by-dhcp.cox.net> <437DAA66.6070301@op5.se>
	<7voe4hfssj.fsf@assigned-by-dhcp.cox.net> <437E67AC.2010400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 10:30:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee7y8-0005Nm-Ri
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 10:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVKUJ2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 04:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVKUJ2J
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 04:28:09 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58065 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932238AbVKUJ2I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 04:28:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121092657.OZJN17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 04:26:57 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12434>

Andreas Ericsson <ae@op5.se> writes:

> I'll run the clone/fetch/push test-suite again tomorrow, with this 
> applied. It looks good though.

Sorry, but there was a thinko in my butchered version of
enter_repo().  While allowing only absolute path was good for
the version with your daemon.c change, it was not with the
current one that runs upload-pack with "." as repo.  In either
case we _do_ chdir() to it after validating the path, so I am
wondering if it is a good idea to keep sending "." as repo when
executing upload-pack with this patch as well.  This does not
make any practical difference, but I think it makes the intent
clearer -- "we are already there so do not try going anywhere
else".

So I am thinking about applying something like this patch
on top of the last part of your patch.

 - Do validation only on canonicalized paths;
 - Run upload-pack with "." as repo, not full path;
 - allow trailing slash under --strict-paths i.e. "git://host/my/repo.git/"

What do you think?

---

diff --git a/daemon.c b/daemon.c
index ac4c94b..21d8260 100644
--- a/daemon.c
+++ b/daemon.c
@@ -93,22 +93,19 @@ static char *path_ok(char *dir)
 
 	if ( ok_paths && *ok_paths ) {
 		char **pp = NULL;
-		int dirlen = strlen(dir);
 		int pathlen = strlen(path);
 
+		/* The validation is done on the paths after enter_repo
+		 * canonicalization, so whitelist should be written in
+		 * terms of real pathnames (i.e. after ~user is expanded
+		 * and symlinks resolved).
+		 */
 		for ( pp = ok_paths ; *pp ; pp++ ) {
 			int len = strlen(*pp);
-			/* because of symlinks we must match both what the
-			 * user passed and the canonicalized path, otherwise
-			 * the user can send a string matching either a whitelist
-			 * entry or an actual directory exactly and still not
-			 * get through */
 			if (len <= pathlen && !memcmp(*pp, path, len)) {
-				if (path[len] == '\0' || (!strict_paths && path[len] == '/'))
-					return path;
-			}
-			if (len <= dirlen && !memcmp(*pp, dir, len)) {
-				if (dir[len] == '\0' || (!strict_paths && dir[len] == '/'))
+				if (path[len] == '\0' ||
+				    (path[len] == '/' &&
+				     (!strict_paths || path[len+1] == 0)))
 					return path;
 			}
 		}
@@ -160,7 +157,7 @@ static int upload(char *dir)
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
 
 	/* git-upload-pack only ever reads stuff, so this is safe */
-	execlp("git-upload-pack", "git-upload-pack", "--strict", timeout_buf, path, NULL);
+	execlp("git-upload-pack", "git-upload-pack", "--strict", timeout_buf, ".", NULL);
 	return -1;
 }
 


 
