From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/4] gc: demonstrate failure with stale remote HEAD
Date: Mon, 28 Sep 2015 16:01:13 +0200
Organization: gmx
Message-ID: <85350603b9f5986381777c386415aff2005ca498.1443448748.git.johannes.schindelin@gmx.de>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
 <cover.1443448748.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 16:01:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgYze-0004Im-RT
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 16:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933960AbbI1OBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 10:01:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:58375 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932920AbbI1OBV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 10:01:21 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MUZG7-1a7CoK3ETz-00RM3E; Mon, 28 Sep 2015 16:01:15
 +0200
In-Reply-To: <cover.1443448748.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:791EA6GOInHWvBQoM8sGITfUjrjROyijFdHU0z6o5dM8ArqwxdK
 8Q3C6c+0l3af/ib6z73W4RhIeRZQJtb8amaxgJozS3PnCCQsvHZBFoXyrX3CayZdTEjKzYj
 p0Hh1HtROmHjVuS845LYoXwXR/iLAJUj6plMazaqIlsjlAWbeIoLPSEpC5eHUXy5KyxQ+Mx
 6w8CzKmVNYaiQFZuHBbzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k2tQCGkw6zY=:tG9scyUMnJ+14HROPDoSdI
 wgMBlHmgJs0DN+RkF0mz6FERSiDGwGlR0VCv+9LqXFfmI/eZoFBFdKzZRT4WZDBKbUFbnmplc
 bz21K3NU6GetECZoUchvrDNt1V8+9zuh/18Xk0b4Dvr5peiBtokcK7UahN0AooYmKmqfyQYqJ
 TE1MAphAf13QC3WEa8muuqhZ+Pv5LfJvUf1a1tGIBPci811EgxxBM3hu/rPbuZHmjDpwSqusY
 FU5d1GNDu//fOiIeIy1NCRJDgFZq9JELIO66ALMevKFVVMRAPHUr+som0uer5cEgjx2yunwa1
 UBY7QeALi4ijW8/+ufV0yUKIkPJDwWnc8WQ/LtoJCF2ph108bE4jsMfalSK1k1jxahIhnfv/M
 2KWOBy37l0jdYi106BDj4qXwE523RbCECxc/4qNEQMAxObO9R0bchWc7cWHGDi4yvCRvNBEp3
 wKMqmEXKtl2+kPtYw/pFe+BxPFC0suuTzT/9s0j5N7Pp2B12pWowk8a/Y1Hte+iCom05CWUAE
 sA/BqZ02r5JwqGQ3IMrzfTTQ1nQnUiqhX9TBiUz4xwXzQiye2rB0fmGpX3URKFf8x8zrpW+5B
 tuNyImgDe6KvrWYHgtdylKht0Mb+GY/EiiSbhCRj9sCD+nP0CujGokGDaUGtwioXN7CpbZWSZ
 9UzxV+dz8hzrhI70udFHSWai+XcYhjecdoIsEg9QoVigzFnp0sPVCkBqCHiReW8qS8o9rZSoq
 AlbSQI08QKdd+Awz5pGAS1PwRRTwTOtRcEw2Vw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278725>

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
2.5.3.windows.1.3.gc322723
