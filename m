From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] merge-one-file: remove empty directories
Date: Sat, 19 Nov 2005 20:14:37 -0800
Message-ID: <7v4q683qhe.fsf@assigned-by-dhcp.cox.net>
References: <17279.1674.22992.607091@cargo.ozlabs.ibm.com>
	<20051119140736.GA24901@lst.de>
	<Pine.LNX.4.64.0511190957320.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@ozlabs.org, Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sun Nov 20 05:14:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdgbD-0007qM-8v
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 05:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVKTEOl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 23:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVKTEOk
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 23:14:40 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:56051 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751198AbVKTEOk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 23:14:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051120041440.METV25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Nov 2005 23:14:40 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12369>

When the last file in a directory is removed as the result of a
merge, try to rmdir the now-empty directory.

[jc: We probably could use "rmdir -p", but for now we do that by
hand for portability.]

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
    Linus Torvalds <torvalds@osdl.org> writes:

    > [ Junio, Fredrik, you're cc'd because the "merge-one-file" logic doesn't 
    >   clean up empty directories after removing a file in merge ]

    Here is the one for merge-one-file that is used by 'git pull
    -s resolve'.  Next patch will be the merge-recursive one.

 git-merge-one-file.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

applies-to: fbe4060a1b8ba894be5767ffc27402f94f356882
397c76697f898e0341699fba8ef783f3342329c7
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index b08597d..b285990 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -25,7 +25,12 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo "Removing $4"
 	fi
 	if test -f "$4"; then
-		rm -f -- "$4"
+		rm -f -- "$4" &&
+		dn="$4" &&
+		while dn=$(expr "$dn" : '\(.*\)/') && rmdir "$dn" 2>/dev/null
+		do
+			:;
+		done
 	fi &&
 		exec git-update-index --remove -- "$4"
 	;;
---
0.99.9.GIT
