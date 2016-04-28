From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/29] ref_transaction_create(): disallow recursive pruning
Date: Thu, 28 Apr 2016 13:15:38 -0700
Message-ID: <xmqq60v14hhx.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
	<xmqq60v2anyo.fsf@gitster.mtv.corp.google.com>
	<1461788637.11504.3.camel@twopensource.com>
	<xmqqh9em93xo.fsf@gitster.mtv.corp.google.com>
	<xmqqvb327nyz.fsf@gitster.mtv.corp.google.com>
	<1461865718.4123.4.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:15:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avsLj-0002Nr-GW
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 22:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbcD1UPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 16:15:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752414AbcD1UPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 16:15:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5387716851;
	Thu, 28 Apr 2016 16:15:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8+zx3MRdeDJbzkZUKs7TTUaPaUc=; b=FzrBJQ
	kD8yDwa4HLAx88kijMP6VPgsIcxHAvSukP7oEx2LV4LY9RkJqPsY9eet2ajx/QYN
	eFtqY1uT5AuKthxGfpqicnnSsZSoGsoXrdj/rb5+7/msk2+tYJbb/SgJ4H+4PoDS
	hlEm+buaQxXVyvci7PmnKPay2zo+ybX1CMzu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iBnYztCSwB/ZMKqw4+jAh9ulQadwX1b4
	nlCbg6o7efOJZblI5p6rRjHFIf+mARtLKIkMCAnv6LUhwvu3bBDA1HrH2qQ/Tdhr
	N0co8y8Si9SwqpVjNa8VMHhngz+7NMEukElb4QtBwud/q7Qd0JlG8Haz1Yy3xrmM
	fJ50Qvv9Nf4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48AF016850;
	Thu, 28 Apr 2016 16:15:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F76B1684E;
	Thu, 28 Apr 2016 16:15:40 -0400 (EDT)
In-Reply-To: <1461865718.4123.4.camel@twopensource.com> (David Turner's
	message of "Thu, 28 Apr 2016 13:48:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA87CEE6-0D7D-11E6-A594-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292949>

David Turner <dturner@twopensource.com> writes:

> Since there is a manual check for that case, the code will fail at test
> time.

I see a difference between "We make it hard to write incorrect code"
and "We keep it easy to write incorrect code but a runtime check
will catch mistakes anyway", and I tend to prefer the former.

I do think the "manual check" needs to be kept in an adjusted form
even if we decide to take the suggested update.  A caller can pass
0x04 instead of REF_ISPRUNING after all---but that is exactly the
case where you have to work hard to write incorrect code.

One existing check that is not touched with 15/29 also needs to be
adjusted.  An incremental update relative to 15/29 would look like
this:

 refs.c               | 4 ++--
 refs/files-backend.c | 4 ++--
 refs/refs-internal.h | 6 ++++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 5dc2473..bb81dfd 100644
--- a/refs.c
+++ b/refs.c
@@ -790,8 +790,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
-	if ((flags & REF_ISPRUNING) && !(flags & REF_NODEREF))
-		die("BUG: REF_ISPRUNING set without REF_NODEREF");
+	if ((flags & REF_ISPRUNING_) && !(flags & REF_NODEREF))
+		die("BUG: REF_ISPRUNING_ set without REF_NODEREF");
 
 	if (new_sha1 && !is_null_sha1(new_sha1) &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8fcbd7d..012e3d0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2116,7 +2116,7 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
+				   REF_ISPRUNING, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
@@ -3178,7 +3178,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				goto cleanup;
 			}
 
-			if (!(update->flags & REF_ISPRUNING))
+			if (!(update->flags & REF_ISPRUNING_))
 				string_list_append(&refs_to_delete,
 						   update->lock->ref_name);
 		}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 37a1a37..0a2bf1f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -15,9 +15,11 @@
 
 /*
  * Used as a flag in ref_update::flags when a loose ref is being
- * pruned.
+ * pruned.  As this must always be done with REF_NODEREF, we make
+ * the public version REF_ISPRUNING to contain REF_NODEREF.
  */
-#define REF_ISPRUNING	0x04
+#define REF_ISPRUNING_	0x04
+#define REF_ISPRUNING	(REF_ISPRUNING_ | REF_NODEREF)
 
 /*
  * Used as a flag in ref_update::flags when the reference should be
