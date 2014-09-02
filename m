From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/22] refs.c: remove the update_ref_lock function
Date: Tue, 2 Sep 2014 14:08:20 -0700
Message-ID: <20140902210819.GQ18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
 <20140902205841.GA18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:08:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvJa-0005fh-LG
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbaIBVI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:08:26 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:64024 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135AbaIBVIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:08:23 -0400
Received: by mail-pd0-f178.google.com with SMTP id y13so9574511pdi.9
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HA9uQ4eIai4xcSYXtbr0nSbr1h+g/Hc0+hO1jrjp1xg=;
        b=O2GW7NUA0TKgGq17Sj5eMZnwPz+tGTDqPM8XmYmr7awgVWuHUfjRi5W5edlzpjUaIk
         xmYZ6nZiidj2psZeP5JLzUgFnC3cZ198AGmiyQDhiKD+x1cdfsD7OGzsrIHBWBMhH6cR
         P9zBn9mhcyMO1+VGFJJUDkXAVA8jfUPeCdhlDDoxPIwkSMLLzNgN/rIhiHUigqt+oPqw
         E8uo37hhTxgeqXRMjcE4/uCwmhIGw5de7cg4QgrvF29nrVFPhyDkZNXk5xGhaAXpACiz
         +fi/vv4hdjnDEdVNTzUUbFxuafYqEEDkRjhJZ2wamf4/83Vj7obv+wLYMyr1WIRndt0d
         j3Vw==
X-Received: by 10.68.245.135 with SMTP id xo7mr6695334pbc.161.1409692102780;
        Tue, 02 Sep 2014 14:08:22 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id te8sm14154523pab.34.2014.09.02.14.08.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:08:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256362>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Tue, 29 Apr 2014 12:14:47 -0700

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index d4cd44b..a4445a1 100644
--- a/refs.c
+++ b/refs.c
@@ -3336,24 +3336,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-static struct ref_lock *update_ref_lock(const char *refname,
-					const unsigned char *oldval,
-					int flags, int *type_p,
-					enum action_on_err onerr)
-{
-	struct ref_lock *lock;
-	lock = lock_any_ref_for_update(refname, oldval, flags, type_p);
-	if (!lock) {
-		const char *str = "Cannot lock the ref '%s'.";
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
-		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
-		case UPDATE_REFS_QUIET_ON_ERR: break;
-		}
-	}
-	return lock;
-}
-
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
 			    struct strbuf *err, enum action_on_err onerr)
@@ -3603,12 +3585,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		update->lock = update_ref_lock(update->refname,
-					       (update->have_old ?
-						update->old_sha1 : NULL),
-					       update->flags,
-					       &update->type,
-					       UPDATE_REFS_QUIET_ON_ERR);
+		update->lock = lock_any_ref_for_update(update->refname,
+						       (update->have_old ?
+							update->old_sha1 :
+							NULL),
+						       update->flags,
+						       &update->type);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.1.0.rc2.206.gedb03e5
