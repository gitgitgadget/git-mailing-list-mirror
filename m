From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/15] http: release the memory of a http pack request as well
Date: Fri, 20 Mar 2015 17:28:06 -0700
Message-ID: <1426897692-18322-10-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:29:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7HX-0001vV-3Z
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbbCUA2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:49 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34989 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbbCUA22 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:28 -0400
Received: by ieclw3 with SMTP id lw3so1799756iec.2
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JN3hGCIHhnixIS9+1e2Zq3QBjfj1DM3ntiYPE198lGE=;
        b=LzqRlUDAq11i2KD0fadHfXI2vy4Jq3EKdubbFs8ZvNqhrfOF8btZIF+OCMCRV0BuVJ
         Tm6AoaxZfRt0uya4WAOXZ1Q0heI3f9BzSFzq4QmSgn6Boa6219Bv+ccn9dm98hMCU1dP
         mJXx9XGK4Smmg3Md5H4WXCG+l90u1ubopck7DOwAAntA5jdlW2X42Hgcn7yOJT/aCJhJ
         ZJir3Q2UVy3mtv7Ehkg7qlzXI7XjQ+2UG0atZ/fbGs+LlgjFLlag8f6IK2ZFqjH/U4T8
         WHkJllus96wg2zpL6FJHmnl4VemcnmcnZaxUvbWn/XaBW6BY/AhqKVSi+/W/iDkENCo3
         biwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JN3hGCIHhnixIS9+1e2Zq3QBjfj1DM3ntiYPE198lGE=;
        b=d4QILZwHENxhomvYKVcI4Ui5VKNLh4tZQgraNO6mbKBPd2QKY5cipSancr5iXq7fx9
         pljESRckpwfFc2uQ/uhm1tpOkYatXJdGiCUGKPsjSWYZbY1i8ESufiKhi92kVAiq0/ZL
         16pVHpYj2IeJ+MIiGKesYYlmzwG4tLgoVxNGpig7F7GyMR2TSrG3giYi7ztNiroefsw/
         kk6bht7F8+kGw3eWMOFUPiFD5Q7S+/V0RsjYHq1GbCX9Oo43hmX5u5aaaNuZaisEH304
         bwQQGIjoTYowXWPsb2kYhP6/vLllkac5oamvmxIO+tM1XZLZBWS5vIIHWIlxZUwrsh7H
         Fgmg==
X-Gm-Message-State: ALoCoQlLbjNLJf/h/AKTJJllFoqMts2DWWsPvJgOPxgNsgkxNtzG23P+y3S+1scYjjy64sXQvC5J
X-Received: by 10.107.26.195 with SMTP id a186mr53135792ioa.78.1426897707382;
        Fri, 20 Mar 2015 17:28:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id 192sm4224095ioo.38.2015.03.20.17.28.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:27 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265994>

The cleanup function is used in 4 places now and it's always safe to
free up the memory as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 http.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http.c b/http.c
index 9c825af..4b179f6 100644
--- a/http.c
+++ b/http.c
@@ -1462,6 +1462,7 @@ void release_http_pack_request(struct http_pack_request *preq)
 	}
 	preq->slot = NULL;
 	free(preq->url);
+	free(preq);
 }
 
 int finish_http_pack_request(struct http_pack_request *preq)
-- 
2.3.0.81.gc37f363
