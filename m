Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CC2C00140
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 00:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbiHFAJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 20:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiHFAJd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 20:09:33 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB752CE32
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 17:09:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0F401300D0;
        Fri,  5 Aug 2022 20:09:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KLSHtHfuvywGYvCuMvXSJjwYF1hWVKsItVs4Cj
        xE+LA=; b=xgSAf0xhgooIgTZXPk735SjfTIOm6LbRDxWyYl/h9gZSR6o1qGYkR3
        XpepYvwhQkfw73wWh/AR9CJdFhgdHGA/mtq0DXGTkR3oxpPhc/OslX5ASBEAgvVm
        o4f0+XtZbzPQOisZLXPeZDfIXPOz/aEHJYMLf4KNVHe1xUkboZQYY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7D671300CF;
        Fri,  5 Aug 2022 20:09:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 202B11300CD;
        Fri,  5 Aug 2022 20:09:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        shaoxuan.yuan02@gmail.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 3/4] cache.h: replace 'index_entry_exists()' with
 'index_name_pos_sparse()'
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
        <f7978d223fe86b6d0d43e905ee3abdc02fef8b7d.1659645967.git.gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:09:29 -0700
In-Reply-To: <f7978d223fe86b6d0d43e905ee3abdc02fef8b7d.1659645967.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Thu, 04 Aug 2022 20:46:06
        +0000")
Message-ID: <xmqqfsiaxmfa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AB856C6-151C-11ED-A513-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> 'index_entry_exists()' was original implemented in 20ec2d034c (reset: make
> sparse-aware (except --mixed), 2021-11-29) to allow callers to search for an
> index entry without expanding a sparse index. That particular case only
> required knowing whether the requested entry existed. This patch expands the
> amount of information returned by indicating both 1) whether the entry
> exists, and 2) its position (or potential position) in the index.

This patch probably should keep index_entry_exists() to potential
new callers that may be introduced by contemporary topics in flight,
by doing something like the following squashed in.  We know that
Shaoxuan's series does add a new callsite, which is of a lessor
concern as that series may want to be rebased on top of these fixes
anyway.  But there may be other topics that may want to add new
calls for this helper that is more trivially and obviously correct
than these four patches, in which case such topics want to proceed
independent of these four patches.

 cache.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git c/cache.h w/cache.h
index ba85435fee..039a32a317 100644
--- c/cache.h
+++ w/cache.h
@@ -839,6 +839,17 @@ int index_name_pos(struct index_state *, const char *name, int namelen);
  */
 int index_name_pos_sparse(struct index_state *, const char *name, int namelen);
 
+/*
+ * This helper function is only kept to help possible
+ * contemporary topics in flight.  Do not use it in new
+ * code; use index_name_pos_sparse() instead.
+ */
+static inline int index_entry_exists(struct index_state *istate,
+				     const char *name, int namelen)
+{
+	return 0 <= index_name_pos_sparse(istate, name, namelen);
+}
+
 /*
  * Some functions return the negative complement of an insert position when a
  * precise match was not found but a position was found where the entry would
