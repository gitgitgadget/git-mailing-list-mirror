From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH] Avoid contrib/stg-swallow deleting unrelated empty
	patches.
Date: Sat, 05 May 2007 15:58:07 +0200
Message-ID: <20070505135757.5142.90536.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 18:18:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkMyB-00028a-A1
	for gcvg-git@gmane.org; Sat, 05 May 2007 18:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592AbXEEQSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 12:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755594AbXEEQSs
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 12:18:48 -0400
Received: from postfix2-g20.free.fr ([212.27.60.43]:37520 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591AbXEEQSr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 12:18:47 -0400
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 361BCFB212D
	for <git@vger.kernel.org>; Sat,  5 May 2007 15:00:14 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 456775EC13;
	Sat,  5 May 2007 15:58:49 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 1BD9B1F15F;
	Sat,  5 May 2007 15:58:08 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46262>


Let's just check ourselves if the patch is empty after pushing instead
of using clean: no more surprise with patches getting abusively
cleaned, and we should now be faster when there are many unapplied
patches.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-swallow |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/contrib/stg-swallow b/contrib/stg-swallow
index 5014f39..924c079 100755
--- a/contrib/stg-swallow
+++ b/contrib/stg-swallow
@@ -15,5 +15,9 @@ patch="$1"
 stg pick --fold "$patch"
 stg refresh
 stg push "$patch"
+
 #stg clean "$patch"
-stg pop; stg clean -u
+#stg pop; stg clean -u
+[ $(stg id "$patch//top") != $(stg id "$patch//bottom") ] ||
+    { echo >&2 "Assertion failed: patch '$patch' is not empty after swallowing, not deleting it."; exit 1; }    
+stg delete "$patch"
