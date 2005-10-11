From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-fetch --tags: deal with tags with spaces in them.
Date: Mon, 10 Oct 2005 22:07:14 -0700
Message-ID: <7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
	<4349ED5D.6020703@catalyst.net.nz>
	<7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
	<7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 07:08:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPCMG-0006TR-Sv
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 07:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVJKFHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 01:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVJKFHW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 01:07:22 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41653 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751320AbVJKFHV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 01:07:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051011050711.CZCM4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Oct 2005 01:07:11 -0400
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
In-Reply-To: <7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 10 Oct 2005 21:29:20 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9953>

"git-fetch --tags" can get confused with tags with spaces in their names,
it used to use shell IFS to split the list of tags and also used curl
which insists the URL to be escaped.  Fix it so it can work with Martin's
moodle repository http://locke.catalyst.net.nz/git/moodle.git/.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

    Junio C Hamano <junkio@cox.net> writes:

    >   But in general, we should avoid spaces in reference names.
    >   Scripts have problem with them.  For example, "git-fetch
    >   --tags" currently cannot handle it.  If people cared deeply
    >   enough maybe they can rewrite parts of it in Perl and send me
    >   a patch ;-).

    And as usual, I end up being "people", but I did not use
    Perl ;-).  Only lightly tested but it should fetch tags from
    your repository.  I did not want to keep slurping those 70MB
    and 16MB packs, so I cheated by creating a small repository
    with funky tag names locally while testing.

 git-fetch.sh |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

applies-to: 5db8c58bc7403c7b076dea420133e6e890835e1a
c1a4b1dd71e23d877dfbf04a2ac8b1c238fc5eb4
diff --git a/git-fetch.sh b/git-fetch.sh
index d398866..b3f3782 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -5,6 +5,10 @@
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
+LF='
+'
+IFS="$LF"
+
 tags=
 append=
 force=
@@ -170,11 +174,14 @@ esac
 reflist=$(get_remote_refs_for_fetch "$@")
 if test "$tags"
 then
-	taglist=$(git-ls-remote --tags "$remote" | awk '{ print "."$2":"$2 }')
+	taglist=$(git-ls-remote --tags "$remote" |
+		sed -e '
+			s/^[^	]*	//
+			s/.*/&:&/')
 	if test "$#" -gt 1
 	then
 		# remote URL plus explicit refspecs; we need to merge them.
-		reflist="$reflist $taglist"
+		reflist="$reflist$LF$taglist"
 	else
 		# No explicit refspecs; fetch tags only.
 		reflist=$taglist
@@ -183,7 +190,7 @@ fi
 
 for ref in $reflist
 do
-    refs="$refs $ref"
+    refs="$refs$LF$ref"
 
     # These are relative path from $GIT_DIR, typically starting at refs/
     # but may be HEAD
@@ -204,7 +211,7 @@ do
     remote_name=$(expr "$ref" : '\([^:]*\):')
     local_name=$(expr "$ref" : '[^:]*:\(.*\)')
 
-    rref="$rref $remote_name"
+    rref="$rref$LF$remote_name"
 
     # There are transports that can fetch only one head at a time...
     case "$remote" in
@@ -212,11 +219,9 @@ do
 	if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 	    curl_extra_args="-k"
 	fi
-	head=$(curl -nsf $curl_extra_args "$remote/$remote_name") &&
-	expr "$head" : "$_x40\$" >/dev/null ||
-		die "Failed to fetch $remote_name from $remote"
 	echo >&2 Fetching "$remote_name from $remote" using http
-	git-http-fetch -v -a "$head" "$remote/" || exit
+	ref_name=`expr "$remote_name" : 'refs/\(.*\)'`
+	git-http-fetch -v -a "$ref_name" "$remote/" || exit
 	;;
     rsync://*)
 	TMP_HEAD="$GIT_DIR/TMP_HEAD"
---
0.99.8.GIT
