From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 resend 2/2] remote-curl: ensure that URLs have a trailing slash
Date: Thu,  8 Apr 2010 00:01:07 +0800
Message-ID: <1270656067-688-2-git-send-email-rctay89@gmail.com>
References: <p2ube6fef0d1004070857j874c2b60z6a4794d472b0ee8a@mail.gmail.com>
 <1270656067-688-1-git-send-email-rctay89@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 18:01:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzXh7-0003dk-B1
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 18:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686Ab0DGQB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 12:01:29 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:43812 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0DGQB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 12:01:28 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so971657bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0Ay9RtSFOcURX60E0L5szX8/R7eiNVimu8W/Rc7H0CE=;
        b=nI8ofZ5fayNeuQjOujOL42FrpdPEritZ7t8QZwowKCZKk6Icefr5YQFfPLMDjEOpJv
         z9Vv+Kbk2kz8+5iKeYAMCALCZWh6ovz8glIeYjP3l1oMCbaxdi2OClJaUjaB7w4qobUh
         2piB1H/yC/9HxTWATv3jVOOdJXHR9s9Heel+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JtXM93rZoAMevzOEE/s7/wUJtJy0Ig/FFtrIDjtmdIm7UHDZ+0OjdyQfCVOh5nGsl1
         kkVoVT70wO9kHtFu1PXG+3UsumjrhYSHX0rdo69ElRTHZgQP6RkHCF1VS78N0blHgpEk
         K8adILgIX55DekGNqN+W6cNEsGkKd0Uc/oOyg=
Received: by 10.204.174.201 with SMTP id u9mr538655bkz.68.1270656087748;
        Wed, 07 Apr 2010 09:01:27 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id 14sm7039360bwz.6.2010.04.07.09.01.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 09:01:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1270656067-688-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144243>

---
 remote-curl.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

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
-- 
1.6.6.1368.g82eeb
