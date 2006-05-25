From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ls-remote fix for rsync:// transport
Date: Wed, 24 May 2006 21:22:17 -0700
Message-ID: <7v7j4a3f9i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 25 06:22:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj7Mc-0003fm-EB
	for gcvg-git@gmane.org; Thu, 25 May 2006 06:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWEYEWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 00:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWEYEWS
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 00:22:18 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:63735 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964978AbWEYEWS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 00:22:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525042217.YIXY5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 00:22:17 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20722>

I think this would fix the "cloning rsync:// clones repository fine but
does not check out the working tree" problem.

---
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index b6882a9..6b21879 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -58,7 +58,8 @@ http://* | https://* )
 	;;
 
 rsync://* )
-	mkdir $tmpdir
+	mkdir $tmpdir &&
+	rsync -rlq "$peek_repo/HEAD" $tmpdir &&
 	rsync -rq "$peek_repo/refs" $tmpdir || {
 		echo "failed	slurping"
 		exit
@@ -69,6 +70,13 @@ rsync://* )
 		cat "$tmpdir/$path" | tr -d '\012'
 		echo "	$path"
 	done &&
+	head=$(cat "$tmpdir/HEAD") &&
+	case "$head" in
+	ref:' '*)
+		head=$(expr "z$head" : 'zref: \(.*\)') &&
+		head=$(cat "$tmpdir/$head") || exit
+	esac &&
+	echo "$head	HEAD" 
 	rm -fr $tmpdir
 	;;
 
