From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Enable info/refs gzip decompression in HTTP client
Date: Wed, 19 Sep 2012 16:12:02 -0700
Message-ID: <1348096322-21426-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:12:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TETRH-0007em-HY
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 01:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab2ISXMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 19:12:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57088 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab2ISXME (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 19:12:04 -0400
Received: by pbbrr13 with SMTP id rr13so3620896pbb.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ENjn9FxdfMyFEfTK5ARXdXlZo6WOjCzw6SDxhXUv8QQ=;
        b=dYgUuD3e+Kafz1TW4d2YksosKDrQ+QHlNbu7pdpPKqB/CTHWx/odgkencK+ZMiKdK4
         qNFtBCbjg9CZ6J+1WlMoYsurujoQ9z3O9XKDPte6c0JgojU3GDkANag4IEj2h2PCzDWz
         6xhhg+pjnWQMYKjXf+yr9WYmFV/QywuNNh9D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=ENjn9FxdfMyFEfTK5ARXdXlZo6WOjCzw6SDxhXUv8QQ=;
        b=lOZ5/5nY8TMYgtl+ISe2NJ7HpF6gHHQRlhvZefy8wMTa2de8jlYhrpK0xd0dWJQxfK
         REuinOq9WlyJXlZiVYhrYuZgWv7F0wbm19bapHDop2boJF1pg/dmaKTni7/P0ZVxSvyx
         a06woyGrcMLHtF7TuSlJdefvgYKRSH2unx91bE/fths7z7BEkdr6EqaAlBM1dYg3cO/a
         SvY72ark58CI2TvaeHhcxh8hW8ZbqcNLemGQM3MhGfZOi9F6iWupMzrfh7mmZglqI+gC
         TeQ0Y5KFMHSwd8QUUD5TKKm+tt/fstf3OObA7RPA3SejCaKuByYgA8+TaRTsvwX1SD80
         PctA==
Received: by 10.68.200.8 with SMTP id jo8mr1383696pbc.148.1348096324492;
        Wed, 19 Sep 2012 16:12:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:be30:5bff:fed0:8744])
        by mx.google.com with ESMTPS id pq7sm2504466pbb.25.2012.09.19.16.12.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 16:12:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.510.g5dd77d8
X-Gm-Message-State: ALoCoQleH3ZoastjgHj7rZo3i/LqVo4Iyu49zUkGfNt06qgtrvJrieH47zUsAYBUALJRekGA4OA/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206008>

From: "Shawn O. Pearce" <spearce@spearce.org>

Some HTTP servers try to use gzip compression on the /info/refs
request to save transfer bandwidth. Repositories with many tags
may find the /info/refs request can be gzipped to be 50% of the
original size due to the few but often repeated bytes used (hex
SHA-1 and commonly digits in tag names).

For most HTTP requests enable "Accept-Encoding: gzip" ensuring
the /info/refs payload can use this encoding format.

Disable the Accept-Encoding header on probe RPCs as response bodies
are supposed to be exactly 4 bytes long, "0000". The HTTP headers
requesting and indicating compression use more space than the data
transferred in the body.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 http.c                | 1 +
 remote-curl.c         | 4 ++--
 t/t5551-http-fetch.sh | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 9bac1d8..345c171 100644
--- a/http.c
+++ b/http.c
@@ -818,6 +818,7 @@ static int http_request(const char *url, void *result, int target, int options)
 
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
+	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
diff --git a/remote-curl.c b/remote-curl.c
index 3ec474f..4a0927e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -393,7 +393,7 @@ static int probe_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
-	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
+	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
@@ -449,7 +449,7 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
-	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
+	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
 
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 2db5c35..380c175 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -32,13 +32,14 @@ setup_askpass_helper
 cat >exp <<EOF
 > GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 > Accept: */*
+> Accept-Encoding: gzip
 > Pragma: no-cache
 < HTTP/1.1 200 OK
 < Pragma: no-cache
 < Cache-Control: no-cache, max-age=0, must-revalidate
 < Content-Type: application/x-git-upload-pack-advertisement
 > POST /smart/repo.git/git-upload-pack HTTP/1.1
-> Accept-Encoding: deflate, gzip
+> Accept-Encoding: gzip
 > Content-Type: application/x-git-upload-pack-request
 > Accept: application/x-git-upload-pack-result
 > Content-Length: xxx
-- 
1.7.12.1.510.g5dd77d8
