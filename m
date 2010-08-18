From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 5/8] detached-stash: simplify git stash branch
Date: Wed, 18 Aug 2010 23:48:50 +1000
Message-ID: <1282139333-5150-2-git-send-email-jon.seymour@gmail.com>
References: <1282139333-5150-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:49:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olj1C-00056e-5Y
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888Ab0HRNtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 09:49:24 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57658 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab0HRNtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:49:22 -0400
Received: by pvg2 with SMTP id 2so215178pvg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OzjnHGbjD/hm7+Hrm8UYXCkhr/os8nXiCZXmTtLwQKc=;
        b=IG+oZpkp3+1xxP/uhqfMbUeH8DelsJMtyk95JmQDwe01QZJLj7qdwwftsDFIRbPRYS
         zzkA8eFJJQ7OnrMvYgNBE7526z2Dw0ywvad/Mi4IkDUocfuyWSUBFdUf3hklmEaIhjRF
         MTLVYGjUyISt9LAluJc8tc4rHfGXpvi12flAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=U0r+CGp4jvtcURLe4AEkuTpRX0qsBQRJy/y2uaJ04toshggE5/LlEn5I3zQRBJ6dMD
         2pUq7KJyQpmEl/ROe0zGfIPEWPl+MuD4R97lYLw4y47BMJBaAG9wich4QacKeylwHDjP
         8uIMVGyb6JbFRwChI46lJbWXpPEY/vKGOp8/k=
Received: by 10.114.66.5 with SMTP id o5mr9569553waa.219.1282139362152;
        Wed, 18 Aug 2010 06:49:22 -0700 (PDT)
Received: from localhost.localdomain (203-158-55-26.dyn.iinet.net.au [203.158.55.26])
        by mx.google.com with ESMTPS id s5sm538803wak.12.2010.08.18.06.49.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:49:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.88.g3dbe5
In-Reply-To: <1282139333-5150-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153851>

This patch teaches git stash branch to tolerate stash-like arguments.

In particular, a stash is only required if an argument isn't specified
and the stash is only dropped if a stash entry reference was
specified or implied.

The implementation has been simplified by taking advantage of
assert_stash_like() and the variables established by
parse_flags_and_rev().

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index ac4c0f6..ff1edc9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -441,20 +441,17 @@ drop_stash () {
 }
 
 apply_to_branch () {
-	have_stash || die 'Nothing to apply'
-
 	test -n "$1" || die 'No branch name specified'
 	branch=$1
+	shift 1
 
-	if test -z "$2"
-	then
-		set x "$ref_stash@{0}"
-	fi
-	stash=$2
+	set -- --index "$@"
+	assert_stash_like "$@"
+
+	git checkout -b $branch $REV^ &&
+	apply_stash "$@"
 
-	git checkout -b $branch $stash^ &&
-	apply_stash --index $stash &&
-	drop_stash $stash
+	test -z "$IS_STASH_REF" || drop_stash "$@"
 }
 
 PARSE_CACHE='--not-parsed'
-- 
1.7.2.1.95.g4fabf
