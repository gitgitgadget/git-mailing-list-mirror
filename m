From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH 2/2] fix merge-tree where two branches share no changes
Date: Sat, 10 Jul 2010 01:53:51 +0100
Message-ID: <1278723231-24802-3-git-send-email-wmpalmer@gmail.com>
References: <1278723231-24802-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 10 03:01:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXORQ-0004GL-NX
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 03:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186Ab0GJBBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 21:01:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61731 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab0GJBBK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 21:01:10 -0400
Received: by wyf23 with SMTP id 23so2051860wyf.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=k1ZXqO/vqEKLc1Fv6ytrZO6OD2OLpLnp6rh+R+6hXNY=;
        b=lh1/Lp3/qpxtSXkdWCNhcnaMBIF7kz8kSdgJnu+YgoUx/4IlJ0PMaSToGSmx7rPPQ7
         /cr4LmdD80JNz3NFnRYyJNj9aLp3Adjs8a2vVR4/Ifq9cYCbXgzCSJg/tngAJV9mxXpi
         VM4U9iy/p8+wJEesI6T5VdO2GCdODx3krqoT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lrC05iEXifL7KWpjOYIm7SSVq8Ec4pkQS1BYEfFqKEG990uqu1s5p4OfF9m8EUvxfD
         hoB6thKnqMtcTUreOhCzGeMEZD5qyGtYbB6uzJD/WqWWdvz/FAwmu8leFHN17r/2He1R
         qRTDW45rVnZn+yLrBNiQWsaPs38B06zzxBDwQ=
Received: by 10.227.140.154 with SMTP id i26mr3565039wbu.199.1278723257610;
        Fri, 09 Jul 2010 17:54:17 -0700 (PDT)
Received: from localhost.localdomain (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id i25sm10539963wbi.4.2010.07.09.17.54.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 17:54:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.703.g42c01
In-Reply-To: <1278723231-24802-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150704>

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
 t/t4300-merge-tree.sh |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

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
index afcb89d..97a3deb 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -30,7 +30,7 @@ test_expect_success 'both added conflict' '
 	git merge-tree initial diff-A diff-B
 '
 
-test_expect_failure 'nothing similar' '
+test_expect_success 'nothing similar' '
 	git reset --hard initial
 	test_commit "no-common-A" "ONE" "AAA" 
 
-- 
1.7.1.703.g42c01
