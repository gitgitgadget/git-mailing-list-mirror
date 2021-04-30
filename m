Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C22C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 06:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBE3613AD
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 06:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhD3GDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 02:03:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52476 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhD3GDO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 02:03:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79FBAA9360;
        Fri, 30 Apr 2021 02:02:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a1dEG3xAeiGETmGsQAdgtlmqDYwAITjsakW6hR
        YCwpI=; b=Wju+Bs6NJBXKpuYqxf32Pvr9DdVmpPgxfvfD1+P80DdB0f44E1X+z6
        Yzb5Pc3nlloZAEwkj6UF2uNv1yC1WZ75cWO6d/V/As9NmHlnGHO2nrBdstP383JK
        5ke7nrWIck93ed0zxl3DOsuJnvF9q7wCxxMYxTENFq8tWgrzGElH0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F6D7A935F;
        Fri, 30 Apr 2021 02:02:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF03FA935D;
        Fri, 30 Apr 2021 02:02:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 3/8] refs: make errno output explicit for read_raw_ref_fn
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <ebd7b8380bf7aed84d23973a4809d1441aa21692.1619710329.git.gitgitgadget@gmail.com>
        <xmqq35v8e982.fsf@gitster.g>
Date:   Fri, 30 Apr 2021 15:02:24 +0900
In-Reply-To: <xmqq35v8e982.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        30 Apr 2021 12:34:37 +0900")
Message-ID: <xmqqeeescntb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A293A8E8-A979-11EB-9A4A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I like the general direction to move away from errno, which may make
> sense only in the context of files backend (e.g. ENOENT would be
> left in errno, only because the original "loose ref" implementation
> used one file per ref, when a ref we wanted to see did not exist)
> and having other backends use the same errno would not make much
> sense, as it is not the goal to make other backends like reftable
> emulate files backend.
>
> I wonder if in the ideal world, we'd rather want to define our own
> enum, not <errno.h>, that is specific to failure modes of ref API
> functions and signal failures by returning these values (and the
> enum includes 0 as a value to signal success, all other errors are
> negative values).
>
> What I am really getting at is if we need an extra "failure"
> out-parameter-pointer in the internal API.  I do not mind if it
> helps the transition to the ideal world, but I offhand do not see if
> we need result and failure as separate variables.

In any case, the change in the function signature helped me catch
that this series invalidates what has been queued on hn/reftable
without updating that topic to align with the new way to handle the
errno (it would have become a silent semantic failure if we instead
encoded the "failure" in the return value).

The following is what I am tentatively using for tonight's
integration when merging this and hn/reftable together to the 'seen'
branch.

Thanks.


 refs/reftable-backend.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git c/refs/reftable-backend.c w/refs/reftable-backend.c
index 1aff21adb4..4385d2d6f5 100644
--- c/refs/reftable-backend.c
+++ w/refs/reftable-backend.c
@@ -52,7 +52,8 @@ static struct reftable_stack *stack_for(struct git_reftable_ref_store *store,
 static int git_reftable_read_raw_ref(struct ref_store *ref_store,
 				     const char *refname, struct object_id *oid,
 				     struct strbuf *referent,
-				     unsigned int *type);
+				     unsigned int *type,
+				     int *failure_errno);
 
 static void clear_reftable_log_record(struct reftable_log_record *log)
 {
@@ -376,7 +377,8 @@ static int fixup_symrefs(struct ref_store *ref_store,
 						&old_oid, &referent,
 						/* mutate input, like
 						   files-backend.c */
-						&update->type);
+						&update->type,
+						&errno);
 		if (err < 0 && errno == ENOENT &&
 		    is_null_oid(&update->old_oid)) {
 			err = 0;
@@ -1538,7 +1540,7 @@ static int reftable_error_to_errno(int err)
 static int git_reftable_read_raw_ref(struct ref_store *ref_store,
 				     const char *refname, struct object_id *oid,
 				     struct strbuf *referent,
-				     unsigned int *type)
+				     unsigned int *type, int *failure_errno)
 {
 	struct git_reftable_ref_store *refs =
 		(struct git_reftable_ref_store *)ref_store;
@@ -1560,12 +1562,12 @@ static int git_reftable_read_raw_ref(struct ref_store *ref_store,
 
 	err = reftable_stack_read_ref(stack, refname, &ref);
 	if (err > 0) {
-		errno = ENOENT;
+		*failure_errno = ENOENT;
 		err = -1;
 		goto done;
 	}
 	if (err < 0) {
-		errno = reftable_error_to_errno(err);
+		*failure_errno = reftable_error_to_errno(err);
 		err = -1;
 		goto done;
 	}
@@ -1578,7 +1580,7 @@ static int git_reftable_read_raw_ref(struct ref_store *ref_store,
 		oidread(oid, reftable_ref_record_val1(&ref));
 	} else {
 		*type |= REF_ISBROKEN;
-		errno = EINVAL;
+		*failure_errno = EINVAL;
 		err = -1;
 	}
 done:
