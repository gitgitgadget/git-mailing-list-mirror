From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/4] t4041 (diff-submodule-option): rewrite add_file() routine
Date: Tue, 27 Nov 2012 14:11:30 +0530
Message-ID: <1354005692-2809-3-git-send-email-artagnon@gmail.com>
References: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 09:42:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdGk2-0007q6-Dr
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 09:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758380Ab2K0Ilr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 03:41:47 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:36624 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758334Ab2K0Ilq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 03:41:46 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so4142929dak.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 00:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0y86KGj7C3zIJmgCdXeBbMYZ8bdsbcWqrG6d49RHbiw=;
        b=NOpTn0q9+Gr2pUgUQE2nNTEFg6f1MG6tqYrgNbO8WKeCJuHcJqBMmyPHk6kEJr87w+
         30kzA8B3DASyNSosunHAzLc/JEsCDK+AAs4jzpnKIkRcraZjb/cYH9u8Imwug+c9D9Mj
         7f2XNpkR0z/36hrz8JNxff8z0x1M/JV+8+ZStDkpHBjM31VqH88GCSFAqpVcQgWafUQK
         CIejpIieLG00QtdlaIWT1VUB5cW/0+mTRRX+c61tHNHaOzIKzHgWuohi7/uTupGQp74z
         KKpY7B+nK1FIFFsA1B+IOWWgGygs95Rn/AosPUenQnC/rpv/ykuLnfZ3kH6bZxyK2EdJ
         5f9A==
Received: by 10.66.84.132 with SMTP id z4mr40890088pay.63.1354005705768;
        Tue, 27 Nov 2012 00:41:45 -0800 (PST)
Received: from localhost.localdomain ([49.206.179.73])
        by mx.google.com with ESMTPS id vi9sm10284793pbc.41.2012.11.27.00.41.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 00:41:45 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210546>

Instead of "cd there and then come back", use the "cd there in a
subshell" pattern.  Also fix '&&' chaining in one place.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t4041-diff-submodule-option.sh |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index cfb71e5..103c690 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -11,18 +11,15 @@ This test tries to verify the sanity of the --submodule option of git diff.
 . ./test-lib.sh
 
 add_file () {
-	sm=$1
-	shift
-	owd=$(pwd)
-	cd "$sm"
-	for name; do
+	(cd "$1" &&
+	    shift &&
+	    for name; do
 		echo "$name" > "$name" &&
 		git add "$name" &&
 		test_tick &&
 		git commit -m "Add $name"
-	done >/dev/null
-	git rev-parse --short --verify HEAD
-	cd "$owd"
+	    done >/dev/null &&
+	    git rev-parse --short --verify HEAD)
 }
 commit_file () {
 	test_tick &&
-- 
1.7.8.1.362.g5d6df.dirty
