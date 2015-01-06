From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] imap-send.c: set CURLOPT_USE_SSL to CURLUSESSL_TRY
Date: Tue,  6 Jan 2015 03:20:37 -0800
Message-ID: <31f38398d53bcfb1d659cd248db522e@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Tue Jan 06 12:25:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8SBs-00032M-HW
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 12:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055AbbAFLUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 06:20:44 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33454 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbbAFLUn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 06:20:43 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so30376703pac.8
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 03:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6uex6J8Ta54Bxqhzq0wJvXy1rbtYVRYkYT3e1OMvBq4=;
        b=byPl+0SyJW3wRLu23TYEIjlEnY74kMksJQmmij0jb1bPKFixphY9FkGn9UZf/CJPV5
         MjDIM7ulYg0sejf37EuOtToV0Fd0pETt03++H71CSBwyHOlOqvqTXytb8lmu9M6Ng55z
         pBn49hjch6kzJOvJ9wUlPakNYxUggjEab2bEWyvECHfzKDcdSmJGaS02TUH/YnEt3Fnb
         O97+lY3dgsfgIcK6itPHO07sXPHNRjb992E5TdEDp/67wI98/QvWH2S+TpTVplpCTCmH
         I0ea/adXgMLLPAAg0ZzLQv6XM99wk8xd8OZCPEnbGs9FDnxJpLChtQv6ycIV1bNS7Ale
         yucw==
X-Received: by 10.68.132.2 with SMTP id oq2mr152328435pbb.45.1420543243029;
        Tue, 06 Jan 2015 03:20:43 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wi15sm57116727pac.21.2015.01.06.03.20.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 03:20:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262058>

According to the cURL documentation for the CURLOPT_USE_SSL option,
it is only used with plain text protocols that get upgraded to SSL
using the STARTTLS command.

The server.use_ssl variable is only set when we are using a protocol
that is already SSL/TLS (i.e. imaps), so setting CURLOPT_USE_SSL
when the server.use_ssl variable is set has no effect whatsoever.

Instead, set CURLOPT_USE_SSL to CURLUSESSL_TRY when the server.use_ssl
variable is NOT set so that cURL will attempt to upgrade the plain
text connection to SSL/TLS using STARTTLS in that case.

This much more closely matches the behavior of the non-cURL code path.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

*** PATCH IS AGAINST NEXT ***

In particular, this patch requires br/imap-send-via-libcurl


 imap-send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 4dfe4c25..5251b750 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1421,8 +1421,8 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
 		strbuf_release(&auth);
 	}
 
-	if (server.use_ssl)
-		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_ALL);
+	if (!server.use_ssl)
+		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_TRY);
 
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, server.ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, server.ssl_verify);
-- 
2.1.4
