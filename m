From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/4] abbrev_sha1_in_line: don't leak memory
Date: Wed, 30 Mar 2016 10:05:16 -0700
Message-ID: <1459357518-14913-3-git-send-email-sbeller@google.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: sunshine@sunshineco.com, peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 19:05:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJYk-00026v-PW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637AbcC3RF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:05:29 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34035 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbcC3RF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:05:26 -0400
Received: by mail-pf0-f173.google.com with SMTP id x3so47622763pfb.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vw7/YKEk9wDyOaYn+idrz0eCcW/bmAHHe+CBpc8MDPg=;
        b=Nybuwu5dgiZxoyB0YykrJEQGaWY40zM8n2U/18DXVBowUAIthhFZF9uZyQrexHCFQy
         Ld//mTSToiBYG+Z99sbtcoS+BxRvMCPGYGdWJDYTWipI805ZS0LwtCz5fpYdyS2nTcJt
         RGiOmCnFo6lzCv3VvyKmRQ0saPFQtI5BVJcryfP6GzDppdxfn/+9JutbE74jlv0RCeoi
         eetI3ZBiA1dMCegbCa7uQ18g0OmakWxV+2J3tS5jHrXiUCVRJey+spCDu0Bd7rmIxdrd
         0dk/Kt52PnNGx+2P/BvmirtaZ70N6SH/O/civ3q/D25vpSIxKRPLtAMhegYp2PNSfk+K
         n05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vw7/YKEk9wDyOaYn+idrz0eCcW/bmAHHe+CBpc8MDPg=;
        b=hJ3PrI4hOSnMfIiWLKPBhhJl0AaB4Od4mtKjealtKTUnXVr54l/tkfzjIduIGsaCrb
         9I2up1crUy0EM7CwLP8F0RcWCkDt6KRX+kCpP9860/dkAzTWMyGrOkdA4Qwn6t+gtORg
         5GmOwStokIU6CPBzFtoec1HntUZxTW8p7y2tWveFryVnsxRr+5/GcemVBi8Wq5Yz3nJb
         A1hcG77EHB0KhdSyFEMhDaFiMlUyuVLbX4qTXrWDQVkyAdUZCfIQQTc+YuW8Jgmq0xZC
         xdO1O47yOqbyc4S4ZpmLI4e/9IleI0h16pSiVouy8Aybi4vyxDPnAR4LSX5NTmNXAg7h
         cOoQ==
X-Gm-Message-State: AD7BkJIzSEgOEXZU789fawTwAAXvbE3/rvt0IujSBdMzRrY+/ukpV3n8nsA9sSfQKBjx8e60
X-Received: by 10.98.68.91 with SMTP id r88mr14950887pfa.12.1459357525661;
        Wed, 30 Mar 2016 10:05:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id 87sm7217832pfq.93.2016.03.30.10.05.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 10:05:24 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
In-Reply-To: <1459357518-14913-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290313>

`split` is of type `struct strbuf **`, which we have a dedicated free
function for, which takes care of freeing all related memory.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 wt-status.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ef74864..1ea2ebe 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1063,9 +1063,7 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 				strbuf_addf(line, "%s", split[i]->buf);
 		}
 	}
-	for (i = 0; split[i]; i++)
-		strbuf_release(split[i]);
-
+	strbuf_list_free(split);
 }
 
 static void read_rebase_todolist(const char *fname, struct string_list *lines)
-- 
2.8.0.2.gb331331
