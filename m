From: Junio C Hamano <junkio@cox.net>
Subject: Help cloning over http.
Date: Sat, 17 Sep 2005 01:50:37 -0700
Message-ID: <7vvf10axia.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
	<7vhdckceas.fsf@assigned-by-dhcp.cox.net>
	<7vacicccxl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat Sep 17 10:51:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGYPC-0008LH-Ll
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 10:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVIQIuj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 04:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVIQIuj
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 04:50:39 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19920 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750844AbVIQIuj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2005 04:50:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050917085037.EEKK26890.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Sep 2005 04:50:37 -0400
To: git@vger.kernel.org
In-Reply-To: <7vacicccxl.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 17 Sep 2005 01:32:06 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8761>

Even when repository is packed, the new "we trust only the refs
we already have" code wasted too much time verifying what are
already in packs, walking down to the root commits.  Since we
slurp all the necessary packs upfront and run verify pack on
them, temporarily register their edge commits as "known to be
good" before invoking git-http-fetch.

I am not proud of this workaround -- this would probably break
in a pathological case where the remote repository has packs
that depend on ancient unpacked objects, but people should not
be making such packs anyway (git repack would not create such
packs).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-clone.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

34414e4170ab8d1d2a9ef582256530dc3b42d3e2
diff --git a/git-clone.sh b/git-clone.sh
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -50,11 +50,30 @@ Perhaps git-update-server-info needs to 
 		git-verify-pack ".git/objects/pack/$idx" || exit 1
 	done <"$clone_tmp/packs"
 
+	while read type idx sha1 commit
+	do
+		case "$type,$commit" in
+		T,commit) ;;
+		*) continue ;;
+		esac &&
+		echo "$sha1" >.git/refs/tags/clone-tmp-$sha1
+	done <"$clone_tmp/packs"
+
 	while read sha1 refname
 	do
 		name=`expr "$refname" : 'refs/\(.*\)'` &&
 		git-http-fetch -v -a -w "$name" "$name" "$1/" || exit 1
 	done <"$clone_tmp/refs"
+
+	while read type idx sha1 commit
+	do
+		case "$type,$commit" in
+		T,commit) ;;
+		*) continue ;;
+		esac &&
+		rm -f .git/refs/tags/clone-tmp-$sha1
+	done <"$clone_tmp/packs"
+
 	rm -fr "$clone_tmp"
 }
 
