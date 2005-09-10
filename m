From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect failure
Date: Sat, 10 Sep 2005 14:32:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509101428490.30958@g5.osdl.org>
References: <20050909011034.12f2bf64.akpm@osdl.org> <7virx9ir3a.fsf@assigned-by-dhcp.cox.net>
 <20050910022638.20832803.akpm@osdl.org> <Pine.LNX.4.58.0509101202070.30958@g5.osdl.org>
 <20050910141343.578649c7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 23:33:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EECxN-0000GP-2m
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 23:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVIJVcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 17:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVIJVcO
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 17:32:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932287AbVIJVcN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Sep 2005 17:32:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8ALW9Bo000381
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Sep 2005 14:32:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8ALW8xD002870;
	Sat, 10 Sep 2005 14:32:08 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050910141343.578649c7.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8262>



On Sat, 10 Sep 2005, Andrew Morton wrote:
> 
> Yup.  Simply keeping a little log file would suffice.

This is a _very_ cheesy and untested patch.

Oh, btw, it also fixes "git bisect reset" - we used to remove the file 
"refs/reads/bisect", not "refs/heads/bisect". 

Cheesy, cheesy, cheesy,

		Linus "not proud" Torvalds

---
Subject: Keep bisect event log

This keeps an event log in refs/bisect/log, which tracks what bisections 
have been done. We could eventually have a "git bisect replay" or 
somethign similar that actually uses it - for now we just have a command 
to show the log: "git bisect log".

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-bisect.sh b/git-bisect.sh
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -8,7 +8,8 @@ git bisect bad [<rev>]		mark <rev> a kno
 git bisect good [<rev>...]	mark <rev>... known-good revisions.
 git bisect next			find next bisection to test and check it out.
 git bisect reset [<branch>]	finish bisection search and go back to branch.
-git bisect visualize            show bisect status in gitk.'
+git bisect visualize            show bisect status in gitk.
+git bisect log                  show bisect log.'
     exit 1
 }
 
@@ -67,6 +68,7 @@ bisect_bad() {
 		usage ;;
 	esac || exit
 	echo "$rev" > "$GIT_DIR/refs/bisect/bad"
+	echo "bad $rev" >> "$GIT_DIR/refs/bisect/log"
 	bisect_auto_next
 }
 
@@ -81,6 +83,7 @@ bisect_good() {
 	do
 		rev=$(git-rev-parse --verify "$rev") || exit
 		echo "$rev" >"$GIT_DIR/refs/bisect/good-$rev"
+		echo "good $rev" >> "$GIT_DIR/refs/bisect/log"
 	done
 	bisect_auto_next
 }
@@ -149,7 +152,11 @@ bisect_reset() {
 	esac
 	git checkout "$branch" &&
 	rm -fr "$GIT_DIR/refs/bisect"
-	rm -f "$GIT_DIR/refs/reads/bisect"
+	rm -f "$GIT_DIR/refs/heads/bisect"
+}
+
+bisect_log() {
+	cat "$GIT_DIR/refs/bisect/log"
 }
 
 case "$#" in
@@ -172,6 +179,8 @@ case "$#" in
 	bisect_visualize "$@" ;;
     reset)
         bisect_reset "$@" ;;
+    log)
+        bisect_log "$@" ;;
     *)
         usage ;;
     esac
