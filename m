From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 19/20] refs.c: make prune_ref use a transaction to delete the
 ref
Date: Tue, 26 Aug 2014 17:36:10 -0700
Message-ID: <20140827003610.GT20185@google.com>
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
X-From: git-owner@vger.kernel.org Wed Aug 27 02:36:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMRDm-0007w5-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbaH0AgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:36:14 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44213 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238AbaH0AgN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:36:13 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so24587251pab.20
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lg/7K+G6ul0WYk4S+8tB+wv6vsVH1v00BITHj2p6yQw=;
        b=kzRmGbo98d/4LfbW07V3KWu/urUE3PsITZVMir2XxFU2fJMXHXjsBvWvJJ+M4Cy+XJ
         UWDDY+BC/wdFF9feiOLtPO9QQRoYFWVq4OvmCue3FVu185I57va5bu93ALvo/kxUI5/0
         vvBQnLT0ZajLv/Fnjn9TdcFQvZFL5eV/uyWOTfeHLNWy9WxJiRvNWUx71DjSQxS34Jhw
         OMVb1hDwtyPsrMY02WMAC6rdWeT+l0nDdY/HtW9USOUvsaFKwokWoh/zGopHGcnJyanD
         lArDT0mvUluBmU9OWEDNYeuOAyqXzVvYB6ZoCtOQeZpguIUX2vEH0nU9bvIIxwh+yVu5
         Fl5w==
X-Received: by 10.67.22.37 with SMTP id hp5mr16836107pad.150.1409099773495;
        Tue, 26 Aug 2014 17:36:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id ju4sm4567071pbc.6.2014.08.26.17.36.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:36:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255975>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 30 Apr 2014 09:03:36 -0700

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 28 +++++++++++++++++++++-------
 refs.h | 13 +++++++++++--
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index f0883d0..5b2d335 100644
--- a/refs.c
+++ b/refs.c
@@ -25,6 +25,11 @@ static unsigned char refname_disposition[256] = {
 };
 
 /*
+ * Used as a flag to ref_transaction_delete when a loose ref is being
+ * pruned.
+ */
+#define REF_ISPRUNING	0x0100
+/*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
  * not legal.  It is legal if it is something reasonable to have under
@@ -2382,17 +2387,25 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (check_refname_format(r->name + 5, 0))
 		return;
 
-	lock = lock_ref_sha1_basic(r->name, r->sha1, 0, NULL);
-	if (lock) {
-		unlink_or_warn(git_path("%s", r->name));
-		unlock_ref(lock);
-		try_remove_empty_parents(r->name);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, r->name, r->sha1,
+				   REF_ISPRUNING, 1, &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return;
 	}
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	try_remove_empty_parents(r->name);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3597,8 +3610,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			delnames[delnum++] = update->lock->ref_name;
 			ret |= delete_ref_loose(update->lock, update->type);
+			if (!(update->flags & REF_ISPRUNING))
+				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
diff --git a/refs.h b/refs.h
index 65dd593..69ef28c 100644
--- a/refs.h
+++ b/refs.h
@@ -170,9 +170,18 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks any ref (for 'HEAD' type refs). */
+/*
+ * Flags controlling lock_any_ref_for_update(), ref_transaction_update(),
+ * ref_transaction_create(), etc.
+ * REF_NODEREF: act on the ref directly, instead of dereferencing
+ *              symbolic references.
+ *
+ * Flags >= 0x100 are reserved for internal use.
+ */
 #define REF_NODEREF	0x01
-/* errno is set to something meaningful on failure */
+/*
+ * This function sets errno to something meaningful on failure.
+ */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
-- 
2.1.0.rc2.206.gedb03e5
