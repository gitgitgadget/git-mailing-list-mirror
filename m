Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E6AC2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5623220857
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FybcDqM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgDIXhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:37:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56106 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgDIXhS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 19:37:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 756DB5A1B0;
        Thu,  9 Apr 2020 19:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bAtdgU/NMCeMBWCTrNuUSqYMRvY=; b=FybcDq
        M8VNz/kzlTFyXwk+l72r7KzC8ogs+Yath8SyCEfBV2L9IZBlfIxdNvRKphpkkjYM
        ZQb1APYYJcL4xZ5d5Y7rbuI8Y4sbH5GpZ+WgGgRNsyl4MJ6kjiQiFumi4/am3wb7
        YQ6gFOZ5ImExwZnyXe/TZ3LjtJKW/rIDEfOrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xtxVjcIjNTYYkhWgPDj1ppyU4HXzjtKV
        E45mody1Y0F3IXRrE8YNrgZoPu8meSPPoYRxStUzjK78/qWRqU6On5of7EzAtK7y
        Q/Br+ddguKF/dORQQY+lw7vCuT62YD9gqsmJTSZBVY2CnZ47P4Ey/stXT2iek2L9
        QuCWF1vufzg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E3595A1AF;
        Thu,  9 Apr 2020 19:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC7125A1AE;
        Thu,  9 Apr 2020 19:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?Q?=C3=89rico?= Rolim <erico.erc@gmail.com>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>
Subject: Re: [BUG] segmentation fault in git-diff
References: <CAFDeuWO+2JEGudtnHZvSsSUOVRR83U9ziLEjSoDyMWxYhvDMKg@mail.gmail.com>
        <xmqqh7xsmg7j.fsf@gitster.c.googlers.com>
        <xmqqd08gmg3s.fsf@gitster.c.googlers.com>
        <xmqq4ktsmfnn.fsf@gitster.c.googlers.com>
Date:   Thu, 09 Apr 2020 16:37:15 -0700
In-Reply-To: <xmqq4ktsmfnn.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 09 Apr 2020 15:57:00 -0700")
Message-ID: <xmqqzhbkkz84.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B9264B8-7ABB-11EA-B56D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The problem bisects down to c931ba4e (sha1-name.c: remove the_repo
from handle_one_ref(), 2019-04-16), which did this:



-			for_each_ref(handle_one_ref, &list);
-			head_ref(handle_one_ref, &list);
+			cb.repo = repo;
+			cb.list = &list;
+			refs_for_each_ref(repo->refs, handle_one_ref, &cb);
+			refs_head_ref(repo->refs, handle_one_ref, &cb);

The old code used the helper for_each_ref().  This is a thin wrapper
around refs_for_each_ref() and allows the default repository object
to be used implicitly by the caller.  It is understandable that the
code wanted to work on arbitrary repository object, and replaced the
for_each_ref() helper with refs_for_each_ref() helper that takes any
ref store object.

But there is a small mistake.  for_each_ref() makes sure that the
ref store is initialized; the new code blindly assumes it has
already been initialized.

    int for_each_ref(each_ref_fn fn, void *cb_data)
    {
            return refs_for_each_ref(get_main_ref_store(the_repository), fn, cb_data);
    }

So, I think the fix is simple.  With the attached one liner on top
of c931ba4e (sha1-name.c: remove the_repo from handle_one_ref(),
2019-04-16),

	$ git rev-parse :/any/path/

no longer segfaults.  I think it would also work just fine when
merged to more modern codebase, but I haven't tried it (yet).




 sha1-name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index d9050776dd..3aba62938f 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1771,7 +1771,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 
 			cb.repo = repo;
 			cb.list = &list;
-			refs_for_each_ref(repo->refs, handle_one_ref, &cb);
+			refs_for_each_ref(get_main_ref_store(repo), handle_one_ref, &cb);
 			refs_head_ref(repo->refs, handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(repo, name + 2, oid, list);



