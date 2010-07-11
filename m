From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCHv2 2/2] fix merge-tree where two branches share no changes
Date: Sun, 11 Jul 2010 14:16:55 +0100
Message-ID: <1278854215-9022-3-git-send-email-wmpalmer@gmail.com>
References: <1278854215-9022-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 15:17:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXwPE-0004Ed-Q5
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 15:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab0GKNRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 09:17:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38320 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332Ab0GKNRG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 09:17:06 -0400
Received: by wyf23 with SMTP id 23so2744603wyf.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wanxaMNfF5qTRDXuDiQAeN+wQTOc93VPmuqRQtKFwVI=;
        b=kwKVSDskuvLs2w+t8wMo7BP7g/wM1iJWCrGK5+alVi+Fo5+87pA0zkB2ODd8g2fRkb
         1c5Z+8P+/P7cWkWmO6hjqHw3lIr9h+x8JXmKSxjc0Y4Re3RPjcIQEBk5wgBrUqW6sMRJ
         ebuAl+FZvELjgcHABuRW8wYbA/gfPbkES2H5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=be8ItxBx909cN6me/Tq/dAorMgJ+LX65yBVeuxY19/0s1A5OylwFs/tekXqR9Agwgl
         05XazKb64bdZ7ftr+fmCtCX78nT8DDaHa45A9E910cQtk2x0wHhIihyVsX+dqcrIvkn3
         Botgw/M0nqJiLxXtQSheyOBksfgcpX9EfVkrI=
Received: by 10.227.7.96 with SMTP id c32mr2584764wbc.109.1278854224630;
        Sun, 11 Jul 2010 06:17:04 -0700 (PDT)
Received: from localhost.localdomain (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id a27sm22521966wbe.12.2010.07.11.06.17.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 06:17:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.703.g42c01
In-Reply-To: <1278854215-9022-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150775>

Here we fix a regression which was introduced by
15b4f7a68d8c3c8ee28424415b203f61202d65d1 /
	merge-tree: use ll_merge() not xdl_merge()

Which caused merge-tree to segfault in particular combinations of
merging files which existed in one branch, but not in the other or in
the merge-base. This was caused by referencing entry->path at a time
when entry was known to be possibly-NULL.

To correct the problem, we save the path of the entry we came in with,
as the path should be the same among all the stages no matter which
sides are involved in the merge.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 builtin/merge-tree.c  |    3 ++-
 t/t4300-merge-tree.sh |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index fc00d79..9b25ddc 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -60,6 +60,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 {
 	enum object_type type;
 	struct blob *base, *our, *their;
+	const char *path = entry->path;
 
 	if (!entry->stage)
 		return read_sha1_file(entry->blob->object.sha1, &type, size);
@@ -76,7 +77,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	their = NULL;
 	if (entry)
 		their = entry->blob;
-	return merge_file(entry->path, base, our, their, size);
+	return merge_file(path, base, our, their, size);
 }
 
 static void *origin(struct merge_list *entry, unsigned long *size)
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index b2ae3a1..5feff91 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -25,7 +25,7 @@ EXPECTED
 	test_cmp expected actual
 '
 
-test_expect_failure 'file add !A, B' '
+test_expect_success 'file add !A, B' '
 	cat >expected <<EXPECTED
 added in local
   our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
@@ -210,7 +210,7 @@ EXPECTED
 	test_cmp expected actual
 '
 
-test_expect_failure 'file remove !A, B' '
+test_expect_success 'file remove !A, B' '
 	cat >expected <<EXPECTED
 removed in remote
   base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
@@ -230,7 +230,7 @@ EXPECTED
 	test_cmp expected actual
 '
 
-test_expect_failure 'file change A, remove B' '
+test_expect_success 'file change A, remove B' '
 	cat >expected <<EXPECTED
 removed in remote
   base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
-- 
1.7.1.703.g42c01
