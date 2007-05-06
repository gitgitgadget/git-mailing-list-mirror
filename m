From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Teach bash to complete branch names in some places.
Date: Mon, 07 May 2007 01:13:57 +0200
Message-ID: <20070506231357.31547.25929.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 01:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkpwG-0000pK-Bz
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbXEFXOp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbXEFXOp
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:14:45 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:33767 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbXEFXOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:14:44 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 990615CA83;
	Mon,  7 May 2007 01:14:43 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 9F4202006;
	Mon,  7 May 2007 01:13:57 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46397>


This patch causes bash completion to look for branch names instead of
patch names for "branch" and "rebase".

Unfortunately, the current completion framework does not seem flexible
enough to get branch completion after "-b" flags, but I feel things
are already better this way.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stgit-completion.bash |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.bash
index 760fc2f..d497098 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -98,6 +98,12 @@ _all_other_patches ()
         | grep -v "^$(cat $g/patches/$b/current 2> /dev/null)$"
 }
 
+_all_branches ()
+{
+    local g=$(_gitdir)
+    [ "$g" ] && (cd .git/patches/ && echo *)
+}
+
 # List the command options
 _cmd_options ()
 {
@@ -137,6 +143,11 @@ _complete_patch_range_options ()
     COMPREPLY=($(compgen -W "$options" -- "$cur"))
 }
 
+_complete_branch ()
+{
+     COMPREPLY=($(compgen -W "$(_cmd_options $1) $($2)" -- "${COMP_WORDS[COMP_CWORD]}"))
+}
+
 # Generate completions for options from the given list.
 _complete_options ()
 {
@@ -211,6 +222,9 @@ _stg ()
         sync)   _stg_patches $command _applied_patches ;;
         # working-copy commands
         diff)   _stg_patches_options $command _applied_patches "-r --range" ;;
+	# commands that usually raher accept branches
+	branch) _complete_branch $command _all_branches ;;
+	rebase) _complete_branch $command _all_branches ;;
         # all the other commands
         *)      _stg_common $command ;;
     esac
