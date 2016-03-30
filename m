From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/4] credential-cache, send_request: close fd when done
Date: Wed, 30 Mar 2016 10:05:18 -0700
Message-ID: <1459357518-14913-5-git-send-email-sbeller@google.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: sunshine@sunshineco.com, peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 19:05:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJYs-00029r-Di
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655AbcC3RFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:05:30 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33512 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084AbcC3RF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:05:29 -0400
Received: by mail-pa0-f45.google.com with SMTP id zm5so45498709pac.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NWlIUOMdU0fUC3hTJNavUhp5qj3p1LeilvhQJJBr2fY=;
        b=MxXMEIUjpFk3Kl3egAXCEucYf/zLESg16Wu0RlrnPKnu8GzKa8YNDb6u9m98dcdYCk
         wKJd4m5zEB+t5ND1qC29S6tTvNFsCoUiUCeeBHz2O2BjvSj8adEhQluqcZ3frRl42CgM
         tISWnPzs5gA7mAO/hPEQCS2vpoR08yJJqD2HhhnolQhJC6NZVMjFvV9p6gfuLtV82N/y
         Zi+zimlZgl8YyGe7XtesFlLz3BUQyCpswpxyYvnfAybdR7KOd+w5FEbBhnwzCJLkg+Oj
         uJTmpv5Y7asK42SzZ1ex07SEw5A3PswCIs/jVTJdPg9Ni5spKvoUBVpQ8lIc0bCfDuGa
         nY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NWlIUOMdU0fUC3hTJNavUhp5qj3p1LeilvhQJJBr2fY=;
        b=EGWVX7Aaa7K7U9NkxPfYhsZLDJs8YPcROC2i0Zn36DzPcFW/f+Hekd6GWG7oH9YlAN
         X9GpMhycbwUE/NozH6PiFigWPv8COYe4spI63gAM+nxN9opHAaTaw29Acs5QEVKyaNL+
         jl/UIa+G4nNIy//kQ8i3VS51gACqH7oiOLQqBj2eZWL1nbCYMDHh3dJkpyX9SKYQHL+L
         XIKHi9l2C97iVv/9En0tFFIEzFNmVo1et3lZ88hm9gh5DPFdCcOahgKWGMHmj6pUlMbW
         XQ3+aJf7XmyB32Nm3jG/iWrzKpQZDFnLE/tTRLCZITYLAnycZPIb29PYPbJHzYJmoBhP
         imMg==
X-Gm-Message-State: AD7BkJIiHpQch2wIh+HTH2CXrYDnkXGutfDeVTkZJINjhlVZ4OyjWqgtgC3Cc0l04sKArDQ1
X-Received: by 10.66.66.1 with SMTP id b1mr14826617pat.63.1459357528380;
        Wed, 30 Mar 2016 10:05:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id p74sm7272288pfa.11.2016.03.30.10.05.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 10:05:27 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
In-Reply-To: <1459357518-14913-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290315>

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
2.8.0.2.gb331331
