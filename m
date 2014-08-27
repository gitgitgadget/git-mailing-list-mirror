From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 20/20] refs.c: make delete_ref use a transaction
Date: Tue, 26 Aug 2014 17:36:38 -0700
Message-ID: <20140827003638.GU20185@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:36:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMREE-00089f-A7
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbaH0Agm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:36:42 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:57124 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119AbaH0Agl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:36:41 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so23609990pdj.29
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vmEpcKCBd4fHL3buwcRv/09VxC3ZGv/s4ZVsgLjtUGg=;
        b=OOQk34aLy87twCwHCqIx2Kjv53L9jmPXRX+Fs8qQ2GsV19EqFW6IgQK107Susm+sb9
         Hmf4oBs84PBefdb7uWygI0dhg7YA9tIEgcqctxASpCwASU44vnsDcrpRgFL1ZPcZZNA6
         YzGZQHqw+dNQTVapgyTh+z7kLUgPSQ1hhw2vu69MeOBrpyMFAh7bs0on6GtqMU2qNp7I
         7Yb1AzOLehBcDYU3uxAKwR3xyjD2sfgnIpjF0mokIWALrMO1I50qbwE+H+05l0qyToOj
         Ia/jFNsrzB63xW+lpf3IidBH2qXiQhUL2kPNie9Lmns230ITuY33TYBlvCj0NrEmMN3m
         WnaA==
X-Received: by 10.68.253.34 with SMTP id zx2mr17315120pbc.152.1409099801326;
        Tue, 26 Aug 2014 17:36:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id hp1sm4478584pbb.77.2014.08.26.17.36.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:36:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255976>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 30 Apr 2014 09:22:45 -0700

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Change delete_ref to return 0 on success and 1 on failure instead of the
previous 0 on success either 1 or -1 on failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 refs.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 5b2d335..7996be9 100644
--- a/refs.c
+++ b/refs.c
@@ -2548,11 +2548,6 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int repack_without_ref(const char *refname)
-{
-	return repack_without_refs(&refname, 1, NULL);
-}
-
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
@@ -2570,24 +2565,22 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
-	struct ref_lock *lock;
-	int ret = 0, flag = 0;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
-	if (!lock)
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, refname, sha1, delopt,
+				   sha1 && !is_null_sha1(sha1), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		error("%s", err.buf);
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return 1;
-	ret |= delete_ref_loose(lock, flag);
-
-	/* removing the loose one could have resurrected an earlier
-	 * packed one.  Also, if it was not loose we need to repack
-	 * without it.
-	 */
-	ret |= repack_without_ref(lock->ref_name);
-
-	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	clear_loose_ref_cache(&ref_cache);
-	unlock_ref(lock);
-	return ret;
+	}
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return 0;
 }
 
 /*
-- 
2.1.0.rc2.206.gedb03e5
