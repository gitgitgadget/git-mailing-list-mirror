From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/4] gc: demonstrate failure with stale remote HEAD
Date: Thu, 24 Sep 2015 11:13:35 +0200
Organization: gmx
Message-ID: <85350603b9f5986381777c386415aff2005ca498.1443085919.git.johannes.schindelin@gmx.de>
References: <cover.1443085919.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 24 11:14:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf2b9-0004Ah-9o
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 11:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbbIXJNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 05:13:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:61549 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbbIXJNl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 05:13:41 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MAhWl-1ZpAgV1hIh-00BrFy; Thu, 24 Sep 2015 11:13:36
 +0200
In-Reply-To: <cover.1443085919.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:PtU77RcnWK3n1x1JAJfXIZKFF1DScnEDReAhHEAcPQxve+sl+03
 5GRCZORY+tdwky88ntx46FIpV78rqUiZ/xEok5G/Lv5l4hSSG4TVFTYqVW+audvurCxE16o
 hCemAVN98DhHNHPuIGf+CqHped07/Dcksk279VJBy2oEOc8jRxA91vrLMe/HIoQiJh8Mw7U
 cfr2t1CK/Xxyju7zf0ieg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EaHNr4iLKHQ=:w/Zppq3oWGj7X0KYnR1ALZ
 amc8mIcVTnTyiQc7150K2Y5JSpcRcOL58CmEaIRzjbZZ8MDetXRrllslnPeiTHJyQXmTTN+m1
 4KPGVTjjtFolgd+djG+Mqf84rq3Rgh3Qf+6WChpBeAhidXg5gTjFWIqjt4dMAgTEMivT0f4tu
 QVvqElCOAd7geg6ifcNHVJaDcui7SE6ZpImmMMu/coaacI2qoHuUlpWpGfIFRieoplRzYU7wj
 LA0JNA6O3awg+0AitraMAlC8g3dg/6/cieqN1wd3pdZT6sx/H9PmX/Cof/8JIBXXYbqQFl7pb
 7RK7NxYOKwYHLX9jbvR0w5kZH3OgNd4hPZL+dK9rH5ajBJgVU5JYzNTsBpVAx88ss1fX3Rcx4
 HJwsXjilom6JjZ430jGiDXxAjOIZ6+M5VWmpodSMFQ4kHiI6jrtmze3J2l10vHSaBbxeYTVn/
 t6FQU/uL739jFsEm+wtkfGKga8xhpSXskn8dFmC4jcf19x5MM6T0ov8nblTGdnlzvuEP79Agi
 yf1UWLI54k8v2e+NAvq8yytUnWtfPFx2ySjFSug4IQ4AqFFRhbdqywzXOqIxqdu4XTntgKGPc
 iU0nsnlNJ3Ugf5D7mosd9nM2s6inA2opRXcv8Yc/USCAQxutOO5/gkHwCwXQ/6T/vrwTt0anc
 FQhwWtDdZLVqb31nlDuAx4ceSTLQAIFrTiA4AucPOs8dH8aVkI2jre6CL1hU/ZFOmdmGNVg9w
 y6vHBNw2+ILjfhVpgfXrJOb/LKAqZ5dWy3ZD6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278540>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6500-gc.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 63194d8..b736774 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -30,4 +30,19 @@ test_expect_success 'gc -h with invalid configuration' '
 	test_i18ngrep "[Uu]sage" broken/usage
 '
 
+test_expect_failure 'gc removes broken refs/remotes/<name>/HEAD' '
+	git init remote &&
+	(
+		cd remote &&
+		test_commit initial &&
+		git clone . ../client &&
+		git branch -m develop &&
+		cd ../client &&
+		git fetch --prune &&
+		git gc &&
+		git branch --list -r origin/HEAD >actual &&
+		test_line_count = 0 actual
+	)
+'
+
 test_done
-- 
2.5.2.windows.2
