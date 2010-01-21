From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] http/remote-curl: coddle picky servers
Date: Thu, 21 Jan 2010 22:41:00 +0800
Message-ID: <20100121224100.624c9c9d.rctay89@gmail.com>
References: <20100121004756.GA18213@onerussian.com>
 <20100121050850.GA18896@Knoppix>
 <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
 <20100121155136.17b59e8f.rctay89@gmail.com>
 <20100121140054.GH18213@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 15:41:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXyDu-0003cA-Ai
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 15:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab0AUOlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 09:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557Ab0AUOlR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 09:41:17 -0500
Received: from mail-bw0-f222.google.com ([209.85.218.222]:57412 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab0AUOlR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 09:41:17 -0500
Received: by bwz22 with SMTP id 22so37952bwz.25
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 06:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=u8a6O8qQVAZWH7efeU6DZxevnxe+OBxSSFWRzrUNZxU=;
        b=ArLl+4cCJ2XtJ88TlSVNHHCPcnXyeuL8LDgdAmaEhXKo2cW2Nsy2iI4xkEAUR3l22h
         dwfwfbOAq8cDVGjZoqPMuGts9i02hQelAAPPuhSCsELxvQ4jTTEfKmvE/k1sBZAISD5T
         OKalkiRrRACC74131thThxAFgztxXsM3WsPcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=PVjJTQi2EkXAl9rYhqdLOgPGwXSXYposGcmkZD4qhj0WwGkEAuEiE2oadZU089J4HS
         cz0vnoFTBxEWeGM04sZQLmwn8t6H6qSd6DEGJC7VGPNK7+4977fPi2Wu5d4Pi3HtePGS
         LOLufipgb+fZM9G6Ykb1oK7ZHw6OkrIliK7jg=
Received: by 10.204.32.19 with SMTP id a19mr801346bkd.90.1264084875350;
        Thu, 21 Jan 2010 06:41:15 -0800 (PST)
Received: from your-cukc5e3z5n (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 15sm489278bwz.12.2010.01.21.06.41.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Jan 2010 06:41:14 -0800 (PST)
In-Reply-To: <20100121140054.GH18213@onerussian.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137658>

When "info/refs" is a static file and not behind a CGI handler, some
servers may not handle a GET request for it with a query string
appended (eg. "?foo=bar") properly.

If such a request fails, retry it sans the query string. In addition,
ensure that the "smart" http protocol is not used (a service has to be
specified with "?service=<service name>" to be conformant).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Reported-and-tested-by: Yaroslav Halchenko <debian@onerussian.com>
---
 remote-curl.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1361006..a904164 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -102,7 +102,7 @@ static struct discovery* discover_refs(const char *service)
 	struct strbuf buffer = STRBUF_INIT;
 	struct discovery *last = last_discovery;
 	char *refs_url;
-	int http_ret, is_http = 0;
+	int http_ret, is_http = 0, proto_git_candidate = 1;

 	if (last && !strcmp(service, last->service))
 		return last;
@@ -121,6 +121,19 @@ static struct discovery* discover_refs(const char *service)

 	init_walker();
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
+
+	/* try again with "plain" url (no ? or & appended) */
+	if (http_ret != HTTP_OK) {
+		free(refs_url);
+		strbuf_reset(&buffer);
+
+		proto_git_candidate = 0;
+		strbuf_addf(&buffer, "%s/info/refs", url);
+		refs_url = strbuf_detach(&buffer, NULL);
+
+		http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
+	}
+
 	switch (http_ret) {
 	case HTTP_OK:
 		break;
@@ -137,7 +150,8 @@ static struct discovery* discover_refs(const char *service)
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;

-	if (is_http && 5 <= last->len && last->buf[4] == '#') {
+	if (is_http && proto_git_candidate
+		&& 5 <= last->len && last->buf[4] == '#') {
 		/* smart HTTP response; validate that the service
 		 * pkt-line matches our request.
 		 */
--
1.6.6.1.337.g96bc8
