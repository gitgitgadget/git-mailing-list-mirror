From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] http: honor no_http env variable to bypass proxy
Date: Mon, 29 Feb 2016 23:16:57 +0800
Message-ID: <5652e025323b60ccf5a59bcbdc7266d4f4e32fc4.1456758964.git.xin.jiang@huawei.com>
Cc: Git List <git@vger.kernel.org>, Jiang Xin <xin.jiang@huawei.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 16:17:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaPZV-0003xx-HI
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 16:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbcB2PRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 10:17:13 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35369 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbcB2PRM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 10:17:12 -0500
Received: by mail-qg0-f47.google.com with SMTP id y89so117450662qge.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 07:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Y520VAeHGH1hQe5+bAiJtiaV9GKaywR/90pGJUoHFlw=;
        b=r8dhhuUImokxwotimcZ9Hinq1yFchT+VP6XgeDaI1W1IHsMSbWqqKMcaGPhtnCrf2s
         WlUWXP42EtTwS618YwqbgmSWuwsnr/UKa5WLTIbAnbEp5H7qtl8nr0cHoQoKHUGCPBAI
         QLiOp9yQBoH16Z0tG5vQcUATgIX0rkhr1kZWNlQCxFfbpyAQujlPM4jYugxZpqzr+qwZ
         zaqv3+wYKUw6ToUPGtw6kOs2xkoczQL/ojMcrlNQSfI7T9AkexI37sZlyiTAQwxzb8aT
         k28bN3vSn0HF8mq//6BovAdbRS8axceGvBbINL/OBmihknIZ7KSaRfnko8BQt45S6QRQ
         y5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y520VAeHGH1hQe5+bAiJtiaV9GKaywR/90pGJUoHFlw=;
        b=WSernmVdGbGNcFpHAudFJgJ98q2/d/Rh/zjO46GOLEB4sXJ352qmy/yAFDLsWbmrzf
         Otru9nerytLPDWwHMOztHq16zibeDg+fvT0+axOi1NZivppu5cBnRQXKZ/yZ73t4RsMt
         /9A0pIf5U1+UMz+YbcUejwSTuKvlz+p7hVQbMbnLMHwQ07I1Gyp/xqezZUlPULnNFzQ1
         r2BefkgImb4X5RFdHGI7dOkTUew4bPKYMwNkQHrcxiB8nfuWvYXSMj4oKhzV2lQlyZsS
         z6w2VVsphNnCIx967A7ASeTM0ELJ8/ulx3hxeJkkOBK6eykpZC4NCqYRaqnWGmTPi45U
         mbEQ==
X-Gm-Message-State: AD7BkJLmDitvTbbISneTRpY33OUxULGQ+YICHx5KOgmr5GuHuCk5yWZQoaa58ru+Q2p0ew==
X-Received: by 10.140.98.71 with SMTP id n65mr4034281qge.22.1456759031686;
        Mon, 29 Feb 2016 07:17:11 -0800 (PST)
Received: from localhost.localdomain ([69.85.93.127])
        by smtp.googlemail.com with ESMTPSA id 78sm11113468qgt.1.2016.02.29.07.17.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 07:17:10 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g9eb3984.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287843>

From: Jiang Xin <xin.jiang@huawei.com>

Curl and its families honor several proxy related environment variables:

* http_proxy and https_proxy define proxy for http/https connections.
* no_proxy (a comma separated hosts) defines hosts bypass the proxy.

This command will bypass the bad-proxy and connect to the host directly:

    no_proxy=* https_proxy=http://bad-proxy/ \
    curl -sk https://google.com/

Before commit 372370f (http: use credential API to handle proxy auth...),
Environment variable "no_proxy" will take effect if the config variable
"http.proxy" is not set.  So the following comamnd won't fail if not
behind a firewall.

    no_proxy=* https_proxy=http://bad-proxy/ \
    git ls-remote https://github.com/git/git

But commit 372370f not only read git config variable "http.proxy", but
also read "http_proxy" and "https_proxy" environment variables, and set
the curl option using:

    curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);

This caused "no_proxy" environment variable not working any more.

Set extra curl option "CURLOPT_NOPROXY" will fix this issue.

Signed-off-by: Jiang Xin <xin.jiang@huawei.com>
---
 http.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/http.c b/http.c
index 1d5e3bb..69da445 100644
--- a/http.c
+++ b/http.c
@@ -70,6 +70,7 @@ static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
+static const char *curl_no_proxy;
 static const char *http_proxy_authmethod;
 static struct {
 	const char *name;
@@ -624,6 +625,11 @@ static CURL *get_curl_handle(void)
 		}
 
 		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
+#if LIBCURL_VERSION_NUM >= 0x071304
+		var_override(&curl_no_proxy, getenv("NO_PROXY"));
+		var_override(&curl_no_proxy, getenv("no_proxy"));
+		curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
+#endif
 	}
 	init_curl_proxy_auth(result);
 
-- 
2.8.0.rc0.1.g9eb3984.dirty
