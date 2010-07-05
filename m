From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] guilt: Make sure the commit time is increasing
Date: Sun,  4 Jul 2010 22:23:59 -0400
Message-ID: <1278296639-25024-1-git-send-email-tytso@mit.edu>
Cc: Git Mailing List <git@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Mon Jul 05 04:24:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVbM7-000688-FH
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 04:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab0GECYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 22:24:07 -0400
Received: from THUNK.ORG ([69.25.196.29]:38315 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494Ab0GECYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 22:24:05 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OVbLk-0000gr-QM; Sun, 04 Jul 2010 22:24:00 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OVbLj-0006W8-9v; Sun, 04 Jul 2010 22:23:59 -0400
X-Mailer: git-send-email 1.7.0.4
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150236>

Git has various algorithms, most notably in git rev-list, git
name-rev, and others, which depend on the commit time increasing.  We
want to keep the commit time the same as much as possible, but if
necessary, adjust the time stamps of the patch files to obey this
constraint.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 guilt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/guilt b/guilt
index b6e2a6c..2371e98 100755
--- a/guilt
+++ b/guilt
@@ -535,6 +535,13 @@ commit()
                         export GIT_AUTHOR_EMAIL="`echo $author_str | sed -e 's/[^<]*//'`"
 		fi
 
+		ct=$(git log -1 --pretty=%ct)
+		if [ $ct -gt $(stat -c %Y "$p") ]; then
+		    echo "Warning time went backwards, adjusting mod time of" \
+			$(basename "$p")
+		    touch -d @$(expr $ct + 60) "$p" || touch "$p"
+		fi
+
 		# must strip nano-second part otherwise git gets very
 		# confused, and makes up strange timestamps from the past
 		# (chances are it decides to interpret it as a unix
-- 
1.7.0.4
