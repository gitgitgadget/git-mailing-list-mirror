From: Junio C Hamano <junkio@cox.net>
Subject: Re: HEAD branch duplicated in remotes/origin
Date: Thu, 08 Jun 2006 01:17:01 -0700
Message-ID: <7vverc9i4i.fsf@assigned-by-dhcp.cox.net>
References: <20060608073857.GA5072@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 10:17:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoFha-0008BJ-5l
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 10:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWFHIRE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 04:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWFHIRE
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 04:17:04 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61350 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932547AbWFHIRC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 04:17:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060608081702.QXMN12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Jun 2006 04:17:02 -0400
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060608073857.GA5072@informatik.uni-freiburg.de> (Uwe
	Zeisberger's message of "Thu, 8 Jun 2006 09:38:57 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21475>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> when cloning with --use-separate-remote, $GITDIR/remotes/origin contains
> two references to refs/heads/master.

Thanks for noticing.

Very lightly tested but I think this should fix it.
-- >8 --
git-clone: fix duplicated "master" in $GIT_DIR/remotes/origin

Under --use-separate-remote we ended up duplicating the branch
remote HEAD pointed at in $GIT_DIR/remotes/origin file.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-clone.sh b/git-clone.sh
index de59904..64318b4 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -391,11 +391,16 @@ Pull: refs/heads/$head_points_at:$origin
 		(cd "$GIT_DIR/$remote_top" && find . -type f -print) |
 		while read dotslref
 		do
-			name=`expr "$dotslref" : './\(.*\)'` &&
-			test "$use_separate_remote" = '' && {
-				test "$head_points_at" = "$name" ||
-				test "$origin" = "$name"
-			} ||
+			name=`expr "$dotslref" : './\(.*\)'`
+			if test "z$head_points_at" = "z$name"
+			then
+				continue
+			fi
+			if test "$use_separate_remote" = '' &&
+			   test "z$origin" = "z$name"
+			then
+				continue
+			fi
 			echo "Pull: refs/heads/${name}:$remote_top/${name}"
 		done >>"$GIT_DIR/remotes/$origin" &&
 		case "$use_separate_remote" in
