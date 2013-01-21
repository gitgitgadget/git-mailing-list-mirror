From: "=?utf-8?q?Jean-No=C3=ABl?= AVILA" <jn.avila@free.fr>
Subject: [RFC] Instruct git-completion.bash that we are in test mode
Date: Mon, 21 Jan 2013 23:30:10 +0100
Message-ID: <201301212330.10824.jn.avila@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 23:31:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxPtb-000682-SZ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 23:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672Ab3AUWay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 17:30:54 -0500
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:49405 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab3AUWax (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 17:30:53 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id C7EB277CB3A
	for <git@vger.kernel.org>; Mon, 21 Jan 2013 23:30:49 +0100 (CET)
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 62F8D4B00C6
	for <git@vger.kernel.org>; Mon, 21 Jan 2013 23:30:12 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214167>

In test mode, git completion should only propose core commands.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---

I reworked the patch so that the test argument is only evaluated
when sourcing the file and there is no environment clutter.

At least, "it works for me".

 contrib/completion/git-completion.bash | 8 +++++++-
 t/t9902-completion.sh                  | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 14dd5e7..ac9fa65 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -531,10 +531,16 @@ __git_complete_strategy ()
 	return 1
 }
 
+if [ "x$1" != "xTEST" ]; then
+	__git_cmdlist () { git help -a|egrep '^  [a-zA-Z0-9]'; }
+else
+	__git_cmdlist () { git help -a| egrep -m 1 -B1000 PATH | egrep '^  [a-zA-Z0-9]'; }
+fi
+
 __git_list_all_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
+	for i in $(__git_cmdlist)
 	do
 		case $i in
 		*--*)             : helper pattern;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3cd53f8..51463b2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -13,7 +13,7 @@ complete ()
 	return 0
 }
 
-. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
+. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" TEST
 
 # We don't need this function to actually join words or do anything special.
 # Also, it's cleaner to avoid touching bash's internal completion variables.
-- 
1.8.1.1.271.g02f55e6
