From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/6] abbrev_sha1_in_line: don't leak memory
Date: Tue, 29 Mar 2016 17:38:51 -0700
Message-ID: <1459298333-21899-5-git-send-email-sbeller@google.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 02:39:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4AA-00045O-BS
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbcC3AjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 20:39:05 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33183 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbcC3AjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 20:39:03 -0400
Received: by mail-pa0-f42.google.com with SMTP id zm5so26611453pac.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 17:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0r5+xScpz62n1FPplVL1AAVWGQRrnKQZW2L/BKcUIKw=;
        b=IXKjTEifAfj8/4jcAJAY+sOL5nQu3XstoRkcjAaNskFrSSkFWS5IOHXXSujrVHo2HT
         35Nd2VCvIiayY97k8vIyDKExsrxFtI4PIo8x1FUVLP7by9PDVK10dEdIDjCer3aIsqOc
         spHkQjec3YW3d8XI0SmQlg+FjefmdUQUAVQYWnbhYZU4EpH40l0VWNbV7oZLiqu19Hw/
         IObx8zW/YEPafZAOTVYEkxV7p7QV1ZH3Yy9VNrzMkoHXQrutz12VTzBpNjKALOPyZlFM
         3akfb4fwO57xhgkkvc8pdPn2D7H2qMLxF43F7r98FoYdaHYsmUl2PxAMZymxJHAI+fQs
         i2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0r5+xScpz62n1FPplVL1AAVWGQRrnKQZW2L/BKcUIKw=;
        b=kzXiomlJWI6xpg5pwB5eZl5GtuovXd9WWh9R02oqYIl3RtrX0ptxByUHjhR89SV6Ht
         NOSOrA59a0qnrlm74vWRNg0JNrbP2l6Y9F1toZzHK9Mkx25j8YxIYtzqf0V1E21d9/uB
         UxKbEkAWxlughdS8TAQm0Ou3vKjY7nFG2Qy3x/Eb1fllYLsDJK8lNtxq2PWRrfq7/9QJ
         dFV3Qx9fdIM8BowI5BLe85at/UPvs1uyXzZ1OGC0oVmQq3Jaxioltr+nLAy5qC44cHXo
         tAs07sEjMTIvCCthG7ZWj+hXhbC2fmXU/uennXzrEPvQxvYplrp+70RiNTNVXpeAluwG
         9UlA==
X-Gm-Message-State: AD7BkJK5sm42OAKk35amrCCuVbS9MsTnGKzBfEOCdhOU33Aml7IVj9ZZ9mfbJnii8ENb0k9D
X-Received: by 10.66.180.111 with SMTP id dn15mr8045038pac.69.1459298342444;
        Tue, 29 Mar 2016 17:39:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id u2sm1015621pfi.26.2016.03.29.17.39.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 17:39:02 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.8.g27a27a6.dirty
In-Reply-To: <1459298333-21899-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290234>

`split` is of type `struct strbuf **` and just before the new free,
we release the inner strbufs. Make sure to also release the memory
containing the pointers to the individual strbufs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index ef74864..a78cfc0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1065,7 +1065,7 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 	}
 	for (i = 0; split[i]; i++)
 		strbuf_release(split[i]);
-
+	free(split);
 }
 
 static void read_rebase_todolist(const char *fname, struct string_list *lines)
-- 
2.8.0.8.g27a27a6.dirty
