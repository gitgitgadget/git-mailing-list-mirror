From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 13/19] fsck: Optionally ignore specific fsck issues
 completely
Date: Fri, 19 Jun 2015 15:34:47 +0200
Organization: gmx
Message-ID: <12e0b6157d95cf259b43a167dfa6e2b77dba60a6.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:35:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wRe-0000h3-KO
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbbFSNez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:34:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:51282 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398AbbFSNex (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:34:53 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MDQUP-1ZKWt31eAv-00GpYm; Fri, 19 Jun 2015 15:34:48
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:jo4BroH56mbeUJrp8C+Va3vQybP6FxxZTeu1sRBtRz2Scottvar
 IVpvCLjwaxZVcpT99ElBiifLMPcBr/HdWyR2Hp48zU7hUsqVUhwu4oo9Ed76W+JBLstM+3z
 XeS9kh9OOp3h/kfQ6u4m3yVZgZln+snxNYWg55hhOXqRvx77d+aBm1QVtK3Hwr+Zssxi2zR
 JzIrePwTonYgZpVLLXxZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i0Q8IgYeeCI=:dcZlx3fayQDW54N0xeAfIo
 EK4lSy45K4p8ANnJyMoLe/KZPLTEO7g5PdMDJvRLh4rHuHGsQrPeWrAIJSnf6ZpnHC+BRYpAz
 5u9ePFNLfbmORxe1+irIXaob5AQ+SPFQus+wVjsiaMxJMLl+xZGot/L9uNjMbe39gtzMSnBYC
 Mni/RM14NNYuXzyJqfz9NNGqoC2Adwu2e+dWgusmTSe6CpunrgBc7NpcuxICGaPqAvoim5uTY
 x53EeX5vZoIjerYKdlYD4WTH9bcPN1gIR4Y+Ck/QjcPKFpexChvcmjU4f9KTomHXfs/MDtZgC
 tsPuEooHexv9aKvgNvz0fFBacHfOhH4RdtB3GNV15jENyDLxDHOGY+fFMtSiOc+n0zj13UCJP
 hHubTSfCHVze9tESj+90qGGmPzkMz4d/4Rz2JAkFL8HZkhhvZHux2p4V8HiHN2uAHz6s/NWgy
 KxB8PIxbrlR7/LOb9a4EsiqKKg/8fMGXCQ9LPGTUGiq2YnIju6z7fFWDJcFeO3iWCTiKFvT1q
 O1Pdv1Fd1jr5JTJi20MFoXNBRBN8HVXmj0CCWQ9jsOwETDm3qQUrIY2+Enpc9yTHFEl0ZeioN
 V7Ez1Q/NY+SQz7oZO64X01DOpO8kcFUTl7iWarQ7jLLNDymbugaezvJvl+7uo1otZy2uIE25k
 ID5hoFlJeBXTzRTZ5XphSv/mFp8KYRuYSams4uFexxKpstXU7UZjosGvQ8iAryegNBEo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272149>

An fsck issue in a legacy repository might be so common that one would
like not to bother the user with mentioning it at all. With this change,
that is possible by setting the respective message type to "ignore".

This change "abuses" the missingemail=warn test to verify that "ignore"
is also accepted and works correctly. And while at it, it makes sure
that multiple options work, too (they are passed to unpack-objects or
index-pack as a comma-separated list via the --strict=... command-line
option).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 5 +++++
 fsck.h                          | 1 +
 t/t5504-fetch-receive-strict.sh | 9 ++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index a4fbce3..b728646 100644
--- a/fsck.c
+++ b/fsck.c
@@ -137,6 +137,8 @@ static int parse_msg_type(const char *str, int len)
 		return FSCK_ERROR;
 	else if (!substrcmp(str, len, "warn"))
 		return FSCK_WARN;
+	else if (!substrcmp(str, len, "ignore"))
+		return FSCK_IGNORE;
 	else
 		die("Unknown fsck message type: '%.*s'",
 				len, str);
@@ -220,6 +222,9 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_type = fsck_msg_type(id, options), result;
 
+	if (msg_type == FSCK_IGNORE)
+		return 0;
+
 	if (msg_type == FSCK_FATAL)
 		msg_type = FSCK_ERROR;
 
diff --git a/fsck.h b/fsck.h
index 738c9df..7e49372 100644
--- a/fsck.h
+++ b/fsck.h
@@ -3,6 +3,7 @@
 
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
+#define FSCK_IGNORE 3
 
 struct fsck_options;
 
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 0d64229..cb077b7 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -133,7 +133,14 @@ test_expect_success 'push with receive.fsck.missingemail=warn' '
 	git --git-dir=dst/.git config \
 		receive.fsck.missingemail warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	grep "missingemail" act
+	grep "missingemail" act &&
+	git --git-dir=dst/.git branch -D bogus &&
+	git  --git-dir=dst/.git config --add \
+		receive.fsck.missingemail ignore &&
+	git  --git-dir=dst/.git config --add \
+		receive.fsck.baddate warn &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	test_must_fail grep "missingemail" act
 '
 
 test_expect_success \
-- 
2.3.1.windows.1.9.g8c01ab4
