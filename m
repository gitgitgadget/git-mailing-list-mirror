From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 4/8] detached-stash: refactor git stash pop implementation
Date: Wed, 18 Aug 2010 23:48:49 +1000
Message-ID: <1282139333-5150-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:49:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olj1B-00056e-Dq
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab0HRNtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 09:49:20 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33667 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab0HRNtT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:49:19 -0400
Received: by pwi7 with SMTP id 7so11722pwi.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+WDoaCMPGKy/RrM4JeA68R9KJIWUZlAQfdK9BsZnVL0=;
        b=IUR8vA00xts0iCR7PZvtK3+8MnqE7Gd89PCNWXybL+vz93zTE7bLXR3YpVyAdmTuz5
         5OJd4Gtgei8CaQDzE8gb9W+VqdJ6B5pqB51yLVn9mPyyutxwa01tFIRCIiXDP7rAH4bG
         CwVmZBBGsEZzKMrQvzDKj2LLe6R3DWOuG/Dc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=H92mbYqDquTdgGJEhdbkxlX1JV3exHsQPm2VRKHXYb2QJjw2Z09RdFspWRwR6QTeo8
         6r6FuEyjfG9PwXWf7bEHZCEG1OPJsvOvcqa+VPKR4eH4AgsuJs6dJqp4W4hdLbVWcDKO
         Ff8duwZ/Okip3Ih3duYzHdHs7m4ZpTn3Nbg+0=
Received: by 10.114.204.7 with SMTP id b7mr9602033wag.124.1282139359169;
        Wed, 18 Aug 2010 06:49:19 -0700 (PDT)
Received: from localhost.localdomain (203-158-55-26.dyn.iinet.net.au [203.158.55.26])
        by mx.google.com with ESMTPS id s5sm538803wak.12.2010.08.18.06.49.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:49:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.88.g3dbe5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153850>

git stash pop is abstracted into its own implementation function - pop_stash.

The behaviour is changed so that git stash pop fails early if the
the specified stash reference does not exist or does not refer to
an extant entry in the reflog of the reference stash.

This fixes the case where the apply succeeds, but the drop fails.
Previously this caused caused git stash pop to exit with a non-zero exit code
and a dirty tree.

Now, git stash pop fails with a non-zero exit code, but the working
tree is not modified.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 750f360..ac4c0f6 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -423,6 +423,13 @@ apply_stash () {
 	fi
 }
 
+pop_stash() {
+	assert_stash_ref "$@"
+
+	apply_stash "$@" &&
+	drop_stash "$@"
+}
+
 drop_stash () {
 	assert_stash_ref "$@"
 
@@ -498,10 +505,7 @@ drop)
 	;;
 pop)
 	shift
-	if apply_stash "$@"
-	then
-		drop_stash "$applied_stash"
-	fi
+	pop_stash "$@"
 	;;
 branch)
 	shift
-- 
1.7.2.1.95.g4fabf
