From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 35/40] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Fri,  6 Jun 2014 15:29:13 -0700
Message-ID: <1402093758-3162-36-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2eX-0002hT-9Q
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbaFFW36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:58 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:47152 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbaFFW3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:24 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so679458veb.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rmGhu44Hg6O8poClKbK2/bzF8ySMUdD8fR2ppV4klCw=;
        b=DmoRbX07lWcuoIYoCDgWEOnsb+46b13RAZKpCSYCRgqiD0aljeiVoUTxM32YHjpd9d
         GXRH8OApeFBaM6y3sYQvGFVxHcIPSgsAVOYO/nE4DS1Qlu4+uapb5V2O6G2FEu4AjLPm
         mRXdd61ddfr/ru+qPmcKxK8obxwwM5xc3/CrgUgDX48sZ/gBZ9KK2ndlWhYolA9CE5B1
         JmW5OgBE6xbXBLGcntLetvQWHwlNIFW5Ij/tuOk3KhNy5rrQnkQyAAtIFYfJ+Lb/MPiN
         OoUQrnHbwkPbe39XGEoVzZHG2+OdjH67/ZP20Wwg4/PXeJJB/ufaZV2x7vSOhGsYmxmN
         X/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rmGhu44Hg6O8poClKbK2/bzF8ySMUdD8fR2ppV4klCw=;
        b=HSeUAh2Bh1lLPM6uBeS57Dcjtheo3RgTOJIFLKYpS8Ugy5Xx6zSzSyML6YuuCfu+GP
         AzJAxVTGpwxI4Zck8krreoBH8I3oSQm26aoN14/mmNISn+f7Sae/H542aXMcu3h66BZK
         4IHlktbtJVMh1gVoXs0mWoY9gKzmkwExWiMw9LL8X5h6qEa+N4c2a9ted4ZIlg09rGk3
         5mRenifhIDqbTQ7pi3h8wpuS1tpy4F3rXzjsoQBK5OgTtwNmSyZlNgx9Q7jr4KU+oeW/
         Y5g+GmNWZtSTYisi08B+s+h0YCg5yVENXyMx7K3EJh8nT2/CCLzm/qddl6sNU6zqat2l
         74iA==
X-Gm-Message-State: ALoCoQnWafmjIowqzXcdoagwrrHeuYn/end/vFlZ5xitjSxhVrRjC9owoC8OWOU+e6j/4Ztzo0YB
X-Received: by 10.52.164.236 with SMTP id yt12mr4250489vdb.8.1402093763292;
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si751222vda.3.2014.06.06.15.29.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 12B1931C62A;
	Fri,  6 Jun 2014 15:29:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E1563E081F; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250991>

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
index 8848dbf..7da5357 100644
--- a/refs.c
+++ b/refs.c
@@ -2058,6 +2058,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
+		return NULL;
+	}
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2149,8 +2154,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.0.0.582.ge25c160
