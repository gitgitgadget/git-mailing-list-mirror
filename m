From: szager@google.com
Subject: Fix potential hang in https handshake.
Date: Thu, 18 Oct 2012 14:35:26 -0700
Message-ID: <5080761e.IEDySUuQzlCwL6fM%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, sop@google.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 23:35:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOxkh-0004NS-Pt
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 23:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154Ab2JRVf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 17:35:29 -0400
Received: from mail-vb0-f74.google.com ([209.85.212.74]:37887 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755799Ab2JRVf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 17:35:28 -0400
Received: by mail-vb0-f74.google.com with SMTP id s24so1045802vbi.1
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=XeCJA0w51DUthvcdr8qaYQaR85TeTd9VjCdhuHXif9Y=;
        b=lIb+suv4UWB/Y0lpfWTme7WcOzxlZuL39Gz3uV1yQJ/xP6VFefG6xDFH/4wc8CdQ5N
         zRY/RVU3ZA3EwzxgOVFZvnef93NSVk12dwOALcvYWEwBIgG20dWDMt1vZXC4FbB9fn4o
         kyM2ZfI6puvFA4okbQWBASl074QQ6LFNQeYg0mm1ZE4UkK03zxVCgFvsLy5sHIA1TovD
         vUbi49ns5KVK6C6CSVPAOGmgEUfvxA1ZnNjcreiM67p48sjcJG2QIZkxH4C2RT+YR8Dq
         K8bPA8KTnSrugCv8V385WeY7WesFy9a5LYEYiqGFs+GM+3mawJdlusrzZkiwJFSYTmFF
         Rb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=XeCJA0w51DUthvcdr8qaYQaR85TeTd9VjCdhuHXif9Y=;
        b=RgLtse+lUaJinXPczxespRNz/+KW9Uf+7zeFIpmH5Dh5g1dS8qu1uxKHIzAzkPPIrA
         vMGazDvDggn7Lb4tjPrT8KcuPu/6A/rqXJ56UHyptcv6+FhlcDBno8APXA6ETAqcM5wC
         FmcsFXLhytDJezhKZF7Wx0IDhKElVxrrYf2Qt3AgtKMLTxdyhFPeUK+U+R3bPMobno1V
         UPNa/6HtUhEdqb+0lzt4TuaCvkXSL9l3ZZn8cSMWcB+Wb2jYn/zYHsucs2zSWHt02rwb
         6vI6nRpbIF1ohzYEgvElsrzBEGwjIeWvnctuoFNVKUy5oTQsX6EbFPRAgmPgmFWXJgKw
         HWSw==
Received: by 10.236.181.234 with SMTP id l70mr17422770yhm.39.1350596127103;
        Thu, 18 Oct 2012 14:35:27 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id g7si1157267anp.1.2012.10.18.14.35.27
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 18 Oct 2012 14:35:27 -0700 (PDT)
Received: from wince.sfo.corp.google.com (wince.sfo.corp.google.com [172.31.53.43])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 034E61E0043;
	Thu, 18 Oct 2012 14:35:27 -0700 (PDT)
Received: by wince.sfo.corp.google.com (Postfix, from userid 138314)
	id 3831F40EE3; Thu, 18 Oct 2012 14:35:26 -0700 (PDT)
User-Agent: Heirloom mailx 12.5 6/20/10
X-Gm-Message-State: ALoCoQnRgISaOh/UAsOo/21y7ujZ3OEDsdW+5ZOsJs5khXQkFEP2UL+D9FGPlIn3ZozEUQ3Mx5uVi08YgvYemcbIY77jkJHeXRtgMy7fVtzOrv1unYrl6avWkggvxnhuTG/fGxkxu1+mPW3Y388q7xL6EvOgj6cLCsZRvLzQimtC36fgztYQoLC1Z4ou6AHezRpCBIuCfJMj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208023>

>From 700b8075c578941c8f951711825c390ac68b190f Mon Sep 17 00:00:00 2001
From: Stefan Zager <szager@google.com>
Date: Thu, 18 Oct 2012 14:03:59 -0700
Subject: [PATCH] Fix potential hang in https handshake.

It will sometimes happen that curl_multi_fdset() doesn't
return any file descriptors.  In that case, it's recommended
that the application sleep for a short time before running
curl_multi_perform() again.

http://curl.haxx.se/libcurl/c/curl_multi_fdset.html

Signed-off-by: Stefan Zager <szager@google.com>
---
 http.c |   40 ++++++++++++++++++++++++++--------------
 1 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/http.c b/http.c
index df9bb71..a6f66c0 100644
--- a/http.c
+++ b/http.c
@@ -602,35 +602,47 @@ void run_active_slot(struct active_request_slot *slot)
 	int max_fd;
 	struct timeval select_timeout;
 	int finished = 0;
+	long curl_timeout;
 
 	slot->finished = &finished;
 	while (!finished) {
 		step_active_slots();
 
 		if (slot->in_use) {
+			max_fd = -1;
+			FD_ZERO(&readfds);
+			FD_ZERO(&writefds);
+			FD_ZERO(&excfds);
+			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
+
 #if LIBCURL_VERSION_NUM >= 0x070f04
-			long curl_timeout;
-			curl_multi_timeout(curlm, &curl_timeout);
-			if (curl_timeout == 0) {
-				continue;
-			} else if (curl_timeout == -1) {
+			/* It will sometimes happen that curl_multi_fdset() doesn't
+			   return any file descriptors.  In that case, it's recommended
+			   that the application sleep for a short time before running
+			   curl_multi_perform() again.
+
+			   http://curl.haxx.se/libcurl/c/curl_multi_fdset.html
+			*/
+			if (max_fd == -1) {
 				select_timeout.tv_sec  = 0;
 				select_timeout.tv_usec = 50000;
 			} else {
-				select_timeout.tv_sec  =  curl_timeout / 1000;
-				select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
+				curl_timeout = 0;
+				curl_multi_timeout(curlm, &curl_timeout);
+				if (curl_timeout == 0) {
+					continue;
+				} else if (curl_timeout == -1) {
+					select_timeout.tv_sec  = 0;
+					select_timeout.tv_usec = 50000;
+				} else {
+					select_timeout.tv_sec  =  curl_timeout / 1000;
+					select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
+				}
 			}
 #else
 			select_timeout.tv_sec  = 0;
 			select_timeout.tv_usec = 50000;
 #endif
-
-			max_fd = -1;
-			FD_ZERO(&readfds);
-			FD_ZERO(&writefds);
-			FD_ZERO(&excfds);
-			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
-
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
-- 
1.7.7.3
