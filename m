Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C4CC433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 08:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359290AbhKZIke (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:40:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50178 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbhKZIic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 03:38:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69B4FF2E2E;
        Fri, 26 Nov 2021 03:35:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tJVapvsEG9A3VyUHYTQ/V3UpwzNhgHNnwh1ria
        gSeK0=; b=k2gqL+cjBXDZ+cJ9tx8CVedwQL/Venn9y2QOc5Kctvbs2GSCvINV8K
        HtljdjxueV9Yh2fZX7bvHZOTofwci17i4K4vBXdzQ9knjY5FVfet64t8i1URmk/m
        3ZzKTA45Wv1Lfx4H5FeekQ1Swd4a1QwtNLy0KJqvIPFKfyFvsrF1s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FF44F2E2D;
        Fri, 26 Nov 2021 03:35:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF423F2E2C;
        Fri, 26 Nov 2021 03:35:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re* [PATCH 2/4] refs: trim newline from reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
        <xmqq35nnddw7.fsf@gitster.g>
        <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
        <xmqqczmqajdk.fsf@gitster.g>
        <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
        <xmqqzgpu7grv.fsf@gitster.g>
Date:   Fri, 26 Nov 2021 00:35:17 -0800
In-Reply-To: <xmqqzgpu7grv.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        23 Nov 2021 12:34:28 -0800")
Message-ID: <xmqqczmn71ru.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C96ACDD8-4E93-11EC-A317-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think what deserves such a comment more is the prototype for
> each_reflog_ent_fn describing what the parameters to that callback
> function, to help the callers of the iterator what to expect.  That
> is the end-user facing part.

Perhaps something along this line.

--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
Subject: [PATCH] refs: document callback for reflog-ent iterators

refs_for_each_reflog_ent() and refs_for_each_reflog_ent_reverse()
functions take a callback function that gets called with the details
of each reflog entry.  Its parameters were not documented beyond
their names.  Elaborate a bit on each of them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git c/refs.h w/refs.h
index 48970dfc7e..4fa97d77cf 100644
--- c/refs.h
+++ w/refs.h
@@ -462,7 +462,27 @@ int delete_reflog(const char *refname);
 
 /*
  * Callback to process a reflog entry found by the iteration functions (see
- * below)
+ * below).
+ *
+ * The committer parameter is a single string, in the form
+ * "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" (without double quotes).
+ *
+ * The timestamp parameter gives the seconds since epoch when the reflog
+ * entry was created.
+ *
+ * The tz parameter is an up to 4 digits integer, whose absolute value
+ * gives the hour and minute offset from GMT (the lower 2 digits are
+ * minutes, the higher 2 digits are hours).  A negative tz means west of,
+ * and a positive tz means east of GMT.
+ *
+ * The msg parameter is a single complete line; a reflog message given
+ * to refs_delete_ref, refs_update_ref, etc. is returned to the
+ * callback normalized---each run of whitespaces are squashed into a
+ * single whitespace, trailing whitespace, if exists, is trimmed, and
+ * then a single LF is added at the end.
+ *
+ * The cb_data is a caller-supplied pointer given to the iterator
+ * functions.
  */
 typedef int each_reflog_ent_fn(
 		struct object_id *old_oid, struct object_id *new_oid,
