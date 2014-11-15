From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] use labs() for variables of type long instead of abs()
Date: Sat, 15 Nov 2014 14:27:21 +0100
Message-ID: <546754B9.2080305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 14:27:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpdOJ-0007tN-NX
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 14:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbaKON1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 08:27:41 -0500
Received: from mout.web.de ([212.227.17.11]:56808 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbaKON1k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 08:27:40 -0500
Received: from [192.168.178.27] ([79.253.145.199]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M3T5g-1Y7IjI3ms4-00r3xf; Sat, 15 Nov 2014 14:27:36
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:hLA4knU2IZn7Iu+5NI8VviLlmqswSVnFnSn/j+vzBHNpYcY4tFY
 R7MPBdzBov7YfOmcWkt1IR423aSNDj1DJ+7wPh+4wUudWd7j7wZKGhPmhbtyqfZqhEzZuCu
 C2Kt9+1n9179wsdzgQSq6NX2zcPdzFz1YP8iLpkp0lKL58CZJOhBl8vfURVk678RCmIFL9d
 3n9DdXs23pC3FnQUyCwKA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using abs() on long values can cause truncation, so use labs() instead.
Reported by Clang 3.5 (-Wabsolute-value, enabled by -Wall).

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/receive-pack.c | 2 +-
 config.c               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 32fc540..e908d07 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -431,7 +431,7 @@ static const char *check_nonce(const char *buf, size_t len)
 	nonce_stamp_slop = (long)ostamp - (long)stamp;
 
 	if (nonce_stamp_slop_limit &&
-	    abs(nonce_stamp_slop) <= nonce_stamp_slop_limit) {
+	    labs(nonce_stamp_slop) <= nonce_stamp_slop_limit) {
 		/*
 		 * Pretend as if the received nonce (which passes the
 		 * HMAC check, so it is not a forged by third-party)
diff --git a/config.c b/config.c
index 15a2983..ae1398f 100644
--- a/config.c
+++ b/config.c
@@ -506,9 +506,9 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 			errno = EINVAL;
 			return 0;
 		}
-		uval = abs(val);
+		uval = labs(val);
 		uval *= factor;
-		if (uval > max || abs(val) > uval) {
+		if (uval > max || labs(val) > uval) {
 			errno = ERANGE;
 			return 0;
 		}
-- 
2.1.3
