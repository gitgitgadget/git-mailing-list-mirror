From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] rebase: consistent error messages for staged and unstaged changes.
Date: Wed,  5 Aug 2009 17:13:41 +0200
Message-ID: <1249485221-10510-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 17:18:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYiEy-0001lQ-M8
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 17:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422AbZHEPQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 11:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755141AbZHEPQ5
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 11:16:57 -0400
Received: from imag.imag.fr ([129.88.30.1]:64829 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754867AbZHEPQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 11:16:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n75FE2eo011261
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 17:14:03 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MYiBm-0003R7-S2; Wed, 05 Aug 2009 17:14:02 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MYiBm-0002kM-Pk; Wed, 05 Aug 2009 17:14:02 +0200
X-Mailer: git-send-email 1.6.4.18.g07a4a.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 05 Aug 2009 17:14:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124912>

Previous version expose the output of the plumbing update-index to the
user, which novice users have difficulty to understand.

We still need to run update-index to refresh the cache (if
diff.autorefreshindex is false, git diff won't do it).
---
 git-rebase.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 18bc694..3555d17 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -382,8 +382,10 @@ else
 fi
 
 # The tree must be really really clean.
-if ! git update-index --ignore-submodules --refresh; then
-	die "cannot rebase: you have unstaged changes"
+if ! git update-index --ignore-submodules --refresh > /dev/null; then
+	echo >&2 "cannot rebase: you have unstaged changes"
+	git diff --name-status -r --ignore-submodules -- >&2
+	exit 1
 fi
 diff=$(git diff-index --cached --name-status -r --ignore-submodules HEAD --)
 case "$diff" in
-- 
1.6.4.18.g07a4a.dirty
