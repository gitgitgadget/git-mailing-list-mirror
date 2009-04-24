From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] bisect: use "git rev-parse --sq-quote" instead of a
	custom "sq" function
Date: Fri, 24 Apr 2009 08:29:00 +0200
Message-ID: <20090424062902.3705.76155.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 08:32:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxExr-0007Fu-71
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 08:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZDXGbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 02:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752867AbZDXGbL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 02:31:11 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:33073 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbZDXGbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 02:31:09 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 0B3BFE08142;
	Fri, 24 Apr 2009 08:31:01 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 0E27AE08080;
	Fri, 24 Apr 2009 08:30:59 +0200 (CEST)
X-git-sha1: 0310b1f7adc665239c729ed5645cd84cb65eda3a 
X-Mailer: git-mail-commits v0.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117413>

As the "sq" function was the only place using Perl in "git-bisect.sh",
this removes the Perl dependency in this script.

While at it, we also remove the sed instruction in the Makefile that
substituted @@PERL@@ with the Perl path in shell scripts, as this is
not needed anymore. (It is now only needed in "git-instaweb.sh" but
this command is dealt with separately in the Makefile.)

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile      |    1 -
 git-bisect.sh |   16 +++-------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 5d491ad..bbe15d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1247,7 +1247,6 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
-	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    $@.sh >$@+ && \
diff --git a/git-bisect.sh b/git-bisect.sh
index e1f300b..786b7b9 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -33,16 +33,6 @@ require_work_tree
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
-sq() {
-	@@PERL@@ -e '
-		for (@ARGV) {
-			s/'\''/'\'\\\\\'\''/g;
-			print " '\''$_'\''";
-		}
-		print "\n";
-	' "$@"
-}
-
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
 		echo >&2 'You need to start by "git bisect start"'
@@ -107,7 +97,7 @@ bisect_start() {
 	for arg; do
 	    case "$arg" in --) has_double_dash=1; break ;; esac
 	done
-	orig_args=$(sq "$@")
+	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
 	while [ $# -gt 0 ]; do
@@ -147,7 +137,7 @@ bisect_start() {
 	# Write new start state.
 	#
 	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
-	sq "$@" >"$GIT_DIR/BISECT_NAMES" &&
+	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval" &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -199,7 +189,7 @@ bisect_skip() {
             *..*)
                 revs=$(git rev-list "$arg") || die "Bad rev input: $arg" ;;
             *)
-                revs=$(sq "$arg") ;;
+                revs=$(git rev-parse --sq-quote "$arg") ;;
 	    esac
             all="$all $revs"
         done
-- 
1.6.3.rc1.112.g17e25
