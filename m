From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/2] sequencer.c: check for lock failure and bail early in fast_forward_to
Date: Tue, 15 Apr 2014 16:46:47 -0700
Message-ID: <1397605608-12128-2-git-send-email-sahlberg@google.com>
References: <1397605608-12128-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 01:47:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaD4H-0001Uy-7A
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 01:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbaDOXqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 19:46:54 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:50298 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbaDOXqw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 19:46:52 -0400
Received: by mail-vc0-f201.google.com with SMTP id ik5so1517687vcb.2
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 16:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vZoskFuQd1vKG/IR+wDe38jYNg0nOUQg0MDmpX+dXW8=;
        b=QiQKopQf7ELiUCfQC7jkc249M5/VeVQdECLeNN/jbF3LYvPJYOpA9u4aNqaKb+vsEv
         vuMF72hIi7IY84Q/PeOfy6491fP1s7QW7w6HGWXSwJqce8jwD5PdAQQuLGyE6xgY3OA0
         ot9tGMd6t++o6njX2YeNkCjOpMOoXSFw3Zfyj0leJuah50PB7WLQp7vEjZh2IlbYIBIP
         Cgdq448+6TmdkhJroykAET7E4xweck9N6Fli8xsUiW0a7atg9Bx5h33y7/HmcgFVxbgF
         IrqK1o8sPw3QWNghx1djLomrlXvWFugk1PmY0k9DSP1Iq2ZHqi33W5O2t4CuvfOl+lQf
         U0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vZoskFuQd1vKG/IR+wDe38jYNg0nOUQg0MDmpX+dXW8=;
        b=XritqSV38DtxKqzQutazkMsfsXbxdog+1ehSCBKrBkk08ui2pxs17h7UbPpXigSvxl
         A0J28KMOd1pLZyCr8g6GSxAZeka7RYZnRonpDS/EZb2Xx/Ay6A3G4KQ2nAY5vegDJcNZ
         qNOHeKsPd/2HFG4QFPBZsiiKzFL0KaPfsvS7Hlf1QG4TMDRkY0Gg5S4YLp6GDwfQCbpu
         jtF6vy8qN+0Ly7lFcq0NXA09MWC2VorQOQeG8NUO6a5ZUzddueLXp6d34QIbCSt22BId
         kzpkjARwII1Xa8cUb/8yUGffjYmdasGuE+VrKeiSrsYHVrOGDDNqgPUm66rMSuAoF4K8
         twJQ==
X-Gm-Message-State: ALoCoQmhKH82HGJZz6TuFwo36w2y2dQ/v5Z63D+0J4/+2QFHa8C0JGCA2XM3ftwAPWMNH+mYK2534nTMiRXnLkdC7mUGeZ6ePekMsERyJBLb365vLm/fKtSQN6MGbBazubzuVHdMXeflt6Zoz3GvL1yb0lA7VDPe9cgob7VZMrT0SgvqdhIEBvdccyF16Be6LW37ESUWW22D
X-Received: by 10.224.95.9 with SMTP id b9mr680677qan.2.1397605611753;
        Tue, 15 Apr 2014 16:46:51 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r61si2916738yhf.1.2014.04.15.16.46.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Apr 2014 16:46:51 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 95B4C31C1D6;
	Tue, 15 Apr 2014 16:46:51 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5616EE099E; Tue, 15 Apr 2014 16:46:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.503.ge4c3920.dirty
In-Reply-To: <1397605608-12128-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246310>

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
 sequencer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index bde5f04..6aa3b50 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -281,8 +281,15 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 		exit(1); /* the callee should have complained already */
 	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
 					   0, NULL);
+	if (!ref_lock) {
+		ret = error(_("Failed to lock HEAD during fast_forward_to"));
+		goto leave;
+	}
+
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 	ret = write_ref_sha1(ref_lock, to, sb.buf);
+
+leave:
 	strbuf_release(&sb);
 	return ret;
 }
-- 
1.9.1.503.ge4c3920.dirty
