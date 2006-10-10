From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] repack: allow simultaneous packing and pruning
Date: Tue, 10 Oct 2006 23:14:53 +1300
Message-ID: <20061010102210.568341380D6@magnus.utsl.gen.nz>
X-From: git-owner@vger.kernel.org Tue Oct 10 12:22:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXEkd-0006vb-K3
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 12:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWJJKWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 06:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWJJKWO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 06:22:14 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43657 "EHLO
	magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751084AbWJJKWO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 06:22:14 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id 568341380D6; Tue, 10 Oct 2006 23:22:10 +1300 (NZDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28623>

If using git-repack -a, unreferenced objects are kept behind in the
pack.  This might be the best default, but there are no good ways
to clean up the packfiles if a lot of rebasing is happening, or
branches have been deleted.
---
see also http://colabti.de/irclogger/irclogger_log/git?date=2006-10-10,Tue&sel=27#l75

 Documentation/git-repack.txt |    7 ++++++-
 git-repack.sh                |   14 +++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 9516227..63ee7cb 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ objects into pack files.
 
 SYNOPSIS
 --------
-'git-repack' [-a] [-d] [-f] [-l] [-n] [-q]
+'git-repack' [-a] [-d] [-f] [-l] [-n] [-q] [-p]
 
 DESCRIPTION
 -----------
@@ -40,6 +40,11 @@ OPTIONS
 	existing packs redundant, remove the redundant packs.
 	Also runs gitlink:git-prune-packed[1].
 
+-p::
+	Before packing, remove any unreferenced objects with
+	gitlink:git-prune[1].  When used with '-a', unreferenced
+	objects in the old packs are not taken across.
+
 -l::
         Pass the `--local` option to `git pack-objects`, see
         gitlink:git-pack-objects[1].
diff --git a/git-repack.sh b/git-repack.sh
index 640ad8d..a2ad955 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -7,13 +7,14 @@ USAGE='[-a] [-d] [-f] [-l] [-n] [-q]'
 . git-sh-setup
 
 no_update_info= all_into_one= remove_redundant=
-local= quiet= no_reuse_delta= extra=
+local= quiet= no_reuse_delta= extra= prune=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
 	-n)	no_update_info=t ;;
 	-a)	all_into_one=t ;;
 	-d)	remove_redundant=t ;;
+	-p)     prune=t ;;
 	-q)	quiet=-q ;;
 	-f)	no_reuse_delta=--no-reuse-delta ;;
 	-l)	local=--local ;;
@@ -32,6 +33,11 @@ case ",$all_into_one," in
 ,,)
 	rev_list='--unpacked'
 	pack_objects='--incremental'
+	if [ -n "$prune" ]
+	then
+	    # prune junk first
+	    git-prune
+	fi
 	;;
 ,t,)
 	rev_list=
@@ -40,8 +46,14 @@ case ",$all_into_one," in
 	# Redundancy check in all-into-one case is trivial.
 	existing=`cd "$PACKDIR" && \
 	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
+
+	if [ -n "$prune" ]
+	then
+	    rev_list=`cd "$GIT_DIR" && find refs -type f -print`
+	fi
 	;;
 esac
+
 pack_objects="$pack_objects $local $quiet $no_reuse_delta$extra"
 name=$(git-rev-list --objects --all $rev_list 2>&1 |
 	git-pack-objects --non-empty $pack_objects .tmp-pack) ||
-- 
1.4.2.g0ea2
