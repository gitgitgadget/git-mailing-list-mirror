From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in master and pu (aka when will 1.0rc4 be out)
Date: Sun, 27 Nov 2005 11:32:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511271106360.13959@g5.osdl.org>
References: <7voe48gqg9.fsf@assigned-by-dhcp.cox.net> <7vek52e4ve.fsf@assigned-by-dhcp.cox.net>
 <20051127151134.0eac7019.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 20:33:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgSGD-0004Na-Jq
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 20:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVK0Tc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 14:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVK0Tc0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 14:32:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11734 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750793AbVK0TcZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 14:32:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jARJW4nO027971
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 27 Nov 2005 11:32:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jARJW3IU031579;
	Sun, 27 Nov 2005 11:32:03 -0800
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20051127151134.0eac7019.tihirvon@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12818>



On Sun, 27 Nov 2005, Timo Hirvonen wrote:
> 
> Hmm.. would something like 
> 
>     git-bisect --include drivers/char/drm/ --include include/ ...
> 
> be easy to implement?  That command would limit bisecting to only the
> commits that have changed files under those two directories.

Heh.

It was surprisingly easy to do.

The syntax is

	git bisect start <pathspec>

followed by all the normal "git bisect good/bad" stuff.

Almost totally untested, and I guarantee that if your pathnames have 
spaces in them (or your GIT_DIR has spaces in it) this won't work. I don't 
know how to fix that, my shell programming isn't good enough.

This involves small changes to make "git-rev-list --bisect" work in the 
presense of a pathspec limiter, and then truly trivial (and that's the 
broken part) changes to make "git bisect" save away and use the pathspec.

I tried one bisection, and a "git bisect visualize", and it all looked 
correct. But hey, don't be surprised if it has problems.

		Linus

---
diff --git a/git-bisect.sh b/git-bisect.sh
index d92993b..2455f00 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -33,7 +33,6 @@ bisect_autostart() {
 }
 
 bisect_start() {
-        case "$#" in 0) ;; *) usage ;; esac
 	#
 	# Verify HEAD. If we were bisecting before this, reset to the
 	# top-of-line master first!
@@ -57,7 +56,8 @@ bisect_start() {
 	rm -f "$GIT_DIR/refs/heads/bisect"
 	rm -rf "$GIT_DIR/refs/bisect/"
 	mkdir "$GIT_DIR/refs/bisect"
-	echo "git-bisect start" >"$GIT_DIR/BISECT_LOG"
+	echo "git-bisect start $@" >"$GIT_DIR/BISECT_LOG"
+	echo "$@" > "$GIT_DIR/BISECT_NAMES"
 }
 
 bisect_bad() {
@@ -121,7 +121,7 @@ bisect_next() {
 	bad=$(git-rev-parse --verify refs/bisect/bad) &&
 	good=$(git-rev-parse --sq --revs-only --not \
 		$(cd "$GIT_DIR" && ls refs/bisect/good-*)) &&
-	rev=$(eval "git-rev-list --bisect $good $bad") || exit
+	rev=$(eval "git-rev-list --bisect $good $bad -- $(cat $GIT_DIR/BISECT_NAMES)") || exit
 	if [ -z "$rev" ]; then
 	    echo "$bad was both good and bad"
 	    exit 1
@@ -131,7 +131,7 @@ bisect_next() {
 	    git-diff-tree --pretty $rev
 	    exit 0
 	fi
-	nr=$(eval "git-rev-list $rev $good" | wc -l) || exit
+	nr=$(eval "git-rev-list $rev $good -- $(cat $GIT_DIR/BISECT_NAMES)" | wc -l) || exit
 	echo "Bisecting: $nr revisions left to test after this"
 	echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
 	git checkout new-bisect || exit
@@ -142,7 +142,7 @@ bisect_next() {
 
 bisect_visualize() {
 	bisect_next_check fail
-	gitk bisect/bad --not `cd "$GIT_DIR/refs" && echo bisect/good-*`
+	gitk bisect/bad --not `cd "$GIT_DIR/refs" && echo bisect/good-*` -- $(cat $GIT_DIR/BISECT_NAMES)
 }
 
 bisect_reset() {
diff --git a/rev-list.c b/rev-list.c
index e17f928..8020d97 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -350,7 +350,8 @@ static int count_distance(struct commit_
 
 		if (commit->object.flags & (UNINTERESTING | COUNTED))
 			break;
-		nr++;
+		if (!paths || (commit->object.flags & TREECHANGE))
+			nr++;
 		commit->object.flags |= COUNTED;
 		p = commit->parents;
 		entry = p;
@@ -362,6 +363,7 @@ static int count_distance(struct commit_
 			}
 		}
 	}
+
 	return nr;
 }
 
@@ -382,15 +384,20 @@ static struct commit_list *find_bisectio
 	nr = 0;
 	p = list;
 	while (p) {
-		nr++;
+		if (!paths || (p->item->object.flags & TREECHANGE))
+			nr++;
 		p = p->next;
 	}
 	closest = 0;
 	best = list;
 
-	p = list;
-	while (p) {
-		int distance = count_distance(p);
+	for (p = list; p; p = p->next) {
+		int distance;
+
+		if (paths && !(p->item->object.flags & TREECHANGE))
+			continue;
+
+		distance = count_distance(p);
 		clear_distance(list);
 		if (nr - distance < distance)
 			distance = nr - distance;
@@ -398,7 +405,6 @@ static struct commit_list *find_bisectio
 			best = p;
 			closest = distance;
 		}
-		p = p->next;
 	}
 	if (best)
 		best->next = NULL;
