From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 37/42] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Wed, 14 May 2014 14:17:11 -0700
Message-ID: <1400102236-30082-38-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:18:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgZA-0003DG-6U
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbaENVRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:37 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:45806 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbaENVRc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:32 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so37077pbc.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9BWPjcXwK970sKUXENhfr0UYGayDllIdPjvuQqLcaYw=;
        b=dZbpM2H8cF6mU1mNdWXT0KrBRT7b6qmVqT4ZlF9g3R/AMIMTgS7MTI9aIP76ppEt6H
         4ZHpcCTDtx3qDi2Dngd3W510Fk0wJCsVDxmPuJbg5nh+T67k/BNt7FuwS9iIwr+f7O47
         JX5yZKwDCTSemnY4tgyOxsYiY11xHTf2gR5U4q4hEESku1AId0cawjk3TeGeEhf92Wng
         vncMgwbinZ6/HlemSBAN/DTRAOpTIcXp1amDtNbADkbpKJOgc+EAxtyE2A3LzhLNLLis
         WTUhLbzDgsnUxrTjV1NzEjYicL1Uwh8f/MjbDINKx3y9oFH1O4AOTbetvjjcTlaxna8C
         GAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9BWPjcXwK970sKUXENhfr0UYGayDllIdPjvuQqLcaYw=;
        b=T02PBnU6M0cRKAz+ggth6R9V1j/eMtDw6Qc1tLBYstwnhCk7Jb311eK4UeNjutygEL
         O/IVMUiyU8orxxGPaN6SKvroOQvgZQHtODi6kWyj9rtgDgb/WGIiNLIPPUOSqmlElAqQ
         GNd0T2OWHSKR3pWfUDYu6vLHQMN79A1x8BiOVFCfSIJyAvM9t6Co7L09PDfzPediwl5p
         Y9CcnWgFfqKNEP512qIOWdp5ctoDDeNgcmKHhli0ScXUembirwWOA3aVGgX9moHWP83U
         RTuQYoCn7iRi4JuDVtmz8YCCFRr/Kl9vy1wxcEbiR836fwfum8AlbhLsL9S9Mn/AkwQf
         g2iQ==
X-Gm-Message-State: ALoCoQmgMfeooh9tiWvQXtTLeFEEGa5SXANFugASUK9OL7j6pQ2F+2Bga86Ad3Yhz3P+Djs0sMQZ
X-Received: by 10.66.232.229 with SMTP id tr5mr3281188pac.16.1400102252452;
        Wed, 14 May 2014 14:17:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h18si146348yhj.0.2014.05.14.14.17.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 46BF631C1F8;
	Wed, 14 May 2014 14:17:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0AC04E0973; Wed, 14 May 2014 14:17:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248961>

Move the check for check_refname_format from lock_any_ref_for_update
to lock_ref_sha1_basic. At some later stage we will get rid of
lock_any_ref_for_update completely.

This leaves lock_any_ref_for_updates as a no-op wrapper which could be removed.
But this wrapper is also called from an external caller and we will soon
make changes to the signature to lock_ref_sha1_basic that we do not want to
expose to that caller.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 157a094..6556417 100644
--- a/refs.c
+++ b/refs.c
@@ -2044,6 +2044,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+		return NULL;
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2135,8 +2138,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.0.0.rc3.471.g2055d11.dirty
