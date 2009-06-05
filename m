From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 19/23] http-push.c::fetch_symref(): use the new http API
Date: Sat, 6 Jun 2009 00:05:59 +0800
Message-ID: <20090606000559.483f22da.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzL-00053w-UM
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908AbZFEQJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbZFEQJX
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:09:23 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43072 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbZFEQJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:09:22 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so944213pzk.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=2rTGIWh6cPsoics6r5ed9/xVDTbbinDHvzUMAyqc9Ck=;
        b=Lq/jpJMxRi//fym1f61KitIaUWpl8WrPdCmnszRYLqHxio2WRQMvcCSZvA27+vKyXD
         4rczgZ4AjyJ0G13HA9VjhFiDYnSfJDstY3N/D/N0hLo05STj2kofEMaiD3FiJRjWLFfL
         afrnAFgW1j+0wTUkxWzPiqjZFpTgsJPaS1c3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Yyci/1Y7d+jvE6q7hgGvGh36pdHtzSg0obHioPXB7ZyI4bM+J/Je4EPMTw5M2aX5h2
         8EaGkDK6bdJGhuIwJ4gyOx5+2rPsfksaaGqGNrqdblFm2v/bAd0Spn0uOpJNL8Gduz7m
         7ebn7q2w4gUovWtItvuVdbOKCFvVXH2tHqJU8=
Received: by 10.142.223.4 with SMTP id v4mr1404094wfg.11.1244218164905;
        Fri, 05 Jun 2009 09:09:24 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 30sm444911wff.9.2009.06.05.09.09.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:09:24 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120799>

From:	Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 09/12] Use the new http API in fetch_symref()
Date:	Sun, 18 Jan 2009 09:04:34 +0100

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
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
