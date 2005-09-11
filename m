From: Greg Louis <glouis@dynamicro.ca>
Subject: [PATCH] Redirect cd output to /dev/null, was: git-clone seems dead
Date: Sun, 11 Sep 2005 19:01:36 -0400
Organization: Dynamicro Consulting Limited
Message-ID: <20050911230136.GA15224@athame.dynamicro.on.ca>
References: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk> <7vd5nfs9y0.fsf@assigned-by-dhcp.cox.net> <20050911220421.GA14593@athame.dynamicro.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Mon Sep 12 01:02:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEapT-0003Ie-GN
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 01:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVIKXBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 19:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVIKXBk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 19:01:40 -0400
Received: from csl2r.consultronics.on.ca ([204.138.93.16]:38120 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S1751072AbVIKXBk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 19:01:40 -0400
Received: from [70.29.36.34] (helo=athame.dynamicro.internal ident=glouis)
	by csl2.consultronics.on.ca with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.52)
	id 1EEapN-0007gx-2g
	for git@vger.kernel.org; Sun, 11 Sep 2005 19:01:37 -0400
Received: from root by athame.dynamicro.internal with local (Exim 4.52)
	id 1EEapM-00040U-GO
	for git@vger.kernel.org; Sun, 11 Sep 2005 19:01:36 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050911220421.GA14593@athame.dynamicro.on.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8337>

Redirect cd output to /dev/null

If someone has the CDPATH environment variable set, bash echoes the
full destination path on stdout when cd is invoked with a relative
target.  This breaks code that uses the output of, for example,
$(cd somewhere && ... && pwd).  Adding &>/dev/null to the cd
command corrects the breakage in a portable way.

Signed-off-by: Greg Louis <glouis@dynamicro.ca>

---
On 20050911 (Sun) at 1804:21 -0400, Greg Louis wrote:

> I have a patch to add
> &>/dev/null in what I think are all the right places, if you want it,
> but it may be easiest just to unset CDPATH and see if that fixes the
> trouble.

Hunk 2 of the patch to git-clone.sh fixes the problem described by the
originator of this thread (at least it does for me).

 git-bisect.sh    |    7 ++++---
 git-clone.sh     |    6 +++---
 git-ls-remote.sh |    2 +-
 git-repack.sh    |    2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

018c87b5f7e7af2ca792c3000ce3f91a02108981
diff --git a/git-bisect.sh b/git-bisect.sh
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -88,7 +88,7 @@ bisect_good() {
 bisect_next_check() {
 	next_ok=no
         test -f "$GIT_DIR/refs/bisect/bad" &&
-	case "$(cd "$GIT_DIR" && echo refs/bisect/good-*)" in
+	case "$(cd "$GIT_DIR" &>/dev/null && echo refs/bisect/good-*)" in
 	refs/bisect/good-\*) ;;
 	*) next_ok=yes ;;
 	esac
@@ -112,7 +112,7 @@ bisect_next() {
 	bisect_next_check fail
 	bad=$(git-rev-parse --verify refs/bisect/bad) &&
 	good=$(git-rev-parse --sq --revs-only --not \
-		$(cd "$GIT_DIR" && ls refs/bisect/good-*)) &&
+		$(cd "$GIT_DIR" &>/dev/null  && ls refs/bisect/good-*)) &&
 	rev=$(eval "git-rev-list --bisect $good $bad") || exit
 	if [ -z "$rev" ]; then
 	    echo "$bad was both good and bad"
@@ -133,7 +133,8 @@ bisect_next() {
 
 bisect_visualize() {
 	bisect_next_check fail
-	gitk bisect/bad --not `cd "$GIT_DIR/refs" && echo bisect/good-*`
+	gitk bisect/bad --not `cd "$GIT_DIR/refs &>/dev/null" && \
+		echo bisect/good-*`
 }
 
 bisect_reset() {
diff --git a/git-clone.sh b/git-clone.sh
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -11,7 +11,7 @@ usage() {
 }
 
 get_repo_base() {
-	(cd "$1" && (cd .git ; pwd)) 2> /dev/null
+	(cd "$1" &>/dev/null && (cd .git &>/dev/null ; pwd)) 2> /dev/null
 }
 
 if [ -n "$GIT_SSL_NO_VERIFY" ]; then
@@ -89,7 +89,7 @@ fi
 dir="$2"
 mkdir "$dir" &&
 D=$(
-	(cd "$dir" && git-init-db && pwd)
+	(cd "$dir" &>/dev/null && git-init-db && pwd)
 ) &&
 test -d "$D" || usage
 
@@ -104,7 +104,7 @@ yes,yes)
 	case "$local_shared" in
 	no)
 	    # See if we can hardlink and drop "l" if not.
-	    sample_file=$(cd "$repo" && \
+	    sample_file=$(cd "$repo" &>/dev/null && \
 			  find objects -type f -print | sed -e 1q)
 
 	    # objects directory should not be empty since we are cloning!
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -48,7 +48,7 @@ http://* | https://* )
 rsync://* )
 	mkdir $tmpdir
 	rsync -rq "$peek_repo/refs" $tmpdir || exit 1
-	(cd $tmpdir && find refs -type f) |
+	(cd $tmpdir &>/dev/null && find refs -type f) |
 	while read path
 	do
 		cat "$tmpdir/$path" | tr -d '\012'
diff --git a/git-repack.sh b/git-repack.sh
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -33,7 +33,7 @@ case ",$all_into_one," in
 	pack_objects=
 	# This part is a stop-gap until we have proper pack redundancy
 	# checker.
-	existing=`cd "$PACKDIR" && \
+	existing=`cd "$PACKDIR" &>/dev/null && \
 	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
 	;;
 esac



-- 
| G r e g  L o u i s         | gpg public key: 0x400B1AA86D9E3E64 |
|  http://www.bgl.nu/~glouis |   (on my website or any keyserver) |
|  http://wecanstopspam.org in signatures helps fight junk email. |
