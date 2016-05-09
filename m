From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 3/3] submodule: pass on http.extraheader config settings
Date: Mon, 9 May 2016 08:19:09 +0200 (CEST)
Message-ID: <554ebb7aa9c4a9974181ff932f1695aca3b42abf.1462774709.git.johannes.schindelin@gmx.de>
References: <cover.1462342213.git.johannes.schindelin@gmx.de> <cover.1462774709.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 08:19:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azeXJ-0003jt-QB
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 08:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbcEIGTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 02:19:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:65443 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbcEIGTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 02:19:17 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MFz0E-1ao5YF2oEQ-00Et66; Mon, 09 May 2016 08:19:05
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462774709.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:P1gLPyODrIBIcm/ebeDpamdiIiiJD/ys+6XD2dAjcMvTefPPYpT
 +ufw6uSs3h/6Rzxxningcin9r1Ytp26U+t7Qr4JDWdcZerwazrbmXLxZmeQOXgzw79pnv3Z
 ikXTQNo8QexVNNxKviWaM7ND776aRxNEv+uf73WLQ/Ts7QrgNidyaap7M6z2VIBUiwh+zpD
 amhCrv3dOSkwS3SxZxjmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EPvkErPqzAM=:+zTR5HtpHx3vbIZJgRQhi9
 Xgj90MjvIcknldrasEspT3NenEb+QdOEsvYpReYp6o/z9JucK99zPJRX9lV2V6OTd4oOWaP7R
 0K6KDiBGXHKDfeWnqbo7q+SlIcgwCHutEKMTib4pLSjA0gQupJ6775A27gNGB4Sohf3mIKZLQ
 gMiAfU4/6lySYD1p9gNGiTpB5dqePfTQ53R8un5VlXfrtGMP5xHB4TK1RgE07e8Yfon7Jq/IR
 Acg3NdTqH3cPt1yznO3M95S/WMEYyLkkRiKHolZlKRSST+hPdKNOtg1WhL4Yjr3GsHW2YaCEO
 vIZGn4M68WiNqVY+yph7kmARLDGin52fkiS90pIVDhgfIfaptEclbSRnCW6pRq+GCzViy7Bgb
 cxO1tJXz2+QuojniyPHc+OLDeYzUgUWG3sT3ENacKkjaOzZtlwcvL2LvjUG1tKIYzPioc4AZA
 S3qZKi3QYAtZmspY4Sw/4GbSUsVHVgieFCxPJtfvwJyUFoYPccKzSwRelU+oLy6kUerMqlBO9
 R97AFGHPDRo4E6v3hLBC20a3lnvTHUz0RtznmRXOJrO2m/BsP/PMz1tTwA9r1Gxy5AVHfwdzA
 I5yXe4IG972HcV/RHnlHzfz1Jub5rsyVfw5SwVaIaHfq8pdgICgo0QHMzd3SW1KF6TIMjn8D5
 pzZ+dFrzYNTgOPlmczb7JzZ18/8gYZYM0+rGLUhRJw+SMfmdcR8EMZLU5Yh2+apH10BnJ8B0n
 4fjcUXiUa/J6sqOYJ1pFoxjAHqzbAjotyyUyKFahiA41mvYWzZ8uBLGczK+Dq4xznwntDbrk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293984>

To support this developer's use case of allowing build agents token-based
access to private repositories, we introduced the http.extraheader
feature, allowing extra HTTP headers to be sent along with every HTTP
request.

This patch allows us to configure these extra HTTP headers for use with
`git submodule update`, too. It requires somewhat special handling:
submodules do not share the parent project's config. It would be
incorrect to simply reuse that specific part of the parent's config.
Instead, the config option needs to be specified on the command-line or
in ~/.gitconfig or friends.

Example: git -c http.extraheader="Secret: Sauce" submodule update --init

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/submodule--helper.c |  3 ++-
 t/t5551-http-fetch-smart.sh | 11 ++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3bd6883..789e081 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -127,7 +127,8 @@ static int module_name(int argc, const char **argv, const char *prefix)
  */
 static int submodule_config_ok(const char *var)
 {
-	if (starts_with(var, "credential."))
+	if (starts_with(var, "credential.") ||
+	    (starts_with(var, "http.") && ends_with(var, ".extraheader")))
 		return 1;
 	return 0;
 }
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 43b257e..2f375eb 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -287,7 +287,16 @@ test_expect_success 'custom http headers' '
 		fetch "$HTTPD_URL/smart_headers/repo.git" &&
 	git -c http.extraheader="x-magic-one: abra" \
 	    -c http.extraheader="x-magic-two: cadabra" \
-	    fetch "$HTTPD_URL/smart_headers/repo.git"
+	    fetch "$HTTPD_URL/smart_headers/repo.git" &&
+	git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
+	git config -f .gitmodules submodule.sub.path sub &&
+	git config -f .gitmodules submodule.sub.url \
+		"$HTTPD_URL/smart_headers/repo.git" &&
+	git submodule init sub &&
+	test_must_fail git submodule update sub &&
+	git -c http.extraheader="x-magic-one: abra" \
+	    -c http.extraheader="x-magic-two: cadabra" \
+		submodule update sub
 '
 
 stop_httpd
-- 
2.8.2.463.g99156ee
