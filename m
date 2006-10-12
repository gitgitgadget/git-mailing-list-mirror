From: Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
Subject: Feature: add --force option to cg-push.
Date: Thu, 12 Oct 2006 23:00:37 +0930
Message-ID: <452E437D.3070708@adelaide.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090108030100040602050800"
X-From: git-owner@vger.kernel.org Thu Oct 12 15:32:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY0eH-00022J-Tb
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 15:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWJLNas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 09:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWJLNas
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 09:30:48 -0400
Received: from bld-mail02.adl2.internode.on.net ([203.16.214.66]:65488 "EHLO
	mail.internode.on.net") by vger.kernel.org with ESMTP
	id S1750910AbWJLNar (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 09:30:47 -0400
Received: from [192.168.1.100] (unverified [203.122.224.179]) 
	by mail.internode.on.net (SurgeMail 3.2f) with ESMTP id 241373304 
	for <git@vger.kernel.org>; Thu, 12 Oct 2006 23:00:41 +0930 (CST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28779>

This is a multi-part message in MIME format.
--------------090108030100040602050800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If I cg-push on a remote branch after changing my mind about how I 
wanted the branch ordered, it will complain and say "maybee you need to 
update"

I didn't know what to do, since I was on the "no" side of maybee.

Here is a patch that adds the --force option for those people.


--------------090108030100040602050800
Content-Type: text/x-patch;
 name="cg_push_forceoption.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cg_push_forceoption.diff"

--- /home/pmdumuid/bin/cg-push2	2006-10-12 22:38:49.000000000 +0930
+++ /usr/bin/cg-push	2006-09-26 14:30:09.000000000 +0930
@@ -27,15 +27,8 @@
 #	future, cg-push should push tags automatically. Also note
 #	that even if you pass `cg-push` the '-t' arguments, your
 #	HEAD is still pushed as well in addition to the tags.
-#
-# --force 
-#       Usually, the command refuses to update a remote ref that is
-#       not an ancestor of the local ref used to overwrite it. This
-#       flag disables the check. What this means is that the remote
-#       repository can lose commits; use it with care.
-#
-#
-USAGE="cg-push [--force] [-r LOCAL_BRANCH] [REMOTE_BRANCH] [-t TAG]..."
+
+USAGE="cg-push [-r LOCAL_BRANCH] [REMOTE_BRANCH] [-t TAG]..."
 
 . "${COGITO_LIB:-/usr/lib/cogito/}"cg-Xlib || exit 1
 
@@ -44,12 +37,11 @@
 {
 	name="$1"; shift
 	commit="$(cg-object-id -c "$locbranch")"; old="$(cat "$_git/refs/heads/$name" 2>/dev/null)"
-	git-send-pack $force "$@" && git-update-ref refs/heads/"$name" "$commit" $old
+	git-send-pack "$@" && git-update-ref refs/heads/"$name" "$commit" $old
 }
 
 
 locbranch="$_git_head"
-force=""
 tags=()
 while optparse; do
 	if optparse -r=; then
@@ -57,8 +49,6 @@
 		[ "$(cg-object-id -c "$locbranch")" ] || exit 1
 	elif optparse -t=; then
 		tags[${#tags[@]}]="refs/tags/$OPTARG"
-	elif optparse --force; then
-                force="--force"
 	else
 		optfail
 	fi
@@ -79,7 +69,7 @@
 sprembranch=":refs/heads/$rembranch"
 
 if [ "${uri#http://}" != "$uri" -o "${uri#https://}" != "$uri" ]; then
-	git-http-push $force "$uri/" "$locbranch$sprembranch" "${tags[@]}"
+	git-http-push "$uri/" "$locbranch$sprembranch" "${tags[@]}"
 elif [ "${uri#git+ssh://}" != "$uri" ]; then
 	send_pack_update "$name" "$(echo "$uri" | sed 's#^git+ssh://\([^/]*\)\(/.*\)$#\1:\2#')" "$locbranch$sprembranch" "${tags[@]}"
 elif [ "${uri#rsync://}" != "$uri" ]; then

--------------090108030100040602050800--
