From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 3/3] remote-curl: ensure that URLs have a trailing slash
Date: Thu,  8 Apr 2010 10:15:18 +0800
Message-ID: <1270692918-4300-3-git-send-email-rctay89@gmail.com>
References: <1270656067-688-2-git-send-email-rctay89@gmail.com>
 <1270692918-4300-1-git-send-email-rctay89@gmail.com>
 <1270692918-4300-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 04:15:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzhHY-0003Hm-Jp
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 04:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab0DHCPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 22:15:47 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:63053 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab0DHCPj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 22:15:39 -0400
Received: by qw-out-2122.google.com with SMTP id 8so625198qwh.37
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 19:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HGY5Cq1Oh+Ax+YdTnRTcpQMj8EBt8moWYAWG179pdxQ=;
        b=CvYFKF8wOgYPBGcwWTmMWxDDdlDz8dlnsA3z2JZiMUeDlNCp9eIHVA9kk4XLyMSM7T
         0JbL9OR6z5cErwx4LjWgu7dmZWqGLda1YPq3GrzuvTXfpJ3gWyyoggsSTpRbFs1CnpSc
         AxI57iL0lkd74BGT357KwkFOGgjO+3VfDUePQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KXHvBGhkK4rh1yC5KQpbr0YnetRxqbDt3t7JRq8tIKT8+PVrNOhXzhqPEd8QA0al1d
         2S6vEiXr7CDvqZfke8BPm/lOoFb/u09t9nhdYndH+rSTvfUmYFU1ywYDOOzinYaTAQDM
         uLC42g9oxoi9p7o1cSV85ZEPqz+Uoz/WLP0EA=
Received: by 10.229.193.18 with SMTP id ds18mr3362968qcb.14.1270692937516;
        Wed, 07 Apr 2010 19:15:37 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id v26sm8664223qce.13.2010.04.07.19.15.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 19:15:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1270692918-4300-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144306>

Previously, we blindly assumed that URLs passed to the remote-curl
helper did not end with a trailing slash.

Use the convenience function end_url_with_slash() from http.[ch] to
ensure that URLs have a trailing slash on invocation of the remote-curl
helper, and use the URL as one with a trailing slash throughout.

It is possible for users to pass a URL with a trailing slash to
remote-curl, by, say, setting it in remote.<name>.url in their git
config. The resulting requests have an empty path component (//) and may
break implementations of the http git protocol.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 remote-curl.c        |   16 +++++++++++-----
 t/t5541-http-push.sh |    2 +-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0782756..ae14137 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -9,6 +9,10 @@
 #include "sideband.h"
 
 static struct remote *remote;
+
+/* At assignment-time, we append a trailing slash; always use this as
+ * if it ends with a slash.
+ */
 static const char *url;
 
 struct options {
@@ -101,7 +105,7 @@ static struct discovery* discover_refs(const char *service)
 		return last;
 	free_discovery(last);
 
-	strbuf_addf(&buffer, "%s/info/refs", url);
+	strbuf_addf(&buffer, "%sinfo/refs", url);
 	if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
 		is_http = 1;
 		if (!strchr(url, '?'))
@@ -120,7 +124,7 @@ static struct discovery* discover_refs(const char *service)
 		strbuf_reset(&buffer);
 
 		proto_git_candidate = 0;
-		strbuf_addf(&buffer, "%s/info/refs", url);
+		strbuf_addf(&buffer, "%sinfo/refs", url);
 		refs_url = strbuf_detach(&buffer, NULL);
 
 		http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
@@ -511,7 +515,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	rpc->out = client.out;
 	strbuf_init(&rpc->result, 0);
 
-	strbuf_addf(&buf, "%s/%s", url, svc);
+	strbuf_addf(&buf, "%s%s", url, svc);
 	rpc->service_url = strbuf_detach(&buf, NULL);
 
 	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
@@ -800,11 +804,13 @@ int main(int argc, const char **argv)
 	remote = remote_get(argv[1]);
 
 	if (argc > 2) {
-		url = argv[2];
+		end_url_with_slash(&buf, argv[2]);
 	} else {
-		url = remote->url[0];
+		end_url_with_slash(&buf, remote->url[0]);
 	}
 
+	url = strbuf_detach(&buf, NULL);
+
 	http_init(remote);
 
 	do {
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index e94ac78..17e1bdc 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -38,7 +38,7 @@ cat >exp <<EOF
 GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
 EOF
-test_expect_failure 'no empty path components' '
+test_expect_success 'no empty path components' '
 	# In the URL, add a trailing slash, and see if git appends yet another
 	# slash.
 	cd "$ROOT_PATH" &&
-- 
1.6.6.1368.g82eeb
