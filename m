From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 4/4] credential-cache, send_request: close fd when done
Date: Thu, 31 Mar 2016 17:35:46 -0700
Message-ID: <1459470946-16522-5-git-send-email-sbeller@google.com>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Apr 01 02:36:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aln4J-0007pf-KO
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757654AbcDAAgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 20:36:00 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34626 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757631AbcDAAf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:35:59 -0400
Received: by mail-pf0-f176.google.com with SMTP id x3so81111482pfb.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mBcwRa4W6qcl2vxuRlOZIOoY/kBcgyXyrchHjz0xV6E=;
        b=Qia7KbNtVTSe2fVRWb6f6+8WqbhgAZBCcAr5dm9i4xImdFGreHu5lB0LzyNt2c2gJg
         rYKqqP003F85+xzLnww9nk4bcfJ1yoieffbY9T0/nhQBeJsaIHfXeCsqNt9a7R23SqPh
         dqZuc4IhcJ+vxB82mvdJYw7sAKZll+8Ghti8zkOcHV2Wn6D//ezvINFZxGdhvN34sqeX
         rfuc0dIyCcgfffpFp8cHiIod2GIBMYVvJOtikIDDoozWhkL+6iV6fxebgIXndYOT9KyP
         7T5GV/qfDnJTwHtFmrOpb0sFZNMyb424Ktl1dJWDbHY5iI2F8pp8OQ0e07U9SWGc++Fg
         nPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mBcwRa4W6qcl2vxuRlOZIOoY/kBcgyXyrchHjz0xV6E=;
        b=XVc8OHxQUYXgeurlfntlzTpZimrbphG5sgv1RX6YPMOKAECgTQzJf1m4NGbBu3YlYp
         U/MWu5OvxjiQiFM+UcKtFuEDf20rUsX4lMv82+mQlVW7A43omXy1022N8LhTOaK1EuZ9
         hROIJgGx1huas/hkimHRvOF9L3XYBvqB7UZw/gMn5tVLI8iHVWgGCxuuUre6ickcjZz/
         ZxAAf01epqY4Iw1J+xTPrPXd9/8Lc9tiVQYd+mRdjAJTOXwVRvznzf3sikynz/94UNdJ
         qJhLQzhX/1eg2QrCDYbfKe4en+q23WIumy3V0ZOCfDuqh4agwmg1eUcxOmyB6qZU/+ud
         uoHA==
X-Gm-Message-State: AD7BkJIT9X4awEPcSDCsQI+YgbWqWLA2J9uY3AvSTIRR0r+LE8bblJlbMzOON4bo8+IlmhzB
X-Received: by 10.98.73.69 with SMTP id w66mr25977022pfa.106.1459470953502;
        Thu, 31 Mar 2016 17:35:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a519:64be:5369:a180])
        by smtp.gmail.com with ESMTPSA id 82sm15959674pfb.64.2016.03.31.17.35.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 17:35:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
In-Reply-To: <1459470946-16522-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290500>

No need to keep it open any further.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 credential-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/credential-cache.c b/credential-cache.c
index f4afdc6..86e21de 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -32,6 +32,7 @@ static int send_request(const char *socket, const struct strbuf *out)
 		write_or_die(1, in, r);
 		got_data = 1;
 	}
+	close(fd);
 	return got_data;
 }
 
-- 
2.5.0.264.gc776916.dirty
