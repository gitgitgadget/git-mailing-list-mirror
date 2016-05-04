From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 2/2] submodule: pass on http.extraheader config settings
Date: Wed, 4 May 2016 08:14:20 +0200 (CEST)
Message-ID: <df040cfd84b354ca206a5cb1430a26ae8afa5a45.1462342213.git.johannes.schindelin@gmx.de>
References: <cover.1461837783.git.johannes.schindelin@gmx.de> <cover.1462342213.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 08:14:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axq4v-0001rL-6n
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 08:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757091AbcEDGO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 02:14:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:57373 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757085AbcEDGO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 02:14:27 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MFLhE-1auYo60zwq-00EL5v; Wed, 04 May 2016 08:14:22
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462342213.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:xJklYnKpJZEqkU3XCFl/mBZgWKheb546MYF47OKwqKjhyWawHej
 oezCu3VNY+S+9XD+uyWwHfOASr8tktJPzPpc+y9Q5vXxgHPuwRryLJ1trAH9Y+I7hKVW0aq
 lZnMNnekP8LYnVHKAAGy4MoPAMI6dxBIFK47m/NMS7zotjZ5VQKwt3OehBR3K7EbcmoBJq/
 LVPBScbChlPYs/wJfR5nQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l8O/Zj7JG6s=:EZ6NWUs2R3tW4aCFsmIe1v
 Lk+Qi2cE53Zo56mDjH2/CLE0I/fwMnosahCHdKBJffikYjHV9TmstLcDk66kQN49EuN0SyEQr
 89pswflqAeyo3cEP8IWRGmBqLLa4AIcVW7a9Y+bhtwzkpi5OcFJbbJwPlKiTeuVnM7fBipVdz
 IK+BU2m4K5pUWo/hDPvgfaadE4cY2WGIOAsPwIREGOdQZHzpbfdkZgSeBVrudYlgjHfrsF0Og
 HIw7vuRdaLHKJ8mMcYpQhyBHSkIjV6IYwXp5uA05n/YiXHS/mVK+FdEGskTC49J11Cwu13ibq
 wZeBpwJOkn4ye1Bna3FhNU4HbWCVbFXPe9KG8/hTGz6h8fP4iwGpOKi4w2IKgJ4gr5pVVAxsJ
 GkCnKCDd6QvMp5JPNt9sh0MnW3R3okQw5sA+DCtXt5kqSDCjovqafdj+arL292ilU9HixsJSQ
 95Se9mvGUZJW+T+hda98lP6ELE5qYn/EVwwBIMu/zccuXiC5veIOPdzBxqMk9OtAC4IsgTbA/
 R9A3mGHOv5HBoaUvWg6Dj0G5iYj3+c6fTZcrl10bGwoM3XVkMfhfM7VR3qykKxBvlV68Lpmuk
 av4u8AkRxld10klcX5mCVM6i0IRJSv35o16CCYPL9BsBBpshfMwn3QRfo9SoS+Y9M/ebQeCeI
 sUa/TCW0E3wfZu7Q5G8v6BVfpB7NnhnsQgxZgKLdD9W2Yjn2OkjhOfykNAgWIg0JBwwFWN/eS
 sggA9nICpJHxvQoTPDrX2curXw+rQl9eUzfUhfHVMZ1OCPxk6CQACgyepzSb+jLm85Op8gF7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293498>

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
index e44fe72..1794168 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -286,7 +286,16 @@ test_expect_success 'custom http headers' '
 	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
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
2.8.1.306.gff998f2
