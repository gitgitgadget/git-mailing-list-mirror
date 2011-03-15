From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] stash: copy the index using --index-output instead of cp
 -p
Date: Tue, 15 Mar 2011 13:37:52 +0100
Message-ID: <4D7F5DA0.3030608@viscovery.net>
References: <4D7F3AA4.1080202@elegosoft.com> <4D7F466A.4090508@viscovery.net> <4D7F54C2.5060500@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, casey@nrlssc.navy.mil, jon.seymour@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Jakob Pfender <jpfender@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 13:38:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzTVn-0003lD-Cp
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 13:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757634Ab1COMiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 08:38:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54986 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757663Ab1COMh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 08:37:59 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PzTVZ-0001pa-3i; Tue, 15 Mar 2011 13:37:53 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CF1401660F;
	Tue, 15 Mar 2011 13:37:52 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D7F54C2.5060500@elegosoft.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169066>

From: Johannes Sixt <j6t@kdbg.org>

'git stash create' must operate with a temporary index. For this purpose,
it used 'cp -p' to create a copy. -p is needed to preserve the timestamp
of the index file. Now Jakob Pfender reported a certain combination of
a Linux NFS client, OpenBSD NFS server, and cp implementation where this
operation failed.

Luckily, the first operation in git-stash after copying the index is to
call 'git read-tree'. Therefore, use --index-output instead of 'cp -p'
to write the copy of the index.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Tested-by: Jakob Pfender <jpfender@elegosoft.com>
---
 Here's a wrap-up. Acked-by is reserved for people whose area-of-expertise
 is touched by someone else. Tested-by is more appropriate here.

 git-stash.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 7561b37..fa62135 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -82,10 +82,9 @@ create_stash () {
 		# state of the working tree
 		w_tree=$( (
 			rm -f "$TMP-index" &&
-			cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
+			git read-tree --index-output="$TMP-index" -m $i_tree &&
 			GIT_INDEX_FILE="$TMP-index" &&
 			export GIT_INDEX_FILE &&
-			git read-tree -m $i_tree &&
 			git diff --name-only -z HEAD | git update-index -z --add --remove --stdin &&
 			git write-tree &&
 			rm -f "$TMP-index"
-- 
1.7.4.rc3.76.gfb457d
