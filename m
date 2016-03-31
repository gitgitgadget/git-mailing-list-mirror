From: stanislav@assembla.com
Subject: [PATCH v4] git-send-pack: fix --all option when used with directory
Date: Thu, 31 Mar 2016 16:55:09 +0300
Message-ID: <1459432509-12934-1-git-send-email-stanislav@assembla.com>
Cc: peff@peff.net, dborowitz@google.com, gitster@pobox.com,
	Stanislav Kolotinskiy <stanislav@assembla.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 15:55:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ald4Q-0008Ag-QH
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 15:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbcCaNzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 09:55:31 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33429 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbcCaNza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 09:55:30 -0400
Received: by mail-wm0-f41.google.com with SMTP id f198so2315280wme.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 06:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=assembla-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=It948F/BDl6+bPY+Fg9s7lQZDD9rA6kD0LMparF6KA0=;
        b=I7Mw5/rTDlXUGSdE1du0+zSyytnpH8BM6uDr2ZWPe0jLDzWwtV1YfwMY1HxI8BINvk
         7uQIjvQgFap1GfFI7uCf1D3QfX4E8A2LmPKYntIerJdWeZ2+cXv2pyLGrXJnoNWuzmFT
         +SrHV+1Z9e6DQcCUkDzug7ZHkrN3qPGvN3MVYWXXHG5ZYyKC0Z8lxAe3KlJg8s33V6Ka
         BGC/+QEsgJiCJCwcAwcB5mTnlfjJ3ZPbaWeOFjkwC+g99H0rRG51L8QxmptwS77AJwfq
         3AH+Kaoihe6f7/zeueehBrWFv41Tw+kjQzGsYuBPAYPrg/D9AqG2RnMZaeLicp7LQPQv
         69oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=It948F/BDl6+bPY+Fg9s7lQZDD9rA6kD0LMparF6KA0=;
        b=blzSVtusMiLv18j8xgIkj0mDfv1LxCElqJw/Y28Ni5sFHNCOD0K397c6IRu59ItiwV
         Zy+6tVHTBScC2X/BieGJJlL/rUJzE/8fUwMCYWdi81D7rdByTYtot4vxdP7VdJlN5ogU
         hu7DtWs74nbSpQP/maJhTXRW3qJD4IzdDfmLjDkfu9dp0DslZG036AFKru1JTY14DeCu
         9mZ+dC5mT2MjvUDR4HZbCIsvH/NzIpDOEPNVahfCVMle367MUm/SJIiAhWkW072zvQPB
         u2qMqHvBfQ4HjxULBsTPRGfKp4Pv2HgcldzcjC5iZLbjeKiyH8XYGHNyfY8GoygNBKHa
         3zsQ==
X-Gm-Message-State: AD7BkJKUlnDehnCf7YuB7txDbmiDdFWOEnEfvgHNVy+caOLvS/xrdAoOIlnySS+6smJeOQ==
X-Received: by 10.194.184.139 with SMTP id eu11mr12448552wjc.154.1459432528703;
        Thu, 31 Mar 2016 06:55:28 -0700 (PDT)
Received: from localhost.localdomain ([217.26.172.139])
        by smtp.gmail.com with ESMTPSA id 188sm14244907wml.19.2016.03.31.06.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 06:55:27 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290382>

From: Stanislav Kolotinskiy <stanislav@assembla.com>

When using git send-pack with --all option
and a target repository specification ([<host>:]<directory>),
usage message is being displayed instead of performing
the actual transmission.

The reason for this issue is that destination and refspecs are being set
in the same conditional and are populated from argv. When a target
repository is passed, refspecs is being populated as well with its value.
This makes the check for refspecs not being NULL to always return true,
which, in conjunction with the check for --all or --mirror options,
is always true as well and returns usage message instead of proceeding.

This ensures that send-pack will stop execution only when --all
or --mirror switch is used in conjunction with any refspecs passed.

Signed-off-by: Stanislav Kolotinskiy <stanislav@assembla.com>
---
 builtin/send-pack.c  |  2 +-
 t/t5400-send-pack.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f6e5d64..19f0577 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -225,7 +225,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	 * --all and --mirror are incompatible; neither makes sense
 	 * with any refspecs.
 	 */
-	if ((refspecs && (send_all || args.send_mirror)) ||
+	if ((nr_refspecs > 0 && (send_all || args.send_mirror)) ||
 	    (send_all && args.send_mirror))
 		usage_with_options(send_pack_usage, options);

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 04cea97..305ca7a 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -128,6 +128,18 @@ test_expect_success 'denyNonFastforwards trumps --force' '
 	test "$victim_orig" = "$victim_head"
 '

+test_expect_success 'send-pack --all sends all branches' '
+	# make sure we have at least 2 branches with different
+	# values, just to be thorough
+	git branch other-branch HEAD^ &&
+
+	git init --bare all.git &&
+	git send-pack --all all.git &&
+	git for-each-ref refs/heads >expect &&
+	git -C all.git for-each-ref refs/heads >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	mkdir parent &&
 	(
--
2.8.0
