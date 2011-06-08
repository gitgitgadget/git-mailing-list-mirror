From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 21/48] merge-recursive: Fix recursive case with D/F conflict via add/add conflict
Date: Wed,  8 Jun 2011 01:30:51 -0600
Message-ID: <1307518278-23814-22-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDK-0005pC-UE
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923Ab1FHH3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902Ab1FHH3i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:38 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=RqI83c2IAyJzS7qDe2jJ/ayhwllh1e0CTGI8u01QBTc=;
        b=mXCKuY8v5c7GuXMD4at+ox3e8gJLQQzhjNGKsUsW23QVu5gskfxbnUpmh4VsaGD/QI
         Qkb8OBk0GOIdUbeRJuVcvyARMJIQSPGTrG/igzJoSf1RrYEnjNtWTirrq8DJZh0BYAsn
         t88b9WdLQuJP+Dv7h19uwNhnD/VJ4yxqKwgqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ETBbZrSxXkulQTFrKcEGhg2bStOS4u3c7y9dXBETLlZaaLXuKChe11psFkaowgrl44
         rOzKgLBv3z6xdYy+Z6Tvz2BVNNyKNIUGz1bVIfJ9yen0l8/U4CTDb8FroBL03tHDLhiw
         A+0ovaYq6VuA0TiwG3h+CsYJp23mETHeiEqT8=
Received: by 10.68.28.136 with SMTP id b8mr701531pbh.457.1307518177820;
        Wed, 08 Jun 2011 00:29:37 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.35
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175311>

When a D/F conflict is introduced via an add/add conflict, when
o->call_depth > 0 we need to ensure that the higher stage entry from the
base stage is removed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                 |    2 ++
 t/t6036-recursive-corner-cases.sh |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7da6aa0..4771fb4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1480,6 +1480,8 @@ static int process_df_entry(struct merge_options *o,
 			       "Adding %s as %s",
 			       conf, path, other_branch, path, new_path);
 			update_file(o, 0, sha, mode, new_path);
+			if (o->call_depth)
+				remove_file_from_cache(path);
 			free(new_path);
 		} else {
 			output(o, 2, "Adding %s", path);
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 2fa7c3e..423fb62 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -494,7 +494,7 @@ test_expect_failure 'git detects conflict and handles merge of D & E1 correctly'
 	test $(git rev-parse :2:a) = $(git rev-parse B:a)
 '
 
-test_expect_failure 'git detects conflict and handles merge of E1 & D correctly' '
+test_expect_success 'git detects conflict and handles merge of E1 & D correctly' '
 	git reset --hard &&
 	git reset --hard &&
 	git clean -fdqx &&
@@ -528,7 +528,7 @@ test_expect_success 'git detects conflict and handles merge of D & E2 correctly'
 	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file)
 '
 
-test_expect_failure 'git detects conflict and handles merge of E2 & D correctly' '
+test_expect_success 'git detects conflict and handles merge of E2 & D correctly' '
 	git reset --hard &&
 	git reset --hard &&
 	git clean -fdqx &&
-- 
1.7.6.rc0.62.g2d69f
