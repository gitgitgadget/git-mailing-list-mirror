From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 1/2] sequencer.c: check for lock failure and bail early in fast_forward_to
Date: Wed, 16 Apr 2014 11:56:52 -0700
Message-ID: <1397674613-4922-2-git-send-email-sahlberg@google.com>
References: <1397674613-4922-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 20:57:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaV16-0002gV-CW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 20:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813AbaDPS47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 14:56:59 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:40002 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390AbaDPS44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 14:56:56 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so865396obb.3
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ijJuEG+HaghB/t4aRLV0FoJ+uG82EgZspry562xhwY0=;
        b=ovSdKDmvgP+9Qh95sGALJuJjM5epH5S8XtHakZz88nO4Spc81BJNTk3J+Ex/dIKVDq
         uQ2eI9GHpJmYwrpPLUZRqR2awx06QM8+2eXeEUJzkfTuZs8YIlWh+lnyHRNdHp8G7SVq
         Cbo6KuTbn+GiAbShrHK0vlnUphHiEMJZJBsmyEOwSAKL6kA1nNjFfT5RbI+eRRda+/Ib
         HeJ9SgJNcgtLYkaCSDU/4NgDp1ew6Jgia2vtCdeCmWG48UK6icfUygMrYj0LBUr1Hqws
         K2T58jaZMmNCGLxsrmtl7wdB0qdCaa17UmxnjOCE6icnabI62lc6CaTtvqxmpms85bvP
         7YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ijJuEG+HaghB/t4aRLV0FoJ+uG82EgZspry562xhwY0=;
        b=ihDhCahdwBJJ9m7jm8dOdXtmAaQCje/R2GLC5Zr8BXcxwbV4bApJuVsSYKGcMkSMsO
         Vxvawbu4rr9pSbSsO0L6w+Itpfdj5mfgMN7scEoAy7zYBpYEddaCMSpRTfUoClSiXxe6
         5e2euVvQm/HmvNR7GsAFQnwdOPuGrfJa56gl2p2KEaNjaBuTLl4xfzx4daM9Krbcjl5o
         flsQ56eZ/s9YLiMuQdo2RJ1PWPYqcynFrb1IhlJr7PaUBS5n4j1kF3g0Q6rKFxdNcGTN
         WBQeBNZG50G4tXKFB1uukLo0bF/bFTz3V9HQjYA2WHqbJXDhb964LXdyVpPOTDZ8z8rE
         1buA==
X-Gm-Message-State: ALoCoQk0Xw8XN2hTyTCxWSJ6WAWUKLntBXLEu8i5ISd5xITgtR5LDzZaryvz8u5GyBMldgtoGZhgXDFyJcQgJWqcgzmGpdiZbuUSUJp51/fkQaJulAAhTUP6xXceQXnHVgO/Ggw3fQPR6CB5YZxAE6KLf5McrSiHyy/3OGTLteejKxTFvr563sdKg4yvWpaaUVx0gZmqWyBa
X-Received: by 10.50.73.132 with SMTP id l4mr3113350igv.5.1397674615964;
        Wed, 16 Apr 2014 11:56:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si3212917yhb.6.2014.04.16.11.56.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Apr 2014 11:56:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C85EE31C1E3;
	Wed, 16 Apr 2014 11:56:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 88C7CE0B22; Wed, 16 Apr 2014 11:56:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.504.g5a62d94
In-Reply-To: <1397674613-4922-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246374>

Change fast_forward_to() to check if locking the ref failed, print a nice
error message and bail out early.
The old code did not check if ref_lock was NULL and relied on the fact
that the write_ref_sha1() would safely detect this condition and set the
return variable ret to indicate an error.
While that is safe, it makes the code harder to read for two reasons:
* Inconsistency.  Almost all other places we do check the lock for NULL
  explicitely, so the naive reader is confused "why don't we check here".
* And relying on write_ref_sha1() to detect and return an error for when
  a previous lock_any_ref_for_update() feels obfuscated.

This change should not change any functionality or logic
aside from adding an extra error message when this condition is triggered.
(write_ref_sha1() returns an error silently for this condition)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index bde5f04..0a80c58 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -281,8 +281,12 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 		exit(1); /* the callee should have complained already */
 	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
 					   0, NULL);
+	if (!ref_lock)
+		return error(_("Failed to lock HEAD during fast_forward_to"));
+
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 	ret = write_ref_sha1(ref_lock, to, sb.buf);
+
 	strbuf_release(&sb);
 	return ret;
 }
-- 
1.9.1.504.g5a62d94
