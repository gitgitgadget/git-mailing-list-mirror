From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] update-ref: Handle large transactions properly
Date: Tue, 20 Jan 2015 17:20:55 -0800
Message-ID: <1421803255-4037-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jan 21 02:21:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDjym-0004Rx-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 02:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbbAUBVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 20:21:03 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:65158 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbbAUBVA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 20:21:00 -0500
Received: by mail-ie0-f181.google.com with SMTP id rp18so807487iec.12
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 17:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WNHlG/CF4t6seusv0EBFpl4svaLnyAGp+S8V+sFpTvY=;
        b=gmY6Kdkb7WJkinl/fQe9RCTQb5R7K0FqunvVfwQyWBFhrz58N5CNbQtLauYYqj8uNU
         7rjxWKvDt/n0vM80jz4VKRpPgV2aaxffwK1DhfNoGiVrk0n3MmUPPSnQNlALTm9Y4q9B
         n+yMBy5idd222JfhtgrlMCwuxI8PERFXjelVGloznLhlvFKcRgUYO+JNpWyYrS+37rBN
         U3UP6KYvrEoZOqqJg34Xdp2Lu0CV05zGRZmrTgSH6sT3sSv1xWdf4Kxn8uIosirZ1ToZ
         imbOqo2kcHZUcnWSiX+/HtFnqCu97/g0QCaHXYFVxbsz9DCOD/Xpu0RFzTeiMWVWMGkn
         1PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WNHlG/CF4t6seusv0EBFpl4svaLnyAGp+S8V+sFpTvY=;
        b=NuKGWFMiZB3SS+YzzgzkUNWnC3Hz6KVJyX3VjNo1nPWVuKwNDGtneRzOIJ951EBVo+
         wmO+OtRaWQa2hHfDjOGtLoAcFcGge/nqqOmGWX7J3AcjaRYmTk5BquSQJmGKZQR1PYcU
         cOrR8B3Gp1VtLlMx8iBkITcSfcPhkMBtjS6/xaTQhqj4PJnzw22ZlOi3T+/rI/HIryVf
         YezrO+Ogn38izhleaSPp1Y6LiId5kwgzNzTNrwVtTGyRmRhkm6DG5lFWvl0QZOOhgM8Q
         iMHFKjfjbx83Jc9DqK6+CQz1HiQ95jXPCHoXOxKmpYMD/oXA3sMT19CnIJ3PXeoJP2Sc
         yrWg==
X-Gm-Message-State: ALoCoQm350tZhE3n/4OEzOvt7X1axROrD6DCjtkcX+2bZ+zDMxUI1r5xAld07lpO7hXSkOzcEFr1
X-Received: by 10.43.100.67 with SMTP id cv3mr31421358icc.92.1421803259798;
        Tue, 20 Jan 2015 17:20:59 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c80:4a2f:c10f:2f71])
        by mx.google.com with ESMTPSA id vk4sm4316213igc.11.2015.01.20.17.20.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Jan 2015 17:20:59 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262709>

Test if we can do arbitrary large transactions. Currently this is a known
bug that we cannot do large transactions, so document it at least in the
test suite.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t1400-update-ref.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6805b9e..a7dd1ff 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1065,4 +1065,31 @@ test_expect_success 'stdin -z delete refs works with packed and loose refs' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
+run_with_limited_open_files () {
+	(ulimit -n 64 && "$@")
+}
+
+test_lazy_prereq ULIMIT 'run_with_limited_open_files true'
+
+test_expect_failure ULIMIT 'large transaction creating branches does not burst open file limit' '
+(
+	for i in $(seq 65)
+		echo "create refs/heads/$i HEAD"
+	done >large_input &&
+	git update-ref --stdin <large_input &&
+	git rev-parse --verify -q refs/heads/65
+)
+'
+
+test_expect_failure ULIMIT 'large transaction deleting branches does not burst open file limit' '
+(
+	for i in $(seq 33)
+	do
+		echo "delete refs/heads/$i HEAD"
+	done >large_input &&
+	git update-ref --stdin <large_input &&
+	test_must_fail git rev-parse --verify -q refs/heads/65
+)
+'
+
 test_done
-- 
2.2.1.62.g3f15098
