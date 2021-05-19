Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F54C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953186135C
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhESW7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 18:59:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60488 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhESW7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 18:59:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF47FB8243;
        Wed, 19 May 2021 18:58:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wk7NVN/wHysfA/q6z6eDcnIdTtS4Rvd89hU0BD
        BzNmc=; b=qvVYNMiHi6vPMAeXT1TnZgo1jLJm7fKdEuMUGPIHU2mGQYib5ZxFES
        LA2iGVE/64yYJ0pDBynmw6lAnl+gZ4bhW4iEbuXRrerJOhwtoPsd9OVeqz8i0F1E
        VwVrx+EtT6FURksbE8FRB1vlj0mHLS/cIfL++nTZ9iq8qwltzEZd0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A747CB8241;
        Wed, 19 May 2021 18:58:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2CA44B8240;
        Wed, 19 May 2021 18:58:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2] refs: make explicit that ref_iterator_peel returns
 boolean
References: <pull.1006.git.git.1618484566164.gitgitgadget@gmail.com>
        <pull.1006.v2.git.git.1621438289354.gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 07:58:14 +0900
In-Reply-To: <pull.1006.v2.git.git.1621438289354.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Wed, 19 May 2021
        15:31:28 +0000")
Message-ID: <xmqqzgwqwcu1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B240C7AE-B8F5-11EB-9917-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Use -1 as error return value throughout.

So this corresponds to the bottommost step in the series that is
queued as hn/reftable, with the difference at the end of this
message.

Do you want me to replace that single step with this version and
rebuild the remainder of the topic on top?

Thanks.


diff --git c/refs.c w/refs.c
index 7292c80a26..3b3478a2f1 100644
--- c/refs.c
+++ w/refs.c
@@ -2020,7 +2020,7 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
 	     oideq(current_ref_iter->oid, base)))
 		return ref_iterator_peel(current_ref_iter, peeled);
 
-	return !!peel_object(base, peeled);
+	return peel_object(base, peeled) ? -1 : 0;
 }
 
 int refs_create_symref(struct ref_store *refs,
diff --git c/refs/packed-backend.c w/refs/packed-backend.c
index dfecdbc1db..66cb90c79e 100644
--- c/refs/packed-backend.c
+++ w/refs/packed-backend.c
@@ -889,7 +889,7 @@ static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	} else if ((iter->base.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
 		return -1;
 	} else {
-		return !!peel_object(&iter->oid, peeled);
+		return peel_object(&iter->oid, peeled) ? -1 : 0;
 	}
 }
 
diff --git c/refs/ref-cache.c w/refs/ref-cache.c
index 703a12959e..49d732f6db 100644
--- c/refs/ref-cache.c
+++ w/refs/ref-cache.c
@@ -491,7 +491,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
-	return !!peel_object(ref_iterator->oid, peeled);
+	return peel_object(ref_iterator->oid, peeled) ? -1 : 0;
 }
 
 static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
diff --git c/refs/refs-internal.h w/refs/refs-internal.h
index 7b427b58f6..2bdabf7b4a 100644
--- c/refs/refs-internal.h
+++ w/refs/refs-internal.h
@@ -454,7 +454,7 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
 /*
- * Peels the current ref, returning 0 for success.
+ * Peels the current ref, returning 0 for success or -1 for failure.
  */
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
 				 struct object_id *peeled);
