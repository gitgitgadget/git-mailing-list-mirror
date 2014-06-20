From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Fri, 20 Jun 2014 07:43:24 -0700
Message-ID: <1403275409-28173-44-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:44:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy03N-0001ou-Sz
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600AbaFTOoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:44:12 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:60200 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbaFTOnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:35 -0400
Received: by mail-ig0-f202.google.com with SMTP id c1so38746igq.1
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PTLy00F+wDD/gdWFCVydKjcyW8HU2sis55AGt8tP3xY=;
        b=D9K5P8opt18KYKRDPGV3mxcn8+AjeXl5lEj2PfqQVbDI7K6LqV7CDZnoiRmHIrsthi
         zRttkcZ1yfddSkLAiyo7l6L90yOWa5EZcVNYXQrPxxvJismoehGw7SIXSqfMUszE4/AI
         kQmazX0kXBGsfrN8145wnZCOl/ehJD4UaQbEdI1HXqxZPSP3FEqj+edC/pSiafCLpRKn
         SG7uzub9BkX+TXOF3Q4INdskDIizlHxMpHtNkyG3FL4IOjEFT8f7lGz/6jRTDxt0L5rD
         z0uWxbSl/E2JV3kDIWIw/2TLCsPdDN1/5o7+vL20fF2tC/8IWsDFv+TnhHdPXeOSOarJ
         x5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PTLy00F+wDD/gdWFCVydKjcyW8HU2sis55AGt8tP3xY=;
        b=Glg83YejXQ/HRrv8PrjwA3TfS1Rso8OP9JoTX7ojyMTQEAmaiiHivAPGRHMZOllF89
         2WpcK+TyJQsNxMnmfr30vTQ6/rOmtAco0IylD/cnmLTNisOmvskdU30cr/EpMcyNO/i8
         06r8wB/01bei2BOR+kkl6u0sKIAnY9qwHE7v3xfnOlvLneQ9xJtHYR96gcla01Q/ox61
         wPYoMcuhQ+ihIFwDCCSrIA3HM2z2ITsJRkT9QUxvISb+UfOCmz+r9Dn4Lpb446LVqaQ0
         yyOidV/X82CwWzNi2hNNK2+UwGDPJ8L7Q3KPesGMrvX/2Ybq47t0OpsYNnl6RmnhLOgP
         T77A==
X-Gm-Message-State: ALoCoQl8DGPzg1q6/xB1GlLb5hqr9yDcX+P+XDtwxFH/gcRsYBWQ/uQEOlxB4B/6rq/+mgOuK5AE
X-Received: by 10.182.73.200 with SMTP id n8mr1582217obv.33.1403275413875;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si664713yhb.3.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B6CB35A44A6;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 92F69E0769; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252243>

Move the check for check_refname_format from lock_any_ref_for_update
to lock_ref_sha1_basic. At some later stage we will get rid of
lock_any_ref_for_update completely.

If lock_ref_sha1_basic fails the check_refname_format test, set errno to
EINVAL before returning NULL. This to guarantee that we will not return an
error without updating errno.

This leaves lock_any_ref_for_updates as a no-op wrapper which could be removed.
But this wrapper is also called from an external caller and we will soon
make changes to the signature to lock_ref_sha1_basic that we do not want to
expose to that caller.

This changes semantics for lock_ref_sha1_basic slightly. With this change
it is no longer possible to open a ref that has a badly name which breaks
any codepaths that tries to open and repair badly named refs. The normal refs
API should not allow neither creating nor accessing refs with invalid names.
If we need such recovery code we could add it as an option to git fsck and have
git fsck be the only sanctioned way of bypassing the normal API and checks.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 389a55f..bccf8c3 100644
--- a/refs.c
+++ b/refs.c
@@ -2088,6 +2088,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
+		return NULL;
+	}
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2179,8 +2184,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.0.0.420.g181e020.dirty
