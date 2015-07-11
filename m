From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] diff: parse ws-error-highlight option more strictly
Date: Sat, 11 Jul 2015 14:58:21 +0200
Message-ID: <55A112ED.3090004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 11 14:58:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDuMg-0006Lg-Ck
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 14:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbbGKM6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 08:58:42 -0400
Received: from mout.web.de ([212.227.17.12]:54098 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbbGKM6l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 08:58:41 -0400
Received: from [192.168.178.27] ([79.250.167.41]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Mas22-1ZYKco2hNS-00KS1M; Sat, 11 Jul 2015 14:58:36
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
X-Provags-ID: V03:K0:x48iD9EJATex7HEpHhRetK38EDEBJHMjB9oEKCpQ1p8QuYMLaSL
 KIDN07QkK3NgULA1WHVWJwjXMvKwMQO/V/oSiaYsX/lbxkW1tMpzdqYBZKL0h9XLTM641jH
 tEeo37xcB1lTbTqfXfOE1s0AHZDjYTyMiNBDe5zhTBfZSQsHB+EuY3D0GV0FgL/DsEel8SM
 tw+GwRXoedy6xszwcVgjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wcQTxsVuZ8k=:Knpw/6TL4mhXwHaAlRHYiO
 OmBXZ0C+FR6g6KTe1lfX4MaiEax5D8tBXcF9ZifdTxcd070gU8oxcXEZjtET6q4W3Jh79SdTL
 sCLT2FDYkY31lK+97Iep1WAndcotIfAhhMJR/ba9onx+Uwcw7trV0cXk+77pcpGoPNo9WNbxk
 wlKDWbaPChFliZ/EN1w2w4Zom9fbLgw6o80HTmqvF9tm5o1X+JnH1Q1KqkRVWhDt5qG5LH+xe
 CRcjGMPnOS7mDsU+sz/ozlZFHTKDkwh6sdEJZdyOKliaCme9DmwvYXolah57UcFJJ5Mhswr6p
 ChPBQJXYWgOSX1dbpJkm3IaB7nUZFp1HJszg0TNr1POPIUXKRTvhM6i9TcbBXVPwyMCGjJ818
 t+3xtL0hbRTime4kbVxjebJHfRVa/odH4zLk45w+w5WTNUm22RjOaS5mDq0IXyG2vWM7U+hob
 9Swx241vN+xZY9pxKtKnIMXdDAxTlOI/Gnqsua4gSxXa3uDWEZ+wVtwrxlxT2PuDGts3vygvc
 5ZLCK8G/ItypIb05vvzgv2Xt2ZAiJPijkOzN9Dm0HS0I4bw1ORY1MzTBvGrfU3WVpFoyp4Ux3
 NU0W8iNb9/BhaeAZ4TdaZ2vH9bf++9hXnvbGdEBIuqqfjiIGur4BM+Hpcp6VhgMjqpQ0p7Peo
 HhWKEC39rqrEXIa8fSozgvJIBkoaI+lAT4xWxMBcdICJTSpnyziCSRBjFL46qRzO/pFw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273874>

Check if a matched token is followed by a delimiter before advancing the
pointer arg.  This avoids accepting composite words like "allnew" or
"defaultcontext".

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diff.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 87b16d5..0f17ec5 100644
--- a/diff.c
+++ b/diff.c
@@ -3653,7 +3653,12 @@ static void enable_patch_output(int *fmt) {
 
 static int parse_one_token(const char **arg, const char *token)
 {
-	return skip_prefix(*arg, token, arg) && (!**arg || **arg == ',');
+	const char *rest;
+	if (skip_prefix(*arg, token, &rest) && (!*rest || *rest == ',')) {
+		*arg = rest;
+		return 1;
+	}
+	return 0;
 }
 
 static int parse_ws_error_highlight(struct diff_options *opt, const char *arg)
-- 
2.4.4
