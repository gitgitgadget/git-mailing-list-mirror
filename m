From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/6] credential-cache, send_request: close fd when done
Date: Tue, 29 Mar 2016 17:38:53 -0700
Message-ID: <1459298333-21899-7-git-send-email-sbeller@google.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 02:39:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4AH-00046b-Hs
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbcC3AjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 20:39:08 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36263 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbcC3AjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 20:39:05 -0400
Received: by mail-pf0-f170.google.com with SMTP id e128so6450642pfe.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 17:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=phgAbZdrRr8h62MjcZjxiJ+z3E26UbdeA5z54IA5s+o=;
        b=KD7+1JTjrtvaDzFgKSLCo1LaHbnorc5efVpldSIKh5oR+v4LRJvaC7AQMgiOzg9PTj
         0Ci/dyHDgYQMx5qU4uVaKDsR59fIr1K4vFaqj+JSwjDgpHekRn+An4Fq6LNwuF+gsw9t
         trMWg+xPFsdtIa5s0LqXLx63FljLoKBWaJVj38/85n8XqGndsz95S6JGv2IolcbgSZxx
         5NTfM+NfrfAyiiIPsy//xqKbU8WtMDbwP9HogYvzkvNhH4OrhS5FJ5yJgblb19JHrz4H
         BzjRn89mcfaSqhn0vFEQ7sMd7PFLISXFJe6RDB7OHGXSoqFEktzaTGyqig+2pbuEw3mE
         XfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=phgAbZdrRr8h62MjcZjxiJ+z3E26UbdeA5z54IA5s+o=;
        b=Lvz2fekw91q1/YCwsVvU7lmU9J1GbaoSF2mP3FUz4T8vmklHgTC4L/bCkri71USRdj
         CZrHqjQ2Vx9/21zMkmrhxQACAZOEx6jQB90WMq2pUiwqZANQZLR2CYk5CgTmkc3UsFwa
         MPQRu/5L2P5n+4l0rQjhCuEIE1d1ZLDi6h/F2GuldYfDgsopVjmqbRTWDDqvOf0Ako4P
         ineQn7fo5RO8HBFmeATI1cTIGbtRdAKaqpmOzJln9SIL1uuhJN6D5bgt0RxvNqNY863x
         tCVhvUZ2t2I/6fVJBIjLggJ5VKZAFOvfiDkPJZUgtuxl4QPliLNr7scBXRXxVN/2eRto
         7Ncw==
X-Gm-Message-State: AD7BkJIoIh6w9NdNjzuWFsdZjcDBNZL4R+Li1ZQNYTHdQlVtC0KJebxdpgSTVWdkNK5tU8sX
X-Received: by 10.98.1.74 with SMTP id 71mr8365496pfb.10.1459298344536;
        Tue, 29 Mar 2016 17:39:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id yj1sm1015212pac.16.2016.03.29.17.39.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 17:39:04 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.8.g27a27a6.dirty
In-Reply-To: <1459298333-21899-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290236>

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
2.8.0.8.g27a27a6.dirty
