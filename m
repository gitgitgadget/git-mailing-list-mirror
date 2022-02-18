Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E65CC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 20:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbiBRUBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:01:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiBRUBF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 15:01:05 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5674D636
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:00:48 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38A0D10D912;
        Fri, 18 Feb 2022 15:00:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wJCKd6LQA2n9EhfzLKlb6IcJrZFvlyoqNkq0To
        VBdoQ=; b=ITAFg6Lb3cqKPvIeYz6nbfty6jaMxXxXB/lllaGswkSoKaU/B3p/hT
        DEnr6fUlpw+bWFPn2Vg1w+HMzf0OZid1vsy/dxMcrW0AUJdfBVwuWQQOBtRgt6XT
        6P7cDhYknlbZ+7Nzucl2v1CRD+d/Rq01YeAeAf3Q3bA5GVJKh2So0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2ED9B10D911;
        Fri, 18 Feb 2022 15:00:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 514C610D910;
        Fri, 18 Feb 2022 15:00:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
        <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
Date:   Fri, 18 Feb 2022 12:00:44 -0800
In-Reply-To: <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Fri, 18 Feb 2022 18:40:45
        +0000")
Message-ID: <xmqqpmnkymfn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 757377D0-90F5-11EC-A834-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/reflog.h b/reflog.h
> new file mode 100644
> index 00000000000..e4a8a104f45
> --- /dev/null
> +++ b/reflog.h
> @@ -0,0 +1,49 @@
> +#ifndef REFLOG_H
> +#define REFLOG_H
> +
> +#include "cache.h"
> +#include "commit.h"
> +
> +/* Remember to update object flag allocation in object.h */
> +#define INCOMPLETE	(1u<<10)
> +#define STUDYING	(1u<<11)
> +#define REACHABLE	(1u<<12)

These names were unique enough back when they were part of internal
implementation detail inside builtin/reflog.c but it no longer is in
the scope it is visible.  builtin/stash.c (and whatever other things
that may want to deal with reflogs in the future) is about stash
entries and wants to have a way to differentiate these symbols from
others and hint that these are about reflog operation.

Perhaps prefix them with REFLOG_ or something?

Or, do we even NEED to expose these bits outside the implementation
of reflog.c?  If these three constants are used ONLY by reflog.c and
not by builtin/reflog.c (or builtin/stash.c), then moving them to
where they are used, i.e. in reflog.c, without exposing them to
others in reflog.h, would be a far better thing to do.  That way,
they can stay with their original name, without having to add a
differentiating prefix.

I also checked if any of the following struct's can be left as a
private implementation detail, but they are shared between reflog.c
and builtin/reflog.c and need to be in reflog.h



> +struct cmd_reflog_expire_cb {
> +	int stalefix;
> +	int explicit_expiry;
> +	timestamp_t expire_total;
> +	timestamp_t expire_unreachable;
> +	int recno;
> +};
> +
> +struct expire_reflog_policy_cb {
> +	enum {
> +		UE_NORMAL,
> +		UE_ALWAYS,
> +		UE_HEAD
> +	} unreachable_expire_kind;
> +	struct commit_list *mark_list;
> +	unsigned long mark_limit;
> +	struct cmd_reflog_expire_cb cmd;
> +	struct commit *tip_commit;
> +	struct commit_list *tips;
> +	unsigned int dry_run:1;
> +};
> +
> +int reflog_delete(const char*, int, int);
> +void reflog_expiry_cleanup(void *);
> +void reflog_expiry_prepare(const char*, const struct object_id*,
> +			   void *);
> +int should_expire_reflog_ent(struct object_id *, struct object_id*,
> +				    const char *, timestamp_t, int,
> +				    const char *, void *);
> +int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
> +		const char *email, timestamp_t timestamp, int tz,
> +		const char *message, void *cb_data);
> +int should_expire_reflog_ent_verbose(struct object_id *,
> +				     struct object_id *,
> +				     const char *,
> +				     timestamp_t, int,
> +				     const char *, void *);
> +#endif /* REFLOG_H */
