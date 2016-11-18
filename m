Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73C31FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 22:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbcKRWTs (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 17:19:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63408 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752866AbcKRWTr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 17:19:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A086050CBA;
        Fri, 18 Nov 2016 17:19:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+aEICTt/WfmXwiV9szZ47Mi4cbg=; b=OGuBHw
        vNVg/6Hohtp+oiZhdTjpcBFOQyervutxWfSNbr78RUM4ioykfwnjxQeMAQf1j97e
        Z22Dq7fckIroNjp5WeI7uMGeZMdHkm7/eWZDrAhdjZO9EdPODMj7dqRhDxhrd2BK
        K5e2EOWAgK5u24PM1YPTE6JlTqBA6LEdQNQC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ekjFd6zIyo6+Op8Ivw6Du1UZFCSEFAwg
        4CEvDBBXvCtvK6XXsaqTu484EBHJzB44AMnMdxI41Smm9teLvPgSQBzjrvjB0+o9
        4IF207fjWI7eDQSLQqDfr9UPxIe/G5Au5a91BTVnfNJifJhTccBrWqgnxab5zj2M
        Uhb4e5Hw4Ts=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 962CE50CB9;
        Fri, 18 Nov 2016 17:19:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F21D50CB8;
        Fri, 18 Nov 2016 17:19:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 5/6] grep: enable recurse-submodules to work on <tree> objects
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
        <1479499135-64269-1-git-send-email-bmwill@google.com>
        <1479499135-64269-6-git-send-email-bmwill@google.com>
Date:   Fri, 18 Nov 2016 14:19:44 -0800
In-Reply-To: <1479499135-64269-6-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Fri, 18 Nov 2016 11:58:54 -0800")
Message-ID: <xmqqh974l9bz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CA64430-ADDD-11E6-8AAB-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> @@ -671,12 +707,29 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>  	enum interesting match = entry_not_interesting;
>  	struct name_entry entry;
>  	int old_baselen = base->len;
> +	struct strbuf name = STRBUF_INIT;
> +	int name_base_len = 0;
> +	if (super_prefix) {
> +		strbuf_addstr(&name, super_prefix);
> +		name_base_len = name.len;
> +	}
>  
>  	while (tree_entry(tree, &entry)) {
>  		int te_len = tree_entry_len(&entry);
>  
>  		if (match != all_entries_interesting) {
> -			match = tree_entry_interesting(&entry, base, tn_len, pathspec);
> +			strbuf_setlen(&name, name_base_len);
> +			strbuf_addstr(&name, base->buf + tn_len);
> +
> +			if (recurse_submodules && S_ISGITLINK(entry.mode)) {
> +				strbuf_addstr(&name, entry.path);
> +				match = submodule_path_match(pathspec, name.buf,
> +							     NULL);

The vocabulary from submodule_path_match() returns is the same as
that of do_match_pathspec() and match_pathspec_item() which is
MATCHED_{EXACTLY,FNMATCH,RECURSIVELY}, which is different from the
vocabulary of the variable "match" which is "enum interesting" that
is used by the tree-walk infrastructure.

I doubt they are compatible to be usable like this.  Am I missing
something?

> +			} else {
> +				match = tree_entry_interesting(&entry, &name,
> +							       0, pathspec);
> +			}
> +
>  			if (match == all_entries_not_interesting)
>  				break;
>  			if (match == entry_not_interesting)
