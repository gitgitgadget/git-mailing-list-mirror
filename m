From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH (resend) 2/3] http.c: replace usage of temporary variable
 for urls
Date: Mon, 10 Aug 2009 23:59:55 +0800
Message-ID: <20090810235955.1a659e6c.rctay89@gmail.com>
References: <be6fef0d0908100847h7e9b53a2ofdf318e9958be3b2@mail.gmail.com>
 <20090810235548.110c43a6.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff Lasslett <jeff.lasslett@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 10 18:00:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXIe-00056E-6M
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbZHJQAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbZHJQAM
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:00:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:24394 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbZHJQAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:00:10 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1030718rvb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=xKyCPI0MTM2u1UuQPVj2aOLefzUpVc/00hSoLMtWr3E=;
        b=bW1xHJqAy1V0SIz0Z5Cue2bYWUwRD+ErFiVGevRFkK2/mE2YWF9HxwfeOGoqeTnEPS
         SxnOH93Bx9hKYotrB4kuMl34r6usoeEth5Yek5e3og1k2BTClrPIfH2cvDOJdqleS0jS
         gxUwtkXzXHEI1ojRcywzBHaOJPJ8QfvLuo2XE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=DgDTSSDiKPvumnJ+HOS2rFKgsEMFV7fLrt16VbSA0NeDBf+wRQOx3HE5VMxVFonMuK
         SHtH12ri2DkkDcdb98iOwRxmDaUCNlHieu2iEtZhynW9kHg2Z6amB0LIQ0kf42lH3EDw
         JUeBnMctLrMKOU8mdr6cHXEhGQ880JsGIpJaE=
Received: by 10.140.170.12 with SMTP id s12mr1657808rve.296.1249920011490;
        Mon, 10 Aug 2009 09:00:11 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta152.maxonline.com.sg [116.87.152.189])
        by mx.google.com with ESMTPS id k41sm22899974rvb.18.2009.08.10.09.00.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 09:00:11 -0700 (PDT)
In-Reply-To: <20090810235548.110c43a6.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125473>

Use preq->url in new_http_pack_request and freq->url in
new_http_object_request when calling curl_setopt(CURLOPT_URL), instead
of using an intermediate variable, 'url'.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/http.c b/http.c
index cfe32f5..98f9707 100644
--- a/http.c
+++ b/http.c
@@ -1004,7 +1004,6 @@ int finish_http_pack_request(struct http_pack_request *preq)
 struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url)
 {
-	char *url;
 	char *filename;
 	long prev_posn = 0;
 	char range[RANGE_HEADER_SIZE];
@@ -1018,8 +1017,7 @@ struct http_pack_request *new_http_pack_request(
 	end_url_with_slash(&buf, base_url);
 	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
 		sha1_to_hex(target->sha1));
-	url = strbuf_detach(&buf, NULL);
-	preq->url = xstrdup(url);
+	preq->url = strbuf_detach(&buf, NULL);

 	filename = sha1_pack_name(target->sha1);
 	snprintf(preq->filename, sizeof(preq->filename), "%s", filename);
@@ -1035,7 +1033,7 @@ struct http_pack_request *new_http_pack_request(
 	preq->slot->local = preq->packfile;
 	curl_easy_setopt(preq->slot->curl, CURLOPT_FILE, preq->packfile);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
 		no_pragma_header);

@@ -1059,6 +1057,7 @@ struct http_pack_request *new_http_pack_request(

 abort:
 	free(filename);
+	free(preq->url);
 	free(preq);
 	return NULL;
 }
@@ -1099,7 +1098,6 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	char *hex = sha1_to_hex(sha1);
 	char *filename;
 	char prevfile[PATH_MAX];
-	char *url;
 	int prevlocal;
 	unsigned char prev_buf[PREV_BUF_SIZE];
 	ssize_t prev_read = 0;
@@ -1153,8 +1151,7 @@ struct http_object_request *new_http_object_request(const char *base_url,

 	git_SHA1_Init(&freq->c);

-	url = get_remote_object_url(base_url, hex, 0);
-	freq->url = xstrdup(url);
+	freq->url = get_remote_object_url(base_url, hex, 0);

 	/*
 	 * If a previous temp file is present, process what was already
@@ -1199,7 +1196,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	curl_easy_setopt(freq->slot->curl, CURLOPT_FILE, freq);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);

 	/*
@@ -1219,9 +1216,9 @@ struct http_object_request *new_http_object_request(const char *base_url,

 	return freq;

-	free(url);
 abort:
 	free(filename);
+	free(freq->url);
 	free(freq);
 	return NULL;
 }
--
1.6.3.1
