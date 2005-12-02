From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] merge-one-file: make sure we create the merged file.
Date: Fri, 02 Dec 2005 01:14:46 -0800
Message-ID: <7v3blb97y1.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
	<7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
	<Pine.LNX.4.64.0511292031280.3099@g5.osdl.org>
	<7vslte1y5z.fsf@assigned-by-dhcp.cox.net>
	<7v8xv39a8z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 02 10:14:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei70H-0004Fk-UP
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 10:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbVLBJOs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 04:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbVLBJOs
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 04:14:48 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:8660 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751759AbVLBJOs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 04:14:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202091335.DEKK17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Dec 2005 04:13:35 -0500
To: git@vger.kernel.org
In-Reply-To: <7v8xv39a8z.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 02 Dec 2005 00:25:00 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13107>

The "update-index followed by checkout-index" chain served two
purposes -- to collapse the index to "our" version, and make
sure that file exists in the working tree.  In the recent update
to leave the index unmerged on conflicting path, we wanted to
stop doing the former, but we still need to do the latter (we
allow merging to work in an un-checked-out working tree).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-merge-one-file.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

7afd8d297cd0c24e51188181769b56e0fb0f4171
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 9a049f4..906098d 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -79,7 +79,13 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
-	merge "$4" "$orig" "$src2"
+	# Create the working tree file, with the correct permission bits.
+	# we can not rely on the fact that our tree has the path, because
+	# we allow the merge to be done in an unchecked-out working tree.
+	rm -f "$4" &&
+		git-cat-file blob "$2" >"$4" &&
+		case "$6" in *7??) chmod +x "$4" ;; esac &&
+		merge "$4" "$orig" "$src2"
 	ret=$?
 	rm -f -- "$orig" "$src2"
 
-- 
0.99.9.GIT
