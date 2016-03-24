From: Stanislav Kolotinskiy <stanislav@assembla.com>
Subject: [PATCH v2] git-send-pack: Fix --all option when used with directory
Date: Thu, 24 Mar 2016 16:14:18 +0200
Message-ID: <1458828858-3577-1-git-send-email-stanislav@assembla.com>
Cc: peff@peff.net, dborowitz@google.com,
	Stanislav Kolotinskiy <stanislav@assembla.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 15:14:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj62F-0005G2-U6
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 15:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbcCXOOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 10:14:48 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35783 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcCXOOr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 10:14:47 -0400
Received: by mail-wm0-f53.google.com with SMTP id l68so238286503wml.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=assembla-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jdFxOXCQoWU5TtG0+guT8Mn38HpQgtsOJlT0P7RuCkQ=;
        b=clQLbOVEJiP4LNhJ7nvldJP5y5WO7A8Nqzo1ZzmcOee3pVli8QJ5bh69mmXFDWbBbw
         j2wJwbd33Jsh22Q3lLVsnORUk3+sjshz6QRqpxBO9szqn/nIhdijlAMTvRAH+h94D/gY
         E7MAiFCGwS9+Qak4ZNOufe1FHJbh1kCl9wnx39MCMlGMA+YGrOemjUsZ6mVxDHVESKNK
         YDegvyk6uvSz0f8BDutA4w6x2RYxoiVObBH0I0oM6jed7nle5W02SYacc2LcuvoAH3VT
         rqE3yMluQ4rfGOBRDQk149FDTCi+9dMx+BRUZdSCSoMoVlzA7BcykRKXXMhRJQkbvtWq
         Xh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jdFxOXCQoWU5TtG0+guT8Mn38HpQgtsOJlT0P7RuCkQ=;
        b=IhKDEmGuYLwSwti2S1qaqZtZbYgNuTV5h+5loGrnCTBDBE15PbZcNyxhMZ27ESrv1x
         rvj8UW/KdCTXX5ymEXVl2z30+B/tAy4HtuKN4qw63FhD9bzlcfD+YgUjXvnBrt6eOm77
         rhO3rqAxCIa8JSFc+xwkT2QttLwpyIwgc+MRTVpQffJcw91PJputEKLJv186t4uhZLyB
         gw5iAqucxKpxLt+tNMi4LokqicYrI5pnJnSJZXbTWJDgNn6GFvSaOTXgjbQRp+OC6uxL
         KT9JCoqTff1Ckn6wD/cPsVEJoA7E2H9uUw8GsSousS+KwxNLP4mJOE+qm3nKPrtSdyI5
         8rBQ==
X-Gm-Message-State: AD7BkJI2p8Bt3CLDUboVTKVQcUdUEAYeQCDwlllU5zlb+L3ZacPNazPoJbomrk8Slw6Wfw==
X-Received: by 10.28.95.131 with SMTP id t125mr34404722wmb.80.1458828885549;
        Thu, 24 Mar 2016 07:14:45 -0700 (PDT)
Received: from localhost.localdomain ([217.26.172.139])
        by smtp.gmail.com with ESMTPSA id xx3sm7586407wjc.32.2016.03.24.07.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 07:14:44 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289746>

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
