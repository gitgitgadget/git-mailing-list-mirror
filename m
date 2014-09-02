From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/22] refs.c: add transaction.status and track OPEN/CLOSED
Date: Tue, 2 Sep 2014 14:00:59 -0700
Message-ID: <20140902210059.GE18279@google.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 02 23:01:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvCO-0001Cl-7Q
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092AbaIBVBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:01:03 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:55773 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbaIBVBC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:01:02 -0400
Received: by mail-pa0-f47.google.com with SMTP id hz1so15573930pad.6
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CWtpXic2S7xU6dMjyY6trLHPCJYpaUDRjld82sEjCCo=;
        b=d1M4jNM0lWZb9bIxWSIPexxqqFhUFE0Vnmwgty9i1+V1BijUIg5RByyZEGJ/v4mL9B
         x+StwlJcE+kRsUYcuXOXludLppC53g7HEHgQZ+9xQ/if6ZVB3UByWpvun9At+WRx4N9X
         z+FspfTAdKKZdD9t0ewb0DP9ofKDIXTaHqfKFHVLd0ruIraLxrS1Z1Gnia18GEOe0RFO
         zdFfJfWoIWiojbR3pKigOp95/lM1EI0J1j0z7Z7bkHQdrzaYNIIVT3X/ta2E6Lhb7vgp
         TjgwemVFyxPQa0luSBMTDz449Mut6thOuGVKaOzyyjvufKuZ/AgcWQUDrhrjxrKw/wAI
         7ECQ==
X-Received: by 10.68.68.133 with SMTP id w5mr6347312pbt.166.1409691661776;
        Tue, 02 Sep 2014 14:01:01 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ca2sm4912685pbc.26.2014.09.02.14.01.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:01:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256350>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Tue, 29 Apr 2014 12:06:19 -0700

Track the state of a transaction in a new state field. Check the field for
sanity, i.e. that state must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 9cb7908..cc63056 100644
--- a/refs.c
+++ b/refs.c
@@ -3387,6 +3387,21 @@ struct ref_update {
 };
 
 /*
+ * Transaction states.
+ * OPEN:   The transaction is in a valid state and can accept new updates.
+ *         An OPEN transaction can be committed.
+ * CLOSED: A closed transaction is no longer active and no other operations
+ *         than free can be used on it in this state.
+ *         A transaction can either become closed by successfully committing
+ *         an active transaction or if there is a failure while building
+ *         the transaction thus rendering it failed/inactive.
+ */
+enum ref_transaction_state {
+	REF_TRANSACTION_OPEN   = 0,
+	REF_TRANSACTION_CLOSED = 1
+};
+
+/*
  * Data structure for holding a reference transaction, which can
  * consist of checks and updates to multiple references, carried out
  * as atomically as possible.  This structure is opaque to callers.
@@ -3395,6 +3410,7 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_state state;
 };
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
@@ -3437,6 +3453,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3457,6 +3476,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: create called for transaction that is not open");
+
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
@@ -3477,6 +3499,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: delete called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3532,8 +3557,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n)
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: commit called for transaction that is not open");
+
+	if (!n) {
+		transaction->state = REF_TRANSACTION_CLOSED;
 		return 0;
+	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3595,6 +3625,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->state = REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.1.0.rc2.206.gedb03e5
