From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 13/31] refs.c: update the list of deleted refs during _update instead of _commit
Date: Wed, 14 May 2014 15:13:12 -0700
Message-ID: <1400105610-21194-14-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhRR-0007Kl-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbaENWOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:16 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:56000 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbaENWNh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:37 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so442862vcb.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BQadBwfI1JrJ7BZ68bOirn4z+eJiQmj5VXG0Nikc8uE=;
        b=MSgK0thzZ7J3SOWuBf9D8wfBpdJOZ2msDHeKoRYnktERb5MSSBSmDu5s+9ScoU/Sum
         9jJgTeSqdZMDYelG8xnBLaeScE0Wrx4l7S29T2fr+egmAA6qZISz7mymbpDT3Vd7RvJd
         aO9Lmbb35bguOT15+yX0LuesuBh6qOsgZK2I3mS9CfM8ew5eKizBGysd25b9xH2q1W9d
         2noaVM2pewPRUca9mnLR8z/P06ZQBH4rLMw6FePS9psQXLj8EjH7/eq2u+1Qg6hToqWC
         tlpnxBQ0zw1ZaXC6uqN/3jA2VX9bxXxTWSvKWLxdF8Z1kTkCSW/SbMElzDTJSglw/qps
         e5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BQadBwfI1JrJ7BZ68bOirn4z+eJiQmj5VXG0Nikc8uE=;
        b=atv+LhUYZFkW8OGv9QMMGHltg5ifNHAOBB//yTejb/eBPc60gIC0nuS7WU5nQVpi0K
         wSeQsjvRzkJLKCDOQA7qAJrufPhxNYq/mSZeOEqN4Wi9Ojzv9jdvAYYTpzBb6RLgUiPo
         9cmW6BZztzwdafJhuwNXXGPyRNsT3fLX+3xDSwPQE9lW5fhgf40mw2NyULXzmrGKu7Ij
         ZXIyJUKVEZlzH6w15t1KtGwzDwmThVxKHJh6Kkj2jHhWfWq/duLify3l+XPbPE59/ZAh
         4ozuky7Xwh/b7e86uYFPVYS9BWb7fYaXJYg4T4bzgXZYmfAVGs3g8Oqvcs393s1ESavZ
         8TLw==
X-Gm-Message-State: ALoCoQl7y00ydCbNpnNSuf3J0IvvQf7XCI0DPavvAUk3q19Up+HRP9n1A4oSfdZ9mOXWs09NTsct
X-Received: by 10.58.100.235 with SMTP id fb11mr838171veb.33.1400105616861;
        Wed, 14 May 2014 15:13:36 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si151198yhb.6.2014.05.14.15.13.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:36 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B1FE05A41E5;
	Wed, 14 May 2014 15:13:36 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 76F15E0973; Wed, 14 May 2014 15:13:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249020>

When deleting refs during a transaction, update the list of the refs to be
deleted already during _update instead of waiting until the _commit stage.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index cc31efe..3249576 100644
--- a/refs.c
+++ b/refs.c
@@ -3431,6 +3431,13 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 		hashcpy(update->old_sha1, old_sha1);
 	if (msg)
 		update->msg = xstrdup(msg);
+
+	/* This is a deletion of a ref that exists as a packed ref which means
+	 * we do not need to check against this ref for name collissions
+	 * during locking.
+	 */
+	if (update->flags & REF_ISPACKONLY)
+		add_delname(transaction, update->refname);
 	return 0;
 }
 
@@ -3550,15 +3557,6 @@ int transaction_commit(struct ref_transaction *transaction,
 	if (ret)
 		goto cleanup;
 
-	for (i = 0; i < n; i++) {
-		struct ref_update *update = updates[i];
-
-		if (update->update_type != UPDATE_SHA1)
-			continue;
-		if (update->flags & REF_ISPACKONLY)
-			add_delname(transaction, update->refname);
-	}
-
 	/* Acquire all ref locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
-- 
2.0.0.rc3.506.g3739a35
