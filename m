From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 17/23] http.c::http_fetch_ref(): use the new http API
Date: Sat, 6 Jun 2009 00:05:56 +0800
Message-ID: <20090606000556.9cbf4ac0.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzK-00053w-GF
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854AbZFEQJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755076AbZFEQJO
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:09:14 -0400
Received: from mail-px0-f202.google.com ([209.85.216.202]:50429 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834AbZFEQJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:09:13 -0400
Received: by mail-px0-f202.google.com with SMTP id 40so80522pxi.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Zv0by7mMXt9IVSLcY3gbiOIP/YKBcO3VPSqeV0Yeew0=;
        b=m/MPwvZ5lLhJurMfNnub4P9tiYSotPaGy2RFCCEe9gHZHxLoqXs9eqfCHOCMN0FKay
         x7WO2wYXMpdk2piuRZe6UrXkQC181s8uX4lhnxf0CLcfyAbolTBsmFYNiZu3VoVn5nrj
         xnO/Y38qk3PWKqjMVR4CIRCksO34zsV0vjZtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=toLeX26Gq5gq9mMNGomN4JB4V5tnPqQiMRbqE8vjOID64QYPvEuHmEiwhRmgJUah46
         sfmlixTzC1PwquMfRXinHE7/3/PxdtbusE+N6Y5itANouF9kB9BdlZoGz/fdDDV8JwHB
         jcx8ey+o75iWwNjw4NPERwUwOafR89u9DNVkA=
Received: by 10.143.39.13 with SMTP id r13mr1313731wfj.33.1244218155393;
        Fri, 05 Jun 2009 09:09:15 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 22sm429635wfi.32.2009.06.05.09.09.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:09:14 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120796>

From:	Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 04/12] Use the new http API in http_fetch_ref()
Date:	Sun, 18 Jan 2009 09:04:29 +0100

The error message ("Unable to start request") has been removed, since
the http API already prints it.

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |   33 ++++++++-------------------------
 1 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/http.c b/http.c
index df22180..2a49372 100644
--- a/http.c
+++ b/http.c
@@ -773,34 +773,17 @@ int http_fetch_ref(const char *base, struct ref *ref)
 {
 	char *url;
 	struct strbuf buffer = STRBUF_INIT;
-	struct active_request_slot *slot;
-	struct slot_results results;
-	int ret;
+	int ret = -1;

 	url = quote_ref_url(base, ref->name);
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result == CURLE_OK) {
-			strbuf_rtrim(&buffer);
-			if (buffer.len == 40)
-				ret = get_sha1_hex(buffer.buf, ref->old_sha1);
-			else if (!prefixcmp(buffer.buf, "ref: ")) {
-				ref->symref = xstrdup(buffer.buf + 5);
-				ret = 0;
-			} else
-				ret = 1;
-		} else {
-			ret = error("Couldn't get %s for %s\n%s",
-				    url, ref->name, curl_errorstr);
+	if (http_get_strbuf(url, &buffer, HTTP_NO_CACHE) == HTTP_OK) {
+		strbuf_rtrim(&buffer);
+		if (buffer.len == 40)
+			ret = get_sha1_hex(buffer.buf, ref->old_sha1);
+		else if (!prefixcmp(buffer.buf, "ref: ")) {
+			ref->symref = xstrdup(buffer.buf + 5);
+			ret = 0;
 		}
-	} else {
-		ret = error("Unable to start request");
 	}

 	strbuf_release(&buffer);
--
1.6.3.1
