From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/2] Do curl option disabling before enabling new options
Date: Mon, 23 Nov 2009 11:03:28 +0800
Message-ID: <20091123110328.748fcf09.rctay89@gmail.com>
References: <Pine.LNX.4.64.0904142200130.7479@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Martin =?ISO-8859-1?Q?Storsj=F6?= <martin@martin.st>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 04:03:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCPDP-000862-0V
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 04:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbZKWDDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 22:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754349AbZKWDDb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 22:03:31 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:53656 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbZKWDDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 22:03:30 -0500
Received: by yxe17 with SMTP id 17so4373616yxe.33
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 19:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=+OQbkVE0wtlgreQ4wXKKXWRzxweGnnW/axLxQwoNA98=;
        b=W7BWU8pXxmHFl112F16TGA1JwWCBXy/1K1p9/iITb5Q9tCNA3owPTrjVSyoQlmebD9
         JWCdLLrc78PgdcUu19HppoR36s43irP6XsARY/zy6uUKybmN8sWfW+Z9pHgr3wn3/7ew
         NhKcZLC1c+zU7IFv1VvE5v7JRxsklyOnIRmsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=N3eeVUMLKiqX5Ar7t7F8a0ayH/DeUwV4ItgEjx1RL4W70ssf3EfyfIgW9ehHKINi9Y
         FG9FpNxMsvtlNHhT2k4DBihrotcg+zw1yDkndB8pfckMPdUAlES51crewgDaTH0Ex9+f
         qvxROwBLQc4rdt9rBGlZhhCi6Rf6Fvqp3G0nQ=
Received: by 10.150.129.39 with SMTP id b39mr7535568ybd.91.1258945416312;
        Sun, 22 Nov 2009 19:03:36 -0800 (PST)
Received: from your-cukc5e3z5n (cm164.zeta152.maxonline.com.sg [116.87.152.164])
        by mx.google.com with ESMTPS id 20sm1335411ywh.17.2009.11.22.19.03.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 19:03:35 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0904142200130.7479@localhost.localdomain>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133476>

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

  Squashed in another potential trigger for this bug in remote-curl.c,
  introduced in 'next'.

 http-push.c   |    2 +-
 remote-curl.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index f10803a..295f1fb 100644
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
