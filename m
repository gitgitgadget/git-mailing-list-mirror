From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/6] update-ref: Test handling large transactions properly
Date: Wed, 21 Jan 2015 15:23:40 -0800
Message-ID: <1421882625-916-2-git-send-email-sbeller@google.com>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	peff@peff.net, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 00:23:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4cx-0000Lu-6p
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbbAUXXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:23:52 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:58239 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbbAUXXt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:23:49 -0500
Received: by mail-ie0-f170.google.com with SMTP id y20so18663651ier.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 15:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EbhgDPQHRbnN+Xv0cwTyAM0+TXTDMC4dK2YStLG/FEo=;
        b=adCcXpHxH6cbhfA2JMUKyZxmuYGwuVn/ZrmMRcAFjTQPRN9DbNnsMhY6Y0mF9LmbYQ
         6G2FUdmiknIxGuuQZkpjkCNWre/tmcb1c6ne5UHjDrO1sQwgFr969hPWGzCy9odubvv+
         A5/7Gd2NX/HVYo9UWwJOEH/FoAUrqPDid9rl/C1BrmujvgMP9urIGytl8qOBZhcHv+fs
         H1FDbfCsudBcx4yVfVii50+fWUGvmdAhdxTwauH+wVCyVCgOILhvLEQ5zLCXt5NNOkQm
         FmTrDqvxKwgpsrHOTUj9x0cYH4GQlYZYCVFyp8Xir2z0m6VnGrxv5YtCWRJGKM5ho2Sn
         u4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EbhgDPQHRbnN+Xv0cwTyAM0+TXTDMC4dK2YStLG/FEo=;
        b=MPWuh9u7DXvD6Q/lXKhT5phFX8jrdWAeX5XCPqAUSyd587BpXr34QY+4BP6LcKFsva
         vZrUDIkzsXxsbfdCgtH+hwrtJjbuhC8IAtLRp5WNcntN9wedXLbhkwkAeIAPl02GEgK2
         MYCf7mKs+238e5pDi8etN+li2GvczsElJaqtEGaETkZQ5kzSVOrlaweP7O+yKfW9hChM
         v2x8cX0bHWwafVrAda19s95RiNxkDq3IxsxN8GA4Syun8yNfJRrs6BERkgeOBHQl4n01
         nLAvBnrXV+/bOwLeB86ArLbjUOhN1hyncLMX41ggIlEV4Fs8m2uNgO+6rSKt/DYmRtlx
         eV2w==
X-Gm-Message-State: ALoCoQlPEn2B+71HD1LBFSFe/CK0+2FkRs4gmAsfebn4IEWDC30xEXwdRoIgQuEQMZr7Pl3zpbmS
X-Received: by 10.50.119.9 with SMTP id kq9mr148432igb.36.1421882628518;
        Wed, 21 Jan 2015 15:23:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id qr1sm667350igb.18.2015.01.21.15.23.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 15:23:48 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421882625-916-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262777>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t1400-update-ref.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6805b9e..ea98b9b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1065,4 +1065,32 @@ test_expect_success 'stdin -z delete refs works with packed and loose refs' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
+run_with_limited_open_files () {
+	(ulimit -n 32 && "$@")
+}
+
+test_lazy_prereq ULIMIT 'run_with_limited_open_files true'
+
+test_expect_failure ULIMIT 'large transaction creating branches does not burst open file limit' '
+(
+	for i in $(seq 33)
+	do
+		echo "create refs/heads/$i HEAD"
+	done >large_input &&
+	run_with_limited_open_files git update-ref --stdin <large_input &&
+	git rev-parse --verify -q refs/heads/33
+)
+'
+
+test_expect_failure ULIMIT 'large transaction deleting branches does not burst open file limit' '
+(
+	for i in $(seq 33)
+	do
+		echo "delete refs/heads/$i HEAD"
+	done >large_input &&
+	run_with_limited_open_files git update-ref --stdin <large_input &&
+	test_must_fail git rev-parse --verify -q refs/heads/33
+)
+'
+
 test_done
-- 
2.2.1.62.g3f15098
