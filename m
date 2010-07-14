From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCHv3 2/2] fix merge-tree where two branches share no changes
Date: Wed, 14 Jul 2010 18:04:07 +0100
Message-ID: <1279127047-3273-3-git-send-email-wmpalmer@gmail.com>
References: <1279127047-3273-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 19:04:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ5O6-0001yA-Qh
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765Ab0GNREd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 13:04:33 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47645 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab0GNREc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 13:04:32 -0400
Received: by wwi17 with SMTP id 17so2255015wwi.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ec/0USDph/gOowTimU060s87XP/xakqRgk9qgYvI0Mk=;
        b=r2hHIFcoF/CoDJdCt2YoulukIItXuxNmYFK9BKqVuP9PNPVZpTWoRgw+BKkNpU9Lv7
         W9XJRGGFybkc3hvxAiqW5oAPjmrcL+wJ7A4rDW/nKqeWrs9TAvmfg6EG7GUl/SaaiBTO
         HZM2utyNcw/Bexebu+hQfxIuZa9qDyZSAobLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=u7lOonnKTOK73vjTHK1IjmKK9/byhQsiXd8ZvcpRDUmilh7+8wi5nY0VnONGAliTtn
         Dmz+YmxalvK8EwXR7l9kWqg53ly9G9pNv9iBOuxYFYA/3zO+HW1E4e2aqJ4EaKEtu0RU
         4Tvsok1qpB1Mk7LkXd/jC2HiC/bE48/mfVT3E=
Received: by 10.227.142.136 with SMTP id q8mr16291622wbu.95.1279127067920;
        Wed, 14 Jul 2010 10:04:27 -0700 (PDT)
Received: from localhost.localdomain (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id o11sm3259854wej.21.2010.07.14.10.04.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 10:04:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.703.g42c01
In-Reply-To: <1279127047-3273-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151012>

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
index c02c986..4d0920c 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -24,7 +24,7 @@ EXPECTED
 	test_cmp expected actual
 '
 
-test_expect_failure 'file add !A, B' '
+test_expect_success 'file add !A, B' '
 	cat >expected <<\EXPECTED
 added in local
   our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
@@ -195,7 +195,7 @@ EXPECTED
 	test_cmp expected actual
 '
 
-test_expect_failure 'file remove !A, B' '
+test_expect_success 'file remove !A, B' '
 	cat >expected <<\EXPECTED
 removed in remote
   base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
@@ -213,7 +213,7 @@ EXPECTED
 	test_cmp expected actual
 '
 
-test_expect_failure 'file change A, remove B' '
+test_expect_success 'file change A, remove B' '
 	cat >expected <<\EXPECTED
 removed in remote
   base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
-- 
1.7.1.703.g42c01
