Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB6A202F8
	for <e@80x24.org>; Mon, 13 Mar 2017 18:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753998AbdCMSd3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:33:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52325 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753550AbdCMScl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:32:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA14983242;
        Mon, 13 Mar 2017 14:32:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9aEZhJ7D9JU3+18jXAAgKH1x150=; b=x32oAn
        ODts+5XQQFpOD/6KHUxmyt0jSSVXK/vxR1OebJ6SLy1QJ5lOlmyGXXIPr/qvZ1Xq
        iFZvQzpFCUYP0nQDw0tyZiMG2a1HXThm83v0QHvxpXIIvz3iYdXr9EueauzklYJn
        uQ0JR/hPWJ4WG0xBZgnC0cATY48GGpdBHn3So=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fLOXSieEKpY7WNvkJorNFK8EIrjKWnMd
        AsJp0So7gPRBgYz4zHGWZIt3A3XsmfOZDMMEoxvItQCrNN22gU93Xh7MPbvCnpiS
        u7a7ZXMNPdnYdrcZq9jIM0vnKp4nJ+sVE6Zo/VvMUxfG/KCHxIMIg+rJJ/Kxh+i5
        zHYr77xdAlg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0A4883241;
        Mon, 13 Mar 2017 14:32:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 471E88323F;
        Mon, 13 Mar 2017 14:32:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christophe Macabiau <christophemacabiau@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: [PATCH] difftool: handle changing symlinks in dir-diff mode
References: <alpine.DEB.2.20.1703072332370.3767@virtualbox>
        <20170313175640.14106-1-davvid@gmail.com>
Date:   Mon, 13 Mar 2017 11:32:38 -0700
In-Reply-To: <20170313175640.14106-1-davvid@gmail.com> (David Aguilar's
        message of "Mon, 13 Mar 2017 10:56:40 -0700")
Message-ID: <xmqqlgs9rprt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FEDA956-081B-11E7-8336-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Detect the null object ID for symlinks in dir-diff so that difftool can
> prepare temporary files that matches how git handles symlinks.
>
> Previously, a null object ID would crash difftool.  We now detect null
> object IDs and write the symlink's content into the temporary symlink
> stand-in file.
>
> Original-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---

I would have appreciated (and I suspect other reviewers would, too)
a bit of back-story wrt how "Original-patch-by" resulted in this
patch after the three-dashes line.  It is perfectly fine if you two
coordinated privately; I mostly wanted to hear something like "Dscho
has been working on this and I asked him if it is OK to take over
his WIP to produce a quick-fix we can ship on the maint branch, here
is the result of that collaboration."  IOW, the person who is named
as the original author is fine to be named like so (I care only
because I do not think we saw the "original" here on the list).

> +static int create_symlink_file(struct cache_entry* ce, struct checkout* state)

Asterisk sticks to variable, not type.

> +{
> +	/*
> +	 * Dereference a worktree symlink and writes its contents

s/writes/write/

> +	 * into the checkout state's path.
> +	 */
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf link = STRBUF_INIT;
> +
> +	int ok = 0;
> +
> +	if (strbuf_readlink(&link, ce->name, ce_namelen(ce)) == 0) {
> +		strbuf_add(&path, state->base_dir, state->base_dir_len);
> +		strbuf_add(&path, ce->name, ce_namelen(ce));
> +
> +		write_file_buf(path.buf, link.buf, link.len);

This does "write content into symlink stand-in file", but why?  A
symbolic link that is not changed on the right-hand side of the
comparison (i.e. S_ISLNK(rmode) && !is_null_oid(&roid)) would go to
checkout_entry() which

 - creates a symbolic link, on a filesystem that supports symlink; or
 - writes the stand-in file on a filesystem that does not.

which is the right thing.  It seems that the other side of "if (!use_wt_file())"
if/elseif/... cascade also does the right thing manually.

Shouldn't this helper also do the same (i.e. create symlink and fall
back to stand-in)?

Also, I am not sure if strbuf_readlink() can unconditionally used
here.  On a filesystem without symbolic link, the working tree
entity that corresponds to the ce that represents a symlink is a
stand-in regular file, so shouldn't we be opening it as a regular
file and reading its contents in that case?

