Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2252C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFBB2071B
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GCt3mnV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgHaRYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:24:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56567 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgHaRYA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 13:24:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6CA5F0974;
        Mon, 31 Aug 2020 13:23:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9s4Gy/qEkIEw23IIuBrBK6JCpSU=; b=GCt3mn
        V1ojtdcemubYiZ8Ghyh2ww9k7NDt/QtohPKp46r5O/8ubShsor0wIZSMiyoQ3DsV
        U80zkSune2Fcs27XCBPYNcla08qYt4fXjARXzEqFdrKXKGgH+IhGgTZDAGcoG6Gl
        lRNpK5+BWBXvSgzwN8ln5oYi7xXWop+WxQQNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gc9/0NkIDgmpJBx58b+K9F+rtTFf1TMU
        pqPIP5rGUh41krAVbzByB4g1JUuiXz4V8UGwsj/pIizbx8DUEvjzFpgdKJoVYbX9
        YlA5rIHmiGEml5MIpT2c/c0Hgr2kwDNDYdp2z3UN/sf687pRdCqbgNio3+TNQhie
        VSdsZgngEHk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF874F0973;
        Mon, 31 Aug 2020 13:23:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E6314F0972;
        Mon, 31 Aug 2020 13:23:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3] revision: add separate field for "-m" of "diff-index -m"
References: <20200829194634.23306-1-sorganov@gmail.com>
        <20200831125350.26472-1-sorganov@gmail.com>
Date:   Mon, 31 Aug 2020 10:23:51 -0700
In-Reply-To: <20200831125350.26472-1-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 31 Aug 2020 15:53:50 +0300")
Message-ID: <xmqq4koihgpk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDCF9E5C-EBAE-11EA-894F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Add separate 'diff_index_match_missing' field for diff-index to use and set it
> when we encounter "-m" option. This field won't then be cleared when another
> meaning of "-m" is reverted (e.g., by "--no-diff-merges"), nor it will be
> affected by future option(s) that might drive 'ignore_merges' field.
>
> Use this new field from diff-lib:do_oneway_diff() instead of reusing
> 'ignore_merges' field.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---

Much easier to reason about.  As I said, I think we would ideally
want to detect and diagnose --[no-]diff-merges on the command line
of "diff" or "diff-{files,index,trees}" as an error, but for now
this is a good first step.

>  	} else if (!strcmp(arg, "-m")) {
>  		revs->ignore_merges = 0;
> +		/*
> +		 * Backward compatibility wart - "diff-index -m" does
> +		 * not mean "do not ignore merges", but "match_missing",
> +		 * so set separate flag for it.
> +		 */
> +		revs->diff_index_match_missing = 1;

Half the wart has been removed thanks to this patch and the rest of
the code can look at the right field for their purpose.  The parsing,
unless we make a bigger change that allows us to detect and diagnose
"diff-index --no-diff-merges" as an error, still needs to be tricky
and may deserve a comment.

The comment should apply to and treat both fields equally, perhaps
like this:

	} else if (!strcmp(arg, "-m")) {
		/*
		 * To "diff-index", "-m" means "match missing", and to
		 * the "log" family of commands, it means "keep merges".
		 * Set both fields appropriately.
		 */
		revs->ignore_merges = 0;
		revs->match_missing = 1;
	}

By the way, let's drop diff_index_ prefix from the name of the new
field.  I do not see a strong reason to object to a possible update
to "diff-files" to match the behaviour of "diff-index".  

In a sparsely checked out working tree (e.g. start from "clone
--no-checkout"), you can check out only paths that you want to
modify, edit them, and then "git diff-files -m" would be able to
show useful result without having to show deletions to all other
files you are not interested in.  And that is exactly the same use
case as "git diff-index -m HEAD" was invented for.

Thanks.

> diff --git a/revision.h b/revision.h
> index c1e5bcf139d7..5ae8254ffaed 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -188,6 +188,7 @@ struct rev_info {
>  	unsigned int	diff:1,
>  			full_diff:1,
>  			show_root_diff:1,
> +			diff_index_match_missing:1,
>  			no_commit_id:1,
>  			verbose_header:1,
>  			combine_merges:1,
