From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 11/17] http.c::http_fetch_ref(): use the new http API
Date: Sat, 30 May 2009 01:59:25 +0800
Message-ID: <20090530015925.e329cdd7.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6P8-0000Xl-AM
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759937AbZE2SBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759858AbZE2SBQ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:01:16 -0400
Received: from mail-pz0-f109.google.com ([209.85.222.109]:61513 "EHLO
	mail-pz0-f109.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759829AbZE2SBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:01:15 -0400
Received: by pzk7 with SMTP id 7so4912597pzk.33
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=MtHFwbjaM0ECQfrVWO+MYjkVZfBmQrnHi8QmMq8O6A4=;
        b=e7KH21HaU5UYfBKrGLQBGtPhnJNder05fgp/zfmSLZTMMn5fV9TE1JlTgZepHgCLGq
         Bteh5LCVdZAf7pXTAP4lFePxbNP9wZymZRWlR6FDROm2tYSsMCYIlPWBTIicfElN5G2r
         Rgyz7z15nPfdHAfllnqUIlGbBcDJZ4DcQGHm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=OBtQdtN2xAqwuJA3iOIWMImN9VDofQKZObAY3I3Gq5poURN67LLFZWH00s/jQAkrVj
         /AMBMdAGsKUYk6NsnIJYIdE5E3i8eZbklGrnTOU+oyDZPhVZZY5+Zr2EGqEMqQ9Se68k
         Z6JfMHcvCJRq4W8cVAJkwHH6YR9uy3OxwQv8w=
Received: by 10.114.181.13 with SMTP id d13mr4655619waf.109.1243620077292;
        Fri, 29 May 2009 11:01:17 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id k37sm2564763waf.7.2009.05.29.11.01.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:01:16 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120299>

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
index 1434603..c640510 100644
--- a/http.c
+++ b/http.c
@@ -772,34 +772,17 @@ int http_fetch_ref(const char *base, struct ref *ref)
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
