From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] read-cache: fix memleak
Date: Mon, 23 Mar 2015 10:57:11 -0700
Message-ID: <1427133432-26703-1-git-send-email-sbeller@google.com>
References: <CAGZ79kY=b3=ppmB+eJOAgcUec7hq+ycJiCvBzkTc7U78Mgog_g@mail.gmail.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 23 18:57:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya6bQ-0005uH-87
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 18:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbbCWR5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 13:57:18 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35986 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbbCWR5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 13:57:15 -0400
Received: by igbud6 with SMTP id ud6so49754646igb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 10:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vLtFLiGCcAuLXPHu0KH00Hqcn1f+yn7dtXlBganiqR8=;
        b=Uh0DuoolV/tFAfCeaMOP1eu17HAVdQokUTUFBpP9GdFoP49HtTWiGhQ0YeZzWoxcG3
         DDeiZZdrQEBnrcWcCSW231s+dpFVpB7+sEF/qeOlumXuuAoctY6FsyREbRTktSy1vxy+
         DCtclclsYDSSvEaH891/v39lpWxRUJ4ifCoRgsxjqZQbse7LFnW85v+/JMDWrS5ltFr7
         wbnhJscGnx97QtYo2t87TUKYQZJc7chGLkN70vgil2LaR23nklODjMQo8ceW26rtDZkZ
         EKei1h7x4Ct2cpiTD3Ve1qaJa5DZcJhdZVgY/JSDLGjX+K7lRnNlIE5huZ1rW/rIpBWV
         1sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vLtFLiGCcAuLXPHu0KH00Hqcn1f+yn7dtXlBganiqR8=;
        b=gsHg9Jc0Hwxny7WoxydODyot/4TcUXm/7nDQHhytiefuXZGMRNEQcPhwKEiulNjpTf
         NUgk8rAeQrKQXwG0o8n+f6yTcUoq4ntqszfwd4yGW0dEoI0T/Y9ulVkV4M7YECai90Ed
         jU5MmgiHV9dr6zF7E2hnG+LgzKPGoe/LrxgUpVJDETcW3Bhd+pHOiBLduWeVKBLP7EOV
         UADLYa5li6CZOS5qW6K156vZ4LJGREhGbByqdeRnGIlie0u5X/s+ZwfCojV7Sd2sK634
         nbi6fyWlIRk6j5VApQkEXUaCX007Mv/gEyX4ZKzyQOQpatUw77nOJcEe+n/7SxzNIf8D
         /tjQ==
X-Gm-Message-State: ALoCoQm94uCLBaVIX5tEAMZ23vcFCQp2WBSaAiJ7L3e/Q75yniDnnx3pBIYI5FJkJfm67nhHsugM
X-Received: by 10.42.11.15 with SMTP id s15mr11425504ics.93.1427133434607;
        Mon, 23 Mar 2015 10:57:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4d5:daa7:294c:bc0b])
        by mx.google.com with ESMTPSA id a71sm1016241ioe.41.2015.03.23.10.57.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Mar 2015 10:57:14 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <CAGZ79kY=b3=ppmB+eJOAgcUec7hq+ycJiCvBzkTc7U78Mgog_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266152>

`ce` is allocated in make_cache_entry and should be freed if it is not
used any more. refresh_cache_entry as a wrapper around refresh_cache_ent
will either return `ce` or a new updated cache entry which is allocated
to new memory. In that case we need to free `ce` ourselfs.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 read-cache.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 60abec6..a102565 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -746,12 +746,9 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	ce->ce_mode = create_ce_mode(mode);
 
 	ret = refresh_cache_entry(ce, refresh_options);
-	if (!ret) {
+	if (ret != ce)
 		free(ce);
-		return NULL;
-	} else {
-		return ret;
-	}
+	return ret;
 }
 
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
-- 
2.3.0.81.gc37f363
