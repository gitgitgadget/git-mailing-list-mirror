From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] remote-curl: Include curl_errorstr on SSL setup failures
Date: Sat, 13 Feb 2016 17:39:34 -0800
Message-ID: <1455413974-25147-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 02:41:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUlhB-0004fd-Dn
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 02:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbcBNBlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 20:41:49 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34363 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbcBNBlt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 20:41:49 -0500
Received: by mail-pf0-f179.google.com with SMTP id x65so67685209pfb.1
        for <git@vger.kernel.org>; Sat, 13 Feb 2016 17:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fd66hkvzLn2edt72tZl6lOPbGEyldBMFDboZW69dt1E=;
        b=VS1ZTTIJBhDvoCZzTBDjfdFAW35ZMWbU/wxWP2DDQHpWCkKTh3YCZtpsYoWLovS1dx
         7WEI2EMZOJLzxQn+z735yK9ZQBQ5klLO/kpGP9/imIzirs22LbgjQzEiBG3UH1GUtx02
         RalBEYd80ZRurz6jGeS20fxL8Z0+7JeSKkFmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fd66hkvzLn2edt72tZl6lOPbGEyldBMFDboZW69dt1E=;
        b=hxxJyLj4PdI4e5utlkT5P5YXL/9+Y2LUcSZSrS6yUTG60ftEUWrW3z1kty847S9/8u
         mc/5qvrdNBzkBdvQtSkjlBcdluP2vV3WA0DlcuXkHCfEWs94LdWtatfptIiGDBQf6ljz
         JrnIaLKH+RYP8AfKsAyc37BYizD+aYR9MxLPXQqYh4O8qZbEMEQhI5l2T9a/Z3lB/BIb
         LY3psU6sOSzTI4d3lW+FczQkz4WARNYR4o02ZMm4KhNY4n2Ln5whhMR4VtyYz6wuNPbl
         EzXL9Q0J1o6dP309RfStGhB6lQchEVXMHwaD7ETW8BrPyJuvmcRHojMY3y5CgNfwRb5H
         dNWQ==
X-Gm-Message-State: AG10YOSd8pj+1jzlLCPZ1DYKltuAEmiUx4HVvhKZyegWU3vtbtV1NRhjTr9Xx65pjdWE2g==
X-Received: by 10.98.80.135 with SMTP id g7mr13411991pfj.132.1455414108569;
        Sat, 13 Feb 2016 17:41:48 -0800 (PST)
Received: from localhost.localdomain (c-73-170-152-75.hsd1.ca.comcast.net. [73.170.152.75])
        by smtp.gmail.com with ESMTPSA id 74sm28749944pfs.33.2016.02.13.17.41.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 17:41:47 -0800 (PST)
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286132>

For curl error 35 (CURLE_SSL_CONNECT_ERROR) users need the
additional text stored in CURLOPT_ERRORBUFFER to debug why
the connection did not start. This is curl_errorstr inside
of http.c, so include that in the message if it is non-empty.

Sometimes HTTP response codes aren't yet available, such as
when the SSL setup fails. Don't include HTTP 0 in the message.

Signed-off-by: Shawn Pearce <spearce@spearce.org>
---
 remote-curl.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index c704857..f611432 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -439,8 +439,20 @@ static int run_slot(struct active_request_slot *slot,
 	err = run_one_slot(slot, results);
 
 	if (err != HTTP_OK && err != HTTP_REAUTH) {
-		error("RPC failed; result=%d, HTTP code = %ld",
-		      results->curl_result, results->http_code);
+		struct strbuf msg = STRBUF_INIT;
+		if (results->http_code && results->http_code != 200)
+			strbuf_addf(&msg, "HTTP %ld", results->http_code);
+		if (results->curl_result != CURLE_OK) {
+			if (msg.len)
+				strbuf_addch(&msg, ' ');
+			strbuf_addf(&msg, "curl %d", results->curl_result);
+			if (curl_errorstr[0]) {
+				strbuf_addch(&msg, ' ');
+				strbuf_addstr(&msg, curl_errorstr);
+			}
+		}
+		error("RPC failed; %s", msg.buf);
+		strbuf_release(&msg);
 	}
 
 	return err;
-- 
2.7.0
