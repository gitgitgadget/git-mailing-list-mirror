From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/4] abbrev_sha1_in_line: don't leak memory
Date: Thu, 31 Mar 2016 17:35:44 -0700
Message-ID: <1459470946-16522-3-git-send-email-sbeller@google.com>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Apr 01 02:36:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aln4D-0007ms-Kp
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757573AbcDAAfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 20:35:55 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35392 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692AbcDAAfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:35:51 -0400
Received: by mail-pa0-f44.google.com with SMTP id td3so77120552pab.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0bOFMkkV1GK2EPOYy1X0fqlK8y8oH7/F/bAz+eEg+jw=;
        b=JkWmc4uF3IFbStslus6kx6TBorIvM+z5Hckw/ABbtXVS5FVqtq6IWhI8C9wAQ6E5DW
         RO1QwRz/v+SrZjiIEMrOgALFyclWEolB6L6VDasmz/Dy9oWRVoJhVHYnFAHWZOMZ22v7
         97/dfWDYw4eirlXbROBFrzhgw5zfd7yYPBfIQ6lgKALwZw/VWB2KbQWXUFAgLHjACF2C
         EVmxLQmFZ0llCA0qsxgizQg7gUTriIb8uPsAGJRDekUB/oflqbQ+ax5D5+/aVmikcN9d
         sW8UTuknLmsG3ZT3eDFgdSd48Dq3+hHasRC4fKZOq2GLQ0J58Bk7mZEHsoFuIirUf8aB
         7EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0bOFMkkV1GK2EPOYy1X0fqlK8y8oH7/F/bAz+eEg+jw=;
        b=Re+k6wJcmq02mjW26ttiWVe3EfcsauTiEuMJdqyTFMlRpaw6heXukoN29aqEweQs4d
         yKT4VFGIYYgUmVnI625RX+62fW3XCfk1XwR9xQwyHEow2S9z+XMqtGWE2pH/twYSNPNr
         ba1+f/gLER3NJX9Qsusn6bT17+XTI7bwBe7vxB0Yj75iFWVcQrwRR3n+/wQG+9PRwTjY
         xu9ITnZZHSoUg3ZzZEBEsazm14CTpTaBrtQ9aEZaanPQJ/VdctNPdKvEsp2qNlEOrE/N
         cl9x/WH8qV6tzx+XQj6SnSaWqUpN8s30jbZYcGQ7aMrI0KMrbZltZXRw8BzcL3U2baq8
         Utdw==
X-Gm-Message-State: AD7BkJKFTiK8rJjFEVLvqnblcHkEvKgAym1ucqmfSpUsne+GXCxMKiYIL3nb9PgRMt2VjdAS
X-Received: by 10.66.228.1 with SMTP id se1mr26290102pac.43.1459470951112;
        Thu, 31 Mar 2016 17:35:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a519:64be:5369:a180])
        by smtp.gmail.com with ESMTPSA id g23sm15983447pfg.35.2016.03.31.17.35.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 17:35:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
In-Reply-To: <1459470946-16522-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290499>

`split` is of type `struct strbuf **`, and currently we are leaking split
itself as well as each element in split[i]. We have a dedicated free
function for `struct strbuf **`, which takes care of freeing all
related memory.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 wt-status.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index bba2596..9f4be33 100644
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
2.5.0.264.gc776916.dirty
