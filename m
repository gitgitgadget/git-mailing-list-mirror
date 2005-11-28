From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] bisect: quote pathnames for eval safety.
Date: Sun, 27 Nov 2005 17:51:23 -0800
Message-ID: <7vmzjp35gk.fsf_-_@assigned-by-dhcp.cox.net>
References: <7voe48gqg9.fsf@assigned-by-dhcp.cox.net>
	<7vek52e4ve.fsf@assigned-by-dhcp.cox.net>
	<20051127151134.0eac7019.tihirvon@gmail.com>
	<Pine.LNX.4.64.0511271106360.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 02:51:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgYAy-0007dE-Mq
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 02:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVK1Bv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 20:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVK1Bv0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 20:51:26 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:63643 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751216AbVK1BvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 20:51:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128015126.TQBD25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 20:51:26 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511271106360.13959@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 27 Nov 2005 11:32:03 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12845>

Linus Torvalds <torvalds@osdl.org> writes:

> Almost totally untested, and I guarantee that if your pathnames have 
> spaces in them (or your GIT_DIR has spaces in it) this won't work. I don't 
> know how to fix that, my shell programming isn't good enough.

Like this?  I've placed the bisect patch with this in the
proposed updates.

---

 git-bisect.sh |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

applies-to: 7da44ab45773e0a424c1e08c838c1f6deeb6ceb2
82c8f5bed2ae61f1f368cfca84f6b0194b1ad208
diff --git a/git-bisect.sh b/git-bisect.sh
index 2455f00..d4196f9 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,9 +1,16 @@
 #!/bin/sh
 . git-sh-setup
 
+sq() {
+    for x
+    do
+	echo "$x" | sed -e "s/'/'\\\\''/g" -e "s/^/'/" -e "s/\$/'/"
+    done
+}
+
 usage() {
     echo >&2 'usage: git bisect [start|bad|good|next|reset|visualize]
-git bisect start		reset bisect state and start bisection.
+git bisect start [<pathspec>]	reset bisect state and start bisection.
 git bisect bad [<rev>]		mark <rev> a known-bad revision.
 git bisect good [<rev>...]	mark <rev>... known-good revisions.
 git bisect next			find next bisection to test and check it out.
@@ -56,8 +63,8 @@ bisect_start() {
 	rm -f "$GIT_DIR/refs/heads/bisect"
 	rm -rf "$GIT_DIR/refs/bisect/"
 	mkdir "$GIT_DIR/refs/bisect"
-	echo "git-bisect start $@" >"$GIT_DIR/BISECT_LOG"
-	echo "$@" > "$GIT_DIR/BISECT_NAMES"
+	sq git-bisect start "$@" >"$GIT_DIR/BISECT_LOG"
+	sq "$@" >"$GIT_DIR/BISECT_NAMES"
 }
 
 bisect_bad() {
@@ -142,7 +149,8 @@ bisect_next() {
 
 bisect_visualize() {
 	bisect_next_check fail
-	gitk bisect/bad --not `cd "$GIT_DIR/refs" && echo bisect/good-*` -- $(cat $GIT_DIR/BISECT_NAMES)
+	not=`cd "$GIT_DIR/refs" && echo bisect/good-*`
+	eval gitk bisect/bad --not $not -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
 bisect_reset() {
---
0.99.9.GIT
