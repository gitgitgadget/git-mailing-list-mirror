From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH - maint review] name-rev: do not omit leading components of ref name.
Date: Wed, 11 Jan 2006 16:04:59 -0800
Message-ID: <7vzmm2jopg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 12 01:05:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewpy6-0002Bo-TS
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWALAFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWALAFF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:05:05 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38056 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751224AbWALAFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:05:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112000309.IPNK17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 19:03:09 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14529>

In a repository with mainto/1.0 (to keep maintaining the 1.0.X
series) and fixo/1.0 (to keep fixes that apply to both 1.0.X
series and upwards) branches, "git-name-rev mainto/1.0" answered
just "1.0" making things ambiguous.  Show refnames unambiguously
like show-branch does.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * For 1.0.10 and 1.1.2

 name-rev.c            |    7 ++++---
 t/t6010-merge-base.sh |    6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

2c817df25d54b557d6cac0800cacfd0a255cd56d
diff --git a/name-rev.c b/name-rev.c
index 65333d4..bbadb91 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -93,10 +93,11 @@ static int name_ref(const char *path, co
 	}
 	if (o && o->type == commit_type) {
 		struct commit *commit = (struct commit *)o;
-		const char *p;
 
-		while ((p = strchr(path, '/')))
-			path = p+1;
+		if (!strncmp(path, "refs/heads/", 11))
+			path = path + 11;
+		else if (!strncmp(path, "refs/", 5))
+			path = path + 5;
 
 		name_rev(commit, strdup(path), 0, 0, deref);
 	}
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index c3a9680..1dce123 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -46,14 +46,14 @@ H=$(doit 8 H $A $F)
 
 test_expect_success 'compute merge-base (single)' \
     'MB=$(git-merge-base G H) &&
-     expr "$(git-name-rev "$MB")" : "[0-9a-f]* B"'
+     expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
 
 test_expect_success 'compute merge-base (all)' \
     'MB=$(git-merge-base --all G H) &&
-     expr "$(git-name-rev "$MB")" : "[0-9a-f]* B"'
+     expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
 
 test_expect_success 'compute merge-base with show-branch' \
     'MB=$(git-show-branch --merge-base G H) &&
-     expr "$(git-name-rev "$MB")" : "[0-9a-f]* B"'
+     expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
 
 test_done
-- 
1.1.1-g8ecb
