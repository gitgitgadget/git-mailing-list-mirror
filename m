From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/2] Do curl option disabling before enabling new options
Date: Tue, 24 Nov 2009 09:50:21 +0800
Message-ID: <20091124095021.93942a56.rctay89@gmail.com>
References: <20091124094810.797341d4.rctay89@gmail.com>
 <Pine.LNX.4.64.0904142200130.7479@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Martin =?ISO-8859-1?Q?Storsj=F6?= <martin@martin.st>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 02:50:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCkYB-0000FW-IO
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 02:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757401AbZKXBuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 20:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755655AbZKXBuX
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 20:50:23 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:61863 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbZKXBuW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 20:50:22 -0500
Received: by ywh12 with SMTP id 12so5917891ywh.21
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 17:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=sjOiondBcsUFjV1gh0/sRsYqdiqSK1hheCxAjgU/EyM=;
        b=Ns0CXGydM3To/FszAiQAjXh3E7xOTDcXMir5mnP0tBgM8gvJaEPxw3G2k+KADkjWJ/
         8sDii1Dn8mekfMfkHavO591Yvgyhu6on7d5dlceV6Xu8uCK8K6ZCriexRfYDf6cooIRy
         OFu2319DA++gbsEpsB6okSuQNc0a47zl80mFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=ieiktS23E5rKVF6/DIZ11pE6/Z4KwQHmwot2kO/erJFQKwZNRkHtac/qQpRcSxFhCC
         ZSTfNY3+RBe707wNa5j0M59E84ZzC9OvSjWoWsRGKjoxK9jxbbaqsuqJ3DW3IskPG/U3
         TYuGe+4sBw8mS8CKA4MULCCRtqeFMaIOIFZnQ=
Received: by 10.91.162.31 with SMTP id p31mr7362743ago.121.1259027428737;
        Mon, 23 Nov 2009 17:50:28 -0800 (PST)
Received: from your-cukc5e3z5n (cm164.zeta152.maxonline.com.sg [116.87.152.164])
        by mx.google.com with ESMTPS id 34sm2174558yxf.29.2009.11.23.17.50.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 17:50:27 -0800 (PST)
In-Reply-To: <20091124094810.797341d4.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133554>

From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>

This works around a bug in curl versions up to 7.19.4, where
disabling the CURLOPT_NOBODY option sets the internal state
incorrectly considering that CURLOPT_PUT was enabled earlier.

The bug is discussed at http://curl.haxx.se/bug/view.cgi?id=2727981
and is corrected in the latest version of curl in CVS.

This bug usually has no impact on git, but may surface if using
multi-pass authentication methods.

Signed-off-by: Martin Storsjo <martin@martin.st>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  No changes from the previous version.

 http-push.c   |    2 +-
 remote-curl.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index 0e040f8..432b20f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -408,10 +408,10 @@ static void start_put(struct transfer_request *request)
 	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &request->buffer);
 #endif
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_PUT, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);

 	if (start_active_slot(slot)) {
diff --git a/remote-curl.c b/remote-curl.c
index 4f28c22..69eaf58 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -356,8 +356,8 @@ static int post_rpc(struct rpc_state *rpc)
 	slot = get_active_slot();
 	slot->results = &results;

-	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");

--
1.6.4.4
