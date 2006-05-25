From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/2] Fix cg-patch hanging on terminals with TOSTOP flag
Date: Wed, 24 May 2006 21:40:01 -0400
Message-ID: <20060525014001.27814.23082.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 03:40:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj4qB-0003rz-Ch
	for gcvg-git@gmane.org; Thu, 25 May 2006 03:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWEYBkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 21:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWEYBkj
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 21:40:39 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:5055 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964843AbWEYBkj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 21:40:39 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fj4pv-0002MS-1p
	for git@vger.kernel.org; Wed, 24 May 2006 21:40:28 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1Fj4pV-0007Ej-Mm; Wed, 24 May 2006 21:40:01 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20717>

From: Pavel Roskin <proski@gnu.org>

Terminals with TOSTOP flag don't allow background processes to write to
the terminal.  This flag is used e.g. by the subshell in GNU Midnight
Commander.  It can also be set by "stty tostop".

Redirect stdout and strerr of the "patch" command to a temporary file
and show it once "patch" terminates.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 cg-patch |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/cg-patch b/cg-patch
index 9ea7de4..115869e 100755
--- a/cg-patch
+++ b/cg-patch
@@ -337,6 +337,7 @@ # parts of the tree from inadverent poll
 [ "$unidiff" ] && newsfile="$(mktemp -t gitapply.XXXXXX)"
 gonefile="$(mktemp -t gitapply.XXXXXX)"
 todo="$(mktemp -t gitapply.XXXXXX)"
+patchout="$(mktemp -t gitapply.XXXXXX)"
 patchfifo="$(mktemp -t gitapply.XXXXXX)"
 rm "$patchfifo" && mkfifo -m 600 "$patchfifo"
 
@@ -347,7 +348,7 @@ # patch file removal behaviour cannot be
 # just handle it all ourselves.
 patch_args="-p$strip -N"
 [ "$reverse" ] && patch_args="$patch_args -R"
-patch $patch_args <"$patchfifo" &
+patch $patch_args <"$patchfifo" >"$patchout" 2>&1 &
 
 tee "$patchfifo" | {
 	redzone_reset
@@ -407,6 +408,7 @@ tee "$patchfifo" | {
 } >$todo
 
 wait %1; ret=$?
+cat "$patchout"
 
 IFS=$'\n' emptyfiles=($(git-ls-files --deleted | join -v 2 "$gonefile" -))
 if [ "$unidiff" ]; then
@@ -441,7 +443,7 @@ while [ "$1" ]; do
 done
 ' padding
 
-rm "$patchfifo" "$todo" "$gonefile"
+rm "$patchfifo" "$todo" "$gonefile" "$patchout"
 [ "$unidiff" ] && rm "$newsfile"
 
 exit $ret
