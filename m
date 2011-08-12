From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 22/56] merge-recursive: Fix recursive case with D/F conflict via add/add conflict
Date: Thu, 11 Aug 2011 23:19:55 -0600
Message-ID: <1313126429-17368-23-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBR-0004nj-VZ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab1HLFVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:23 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab1HLFVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:18 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LTqVbMPJWU7xUmTNz8qPGBpSSjhiqlBBf4bR57Un2X8=;
        b=ephwgS99V8OFRD5/xuveD2qk28KmH63wtEWFtqlm3zB0Q2zJGVqJU75lwKt1+3z9FH
         zWqoEqNDGYt+e57JZZv6jlWzWrGJIYjIVa7ytGElJB3GAdOfS2FYcxQxdXNT40qPG+ct
         23lCdQOYXuAqhhoRXNRtMb37iYlUbkZ/URf38=
Received: by 10.231.56.75 with SMTP id x11mr1016000ibg.98.1313126478492;
        Thu, 11 Aug 2011 22:21:18 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.16
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179176>

When a D/F conflict is introduced via an add/add conflict, when
o->call_depth > 0 we need to ensure that the higher stage entry from the
base stage is removed.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c                 |    2 ++
 t/t6036-recursive-corner-cases.sh |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8863b02..85620f7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1468,6 +1468,8 @@ static int process_df_entry(struct merge_options *o,
 			       "Adding %s as %s",
 			       conf, path, other_branch, path, new_path);
 			update_file(o, 0, sha, mode, new_path);
+			if (o->call_depth)
+				remove_file_from_cache(path);
 			free(new_path);
 		} else {
 			output(o, 2, "Adding %s", path);
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 526a2ea..ed6c6f4 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -509,7 +509,7 @@ test_expect_failure 'merge of D & E1 fails but has appropriate contents' '
 	test $(git rev-parse :2:a) = $(git rev-parse B:a)
 '
 
-test_expect_failure 'merge of E1 & D fails but has appropriate contents' '
+test_expect_success 'merge of E1 & D fails but has appropriate contents' '
 	get_clean_checkout E1^0 &&
 
 	test_must_fail git merge -s recursive D^0 &&
@@ -539,7 +539,7 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
 	test -f a~HEAD
 '
 
-test_expect_failure 'merge of E2 & D fails but has appropriate contents' '
+test_expect_success 'merge of E2 & D fails but has appropriate contents' '
 	get_clean_checkout E2^0 &&
 
 	test_must_fail git merge -s recursive D^0 &&
-- 
1.7.6.100.gac5c1
