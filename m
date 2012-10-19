From: szager@google.com
Subject: [PATCH] Fix potential hang in https handshake.
Date: Fri, 19 Oct 2012 14:39:34 -0700
Message-ID: <5081c896.cMdU6VySSwFm0uOa%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: daniel@haxx.se, sop@google.com, gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 23:39:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPKIG-0001lK-5R
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 23:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015Ab2JSVjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 17:39:37 -0400
Received: from mail-ye0-f202.google.com ([209.85.213.202]:38538 "EHLO
	mail-ye0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149Ab2JSVjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 17:39:36 -0400
Received: by mail-ye0-f202.google.com with SMTP id r11so51801yen.1
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=N8eNO6HIGPtQf7JLbWVupdh1TzKU0Aomkryu34Q3oJk=;
        b=hVoJtEyGnTG9LkxNyhrw/X3LWrXq2tcWFqaSzHZXaC83MuerhDdYmcB4gLcF4bo01K
         P1MvWwWegaessBYnZXPN+SBnEMtz3MeBb5KPiCkqJraUiObnDXg270OLJHZWQcKwxend
         wfo5am9JDT7ZyIVOypZi1smmKlGePZaAjWJCrLPC/rgvXQIVhpkGep3ffcLocog2UBZ/
         FV3161JDbC4n+LmPe8DpuzhqhS/kyUVH6xi+q4xKH/rQGneIKAAK681D7+CxkDcLqjig
         U6zGatZPXyH9ULd60y+WaZvxOuHIfCDKcCp6HbT64x6DjzMZ4/PKsIIrYbuliCP+2xaN
         mnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=N8eNO6HIGPtQf7JLbWVupdh1TzKU0Aomkryu34Q3oJk=;
        b=EXm4g3V7Dde4f2kEz1f9xej/fcb2DhRKK7UOHj0yLim+Vq/ksxHSOVsl9/khR3ww0Z
         kjLMwM4nl5WfYiti6VebXksRB0zLspDGBqmH3aWNvQ+4MTQyv5Xb6dNO4B98KOhwp7du
         mFOJNj96RtyLWE/64ns0HY2HV4hksirODLgp8cbtwjmCqWiILtybtkHZT5eX9CnJycPh
         9d144pudIGsGhrbYZD3rL3C/mEFoku7itcTl8bc7UwBIZnxDde6NOtFXF7aNBOhEfmzx
         1Fkj42s1ZVpr2TfPqAdmOL+XUAeQ6xW9ZWg1PdVAagbZqG+L5g2IXqgnXPVVKZNPEiW8
         wZng==
Received: by 10.236.102.231 with SMTP id d67mr1479949yhg.6.1350682775616;
        Fri, 19 Oct 2012 14:39:35 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id g7si132668anp.1.2012.10.19.14.39.35
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 19 Oct 2012 14:39:35 -0700 (PDT)
Received: from wince.sfo.corp.google.com (wince.sfo.corp.google.com [172.31.53.43])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 809EE1E0043;
	Fri, 19 Oct 2012 14:39:35 -0700 (PDT)
Received: by wince.sfo.corp.google.com (Postfix, from userid 138314)
	id E14514059E; Fri, 19 Oct 2012 14:39:34 -0700 (PDT)
User-Agent: Heirloom mailx 12.5 6/20/10
X-Gm-Message-State: ALoCoQndIXtQv50qHjYhHyMYwRmJzvscQ15efmXmutAcugW33hDNaM5YzeiABzGm4+Iiab8gtGwfC87oaTLBevSFubQnfsdQvpPDrox9OK9lDOjCKXGX5E+OQ4DLB41y9tJCM9FeiI1cc1F84CacfeLzHDgKav4PF5/6kCDnPkciqzUApr/DGlsf9V/7EaZUjhEKsAagY9W4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208069>

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
 http.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index df9bb71..b7e7ab4 100644
--- a/http.c
+++ b/http.c
@@ -631,6 +631,18 @@ void run_active_slot(struct active_request_slot *slot)
 			FD_ZERO(&excfds);
 			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
 
+			/*
+			 * It can happen that curl_multi_timeout returns a pathologically
+			 * long timeout when curl_multi_fdset returns no file descriptors
+			 * to read.  See commit message for more details.
+			 */
+			if (max_fd < 0 &&
+			    (select_timeout.tv_sec > 0 ||
+                             select_timeout.tv_usec > 50000)) {
+                        	select_timeout.tv_sec  = 0;
+                                select_timeout.tv_usec = 50000;
+			}
+
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
-- 
1.7.7.3
