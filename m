From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC (git-core)] squelch pack-object eye-candy on non-tty
Date: Fri, 05 May 2006 03:20:44 -0700
Message-ID: <7vmzdwzsar.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 05 12:21:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbxQX-0001YU-8a
	for gcvg-git@gmane.org; Fri, 05 May 2006 12:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWEEKUq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 06:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWEEKUq
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 06:20:46 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:6078 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750938AbWEEKUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 06:20:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505102045.BZIU15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 May 2006 06:20:45 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19608>

One of my post-update scripts runs a git-fetch into a separate
repository and sends the results back to me (2>&1); I end up
getting this in the mail:

    Generating pack...
    Done counting 180 objects.
    Result has 131 objects.
    Deltifying 131 objects.
       0% (0/131) done^M   1% (2/131) done^M...

This defaults not to do the progress report when not on a tty.

You could give --progress to force the progress report, but
let's not bother even documenting it nor mentioning it in the
usage string.

---
diff --git a/pack-objects.c b/pack-objects.c
index 6604338..53caed4 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1239,6 +1239,7 @@ int main(int argc, char **argv)
 
 	setup_git_directory();
 
+	progress = isatty(2);
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -1269,6 +1270,10 @@ int main(int argc, char **argv)
 					usage(pack_usage);
 				continue;
 			}
+			if (!strcmp("--progress", arg)) {
+				progress = 1;
+				continue;
+			}
 			if (!strcmp("-q", arg)) {
 				progress = 0;
 				continue;
