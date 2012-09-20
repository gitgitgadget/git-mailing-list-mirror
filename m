From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Disable dumb HTTP fallback with GIT_CURL_FALLBACK=0
Date: Wed, 19 Sep 2012 19:55:53 -0700
Message-ID: <1348109753-32388-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 04:56:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEWvt-0005vo-Uh
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 04:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab2ITCz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 22:55:57 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55890 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab2ITCz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 22:55:56 -0400
Received: by pbbrr13 with SMTP id rr13so3984683pbb.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 19:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=t7V+mnDw0mPHPw6Z5v05/a8Lr1FyUcrlFKBp5ylWecg=;
        b=A5yFVqPoFTZ8Tzy+D+pqfjJXeUXxm+88FYLq4NTw2e91eMvBxK9ZLWYZNK3ZHHc2BF
         2vW9ZC+KkY/qB5ivNRC4S8plX+Fc84fXGF3tXR30Cw/ATv5RvI3GGf6ygQcw20GxTfCg
         11jRqK0fHYjKNw63q4HqOjG6jJmOGoz5aW8RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=t7V+mnDw0mPHPw6Z5v05/a8Lr1FyUcrlFKBp5ylWecg=;
        b=ct3GcT0eM15zovvS5HZPxGZle7zwZk8sPb/WzaJ8YSfAMLrbOq7EjUjDqgrSkGHAO6
         RffDleZFpQfA3MTmerqzcF98H4sjyY+5CVU1ZLKbxEoT/55Drkat8tpt0su0TIQz+m0f
         J7/i5M95O9iyt475sPkVRxaWh2EYLJZzfT64N2MGW1Rae5+UdcjQHHZqQEHI58pkcpnb
         O3pTwVNoQBRWIVFMalcmGu4bvxeNg8xGGio2iGHZ05Nbcdr/aQUXgl5KZnLxq3e43flv
         90C5HYfFObT4gKbaGkLE2MHU7KuFQ8OY+Qitf7xnDMiNSvX9VnOc3/CUb+LyUmkvucH0
         a/UQ==
Received: by 10.66.9.2 with SMTP id v2mr1736690paa.65.1348109755989;
        Wed, 19 Sep 2012 19:55:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:be30:5bff:fed0:8744])
        by mx.google.com with ESMTPS id pi1sm2778375pbb.7.2012.09.19.19.55.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 19:55:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.512.g9b230e6
X-Gm-Message-State: ALoCoQnp2kSUBDjwWLI7KtD3MTw2dOyvKqB3n/aznR+fe3iuAnlbZ4en3KRAhv2af3dGwsMzAvNY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206026>

From: "Shawn O. Pearce" <spearce@spearce.org>

If the user doesn't want to use the dumb HTTP protocol, she may
set GIT_CURL_FALLBACK=0 in the environment before invoking a Git
protocol operation. This is mostly useful when testing against
servers that are known to not support the dumb protocol. If the
smart service detection fails the client should not continue with
dumb behavior, but instead provide accurate HTTP failure data.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 remote-curl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 4a0927e..2f91128 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -17,7 +17,8 @@ struct options {
 	unsigned progress : 1,
 		followtags : 1,
 		dry_run : 1,
-		thin : 1;
+		thin : 1,
+		fallback : 1;
 };
 static struct options options;
 
@@ -115,7 +116,8 @@ static struct discovery* discover_refs(const char *service)
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
 
 	/* try again with "plain" url (no ? or & appended) */
-	if (http_ret != HTTP_OK && http_ret != HTTP_NOAUTH) {
+	if (options.fallback && http_ret != HTTP_OK
+	    && http_ret != HTTP_NOAUTH) {
 		free(refs_url);
 		strbuf_reset(&buffer);
 
@@ -868,6 +870,12 @@ int main(int argc, const char **argv)
 	options.verbosity = 1;
 	options.progress = !!isatty(2);
 	options.thin = 1;
+	options.fallback = 1;
+
+	if (getenv("GIT_CURL_FALLBACK")) {
+		char *fb = getenv("GIT_CURL_FALLBACK");
+		options.fallback = *fb != '0';
+	}
 
 	remote = remote_get(argv[1]);
 
-- 
1.7.12.1.512.g9b230e6
