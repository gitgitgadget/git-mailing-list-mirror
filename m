From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 19/23] http-push.c::fetch_symref(): use the new http API
Date: Sat, 6 Jun 2009 16:43:58 +0800
Message-ID: <20090606164358.29164835.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:51:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrcK-0004Mp-Ig
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbZFFIub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754741AbZFFIua
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:50:30 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:34239 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713AbZFFIu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:50:28 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so1305746pzk.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ttufWJ9q3UPI/hF3zLDNpWHyMaFwkZfQf2MJnP1VS04=;
        b=yGNeNErPuCEaMGc+AQCN0Sc+j0eFs82jAlUj7twfpduxh08ywDW5g90LrPtzMqMb7a
         Y/y1uLzRawHbv47//WFGV9TDv1OvW/xPyQ94/6yiAI3Rq2T0qgJ7IAPu45dCFLtufX9o
         Q4ZkGmq9+zyXvAVefSadic3HVPWi8tUuPYht4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=f3DgstFIDB24JLKdTqwRkgeNMVK6UQhP21X1Uys80W3pct7rKsANAiHn1s7mWAVYAF
         SvUuwEY2kn1gsb4Nf6Au428g0tcIzyz2tIwxDoVfxL0Qhk0TrMh3Ud0TzJ+Rsi0L0cA0
         cN3w5nR0KZyCu1ThoIsfyWx3IZkom92Ja/GQY=
Received: by 10.143.6.19 with SMTP id j19mr1477518wfi.338.1244278231289;
        Sat, 06 Jun 2009 01:50:31 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 22sm2744127wfd.19.2009.06.06.01.50.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:50:30 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120901>

From:	Mike Hommey <mh@glandium.org>

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This is based on Mike's earlier patch:

Subject: [WIP Patch 09/12] Use the new http API in fetch_symref()
Date:	Sun, 18 Jan 2009 09:04:34 +0100

 http-push.c |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/http-push.c b/http-push.c
index 455e0aa..1714e4e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2029,27 +2029,13 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
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
