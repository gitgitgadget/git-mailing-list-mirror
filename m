From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH] Removed the .git/config check from "git submodule status"
Date: Wed, 13 Jan 2010 20:31:39 +0000
Message-ID: <1263414699-1613-1-git-send-email-peter@pcc.me.uk>
Cc: Lars Hjemli <hjemli@gmail.com>,
	Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 21:36:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9wZ-0008Oi-KQ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab0AMUfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906Ab0AMUfv
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:35:51 -0500
Received: from master.pcc.me.uk ([207.192.74.179]:50544 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227Ab0AMUfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:35:51 -0500
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NV9wT-00050P-IG; Wed, 13 Jan 2010 20:35:49 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NV9tS-0000QY-Fe; Wed, 13 Jan 2010 20:32:42 +0000
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136877>

"git submodule status" requires that the following conditions be met
for a submodule to be considered initialised:

1) The existence of an entry in .git/config for that module
2) The existence of a .git subdirectory under the submodule directory

Plumbing only requires condition 2 to be met, and does not care about
condition 1 (these entries being part of the git-submodule porcelain).
Therefore removing condition 1 from "git submodule status" will make
git-submodule's view of the world consistent with plumbing's thus
eliminating unexpected behaviour.

Furthermore if the user is using the git-submodule porcelain and
not cloning submodules himself, condition 1 should always follow
from condition 2 because "git submodule update" requires that the
submodule entry in .git/config be present.

By removing condition 1 we can also remove the call to module_name from
cmd_status.  "git submodule status" will now work if the user is using
a submodule porcelain other than git-submodule, because module_name
requires that the .gitmodules file be maintained by git-submodule.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 git-submodule.sh           |    4 +---
 t/t7400-submodule-basic.sh |    8 ++------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 77d2232..811f001 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -738,10 +738,8 @@ cmd_status()
 	module_list "$@" |
 	while read mode sha1 stage path
 	do
-		name=$(module_name "$path") || exit
-		url=$(git config submodule."$name".url)
 		displaypath="$prefix$path"
-		if test -z "$url" || ! test -d "$path"/.git -o -f "$path"/.git
+		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
 			say "-$sha1 $displaypath"
 			continue;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 1a4dc5f..c16fb14 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -106,12 +106,8 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	)
 '
 
-test_expect_success 'status should fail for unmapped paths' '
-	if git submodule status
-	then
-		echo "[OOPS] submodule status succeeded"
-		false
-	elif ! GIT_CONFIG=.gitmodules git config submodule.example.path init
+test_expect_success 'mapping a path using git config' '
+	if ! GIT_CONFIG=.gitmodules git config submodule.example.path init
 	then
 		echo "[OOPS] git config failed to update .gitmodules"
 		false
-- 
1.6.5
