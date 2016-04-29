From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/14] do_fetch_pack: select capabilities for transport version 1 only
Date: Fri, 29 Apr 2016 16:34:43 -0700
Message-ID: <1461972887-22100-11-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwh-00017A-E3
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbcD2Xff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:35 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34609 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbcD2XfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:35:09 -0400
Received: by mail-pf0-f179.google.com with SMTP id y69so54013357pfb.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PTtDPsN3fIUcAdEJF2y/VHYjyjNyILTXELHTEYX449o=;
        b=RpAYn8GCf/Pqcu/Su5nSF7legonNLSkIt/evCwLIZD9HaGsCVN7rbD5jJgtFEw55LO
         Iker7Hy2+9hAFu13GZE/S+9yD8DPMxMBN1AE0dLr0H/2aqwoeZWHIynwo8FJnrWzfCx+
         4VIE3OfgAo/vyc2rJqSUJ2l/Ye7FUJF6BwKDMPtP5XmwkOoke+lmOCYdPW8zuyBV1Oqx
         Tu5hUZmwsc8xURup//nFuTksj/JMmZQocREQ7S/NnFYcsoUgpWu6QtQNAUkJZ50MBdQR
         WAXrJktPeACQyOK7I4arGBxnxNJTwSzDfCFb0JYJhH6qsGUU/62SykvYnNRshGXhmub7
         6N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PTtDPsN3fIUcAdEJF2y/VHYjyjNyILTXELHTEYX449o=;
        b=mbx+5YL3FbAaX2EAB6bMENln6w1jo25wt5TFRWsOFIS6BkzikrthwlCqJXUknnkRNR
         iAVKk48a3tMpqjSwLILqH85b63QcKhsH54bk2dcOfbUelvLFec/J+Uog7/nBM0cQaxR2
         WHF88joBKSOx5XcrTkhp7cznknU6LDpzgcT7t0Twj9zi3GY91ynFphx0azd4lFVJict7
         R0hMn0T34+jLIKNra/t9H8twDGU6D4aDjOgDjqu3WJWronpOahTJezAp9S4sFr8xB5gn
         PT0Och4MQDluUOhoYFXRjmugGjrHASbKNUn3Pf6SSI7j52QV5ssjb3lCjs7i0gSoOAXD
         GcNg==
X-Gm-Message-State: AOPr4FVWzCvmLl3YbY/ikBen3HLKNHK94uYp9ALXowsivsWx5S4mGAFAYc/Wxl8abFAG0OoY
X-Received: by 10.98.15.145 with SMTP id 17mr32576228pfp.19.1461972908584;
        Fri, 29 Apr 2016 16:35:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id b64sm26237297pfa.48.2016.04.29.16.35.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:35:08 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293080>

`select_capabilities` would set local variables depending on the
user selection provided by `args` and the server advertisement which
is kept in a list in connect.c

When talking pack protocol version 2 however this has already happend
before during 'negotiate_capabilities'

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 fetch-pack.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 1544629..5ca1e97 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -915,7 +915,16 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	sort_ref_list(&ref, ref_compare_name);
 	qsort(sought, nr_sought, sizeof(*sought), cmp_ref_by_name);
 
-	select_capabilities(args);
+	switch (args->transport_version) {
+	case 2:
+		/* capability selection already happend */
+		break;
+	case 1:
+		select_capabilities(args);
+		break;
+	default:
+		die ("transport version %d not supported", args->transport_version);
+	}
 
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
-- 
2.8.0.32.g71f8beb.dirty
