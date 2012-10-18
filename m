From: szager@google.com
Subject: Fix potential hang in https handshake (v2).
Date: Thu, 18 Oct 2012 16:27:39 -0700
Message-ID: <5080906b.xT6aRtW1ELoWhZZw%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, sop@google.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 01:27:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOzVM-0004fv-9g
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 01:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837Ab2JRX1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 19:27:45 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:45046 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932781Ab2JRX1m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 19:27:42 -0400
Received: by mail-lb0-f202.google.com with SMTP id l12so559372lbo.1
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 16:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=m3S+hqUHT410IyL8tTOZLxx6tLYYHe7ABc+Otj+Aa80=;
        b=K5it1xINuQAFzfZ3OzMR1OJyBtQkwjN6ceUKgfk8TI1QrBnPNwprV7wOBFqYF+LJza
         iaVBteErCBWCiQDqur4Cf153c/o3+D7ypDuYOOYKIcG60ao1wTlsgS8Bv4nQZCmcsVf5
         vwuSj07zmObRoljJqB4ZnqMPMo1XkWLZ91rCNPJRG9GJoSXWaXVNWvXu85z/ucw19n2z
         nnbRZ8dcOYzDFyaua8cHl7wpiWpGTnx88ydcK6LUzafYMyj83OlSaGA44H7Nv1dl/GRk
         g0gkrLY03HSMGKeRyIsA+fnE2ybpeEyB+mVOhSq6cAhoKyGG0X0u5qwEZ/bfzhg/FmSr
         llBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=m3S+hqUHT410IyL8tTOZLxx6tLYYHe7ABc+Otj+Aa80=;
        b=GXPO77gtfjvCswk0wy+zrNTE+yguq3yOo34TilNB9RvnkY0BrCb3jW3Yj7NjyU1t/q
         DDhuATHhWxqt5RdMG25zCjjnkyAzzujS1/kfhSPCBwHJukd+GeFGrmKMVC0JUvddW1Ax
         rwSlRtisRZIZ8vv2b73ZRHZcVOtVekH9D7AIB9oLf3c4AfaT40AQ5GdoYE1KD8lZ/4XZ
         06FsQWVl5DDz2n2XY0QZEOamOz/454FwTrfeI4+ufOAY8VTiT7cS1EewFYDt7Lot85oH
         tvZqtHmopZZ/YvHdfBWhlMymuZu4B6aDNWGinRa/8EUXsbECO97h2FFgcySjglHtUFJV
         aKdw==
Received: by 10.180.84.234 with SMTP id c10mr2065254wiz.4.1350602860698;
        Thu, 18 Oct 2012 16:27:40 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id cx9si5657wib.0.2012.10.18.16.27.40
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 18 Oct 2012 16:27:40 -0700 (PDT)
Received: from wince.sfo.corp.google.com (wince.sfo.corp.google.com [172.31.53.43])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 4DEB220004E;
	Thu, 18 Oct 2012 16:27:40 -0700 (PDT)
Received: by wince.sfo.corp.google.com (Postfix, from userid 138314)
	id 5EE3940698; Thu, 18 Oct 2012 16:27:39 -0700 (PDT)
User-Agent: Heirloom mailx 12.5 6/20/10
X-Gm-Message-State: ALoCoQlvNwqByB6Ne9OqeLDu2fDT5lJtFTVabFQMtF53T59S4SCFkCtwwfKb8di3UYBCfWhO1nENJx6UnrEUM8cmuabCQTIRe3IhN0/Q7xu/HlC6Wp1ingYI6im5Z6zqJ0zU4u0eyKgGnAMuKY0aqCZOX2ozozIwMSuEuBC4MZiR3gJXyOtYWWqsDI9jSBUIXtMz60RzLWp3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208031>

>From aa77ab3dd5b98a5786ac158528f45355fc0ddbc3 Mon Sep 17 00:00:00 2001
From: Stefan Zager <szager@google.com>
Date: Thu, 18 Oct 2012 16:23:53 -0700
Subject: [PATCH] Fix potential hang in https handshake.

It will sometimes happen that curl_multi_fdset() doesn't
return any file descriptors.  In that case, it's recommended
that the application sleep for a short time before running
curl_multi_perform() again.

http://curl.haxx.se/libcurl/c/curl_multi_fdset.html

Signed-off-by: Stefan Zager <szager@google.com>
---
 http.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index df9bb71..e8aba7f 100644
--- a/http.c
+++ b/http.c
@@ -630,6 +630,10 @@ void run_active_slot(struct active_request_slot *slot)
 			FD_ZERO(&writefds);
 			FD_ZERO(&excfds);
 			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
+			if (max_fd < 0) {
+				select_timeout.tv_sec  = 0;
+				select_timeout.tv_usec = 50000;
+			}
 
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
-- 
1.7.7.3
