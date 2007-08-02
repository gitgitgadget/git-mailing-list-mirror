From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 5/6] Provide file completion for add/resolved/refresh
	based on status.
Date: Thu, 02 Aug 2007 22:18:36 +0200
Message-ID: <20070802201836.16614.49897.stgit@gandelf.nowhere.earth>
References: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:20:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGh9N-0007HH-8A
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760017AbXHBUTm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760019AbXHBUTl
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:19:41 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55163 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759931AbXHBUTk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:19:40 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E694859C83;
	Thu,  2 Aug 2007 22:19:39 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CC48159FE3;
	Thu,  2 Aug 2007 22:19:39 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 8AA6B1F06F;
	Thu,  2 Aug 2007 22:18:36 +0200 (CEST)
In-Reply-To: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54596>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stgit-completion.bash |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.bash
index a843db4..2d0d5f2 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -111,6 +111,30 @@ _all_branches ()
     [ "$g" ] && (cd .git/patches/ && echo *)
 }
 
+_conflicting_files ()
+{
+    local g=$(_gitdir)
+    [ "$g" ] && stg status --conflict
+}
+
+_dirty_files ()
+{
+    local g=$(_gitdir)
+    [ "$g" ] && stg status --modified --new --deleted
+}
+
+_unknown_files ()
+{
+    local g=$(_gitdir)
+    [ "$g" ] && stg status --unknown
+}
+
+_known_files ()
+{
+    local g=$(_gitdir)
+    [ "$g" ] && git ls-files
+}
+
 # List the command options
 _cmd_options ()
 {
@@ -162,6 +186,11 @@ _complete_options ()
     COMPREPLY=($(compgen -W "$options" -- "${COMP_WORDS[COMP_CWORD]}"))
 }
 
+_complete_files ()
+{
+    COMPREPLY=($(compgen -W "$(_cmd_options $1) $2" -- "${COMP_WORDS[COMP_CWORD]}"))
+}
+
 _stg_common ()
 {
     _complete_options "$(_cmd_options $1)"
@@ -223,12 +252,16 @@ _stg ()
         log)    _stg_patches $command _all_patches ;;
         mail)   _stg_patches $command _all_patches ;;
         pick)   _stg_patches $command _unapplied_patches ;;
-        refresh)_stg_patches_options $command _applied_patches "-p --patch" ;;
+#	refresh)_stg_patches_options $command _applied_patches "-p --patch" ;;
+        refresh) _complete_files $command "$(_dirty_files)" ;;
         rename) _stg_patches $command _all_patches ;;
         show)   _stg_patches $command _all_patches ;;
         sync)   _stg_patches $command _applied_patches ;;
         # working-copy commands
         diff)   _stg_patches_options $command _applied_patches "-r --range" ;;
+	resolved) _complete_files $command "$(_conflicting_files)" ;;
+	add)	_complete_files $command "$(_unknown_files)" ;;
+#	rm)	_complete_files $command "$(_known_files)" ;;
 	# commands that usually raher accept branches
 	branch) _complete_branch $command _all_branches ;;
 	rebase) _complete_branch $command _all_branches ;;
