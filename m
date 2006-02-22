From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-fetch: follow tag only when tracking remote branch.
Date: Wed, 22 Feb 2006 13:12:06 -0800
Message-ID: <7vfymbm72x.fsf_-_@assigned-by-dhcp.cox.net>
References: <43FB6C42.5000208@gorzow.mm.pl>
	<BAYC1-PASMTP03A58A4F389365AC85DA68AEFC0@CEZ.ICE>
	<Pine.LNX.4.64.0602211635450.30245@g5.osdl.org>
	<20060222011338.GL5000@delft.aura.cs.cmu.edu>
	<7v3bicupgb.fsf@assigned-by-dhcp.cox.net>
	<20060222031136.GN5000@delft.aura.cs.cmu.edu>
	<7vacckt6vr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jan Harkes <jaharkes@cs.cmu.edu>
X-From: git-owner@vger.kernel.org Wed Feb 22 22:12:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC1HT-0007GL-9b
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 22:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWBVVMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 16:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWBVVMK
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 16:12:10 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:28636 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751457AbWBVVMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 16:12:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222211213.AJP25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 16:12:13 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vacckt6vr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 21 Feb 2006 19:22:16 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16615>

Unless --no-tags flag was given, git-fetch tried to always
follow remote tags that point at the commits we picked up.

It is not very useful to pick up tags from remote unless storing
the fetched branch head in a local tracking branch.  This is
especially true if the fetch is done to merge the remote branch
into our current branch as one-shot basis (i.e. "please pull"),
and is even harmful if the remote repository has many irrelevant
tags.

This proposed update disables the automated tag following unless
we are storing the a fetched branch head in a local tracking
branch.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Likes, dislikes?

 git-fetch.sh |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

f41b73b4c2e0313d1638261ed87f0921e47904b2
diff --git a/git-fetch.sh b/git-fetch.sh
index b4325d9..fcc24f8 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -368,20 +368,25 @@ fetch_main "$reflist"
 # automated tag following
 case "$no_tags$tags" in
 '')
-	taglist=$(IFS=" " &&
-	git-ls-remote $upload_pack --tags "$remote" |
-	sed -ne 's|^\([0-9a-f]*\)[ 	]\(refs/tags/.*\)^{}$|\1 \2|p' |
-	while read sha1 name
-	do
-		test -f "$GIT_DIR/$name" && continue
-	  	git-check-ref-format "$name" || {
-			echo >&2 "warning: tag ${name} ignored"
-			continue
-		}
-		git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
-		echo >&2 "Auto-following $name"
-		echo ".${name}:${name}"
-	done)
+	case "$reflist" in
+	*:refs/*)
+		# effective only when we are following remote branch
+		# using local tracking branch.
+		taglist=$(IFS=" " &&
+		git-ls-remote $upload_pack --tags "$remote" |
+		sed -ne 's|^\([0-9a-f]*\)[ 	]\(refs/tags/.*\)^{}$|\1 \2|p' |
+		while read sha1 name
+		do
+			test -f "$GIT_DIR/$name" && continue
+			git-check-ref-format "$name" || {
+				echo >&2 "warning: tag ${name} ignored"
+				continue
+			}
+			git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
+			echo >&2 "Auto-following $name"
+			echo ".${name}:${name}"
+		done)
+	esac
 	case "$taglist" in
 	'') ;;
 	?*)
-- 
1.2.2.ga35e
