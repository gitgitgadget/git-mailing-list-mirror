From: szager@google.com
Subject: Fix potential hang in https handshake (v3)
Date: Fri, 19 Oct 2012 14:04:20 -0700
Message-ID: <5081c054.eD2hEWR8K8zW5vdM%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, gitster@pobox.com, sop@google.com, daniel@haxx.se
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 23:04:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPJkA-0001HU-Bp
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 23:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883Ab2JSVEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 17:04:23 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:42637 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab2JSVEW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 17:04:22 -0400
Received: by mail-vc0-f202.google.com with SMTP id fy27so103399vcb.1
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=M7fDtaStcbAmrUdC1HXMouVT212SVg3FkzS7XpiXGxk=;
        b=Bw8olWD7AFVp9E2Xg+XB8+A+mSqQqZzT3vBQMygFFAPzdk27N8219c7y5NEzQ3APsN
         YTiJiYBujZ3lG+iMNTPyROLFIIDM/28H/N+EnU0AquV5DylnNVzbX04q/6C0tVqzI7PT
         Dr6pDDBb5DLb33OOq4603RYPrANm7YxZZWraacTTI6MCcZcc7jkx0SP/gZHF/2a5SQoD
         7gG6B0db6AtZUYcIqinIMb/Jm+DB6C/joOVhKplnekz0jyjbh0bIo8aLYTSYDXm32qBu
         FnuenhxFu8ebQG3e7A704zMvZt9Q+GWiC2MclNugwDqlTx8VLtykxSpp74Z4H9sydjm/
         u3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=M7fDtaStcbAmrUdC1HXMouVT212SVg3FkzS7XpiXGxk=;
        b=gYkFxdeOlm057mCNSWB5QNzJKzJ2fVowYmmOjj/389VbnGoQOW20V8gCR4r3fonhLU
         nXWW3uXdFMbCcEBpx4saULDIDsLfOtPf/9qh2GYS6efr+axHMCjq6SHRLHnBjwjoJjmC
         G19BWc9l75IsM7sYOqXK/2mF+ZvDvUKzwXKvCZba4RgzT44zHZSl+FoDCNVCZ7IUhFHL
         uON367pFHIVcb2SM+K9B2qTQSHru9QizzZKaKkTMp5ftqmr6iMMvUBhXv08p7dk6YzNY
         1l6MLYLEoKJo8csT7CeLb4EFp6QmqTZ2XBSDYSoFNrQueHt8mh/AsEbKCfOtM8lkQWvG
         /Jug==
Received: by 10.236.153.6 with SMTP id e6mr1496755yhk.20.1350680661544;
        Fri, 19 Oct 2012 14:04:21 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id o6si241805yhn.7.2012.10.19.14.04.21
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 19 Oct 2012 14:04:21 -0700 (PDT)
Received: from wince.sfo.corp.google.com (wince.sfo.corp.google.com [172.31.53.43])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 6B0F61E0043;
	Fri, 19 Oct 2012 14:04:21 -0700 (PDT)
Received: by wince.sfo.corp.google.com (Postfix, from userid 138314)
	id AD4344052F; Fri, 19 Oct 2012 14:04:20 -0700 (PDT)
User-Agent: Heirloom mailx 12.5 6/20/10
X-Gm-Message-State: ALoCoQm3Omwb/QBEKSIM0W9iFWskoaYYHGmNiX5Wd7lpHaprop5xm96QGNYy03BGvvMda+5QPQwuJ+NLFnq1Q95LOLsHceEReIW0sNiutEJWAkw4SqrQ60Wrd2dW//0L96MEqUVA4JvkNfjIS+Df/1x/XAGOBJocnY/IgGbm0LBXZexq8zIKYUMPLIQv9c+pIqAtrgkR2Shq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208066>

>From 32e06128dbc97ceb0d060c88ec8db204fa51be5c Mon Sep 17 00:00:00 2001
From: Stefan Zager <szager@google.com>
Date: Thu, 18 Oct 2012 16:23:53 -0700
Subject: [PATCH] Fix potential hang in https handshake.

It has been observed that curl_multi_timeout may return a very long
timeout value (e.g., 294 seconds and some usec) just before
curl_multi_fdset returns no file descriptors for reading.  The
upshot is that select() will hang for a long time -- long enough for
an https handshake to be dropped.  The observed behavior is that
the git command will hang at the terminal and never transfer any
data.

This patch is a workaround for a probable bug in libcurl.  The bug
only seems to manifest around a very specific set of circumstances:

- curl version (from curl/curlver.h):

 #define LIBCURL_VERSION_NUM 0x071307

- git-remote-https running on an ubuntu-lucid VM.
- Connecting through squid proxy running on another VM.

Interestingly, the problem doesn't manifest if a host connects
through squid proxy running on localhost; only if the proxy is on
a separate VM (not sure if the squid host needs to be on a separate
physical machine).  That would seem to suggest that this issue
is timing-sensitive.

This patch is more or less in line with a recommendation in the
curl docs about how to behave when curl_multi_fdset doesn't return
and file descriptors:

http://curl.haxx.se/libcurl/c/curl_multi_fdset.html

Signed-off-by: Stefan Zager <szager@google.com>
---
 http.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index df9bb71..51eef02 100644
--- a/http.c
+++ b/http.c
@@ -631,6 +631,17 @@ void run_active_slot(struct active_request_slot *slot)
 			FD_ZERO(&excfds);
 			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
 
+			/* It can happen that curl_multi_timeout returns a pathologically
+			 * long timeout when curl_multi_fdset returns no file descriptors
+			 * to read.  See commit message for more details.
+			 */
+			if (max_fd < 0 &&
+			    select_timeout.tv_sec > 0 ||
+			    select_timeout.tv_usec > 50000) {
+				select_timeout.tv_sec  = 0;
+				select_timeout.tv_usec = 50000;
+			}
+
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
-- 
1.7.7.3
