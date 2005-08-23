From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cg-pull to stop treating "master" specially, fix
	fetch_local for .git/HEAD
Date: Tue, 23 Aug 2005 17:33:16 -0400
Message-ID: <1124832796.23795.9.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 23 23:35:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7gOi-0003uW-He
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 23:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVHWVd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 17:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVHWVd3
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 17:33:29 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:48264 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932395AbVHWVd2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 17:33:28 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E7gOX-0003KY-VB
	for git@vger.kernel.org; Tue, 23 Aug 2005 17:33:22 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E7gOT-0006Cc-3Y; Tue, 23 Aug 2005 17:33:17 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7NLXG8e023843;
	Tue, 23 Aug 2005 17:33:16 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7674>

Hello!

This patch changes cg-pull so that if the branch is not specified, it
takes origin's .git/HEAD without first trying .git/refs/heads/master.
This removes preferential treatment of the "master" branch, allowing the
upstream to use another name for the default branch.  To get the master
branch, users would have to append "#master" to the URL.

Local URL handling needs to be fixed to handle .git/HEAD properly, since
it's a symlink in the upstream directory.  A new flag "-b" for fetch_*
functions is introduced, meaning "dereference" (like in GNU cp).

To do: the code needs refactoring with better option handling.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -67,6 +67,8 @@ pull_progress()
 
 fetch_rsync()
 {
+	[ "$1" = "-b" ] && shift
+
 	redir=
 	if [ "$1" = "-i" ]; then # ignore-errors
 		redir="2>/dev/null"
@@ -108,6 +110,7 @@ pull_rsync()
 
 fetch_http()
 {
+	[ "$1" = "-b" ] && shift
 	[ "$1" = "-i" ] && shift
 	[ "$1" = "-s" ] && shift
 
@@ -158,6 +161,7 @@ pull_http()
 
 fetch_ssh()
 {
+	[ "$1" = "-b" ] && shift
 	[ "$1" = "-i" ] && shift
 	[ "$1" = "-s" ] && shift
 
@@ -205,6 +209,11 @@ fetch_local()
 	[ "$1" = "-s" ] && shift
 
 	cp_flags_l="-vdpR"
+	if [ "$1" = "-b" ]; then
+		cp_flags_l="-vb" # Dereference symlinks
+		shift
+	fi
+
 	if [ "$1" = "-u" ]; then
 		cp_flags_l="$cp_flags_l -fu$can_hardlink"
 		suggest_hardlink=
@@ -255,7 +264,7 @@ name=${ARGS[0]}
 [ "$name" ] || die "where to pull from?"
 uri=$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch: $name"
 
-rembranch=master
+rembranch=
 if echo "$uri" | grep -q '#'; then
 	rembranch=$(echo $uri | cut -d '#' -f 2)
 	uri=$(echo $uri | cut -d '#' -f 1)
@@ -308,13 +317,13 @@ orig_head=
 
 
 mkdir -p $_git/refs/heads
-rsyncerr=
-$fetch -i "$uri/refs/heads/$rembranch" "$_git/refs/heads/.$name-pulling" || rsyncerr=1
-if [ "$rsyncerr" ] && [ "$rembranch" = "master" ]; then
-	rsyncerr=
-	$fetch -s "$uri/HEAD" "$_git/refs/heads/.$name-pulling" || rsyncerr=1
+if [ "$rembranch" ]; then
+	$fetch -i "$uri/refs/heads/$rembranch" "$_git/refs/heads/.$name-pulling" ||
+		die "unable to get the head pointer of branch $rembranch"
+else
+	$fetch -b -s "$uri/HEAD" "$_git/refs/heads/.$name-pulling" ||
+		die "unable to get the HEAD branch"
 fi
-[ "$rsyncerr" ] && die "unable to get the head pointer of branch $rembranch"
 
 new_head=$(cat "$_git/refs/heads/.$name-pulling")
 if ! [ "$symlinked" ]; then


-- 
Regards,
Pavel Roskin
