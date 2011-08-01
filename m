From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 1/2] connect: correctly number ipv6 network adapter
Date: Mon,  1 Aug 2011 13:16:09 +0200
Message-ID: <1312197370-5112-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 13:16:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnqU8-0007UY-KQ
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab1HALQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:16:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47249 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab1HALQc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:16:32 -0400
Received: by fxh19 with SMTP id 19so4463078fxh.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        bh=vcjrjIMhnPy2i1Rk0DVW+WqEgNQRyGzn0FcxZtZOY1s=;
        b=IPHg73wYExnfLEmqsCuKvWK7YGSYWJLz8mLiMNgFua2DKOf6s8XIf3udRfcggCvOyT
         dSR/wVPgUjuN7WyL4F8gMhx/61/PEFa7/sWIcwJwBdOQTpAU8LZukJRBUvuTV9QwISH0
         6JSgtW0PxCOdfZIGsVPBydY8UvDv+UbYDlpY0=
Received: by 10.204.137.155 with SMTP id w27mr1321479bkt.104.1312197390756;
        Mon, 01 Aug 2011 04:16:30 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id o11sm1285552bkt.37.2011.08.01.04.16.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 04:16:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g4db0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178329>

In ba50532, the variable 'cnt' was added to both the IPv6 and the
IPv4 version of git_tcp_connect_sock, intended to identify which
network adapter the connection failed on. But in the IPv6 version,
the variable was never increased, leaving it constantly at zero.

This behaviour isn't very useful, so let's fix it by increasing
the variable at every loop-iteration.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 connect.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index 844107e..d2ce57f 100644
--- a/connect.c
+++ b/connect.c
@@ -217,7 +217,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
 
-	for (ai0 = ai; ai; ai = ai->ai_next) {
+	for (ai0 = ai; ai; ai = ai->ai_next, cnt++) {
 		sockfd = socket(ai->ai_family,
 				ai->ai_socktype, ai->ai_protocol);
 		if ((sockfd < 0) ||
-- 
1.7.6.347.g4db0d
