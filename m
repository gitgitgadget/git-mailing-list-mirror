From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 7/7] send-pack.c: Die if the nonce is empty
Date: Wed,  1 Jul 2015 11:08:19 -0700
Message-ID: <1435774099-21260-8-git-send-email-dborowitz@google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 20:09:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAMS0-00050U-Qa
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbbGASJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:09:27 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34439 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbbGASIz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:08:55 -0400
Received: by iebmu5 with SMTP id mu5so40232782ieb.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3A75RLjPSrI0UHmsqXxAZvex+EMVRxSumcXV2h9n6JY=;
        b=idHhmZzZ+vR3+9Z8zka2Pj7mXUhdtDo1uOWvM/Ts7TNseVGELKR0/pMFlHznUAkM/a
         DMoTPvPgg6dqLsfO9pYQVt5pY1T6BhKGRrnGh1wOHCOPJ9aUtS6ei41w9XeSxPVwLhZb
         755ytWXYxu/8F+Rl2Svou+4pECPvNoKaQPq281LRAmgFhDkwa7TvJFhtQeg2KdMO6Ltx
         GvaSDlGlr8rdSu+NwDS75vjxCVhiAu0Qqujairuam6cNEJblHjNWALnU1ymQ/fSOXATw
         WbUOOa31B3aYb/AWCGd/03G9bSciYnmVlUAkcsShlfz9fuiJAumDGLMp9Dkgp0huMhpl
         xYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3A75RLjPSrI0UHmsqXxAZvex+EMVRxSumcXV2h9n6JY=;
        b=GhYCrm/cbKlfqFwNYt3mJ2jeAsLrYMIMmrOKskWGqkeuh2ozETrue3j50uZm9J03uz
         JzOGzckEgFWiK8Qjq/SaT7eVS9YUlwzKrYf3F2LIDleV5ejbHdItx2eTl7oNRgivQ4Ga
         0HUaeLVAlMssQ9bZg7nXJysNTXtf5eTu0boPKWmFpSSygTvgSTEEUU6RRGSCIjQCff0b
         vBCTaA6KOMHKjZNKSMdnvALj1p4BRb7R00smYIupj2SwuE/x3DzGvHfjHdelRZ0Z8OH/
         UewKVwZEyRIVv/rau4mCQTLAXO5/OWx4xbmSNAmaqp/oxrQ/jfj0gmKAa/vmvdRjymwk
         /Y8A==
X-Gm-Message-State: ALoCoQkiKIJn/Nl10+qDXzpls1h7FzRZAlvViRSEnQxFfdVvo7dFegB3c1Z3DG2zkAR1a4L6o2sa
X-Received: by 10.42.120.66 with SMTP id e2mr6060567icr.37.1435774133517;
        Wed, 01 Jul 2015 11:08:53 -0700 (PDT)
Received: from serval.mtv.corp.google.com ([172.27.69.27])
        by smtp.gmail.com with ESMTPSA id k2sm2782076ige.1.2015.07.01.11.08.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 11:08:52 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.573.g4eafbef
In-Reply-To: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273172>

pack-protocol.txt does not list the nonce as optional. Fortunately, it
should be impossible to not have a nonce by this point in the code, as
the caller should have died on line 380 prior to generating a push
certificate with an empty nonce.

Nonetheless, having this explicit error handling in the code reduces
confusion for implementors trying to understand the signed push
protocol by looking at the reference implementation.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 send-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index 2a64fec..77e2131 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -254,6 +254,8 @@ static int generate_push_cert(struct strbuf *req_buf,
 	}
 	if (push_cert_nonce[0])
 		strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
+	else
+		die(_("server did not provide a nonce"));
 	strbuf_addstr(&cert, "\n");
 
 	for (ref = remote_refs; ref; ref = ref->next) {
-- 
2.4.3.573.g4eafbef
