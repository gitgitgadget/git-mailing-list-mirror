From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/5] refs.c: return error instead of dying when locking fails during transaction
Date: Fri, 25 Jul 2014 09:58:38 -0700
Message-ID: <1406307521-10339-3-git-send-email-sahlberg@google.com>
References: <1406307521-10339-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 18:59:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAipo-0005kX-0x
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 18:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934693AbaGYQ7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 12:59:00 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:37040 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934614AbaGYQ6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 12:58:49 -0400
Received: by mail-qg0-f74.google.com with SMTP id z60so256071qgd.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8JgEHDfzuFfLu/HG8Ya6X7qsanAQd039zrq+5zMbLJ8=;
        b=AvoYIE0lxYk5/ocudMrZnHCrTdx+dmCOMlzzz7Q5MXO+p81uFTNmnmgaqSyvP3RpK9
         cpB926e0Up2u/veEdaxhLKUDXIo90VQpni9OxN0A/aYRsI/Qi+R1kL9HXi9OBG9KwgYS
         JJkQmJYXolHdlzvXUUklW4AmToikrXrmoOgRS6qY7NAzNkaPuhphxowsVEsPVnysW0jr
         R9/odG/s4bk2T7c++MIE7L4rzUrn1liVRJPTOPaeYn+cu4SvfXvEsziHn7C7vKjV8sZE
         9rkpP6fTGnaxYSXCvBdknOcXRcWecOS3KaQ5Iw1bp8XDkZAhkvfei4+Hz59fuTZUDpc/
         Zivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8JgEHDfzuFfLu/HG8Ya6X7qsanAQd039zrq+5zMbLJ8=;
        b=QMcbMtkFsjV64T7wxa9CCAXzTE5+YFELPfpkDDjdhEo2tZ8npKtcwtqGn98hhWmB3S
         U7Qk+x77xrN/hdffLHzpXif8ev3CXA0I88DDmmNkTda4guhrIoPHJqPoYDCOxXKiXVhQ
         b+cUKRO9+VRlLtu4xqga/GbZWko06d+9+I77mfN+MyW2uAI1LE3kKCEm4e43Q9OFiU4B
         OKT4m4CQJYshDMZGqAXdjTQ6AN2xnQmHcXqE56fhzBJIbsWqyB73q9bWOfRXlN19HeI8
         wn3seKUbV+WI+TDw7wDD5fy4oNRGf/HpFELUU3OFa2X/eH4VJKaBixibSW5K9lrvHVCb
         odfA==
X-Gm-Message-State: ALoCoQk9XAXzt9U7C54ZWUXGmEAXAiTC8HkSOJ3G0fFEdz+FGWFfCV5TMfDfAoiEzVIOLq3GkxyH
X-Received: by 10.236.69.138 with SMTP id n10mr6330113yhd.49.1406307528356;
        Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si1291273yhh.5.2014.07.25.09.58.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 39BA75A43EE;
	Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CE0F1E0CE0; Fri, 25 Jul 2014 09:58:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406307521-10339-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254235>

Change lock_ref_sha1_basic to return an error instead of dying when
we fail to lock a file during a transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 6c55032..2ea85a8 100644
--- a/refs.c
+++ b/refs.c
@@ -2214,7 +2214,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else
-			unable_to_lock_index_die(ref_file, errno);
+			goto error_return;
 	}
 	if (bad_ref)
 		return lock;
-- 
2.0.1.508.g763ab16
