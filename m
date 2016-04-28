From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 12:03:47 +0200 (CEST)
Message-ID: <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de> <cover.1461837783.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 12:04:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avino-0000yM-I4
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 12:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbcD1KEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 06:04:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:54895 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbcD1KEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 06:04:01 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LZzKf-1bOzHj3J65-00lm14; Thu, 28 Apr 2016 12:03:46
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1461837783.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:4dDPKC/e80wCVtAXhYd8WafCUumf/bcjubaWTjpN6wBKwpegeBU
 dtU87EfcViGEKoDSB8Ye1+vtNGfzfbWjQs1W6iiHglFd3hCxx1ys+/JWq90MWXqNItIp5qq
 mSI4y3NYl/N3HXWNs7lJoR74CvfQuYUbhszY7FYTyFzUvj2SbScu1gLN9P7+XqvXceSxX/g
 TVuW947yIDi6mKPG3uhvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:psuafRNU1Jo=:F5Bs7FTddgfeaUDgD/zdMC
 ohi25g7dN8GFm0l8DGQQ7mSG0KHzJaDAKdngdHmzWjZKwyuVHzdCk4vKbVzN3AquZipWw0+Vr
 htk5J+oy6mWvGbcKMUYxhbzBEPzifpG8/kUoFnngEFFtYZuT/mgWzuACs3olbER74nkIhR0yg
 f3xwHWamKcAR6+idiREdzYihrmk9IWXGAIfFlDL+s8bwqNjXX7tlkrAjENGl+CqRZiAVHHhl3
 juAOMUD2AF3UZ5ARUh4u18SrwGp4eKZVSxb5ODBecidgxR385bQJhbp7/kPkosHGDPB04Spby
 pKzm6cPbwZqktlkw0RP6SeuPiejzBx6TYwtougIM5pqOLJQmGfccyxpiMIXu0DNEyEltpn410
 BiYrJqiB1OY9m+9oAK0FzKqd6yQXs+EHzBVvoWOgExnQ5YgW9ZDRfvLQKWKlvrsRD8plrS69L
 J2uzfKmPQ2tR2hJi7zpBo9lz/q9yr4wYnLwUl3j8C3dUMV+bpC6N3d3A/HFEvAAoSDLwNKu8p
 vbZmsZBnllYxRrcqgpq/ebIijgVGX06Pf7ktncYl3KVhlzQwOhng4c4j1CsdfQYB0UXQJxQIE
 q1DVREBH8ouVUBrSmNdLXpe8+JnpnWeExe7HqbjTHZ0BjCAlhq4y+5YhbaWHp1Ns3H1AJHS0h
 uKQLd8LtYteM3h+O8t/0gizbDHUe+AAk6WQETg8acHJ3KZBJuhtIMO2vZFr8+a98XJbUnmW8E
 LrRKx/R9mJZdyJJsQcXhFRo7Bby9Nbjll4dOOZX+xdCQ0SZ/5Gjz4Fp0b+OA804JXD/VtPd6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292861>

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
 builtin/submodule--helper.c |  4 +++-
 t/t5551-http-fetch-smart.sh | 11 ++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3bd6883..b338f93 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -127,7 +127,9 @@ static int module_name(int argc, const char **argv, const char *prefix)
  */
 static int submodule_config_ok(const char *var)
 {
-	if (starts_with(var, "credential."))
+	if (starts_with(var, "credential.") ||
+			(starts_with(var, "http.") &&
+			 ends_with(var, ".extraheader")))
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
