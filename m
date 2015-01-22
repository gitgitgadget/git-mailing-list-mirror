From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/5] update-ref: test handling large transactions properly
Date: Wed, 21 Jan 2015 18:32:05 -0800
Message-ID: <1421893929-7447-2-git-send-email-sbeller@google.com>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 03:32:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE7ZS-0007xw-BZ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 03:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbbAVCc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 21:32:27 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:54129 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbbAVCcP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 21:32:15 -0500
Received: by mail-ig0-f177.google.com with SMTP id h15so288235igd.4
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 18:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fV4neS9W27OgnJcg70iS0O7Qam1Jh2NrObPTkUq+/uM=;
        b=F8hLtn8OCgN4k7WXkte8R5iOWuvwNmqZvV2vdIrViemTgvVIzHN3GYg66kE27hhGlc
         LhOo6Q3eIQ9H451FdjCPTxB2UE8Y9N0RCgjzhRua8HuHrK7ZRB92/Vq6J9+Zg7j3GMAn
         KNs/43vHnoWrYCq5rVzcBVRR0SbM7vC5s8NQK0sGqTkjEJFg4gNss5LODM1BOawVNHUD
         E5cC4E16DtDY8RmatsYhwt2iYSew4UYylJYZIP0BFYogh0k7Ic3KxnMzzCb6hF0RHdKW
         65ufcFwkULXxJi+fZ4NZEDZRu7yxQQhON6s2HsEeWjddQvNz7sKsJrvf+Q056eEBPiFO
         n6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fV4neS9W27OgnJcg70iS0O7Qam1Jh2NrObPTkUq+/uM=;
        b=fVG5nqgvamcQYsH8Ws/gv1UcK6CIXoD1Nm9fnvn/UJYKVu9cEbkr2yT0JK7RtFuTrg
         IBDwrTAaBtHF5H88+al63WKBd/394ZIMOaPaTBD6DFwQdADGnoPOGgYGX1faW82OaE4B
         zHODx6yqkztk08ZW0/QbFfka4B4WDvkPHsm8w7MG1KPdIlxBpfpSVBB2xa5ut4MDUlit
         iVdlKUF/zIpbsrOScSJbGfvS6B9zhXy9FqjoTZ7oq1USTKOp6VXM0rAuZ2U8jz92we8b
         9fas+NYiFa1jEuq9yo3qSvNqOkuNC+qlOmjwvTX/tJBDLtpEm47sAMcmXrf81nVVSHv8
         skdg==
X-Gm-Message-State: ALoCoQly0W6ovi18McIqIbNADYhjAEVA+QRHTbc1E88+sEEHeMDoqR8jvaFK/JJ+z4Cdy2DZCQEe
X-Received: by 10.43.34.137 with SMTP id ss9mr230807icb.11.1421893933903;
        Wed, 21 Jan 2015 18:32:13 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id i20sm1166785igh.16.2015.01.21.18.32.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 18:32:13 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421893929-7447-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262792>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t1400-update-ref.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7b4707b..47d2fe9 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -973,4 +973,32 @@ test_expect_success 'stdin -z delete refs works with packed and loose refs' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
+run_with_limited_open_files () {
+	(ulimit -n 32 && "$@")
+}
+
+test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
+
+test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
+(
+	for i in $(test_seq 33)
+	do
+		echo "create refs/heads/$i HEAD"
+	done >large_input &&
+	run_with_limited_open_files git update-ref --stdin <large_input &&
+	git rev-parse --verify -q refs/heads/33
+)
+'
+
+test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
+(
+	for i in $(test_seq 33)
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
