From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5] Another squash on run-command: add an asynchronous parallel child processor
Date: Wed, 23 Sep 2015 16:41:51 -0700
Message-ID: <1443051711-15322-1-git-send-email-sbeller@google.com>
References: <xmqqpp19xbpz.fsf@gitster.mtv.corp.google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 01:42:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zetfp-0003mg-6I
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 01:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbbIWXl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 19:41:59 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33985 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914AbbIWXl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 19:41:58 -0400
Received: by padhy16 with SMTP id hy16so53985971pad.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DuWCf2olyYAp8Qcv/OujORuJcjqRD9khxTTInfYn1qo=;
        b=GSd90AIBs1tMh0pqAoAcrFRDBaKQUdBXheRMMT3HlI8rVNQPLEkIimZSfc1EabHPm0
         IK4YVMKWmoR46+qjJzxPYEO085Iyij9Agbm5haIlujvvZzFAI2dnODAg8M6u4ngoJXib
         hKjQY5Ofwk11jiqLRoFXiyMDZ/qNnJWkACkthNGAdMf2BzO+StGDyEqRWcG2Qm34DHsz
         IGd3dqtecb/DzaYc/waJIMXscw6RXqrVB7F6KVrS6kihyO3BEsr2pqimJk8yGOSX7Sj/
         BUNNHHqSHJXkLRt2sVl+sYuALPdVlPr+FgvZvcfaVpltcd6Yl4qoVY5gJZxSJj57rC0x
         FnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DuWCf2olyYAp8Qcv/OujORuJcjqRD9khxTTInfYn1qo=;
        b=HItDQRBgd2rJuHwtUqdFCZcjODFtKyTqYuxJdWmG+i/2fTV8HRv+/udUhd4GT99Bls
         s8HBFzrrE0L3ZgkIVziZjMSKcIT4HCfut9tslh2CzSoFV1iR1+G9epZQPqFPHEoFOj4e
         0tFUl8K1U0JnfDfZlHY/lTVQxLPQhx+IB1U9tKSt61VVqGdMN6STQVRGR3+mxFGp4/ov
         F5xgluOIAZnFR/MT5d9TxEkqSN9AtqZ0Xz/eFpjUQo8e5gPs5BQLY/c1LijmO6kZSmLA
         6KqSotcDyyL+6whBLOFKTN5gyVzY5dFhelsjrqQl0VRjI046+9DPvuFsyJJBog8z0a60
         Fe0A==
X-Gm-Message-State: ALoCoQl+cOOpRTXzW5lFXl6sCk3ebAThzpE55p8Lz/2Oh00bamY0ZN/NK8QNfblzwIL3Nvs3sYmr
X-Received: by 10.66.124.229 with SMTP id ml5mr39836529pab.77.1443051718153;
        Wed, 23 Sep 2015 16:41:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:1c11:7f2f:c8db:35c])
        by smtp.gmail.com with ESMTPSA id rk2sm1715216pbc.75.2015.09.23.16.41.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 23 Sep 2015 16:41:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <xmqqpp19xbpz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278522>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I agree the commit 7087c5f3 (SQUASH??? on top of run-command: add an
asynchronous parallel child processor) makes sense; I arrived at the same
patch after adding in the feedback.

However I have the difference below, which I think could also be squashed in.
when we operate under the assumption that the CPUs are the bottleneck in
the case of parallelism.

 run-command.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index b6d8b39..e9722ff 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1107,8 +1107,13 @@ static void pp_collect_finished(struct parallel_processes *pp)
 	}
 }
 
-
-#define SPAWN_CAP (pp.max_processes + 1) /* spawn as many as possible */
+/*
+ * Throttle spawning children when starting the asynchronous processing,
+ * such that the first process to produce output is not slowed down to
+ * enable the fastest early feedback to the user.
+ */
+#define SPAWN_CAP (pp.max_processes + 1 < online_cpus() - 1 ? \
+		   pp.max_processes + 1 : online_cpus() - 1)
 
 int run_processes_parallel(int n, void *data,
 			   get_next_task_fn get_next_task,
-- 
2.5.0.273.g6fa2560.dirty
