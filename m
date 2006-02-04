From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] daemon: Support a --user-path option.
Date: Sat, 04 Feb 2006 00:50:04 -0800
Message-ID: <7v8xsr33ur.fsf@assigned-by-dhcp.cox.net>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
	<20060203202706.1895.70864.stgit@metalzone.distorted.org.uk>
	<7vr76kcggx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 09:50:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5J7T-0005cu-Se
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 09:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWBDIuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 03:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWBDIuH
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 03:50:07 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:52918 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750942AbWBDIuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 03:50:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204084706.NGZJ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 03:47:06 -0500
To: Mark Wooding <mdw@distorted.org.uk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15580>

Junio C Hamano <junkio@cox.net> writes:

> Wouldn't loosening the "request must be absolute if you use
> --base-path" check in the area your first patch in the series
> touches to also allow paths that start with a '~' be enough?

That is, something like this is what I mean.

Tested, of course ;-).

diff --git a/daemon.c b/daemon.c
index 532bb0c..324bb04 100644
--- a/daemon.c
+++ b/daemon.c
@@ -145,13 +145,17 @@ static char *path_ok(char *dir)
 
 	if (base_path) {
 		static char rpath[PATH_MAX];
-		if (*dir != '/') {
-			/* Forbid possible base-path evasion using ~paths. */
+		if (!strict_paths && *dir == '~')
+			; /* allow user relative paths */
+		else if (*dir != '/') {
+			/* otherwise allow only absolute */
 			logerror("'%s': Non-absolute path denied (base-path active)", dir);
 			return NULL;
 		}
-		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
-		dir = rpath;
+		else {
+			snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
+			dir = rpath;
+		}
 	}
 
 	path = enter_repo(dir, strict_paths);
