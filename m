From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 2/2 v2] stash: copy the index using --index-output instead
 of cp -p
Date: Wed, 16 Mar 2011 09:18:49 +0100
Message-ID: <4D807269.1070802@viscovery.net>
References: <4D7F3AA4.1080202@elegosoft.com>	<4D7F466A.4090508@viscovery.net>	<4D7F54C2.5060500@elegosoft.com>	<4D7F5DA0.3030608@viscovery.net>	<7vk4g09o9x.fsf@alter.siamese.dyndns.org> <AANLkTi=+-tDz6XSSUAyvzGZ6fJohSU+rY4GhRa5C-+oA@mail.gmail.com> <4D8070E1.8000305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>, casey@nrlssc.navy.mil,
	jon.seymour@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 09:19:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzlwf-00063w-FI
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 09:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab1CPISy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 04:18:54 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33038 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab1CPISw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 04:18:52 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PzlwQ-0004zu-GD; Wed, 16 Mar 2011 09:18:50 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3B0CB1660F;
	Wed, 16 Mar 2011 09:18:50 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D8070E1.8000305@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169120>

From: Johannes Sixt <j6t@kdbg.org>

'git stash create' must operate with a temporary index. For this purpose,
it used 'cp -p' to create a copy. -p is needed to preserve the timestamp
of the index file. Now Jakob Pfender reported a certain combination of
a Linux NFS client, OpenBSD NFS server, and cp implementation where this
operation failed.

Luckily, the first operation in git-stash after copying the index is to
call 'git read-tree'. Therefore, use --index-output instead of 'cp -p'
to write the copy of the index.

--index-output requires that the specified file is on the same volume as
the source index, so that the lock file can be rename()d. For this reason,
the name of the temporary index is constructed in a way different from the
other temporary files. The code path of 'stash -p' also needs a temporary
index, but we do not use the new name because it does not depend on the
same precondition as --index-output.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Changes since v1:

 - Addresses the --index-output precondition.

 - Also removes the first 'rm -f "$TMP-index" &&'

 Warning: This was only tested by the test suite.

 git-stash.sh |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 7c0d563..5130228 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -17,7 +17,8 @@ require_work_tree
 cd_to_toplevel
 
 TMP="$GIT_DIR/.git-stash.$$"
-trap 'rm -f "$TMP-"*' 0
+TMPindex=${GIT_INDEX_FILE-"$GIT_DIR/index"}.stash.$$
+trap 'rm -f "$TMP-"* "$TMPindex"' 0
 
 ref_stash=refs/stash
 
@@ -81,14 +82,12 @@ create_stash () {
 
 		# state of the working tree
 		w_tree=$( (
-			rm -f "$TMP-index" &&
-			cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
-			GIT_INDEX_FILE="$TMP-index" &&
+			git read-tree --index-output="$TMPindex" -m $i_tree &&
+			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git read-tree -m $i_tree &&
 			git diff --name-only -z HEAD | git update-index -z --add --remove --stdin &&
 			git write-tree &&
-			rm -f "$TMP-index"
+			rm -f "$TMPindex"
 		) ) ||
 			die "Cannot save the current worktree state"
 
-- 
1.7.4.1.316.g2ab2cb
