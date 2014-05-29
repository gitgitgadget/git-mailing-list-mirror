From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 36/41] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Thu, 29 May 2014 09:07:52 -0700
Message-ID: <1401379676-9307-11-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:08:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2sa-0006kJ-1s
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569AbaE2QI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:27 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:39027 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496AbaE2QIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:08:00 -0400
Received: by mail-ie0-f201.google.com with SMTP id tp5so105540ieb.4
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C/EodbOBeBJFPuzg/Btoeb1WO9cnsSY1adHcNQHJtiw=;
        b=dh5IwHGsqNk3WGCZHRP3l+v4WY4+6dU8OqZEmlbah4Z5Q78YeoyghzjkvjL0u1JpcI
         llnAsQLbkk4dn4lF9Qs3e/T8kByGRHSXFKIvfVFJexPlRdC4WhWMMZFLLY72EI/uUFG4
         VjVJBbSF+Opo+QzRiucnr0HigT5rCz4i3w0e1/IUTm1wjZeyLlBDTfMoGib6n30Af29o
         PXagKY7SaSmbfR+ZSOk4CPY2qRhadB4DjgdhWHiZSr791wc9JLR088o1hgNPzYWdJeXO
         NECUR3ubA2V6KBoGmsOEMSuAfWWYMTS1oiIVmyNYRsQuW4hzdzpjs/l3sCURp45p86Ew
         DVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C/EodbOBeBJFPuzg/Btoeb1WO9cnsSY1adHcNQHJtiw=;
        b=UTcaif17sYD+vL+S8M1Vj1wA3okEtI4vs7kejCE+3NWj6xdrfnC+tWkgtEynhGXoPE
         2btqJpt7NuZf7AKwZc8/4PzXcYRekyisrMByZGrRqIIR0xoty7yWtECOCYhpD1gRQZfk
         6WS6oXS2LB2n2Mw5Z+tFgOfOc7+FyS0CAcVTjKUuYXX6AM2uioymeQ2pPFAHkInEoYVt
         t2j6TvRoLd85v8hg1uiXOdH61H2xnlaRbH8lP0GjH5vc4VT7aKKx3PTSTn9/e2oizPEs
         bxKvsDfjltu4fK/Z918d7nY4f/Zkjm/HmUvGe8QVWMbI86wAgR5mhp73ORLqk5luttQe
         ykRg==
X-Gm-Message-State: ALoCoQlqBulsCbJYq45xKXIym6P96PqBdiN7IeIlEFODgwnqpcRxck6DoyT/UsTPtWZRou0TF3JC
X-Received: by 10.43.103.136 with SMTP id di8mr2883077icc.14.1401379679805;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si81367yhk.4.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A117431C3FD;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5450BE06F0; Thu, 29 May 2014 09:07:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250380>

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
index 5680028..df00993 100644
--- a/refs.c
+++ b/refs.c
@@ -2043,6 +2043,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+		return NULL;
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2134,8 +2137,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.0.0.rc3.474.g3833130
