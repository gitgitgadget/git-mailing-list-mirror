From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 17/23] http.c::http_fetch_ref(): use the new http API
Date: Sat, 6 Jun 2009 16:43:55 +0800
Message-ID: <20090606164355.b2f491f1.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrcJ-0004Mp-5Z
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbZFFIuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713AbZFFIuX
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:50:23 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:34239 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694AbZFFIuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:50:21 -0400
Received: by pzk1 with SMTP id 1so1305746pzk.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=v5OZaCxwKXxQ72D9Mv1Kw18EY8jImcTnRcSitssF2Lg=;
        b=HUUT6lADEISyAytMAanP8o1aEQ+msvu3kemRyFTat+A4cNrfObwklZw+V+Pv4lWJa7
         esE23jdU6GDVyYiGNPnmazzfBJGRFNXp0SxB4MPsqvyk4xenmpVYuLDFQzQc+dPzatB2
         EzQfMvkpS7CIpJq74zIwmwvN+RFrpl4QE78uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=kb65mzq3WF8vnVi0ZB4x/qbKsemG0Wt61rDRMLCJXnhMnEO+q3HvbEuM7oGT6kEmn7
         pujAyuQqsuGa5nEP8MCZ2BYVTrIZ1CFtHauZOYzKRWRv2rQh33oo4RWZiIG6j+V5Ynpn
         32GGhLXEw+fO6xilMS1+4nIbPzU3ll/Kn/FHE=
Received: by 10.142.88.3 with SMTP id l3mr1647609wfb.339.1244278221865;
        Sat, 06 Jun 2009 01:50:21 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 28sm2825709wfg.5.2009.06.06.01.50.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:50:21 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120897>

From:	Mike Hommey <mh@glandium.org>

The error message ("Unable to start request") has been removed, since
the http API already prints it.

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This is based on Mike's earlier patch:

Subject: [WIP Patch 04/12] Use the new http API in http_fetch_ref()
Date:	Sun, 18 Jan 2009 09:04:29 +0100

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
