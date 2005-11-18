From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "git fetch" less verbose by default
Date: Fri, 18 Nov 2005 08:31:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511180820130.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Nov 18 17:32:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed99p-0008Qm-1t
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 17:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVKRQcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 11:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVKRQcE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 11:32:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932377AbVKRQcC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 11:32:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAIGVunO016122
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 08:31:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAIGVtoq017756;
	Fri, 18 Nov 2005 08:31:55 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12238>


When doing something like

	git fetch --tags origin

the excessively verbose output of git fetch makes the result totally 
unreadable. It's impossible to tell if it actually fetched anything new or 
not, since the screen will fill up with an endless supply of

   ...
   * committish: 9165ec17fde255a1770886189359897dbb541012
     tag 'v0.99.7c' of master.kernel.org:/pub/scm/git/git
   * refs/tags/v0.99.7c: same as tag 'v0.99.7c' of master.kernel.org:/pub/scm/git/git
   ...

and any new tags that got fetched will be totally hidden.

So add a new "--verbose" flag to "git fetch" to enable this verbose mode, 
but make the default be quiet.

NOTE! The quiet mode will still report about new or changed heads, so if 
you are really fetching a new head, you'll see something like this:

   [torvalds@g5 git]$ git fetch --tags parent
   Packing 6 objects
   Unpacking 6 objects
    100% (6/6) done
   * refs/tags/v1.0rc2: storing tag 'v1.0rc2' of master.kernel.org:/pub/scm/git/git
   * refs/tags/v1.0rc3: storing tag 'v1.0rc3' of master.kernel.org:/pub/scm/git/git
   * refs/tags/v1.0rc1: storing tag 'v1.0rc1' of master.kernel.org:/pub/scm/git/git

which actually tells you something useful that isn't hidden by all the 
useless crud that you already had.

Extensively tested (hey, for me, this _is_ extensive) by doing a

   rm .git/refs/tags/v1.0rc*

and re-fetching with both --verbose and without. 

NOTE! This means that if the fetch didn't actually fetch anything at all, 
git fetch will be totally quiet. I think that's much better than being so 
verbose that you can't even tell whether something was fetched or not, but 
some people might prefer to get a "nothing to fetch" message in that case.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-fetch.sh b/git-fetch.sh
index 8564cbf..6586e77 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -12,6 +12,7 @@ IFS="$LF"
 tags=
 append=
 force=
+verbose=
 update_head_ok=
 while case "$#" in 0) break ;; esac
 do
@@ -30,6 +31,9 @@ do
 	--update-head-o|--update-head-ok)
 		update_head_ok=t
 		;;
+	-v|--verbose)
+		verbose=Yes
+		;;
 	*)
 		break
 		;;
@@ -91,12 +95,12 @@ append_fetch_head () {
     then
 	headc_=$(git-rev-parse --verify "$head_^0") || exit
 	echo "$headc_	$not_for_merge_	$note_" >>"$GIT_DIR/FETCH_HEAD"
-	echo >&2 "* committish: $head_"
-	echo >&2 "  $note_"
+	[ "$verbose" ] && echo >&2 "* committish: $head_"
+	[ "$verbose" ] && echo >&2 "  $note_"
     else
 	echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
-	echo >&2 "* non-commit: $head_"
-	echo >&2 "  $note_"
+	[ "$verbose" ] && echo >&2 "* non-commit: $head_"
+	[ "$verbose" ] && echo >&2 "  $note_"
     fi
     if test "$local_name_" != ""
     then
@@ -116,7 +120,7 @@ fast_forward_local () {
 	then
 		if now_=$(cat "$GIT_DIR/$1") && test "$now_" = "$2"
 		then
-			echo >&2 "* $1: same as $3"
+			[ "$verbose" ] && echo >&2 "* $1: same as $3"
 		else
 			echo >&2 "* $1: updating with $3"
 		fi
