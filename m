From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/15] read-cache: fix memleak
Date: Fri, 20 Mar 2015 17:27:58 -0700
Message-ID: <1426897692-18322-2-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7Hj-00028j-IH
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbbCUA2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:21 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34928 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbbCUA2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:19 -0400
Received: by ieclw3 with SMTP id lw3so1798286iec.2
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XjUkxYyO1AmOneLsFfsu+xWlHd4kC1MXo97C/wBks44=;
        b=oFrB8H94yfKRftpiFASPxQapuuquWKSwUL31Yi93BMQQ76NXauh+wj1+Tj2pX7lQH/
         h+G5/GfCug/5LvHGxd4FN5150od+OT0SrGXNBq+Q2ZOnNbBVa7F0YDBpcRO6IOaFjhAc
         NqN7JsXi7FqTB37+q50UCmrEQMBBd9rEQ7wrBBVTF0y1b057UrmcQTFbjUuVdfqfUiH+
         wxfxvQ0wEjnyA46HblrpPYig0qjHyRzHcQxki5H4zltHYi5B9/0cmPSpvGRnkz7i5bxy
         8vNjrAlGk1OCU4FDuqISF6kxMlnkyIekTzcF5mCAb4dwruYB1WpL6LQDvekHY6PGMwD5
         LodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XjUkxYyO1AmOneLsFfsu+xWlHd4kC1MXo97C/wBks44=;
        b=bAeGg7KrqTZbyC8Pi1dNOoGxBgqo43mWilKQkCEC2seP4MeNjATTf+gNLfgs2cRXgh
         LyTgyKsRDUeWhtCF/iFn8QcniFcyN4IumjL5Pc0NCPUIofBiMNNevgGdgnA+m0CoL2Xt
         6VT40910s0y7vN0nUSJ22JY8b47EI+AMaPKv61XGHYUKJiU+Tzkj+uMIp8TM/uYdoTA2
         Wbeg7vGnwXtFKZZ4h7EdAJ7Tq0mGY6RPrIFn+YbUouFxjnIkqkfxjUwSDD37PjRJJSTR
         CUPUsczegH6UoERnYefZcNbWKXPdsAz17yht1qPtCMyQTQlyNj4wlTQLOC6imiTiERZM
         Q2Vw==
X-Gm-Message-State: ALoCoQnGcuqpvOXjNIi81Tpjjl8ARGKzDerx7J2nyXycyzFwmZbIeLdEAX+kPoFC8jneAjUHgFUL
X-Received: by 10.50.79.193 with SMTP id l1mr458781igx.27.1426897698724;
        Fri, 20 Mar 2015 17:28:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id i20sm178475igh.16.2015.03.20.17.28.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:18 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265993>

`ce` is allocated in make_cache_entry and should be freed if it is not
used any more. refresh_cache_entry as a wrapper around refresh_cache_ent
will either return `ce` or a new updated cache entry which is allocated
to new memory. In that case we need to free `ce` ourselfs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 read-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 8d71860..f72ea9f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -747,6 +747,8 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 		free(ce);
 		return NULL;
 	} else {
+		if (ret != ce)
+			free(ce);
 		return ret;
 	}
 }
-- 
2.3.0.81.gc37f363
