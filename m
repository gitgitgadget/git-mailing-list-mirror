From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/4] refs.c: return error instead of dying when locking fails during transaction
Date: Thu,  5 Jun 2014 16:17:12 -0700
Message-ID: <1402010234-7628-3-git-send-email-sahlberg@google.com>
References: <1402010234-7628-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 07:49:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsn1g-0007HH-0d
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 07:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbaFFFtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 01:49:12 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:45103 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaFFFtL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 01:49:11 -0400
Received: by mail-vc0-f202.google.com with SMTP id lc6so464705vcb.5
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JzfE+gfNtwBzpz6Xp8WMUORMXsLzZs29nQdeToVqr/w=;
        b=JsE82TEWD6BIpvS3mVbWCoCQqKHXCz8hGVijts3XTMs2HR+/P1w3bZXHJF/Fl+W5ki
         Y2hxHx67/Jm3aSotuiMwGxyYcOl6gfWwUJzeubYAM0S27E1nGFGeON8PXk8sakXe+EmE
         svsLM4zFOvl7dyTqyrppiqYBJTGJXr5YXeorle9s0Hfdq3FylkAL1TCOxXjg74jAOlzX
         ynngsDmExNUhABlRLoelvvyB17RnBAnAXrLnlQTXmY+3NgV53yIMqRWeEF4qyEKKxOQp
         Qo6i7QV81LEZXRZbNCCd9NCIVx11nrhcS+y0esIM4V+yTZv1MdJHRI+PonVrU0EDzBxJ
         JOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JzfE+gfNtwBzpz6Xp8WMUORMXsLzZs29nQdeToVqr/w=;
        b=MJzBZm7ROKSY2PE1QNSzsNKK7YfI80oOQXFns9YDuikkuuO7/j7jvKftPPKIXGYmM2
         NcQW3//goskMxRUaoXBI2LM+DMMk14BlO82HCKwu/98MDha3e99kC5L1PV9cHhHZ78Ta
         77Xq2Tw/fqExD7eqH60nhW2qr6dlpLcSQGs9Ai3WeIRKGgy/kuhFUzmZU9cL2Lg3FvnK
         5y7+H1Y3EQd5lLs/L8a9ZO/CPeBCXxLwAGT91IBGuwiFKUKhuQpUpbyxEzuoiKW9ymxL
         TOaP69/ty+JQFZhVWk5QSo9cuVCHlHOak7t79kS4htWNrCOneLYpS4Q/nf8T9Bf2homj
         6/2Q==
X-Gm-Message-State: ALoCoQkny9WwoCbUWObQK9zsDMKSldmaq6lTE9azfDF/eVJvOkt7HFcFT/f3XuFBBjMP4W7LeRrt
X-Received: by 10.236.112.12 with SMTP id x12mr208317yhg.56.1402010238255;
        Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si667825yhl.7.2014.06.05.16.17.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 21DEE31C711;
	Thu,  5 Jun 2014 16:17:18 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BDD36E103B; Thu,  5 Jun 2014 16:17:17 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.583.g402232d
In-Reply-To: <1402010234-7628-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250890>

Change lock_ref_sha1_basic to return an error instead of dying when
we fail to lock a file during a transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e3a0383..ab0b629 100644
--- a/refs.c
+++ b/refs.c
@@ -2153,7 +2153,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else
-			unable_to_lock_index_die(ref_file, errno);
+			goto error_return;
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
2.0.0.583.g402232d
