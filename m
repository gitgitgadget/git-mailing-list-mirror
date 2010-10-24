From: Robin Green <greenrd@greenrd.org>
Subject: [TopGit PATCH] Make tg help work in any directory
Date: Sun, 24 Oct 2010 14:34:59 +0000
Message-ID: <1287930899-20186-1-git-send-email-greenrd@greenrd.org>
Cc: Robin Green <greenrd@greenrd.org>
X-From: git-owner@vger.kernel.org Sun Oct 24 18:14:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA3Cp-000347-Jw
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 18:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586Ab0JXQNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 12:13:53 -0400
Received: from host29.netdorm.com ([64.182.105.29]:41252 "EHLO
	mxout.netdorm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab0JXQNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 12:13:52 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Oct 2010 12:13:52 EDT
Received: from mail.dnsexit.com (mail.dnsexit.com [67.214.171.75] (may be forged))
	by mxout.netdorm.com (8.13.8/8.13.8) with ESMTP id o9OG8fPE007000
	for <git@vger.kernel.org>; Sun, 24 Oct 2010 12:08:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.dnsexit.com (Postfix) with ESMTP id 59CA28B5D23
	for <git@vger.kernel.org>; Sun, 24 Oct 2010 12:04:17 -0400 (EDT)
X-Quarantine-ID: <l1GyaUTSW3-h>
X-Virus-Scanned: amavisd-new at box11.dnsexit.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "To"
Received: from mail.dnsexit.com ([127.0.0.1])
	by localhost (mail.dnsexit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l1GyaUTSW3-h; Sun, 24 Oct 2010 12:04:16 -0400 (EDT)
Received: from cspcnh.swan.ac.uk (cspcnh.swan.ac.uk [137.44.6.171])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dnsexit.com (Postfix) with ESMTP id 98DE98B5D21;
	Sun, 24 Oct 2010 12:04:16 -0400 (EDT)
Received: from cspcnh.swan.ac.uk (exherbo.local [127.0.0.1])
	by cspcnh.swan.ac.uk (8.14.4/8.14.4) with ESMTP id o9OEa0gT020223;
	Sun, 24 Oct 2010 14:36:00 GMT
Received: (from greenrd@localhost)
	by cspcnh.swan.ac.uk (8.14.4/8.14.4/Submit) id o9OEa069020222;
	Sun, 24 Oct 2010 14:36:00 GMT
To: git@vger.kernel.org
X-Mailer: git-send-email 1.7.2.3
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159883>

tg was checking if the current directory is a git repository,
which isn't necessary if the command is "help" or there is no
command.

Signed-off-by: Robin Green <greenrd@greenrd.org>

---
 tg.sh |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tg.sh b/tg.sh
index 8264a3b..03ef227 100644
--- a/tg.sh
+++ b/tg.sh
@@ -356,16 +356,25 @@ setup_pager()
 
 ## Initial setup
 
-set -e
-git_dir="$(git rev-parse --git-dir)"
-root_dir="$(git rev-parse --show-cdup)"; root_dir="${root_dir:-.}"
+cmd="$1"
+[ -z "$tg__include" ] || cmd="include" # ensure setup happens
+case "$cmd" in
+help|--help|-h)
+        :;;
+*)
+        if [ -n "$cmd" ]; then
+            set -e
+            git_dir="$(git rev-parse --git-dir)"
+            root_dir="$(git rev-parse --show-cdup)"; root_dir="${root_dir:-.}"
 # Make sure root_dir doesn't end with a trailing slash.
-root_dir="${root_dir%/}"
-base_remote="$(git config topgit.remote 2>/dev/null)" || :
-tg="tg"
+            root_dir="${root_dir%/}"
+            base_remote="$(git config topgit.remote 2>/dev/null)" || :
+            tg="tg"
 # make sure merging the .top* files will always behave sanely
-setup_ours
-setup_hook "pre-commit"
+            setup_ours
+            setup_hook "pre-commit"
+        fi
+esac
 
 ## Dispatch
 
@@ -385,7 +394,6 @@ if [ "$1" = "-r" ]; then
 	tg="$tg -r $base_remote"
 fi
 
-cmd="$1"
 [ -n "$cmd" ] || { do_help; exit 1; }
 shift
 
-- 
tg: (8b0f1f9..) t/help-anywhere (depends on: master)
