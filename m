From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] merge-recursive: Fix multiple file rename across D/F conflict
Date: Tue, 17 Aug 2010 17:53:19 -0600
Message-ID: <1282089199-17253-3-git-send-email-newren@gmail.com>
References: <1282089199-17253-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 01:52:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVwt-0006gP-M5
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab0HQXv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 19:51:56 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62744 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0HQXvz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 19:51:55 -0400
Received: by mail-qw0-f46.google.com with SMTP id 6so6618535qwh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rWBKbIkT77AdwholkD9H4YpDmOgWynMXwlfwEA2OZAE=;
        b=WlGe8VZEarw9vJ4dkOHfYK8rEM3PAvVu4tQ6uspy6ujBjtS3z1SeW8yM+Ny/u6k4sB
         hM0+ZST4nb+VXhdbQ7+nexaWlfwQrwtzgqHVWLwxkMk92mWy1jLRLYMn2py8DWZVm85Q
         dEN5N0YYc2MFSkPprLbqFDfAc+KZBep3XT5S8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GpeoHFwPYsy6uTIccvLZluXMH8y+PRP/xb/n6dtP5YjJ37hhFz6oaDBgJaocc2qJkI
         5oNWcS1Ocqob4VHj7B8Qz7tbEp5jtOaAlQt27ct5NrcuhZQ7fxuLkZcnxylYfjD54lEW
         /jenvGO8khiXGTF83x5zcVIndGBMJu1kt01Fo=
Received: by 10.224.18.22 with SMTP id u22mr4872981qaa.18.1282089110406;
        Tue, 17 Aug 2010 16:51:50 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r36sm9427471qcs.3.2010.08.17.16.51.48
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 16:51:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.227.g086c8
In-Reply-To: <1282089199-17253-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153796>

In 5a2580d (merge_recursive: Fix renames across paths below D/F conflicts
2010-07-09), detection was added for renames across paths involved in a
directory<->file conflict.  However, the change accidentally involved
reusing an outer loop index ('i') in an inner loop, changing its values
and causing a slightly different type of breakage for cases where there are
multiple renames across the D/F conflict.  Fix by creating a new temporary
variable 'i'.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
I'm really embarrased about this one...  :-/

 merge-recursive.c          |    1 +
 t/t6031-merge-recursive.sh |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index af53b2a..f413e9f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1018,6 +1018,7 @@ static int process_renames(struct merge_options *o,
 				if (mfi.clean &&
 				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
 				    mfi.mode == ren1->pair->two->mode) {
+					int i;
 					/*
 					 * This messaged is part of
 					 * t6022 test. If you change
diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
index aa235b9..25ae637 100755
--- a/t/t6031-merge-recursive.sh
+++ b/t/t6031-merge-recursive.sh
@@ -57,7 +57,7 @@ test_expect_success FILEMODE 'verify executable bit on file' '
 	test -x file2
 '
 
-test_expect_failure 'merging with triple rename across D/F conflict' '
+test_expect_success 'merging with triple rename across D/F conflict' '
 	git reset --hard HEAD &&
 	git checkout --orphan main &&
 	git rm -rf . &&
-- 
1.7.2.1.227.g086c8
