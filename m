From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add cheap local clone '-s' flag to git-clone-script
Date: Sun, 14 Aug 2005 01:20:37 -0700
Message-ID: <7v4q9tdj56.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 14 10:21:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4Djm-0004u9-1B
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 10:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVHNIUj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 04:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVHNIUj
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 04:20:39 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:4335 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751343AbVHNIUi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2005 04:20:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050814082038.RNPI1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 Aug 2005 04:20:38 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Using the $GIT_OBJECT_DIRECTORY/info/alternates mechanism,
create a new repository that borrows objects from the original
repository when --shared flag is given in addition to --local.

It is worth pointing out that the "cloned" repository depends on
the original repository, so this should be used only when you
can reasonably trust that the original repository would not
disappear without your knowing.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

    This depends on the "Alternate object pool mechanism" patch I
    sent out earlier, with a change suggested by Pasky to use
    "$GIT_OBJECT_DIRECTORY/info/alternates" as the file name
    instead of "info/alt".

    This approach has the same danger as symlinking .git/objects
    directory to the original repository that cg-clone mentions
    about its '-l' option, but it is safer and easier to use in
    multi-user environment.  Objects newly created in the cloned
    repository go to the primary object pool of it, not the
    object pool of the original repository.

 git-clone-script |   45 ++++++++++++++++++++++++++++-----------------
 1 files changed, 28 insertions(+), 17 deletions(-)

ffdb36832dd755e65b9adfb68fa6b4a137176bc5
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -6,7 +6,7 @@
 # Clone a repository into a different directory that does not yet exist.
 
 usage() {
-	echo >&2 "* git clone [-l] [-q] [-u <upload-pack>] <repo> <dir>"
+	echo >&2 "* git clone [-l [-s]] [-q] [-u <upload-pack>] <repo> <dir>"
 	exit 1
 }
 
@@ -16,11 +16,14 @@ get_repo_base() {
 
 quiet=
 use_local=no
+local_shared=no
 upload_pack=
 while
 	case "$#,$1" in
 	0,*) break ;;
 	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
+        *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared) 
+          local_shared=yes ;;
 	*,-q|*,--quiet) quiet=-q ;;
 	1,-u|1,--upload-pack) usage ;;
 	*,-u|*,--upload-pack)
@@ -57,22 +60,30 @@ yes,yes)
 		exit 1
 	}
 
-	# See if we can hardlink and drop "l" if not.
-	sample_file=$(cd "$repo" && \
-		      find objects -type f -print | sed -e 1q)
-
-	# objects directory should not be empty since we are cloning!
-	test -f "$repo/$sample_file" || exit
-
-	l=
-	if ln "$repo/$sample_file" "$D/.git/objects/sample" 2>/dev/null
-	then
-		l=l
-	fi &&
-	rm -f "$D/.git/objects/sample" &&
-	cd "$repo" &&
-	find objects -type f -print |
-	cpio -puamd$l "$D/.git/" || exit 1
+	case "$local_shared" in
+	no)
+	    # See if we can hardlink and drop "l" if not.
+	    sample_file=$(cd "$repo" && \
+			  find objects -type f -print | sed -e 1q)
+
+	    # objects directory should not be empty since we are cloning!
+	    test -f "$repo/$sample_file" || exit
+
+	    l=
+	    if ln "$repo/$sample_file" "$D/.git/objects/sample" 2>/dev/null
+	    then
+		    l=l
+	    fi &&
+	    rm -f "$D/.git/objects/sample" &&
+	    cd "$repo" &&
+	    find objects -type f -print |
+	    cpio -puamd$l "$D/.git/" || exit 1
+	    ;;
+	yes)
+	    mkdir -p "$D/.git/objects/info"
+	    echo "$repo/objects" >"$D/.git/objects/info/alternates"
+	    ;;
+	esac
 
 	# Make a duplicate of refs and HEAD pointer
 	HEAD=
