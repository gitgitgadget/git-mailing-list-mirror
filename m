From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] ls-files --others --directory: fix a bug with index entry ordering
Date: Sat, 07 Jan 2006 14:32:09 -0800
Message-ID: <7vmzi7acuu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 07 23:32:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvMbh-0000gx-T5
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 23:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbWAGWcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 17:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbWAGWcM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 17:32:12 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:36517 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752590AbWAGWcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 17:32:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107223216.KUGG25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 17:32:16 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14283>

When both howto-index.sh and howto/make-dist.txt exist under
Documentation/ directory, dir_exists() mistakenly checked it
without the trailing slash to see if there was something under
Documentation/howto directory, and did not realize there was,
because '-' sorts earlier than '/' and cache_name_pos() finds
howto-index.sh, which is not under howto/ directory.  This
caused --others --directory to show it which was incorrect.

Check the directory name with the trailing slash, because having
an entry that has such as a prefix is what we are looking for.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 ls-files.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

598164857b48f251c627b6b7ce7bf91cad21a779
diff --git a/ls-files.c b/ls-files.c
index 841c98a..cc5b32e 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -240,11 +240,9 @@ static int dir_exists(const char *dirnam
 	if (pos >= 0)
 		return 1;
 	pos = -pos-1;
-	if (pos >= active_nr)
+	if (pos >= active_nr) /* can't */
 		return 0;
-	if (strncmp(active_cache[pos]->name, dirname, len))
-		return 0;
-	return active_cache[pos]->name[len] == '/';
+	return !strncmp(active_cache[pos]->name, dirname, len);
 }
 
 /*
@@ -294,11 +292,10 @@ static void read_directory(const char *p
 					continue;
 				/* fallthrough */
 			case DT_DIR:
-				if (show_other_directories) {
-					if (!dir_exists(fullname, baselen + len))
-						break;
-				}
 				memcpy(fullname + baselen + len, "/", 2);
+				if (show_other_directories &&
+				    !dir_exists(fullname, baselen + len + 1))
+					break;
 				read_directory(fullname, fullname,
 					       baselen + len + 1);
 				continue;
-- 
1.0.7-g0263
