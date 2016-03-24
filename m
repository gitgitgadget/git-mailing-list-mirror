From: Stanislav Kolotinskiy <stanislav@assembla.com>
Subject: [PATCH v3] git-send-pack: Fix --all option when used with directory
Date: Thu, 24 Mar 2016 16:16:29 +0200
Message-ID: <1458828989-3799-1-git-send-email-stanislav@assembla.com>
Cc: peff@peff.net, dborowitz@google.com,
	Stanislav Kolotinskiy <stanislav@assembla.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 15:17:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj64K-0006pG-Aj
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 15:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882AbcCXOQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 10:16:53 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37250 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcCXOQv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 10:16:51 -0400
Received: by mail-wm0-f42.google.com with SMTP id p65so67858150wmp.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=assembla-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=hjJ0mOwWe7fGYr3WmtEeMnHdtjnYbnSdiuX7/C6nC2w=;
        b=eshCtpMuBGXJJM/Qgx5ZbFMlJ1QIOYUgD+urpfNSzjaAhwuziCrU75A/GKhlc3kmer
         bIEodskuWsy57628jDBqXQ9xgW8WKrwJvdoWmYsch6E4hqov/0882tmKtcCs4q2Vy/rW
         tyqG5O8ikoVP4vOdkFz08bjpXGm12z+q+QIr+n35CQ5CedZQ5gfdPBcRYlxufczFhlJW
         oXnTk4jpbD/siBX4EAtxINCHJ1ro5YFtfJ6JghngGZUTRu4iGD73opmdloclpdwuSKaZ
         ecLVIZjdCqLMS3D2HpjKsjFgII2viRkAMgBfD1jT6fMZ4CUkaS+Rtsd/E7VzfP0Lpd99
         Lebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hjJ0mOwWe7fGYr3WmtEeMnHdtjnYbnSdiuX7/C6nC2w=;
        b=Ncys2qpHvrfuiy0FkilGEUtumwe9AioBTXvoGQvKscPs25BZoVa+xVG/wNy4ICBQ09
         HE5gEHpPk8723f4iCuyl8zHExHwzgz2+iLdTm74YYWwvoEuVC4B50bJ1NMnAdyWKzmn9
         EosF1xKggSqOBMDyX2yIOBSnmc+cMXtdtor0wTCzSZpElBAOydC+joDe5WquwDNKQCeW
         NC8lU0XkIonPfZer49XvFZTLYMc3n1ZiHB6e99mQDylE6DJnA7xWTrkQkYv3fEQGZt/j
         Nk1vPhp3oeXQ6b//vD6uhDo3M6HIyvOcVyAmROarPTyvocRi6kQzcNj6jXbdOUVmOLjf
         tnPg==
X-Gm-Message-State: AD7BkJJQbNEXP5VufR54C9//jziWBaXmQX3MkzzAD5h/FpnSfhm8OTdl0AgDPLfKGRh8Nw==
X-Received: by 10.28.0.148 with SMTP id 142mr10394463wma.72.1458829008789;
        Thu, 24 Mar 2016 07:16:48 -0700 (PDT)
Received: from localhost.localdomain ([217.26.172.139])
        by smtp.gmail.com with ESMTPSA id fv6sm7625537wjc.12.2016.03.24.07.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 07:16:47 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289747>

When using git send-pack with --all option
and a target directory, usage message is being
displayed instead of performing the actual transmission.

The reason for this issue is that refspecs variable is being
calculated in a different way comparing to previous versions,
and even though the number of refspecs (nr_refspecs) is 0,
refspecs contain all the arguments and switches passed to send-pack.

This ensures that send-pack will stop execution only when --all
or --mirror switch is used in conjunction with any refs passed.

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
2.7.4
