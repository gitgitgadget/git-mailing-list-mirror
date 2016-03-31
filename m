From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/4] abbrev_sha1_in_line: don't leak memory
Date: Thu, 31 Mar 2016 11:04:04 -0700
Message-ID: <1459447446-32260-3-git-send-email-sbeller@google.com>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 31 20:04:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algxG-0001NJ-BY
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757875AbcCaSET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:04:19 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34318 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415AbcCaSER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:04:17 -0400
Received: by mail-pa0-f46.google.com with SMTP id fe3so71332892pab.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mAyksr081wvJjo2nBxxtXJrEc3cd12p5ZtETcHltJpQ=;
        b=L6aEkRF9ngoSbGX2/USwLXsP20wO6wrneihu4J7c2sfpi9dI6kzXTcspI7E7I4kk0b
         VBh1B0jrVVvH6zPdj5c5F30PfIxOlKPqjs62gK3DsiwbN0arSneDxQBhE+dofCyNOyG4
         SY/bLB/GT/MHtF3tda2BwJ1gPQggHfnQ8jyPU9b5zYX09MWX+Sxe1RChyF/ySznZCZwX
         02RYVawDoXMZ5lHnamrNfAqXdtf317JzuyczGS4CN9w177Zw5PqMc5ROsm8rQRMM5iax
         vhB2VvrupI5fQjgIp+V8ACxtiPnNxAPXkimFB1W5RrP8UJ5Jq7JeXScnnVbrVAZEuHfX
         S0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mAyksr081wvJjo2nBxxtXJrEc3cd12p5ZtETcHltJpQ=;
        b=dqI1VLDPg+OjnXwgqUfXJMuCU+4GmseYpip8rjU4Z5sOc59RJKpNnb6uUX5jZ43vI2
         9y5Tk99rcM3a2chb9KGNBSAPqxDNPvHzVj4K2+uBhPSU/dtBxbqgPcPXmfijWmCirQJz
         P6NOu93Hp1VFUSPhoE7R3BQTAM/LOs7Kbuk8dRja2xVFS+4hMTxhQxBZ7pRdsi8UQEGs
         YDvoxjmI7i+mvTacmGncG+vGvlmgBPvO6z80EODJ2cwKRWLWjNvIU7+cRk22u1LRiGZK
         RfR0DqmU4edeV5G5rWfDaaxf1+DdyzWo/mxRfABiJwMdOSZHBw/yG5OnSHDqvRgiA/Q8
         hNow==
X-Gm-Message-State: AD7BkJJjFh5rI166V61BcyI4jVGgIME9+W/I+Iwbo5duBwMviWb4b3myfgrC2u9vBu4Xn9Fz
X-Received: by 10.66.146.164 with SMTP id td4mr23943006pab.47.1459447456493;
        Thu, 31 Mar 2016 11:04:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id o7sm14965430pfa.37.2016.03.31.11.04.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 11:04:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g4004fdc.dirty
In-Reply-To: <1459447446-32260-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290437>

`split` is of type `struct strbuf **`, and currently we are leaking split
itself as well as each element in split[i]. We have a dedicated free
function for `struct strbuf **`, which takes care of freeing all
related memory.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Feel free to drop this patch and use the
    the proposal, which drops `**split` entirely
    http://thread.gmane.org/gmane.comp.version-control.git/290232/focus=290318

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
2.5.0.264.g4004fdc.dirty
