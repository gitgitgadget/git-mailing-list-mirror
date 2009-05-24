From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 14/18] http-push: use the new http API in fetch_symref()
Date: Sun, 24 May 2009 22:20:01 +0800
Message-ID: <20090524222001.ee7143cc.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Ear-0005ol-Vl
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbZEXOWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754521AbZEXOWX
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:22:23 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:48930 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbZEXOWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:22:21 -0400
Received: by mail-px0-f103.google.com with SMTP id 1so2153790pxi.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=yMFq3v5N0MbfZyE6c8m9G3rAajQuoOkTXfU5adX448c=;
        b=C2JBGPc5w5Fd84qG4ukblotFX4Een7q0+pnZKr0+kH/+7KnJFLJMb7r4dQRni03W1L
         cvOUZarr0G1ZE6Q5fKdx0T7fiNgM/McXY4H0G+4WQH4DcTFUIvILsHGIUHh2QrEjWvET
         RFZKJoMnVhp2m8NAYra18MSzy6ndHFtoFUxBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=GrAmgQHuuO+DxlQatZWgRcxme/26YIrvL3yAIPSl7YeFrjLXttDMn9mqe/CVf6+TZZ
         0UFLTfS/cvCkmew/H9TNeqkiwJMR0KlmK7nQ8WutDGtGam9KFRRPsbk2zOktNAxw0eWf
         jJEE50phczB4daYLUES8Ui7hkhdD3C9nLGVIs=
Received: by 10.114.152.17 with SMTP id z17mr12606965wad.91.1243174943590;
        Sun, 24 May 2009 07:22:23 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id j39sm2711546waf.45.2009.05.24.07.22.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:22:23 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119826>

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/http-push.c b/http-push.c
index 5b20cec..7aa4fc4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2024,27 +2024,13 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 {
 	char *url;
 	struct strbuf buffer = STRBUF_INIT;
-	struct active_request_slot *slot;
-	struct slot_results results;

 	url = xmalloc(strlen(repo->url) + strlen(path) + 1);
 	sprintf(url, "%s%s", repo->url, path);

-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			die("Couldn't get %s for remote symref\n%s",
-			    url, curl_errorstr);
-		}
-	} else {
-		die("Unable to start remote symref request");
-	}
+	if (http_get_strbuf(url, &buffer, 0) != HTTP_OK)
+		die("Couldn't get %s for remote symref\n%s", url,
+		    curl_errorstr);
 	free(url);

 	free(*symref);
--
1.6.3.1
