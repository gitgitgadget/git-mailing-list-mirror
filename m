From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Revert "retry request without query when info/refs?query fails"
Date: Wed, 19 Sep 2012 22:58:00 -0700
Message-ID: <1348120680-24788-1-git-send-email-spearce@spearce.org>
References: <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 07:58:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEZmC-0003cF-AC
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 07:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab2ITF6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 01:58:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58133 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab2ITF6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 01:58:03 -0400
Received: by pbbrr13 with SMTP id rr13so4283273pbb.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 22:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=m0YsmsEHXvT1Cn/DTN8RJu5ZB4lmYxdHDQqsJHaVbJE=;
        b=ZVAQJ9SXZeKusX1B2ZVEmLF7qmVpgm+RmUO/ej8ejdeHeh1zCNvEFaCjgAl+28KoeL
         ERvh6hQuOvu+FDAo+BYSCvBo5d+/E1sMHZPhSwHdcnYDsECjcR1KFpIg7CjBYnwUx9jT
         hSI5rmsb9Yp31YFadMSCoWmHtjF8XooQa+pFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=m0YsmsEHXvT1Cn/DTN8RJu5ZB4lmYxdHDQqsJHaVbJE=;
        b=pywwsw+viAzh64qX6kePMtjESvdYdX6XAqcEuVnbpVIuKTA3SscWR59rG6iw8XWPHJ
         x7ccQN7DOkp5ru+WJJlZaMN12hcr6mlv8dpMjFofIOrYKw1Mg1S7F8YOQ57iS1nemeVq
         m8M/VbgkEdmyozOakrw+gs0miHuKXJKz2L0xR/IJqyHk7o9cuxPzwNmfPbeUMqRsBMST
         IYKcZKSrLT++rfCRWvT8V+2MZtgyp/zL+R7OxO9QJO8Fs+ySGv8HXPMtvyvQXDd83+dz
         /i6/56mx4GLI91PDmE+stRKjZOmp6PZRwPtFl3M0OOZTBDa/dPFHxFzwHeqgrnspXm+j
         oL/Q==
Received: by 10.68.222.42 with SMTP id qj10mr3811695pbc.117.1348120682818;
        Wed, 19 Sep 2012 22:58:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:be30:5bff:fed0:8744])
        by mx.google.com with ESMTPS id pi1sm3013356pbb.7.2012.09.19.22.58.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 22:58:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.512.g9b230e6
In-Reply-To: <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
X-Gm-Message-State: ALoCoQki3iE7dd511deROj0VNsK3shcMZGp0KfNNaAxH/ZLPVq6iceHvPfE7dHTKJCWnU3/g2an7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206036>

From: "Shawn O. Pearce" <spearce@spearce.org>

This reverts commit 703e6e76a14825e5b0c960d525f34e607154b4f7.

Retrying without the query parameter was added as a workaround
for a single broken HTTP server at git.debian.org[1]. The server
was misconfigured to route every request with a query parameter
into gitweb.cgi. Admins fixed the server's configuration within
16 hours of the bug report to the Git mailing list, but we still
patched Git with this fallback and have been paying for it since.

Most Git hosting services configure the smart HTTP protocol and the
retry logic confuses users when there is a transient HTTP error as
Git dropped the real error from the smart HTTP request. Removing the
retry makes root causes easier to identify.

[1] http://thread.gmane.org/gmane.comp.version-control.git/137609
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 remote-curl.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 3ec474f..2359f59 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -95,7 +95,7 @@ static struct discovery* discover_refs(const char *service)
 	struct strbuf buffer = STRBUF_INIT;
 	struct discovery *last = last_discovery;
 	char *refs_url;
-	int http_ret, is_http = 0, proto_git_candidate = 1;
+	int http_ret, is_http = 0;
 
 	if (last && !strcmp(service, last->service))
 		return last;
@@ -113,19 +113,6 @@ static struct discovery* discover_refs(const char *service)
 	refs_url = strbuf_detach(&buffer, NULL);
 
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
-
-	/* try again with "plain" url (no ? or & appended) */
-	if (http_ret != HTTP_OK && http_ret != HTTP_NOAUTH) {
-		free(refs_url);
-		strbuf_reset(&buffer);
-
-		proto_git_candidate = 0;
-		strbuf_addf(&buffer, "%sinfo/refs", url);
-		refs_url = strbuf_detach(&buffer, NULL);
-
-		http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
-	}
-
 	switch (http_ret) {
 	case HTTP_OK:
 		break;
@@ -144,8 +131,7 @@ static struct discovery* discover_refs(const char *service)
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
 
-	if (is_http && proto_git_candidate
-		&& 5 <= last->len && last->buf[4] == '#') {
+	if (is_http && 5 <= last->len && last->buf[4] == '#') {
 		/* smart HTTP response; validate that the service
 		 * pkt-line matches our request.
 		 */
-- 
1.7.12.1.512.g9b230e6
