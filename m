From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 14/31] refs.c: return error instead of dying when locking fails during transaction
Date: Wed, 14 May 2014 15:13:13 -0700
Message-ID: <1400105610-21194-15-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhRS-0007Kl-Hf
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbaENWOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:14 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:60868 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbaENWNh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:37 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so442015vcb.3
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m1sHvGko/bCN9Xpfa4/q29IYJGkAn8OX5QFOOnGjBxQ=;
        b=mYx/PgzQwPPCBPgBCONStoKcDsM6TKS2OzcvIwzKDL6Zb3+0f2EmQ/Tc0Uoh2Ev3IQ
         oKYU4zvmZ3WjU+oxNjkjM+5FK+pWp3L3m8+SzSCaDhlvPRpEyGajmyRVroJMXIcrl3AQ
         SV+T46hl3uVrys7Kg1Wkgd+QRhLozZgrVbOgDbOQDis0gAVqzqGRl6Eto6NZpqo6Dq1E
         E739DZq0CT8alEZxmHGt4M77by6kQXlNRByef0ndnmRpAPItE5oTkZsvBjH4ldeaZ9Ca
         Gr0Sed6MzwiRe+Q22siqFC+lODsT6iiYKZgiaxC+lIl1E9gD1AzmOrI3rroZb6FXtaKS
         pJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m1sHvGko/bCN9Xpfa4/q29IYJGkAn8OX5QFOOnGjBxQ=;
        b=PzM3og8r2MVSUmMWpANiFLsBPJl4VEzsZu+NTAuSrHOIZETkH2EWHk2oy++6a3zmz4
         tldv3tb5SixoG8i8Zes016lAKZGBbd7IRc82ThFSHDPE69NBiPaEH4aKxCZGzybuFqx9
         PXCEeicOH/dN12oJWa2anac9+bQ3bEMvTVJ1liVi4ZYmFF7xmu+OU5GwuqYeABM+Gyfv
         UPQJThq1NN+ODYo29FxADXCFke5jwPlVGcRg2MhzfnFtveQVtgR9Vx+i79CKl7FVwHds
         j18mFEpXIHu/AfqgZPpJnxAHxcqOVCx25bDNWZ9itcOL3y17wxxl7ppfxQ+fZnuZRD3F
         7Tww==
X-Gm-Message-State: ALoCoQmYxUxYrwx19BK19C/xaidpaZDe38PeWPuZUX3t61ox2BSNujNj89bfLdA73R+0xHPLaZbL
X-Received: by 10.236.149.115 with SMTP id w79mr2653038yhj.41.1400105617189;
        Wed, 14 May 2014 15:13:37 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r79si152498yhj.2.2014.05.14.15.13.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 11A655A41E5;
	Wed, 14 May 2014 15:13:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CA972E038E; Wed, 14 May 2014 15:13:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249022>

Change lock_ref_sha1_basic to return an error instead of dying when
we fail to lock a file during a transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 3249576..8212d77 100644
--- a/refs.c
+++ b/refs.c
@@ -2147,7 +2147,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else
-			unable_to_lock_index_die(ref_file, errno);
+			goto error_return;
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
2.0.0.rc3.506.g3739a35
