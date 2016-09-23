Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03C8207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761622AbcIWTU2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 15:20:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54185 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759699AbcIWTU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 15:20:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C61333F983;
        Fri, 23 Sep 2016 15:20:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f6mxp9vKawGD6YjVMUhySx0/1aw=; b=OlIq9F
        oD2EMvFESR/GjYB6OOXEOoe1dm5Li9N5KglI1u0D+BFQ6p83Gf9Uw3/IcZmYMIe0
        QTUpJJQR4n2wHOyrVy4EwUJNYhi38zsvM4Uia3NTDGeMBnmF3s/jSqz3YjgUQ5rQ
        WpIysjDShVQpEc+sZwvl5nHvXCzdG+W5u5Sts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AaCuO95VZssZCuKDcv9VIT7T1e44j23Q
        iMavN89NLzlz6r7peNEvkhlQNIdjnZWFDfBsbZJsMpB8vnNBC4/FP9SLL+SNOeOC
        G9NQhVlBrc/CrNAJs+2q7K0K//grL9lPx+XWuAdTgt2exaX+5WhjBIKeAW6BfIM9
        C7FXPWm3Jt8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC1BE3F982;
        Fri, 23 Sep 2016 15:20:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AE403F981;
        Fri, 23 Sep 2016 15:20:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] ls-files: add pathspec matching for submodules
References: <CAKoko1oacXxrSMZBvfM9X6iGDq+KcUUZnUrD2qD3X8+ze8vUXg@mail.gmail.com>
        <1474500486-101640-1-git-send-email-bmwill@google.com>
Date:   Fri, 23 Sep 2016 12:20:22 -0700
In-Reply-To: <1474500486-101640-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Wed, 21 Sep 2016 16:28:06 -0700")
Message-ID: <xmqqbmze1kzt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6F8BDF6-81C2-11E6-8E19-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>  static void show_ce_entry(const char *tag, const struct cache_entry *ce)
>  {
> +	struct strbuf name = STRBUF_INIT;
>  	int len = max_prefix_len;
> +	if (submodule_prefix)
> +		strbuf_addstr(&name, submodule_prefix);
> +	strbuf_addstr(&name, ce->name);
> ...  
> +	} else if (match_pathspec(&pathspec, name.buf, name.len,
> +				  len, ps_matched,
> +				  S_ISDIR(ce->ce_mode) ||
> +				  S_ISGITLINK(ce->ce_mode))) {

There is an interesting observation around this code.  Note that it
is just something to keep in mind, even though I think we are in no
position to solve this within the scope of this series, or in fact I
am not sure if there is anything to "fix".

The expectation here is that the leading part of pathspec elements
contain path components above and outside the current working tree,
e.g. in a superproject with a submodule at "sub/", the end-user may
have said from the top of the superproject

    git ls-files --recurse-submodules -- sub/file

and the recursing "ls-files" is spawned as

    git -C sub ls-files -- sub/file

relaying the pathspec literally.

This does not correctly work if the path to the submodule has
wildcard in it.  Imagine that the submodule were at "s*b/".  The
recursing invocation would look like:

    git -C "s*b" ls-files -- "s*b/file"

Further imagine that the index in the submodule at "s*b" has two
paths in it, i.e.

	file
        oob/file

The prefix is prepended to them, to turn them into

	s*b/file
        s*b/oob/file

and I suspect that the pathspec element "s*b/file" would match both
of them.

The pathspec machinery has a provision to prevent a similar gotcha
happening for the "prefix" we internally use.  In a sample
repository created like so:

    $ git init
    $ mkdir -p 's*b/oob' sib
    $ >sib/file
    $ cd 's*b'
    $ >file
    $ >oob/file
    $ git add .
    $ git ls-files -- file

the "ls-files" in the last step gets 's*b/' as the "prefix", and the
pathspec is formed by concatenating "file" to it, but in a special
way.  The part that come from the "prefix" is marked not to honor
any wildcard in it, so 's*b/' even though it has an asterisk, it is
forced to match literally, giving only 's*b/file'.

A saving grace is that "s*b/file" in this case is what the end-user
is giving us, not something we internally generated.  So we can
simply blame the end user, saying "what --recurse-submodules does is
to (conceptually) flatten the indices of submodules into the index
of the superproject and show the entries that match your pathspec.
Because you gave us 's*b/file', which does match 's*b/oob/file',
that is what you get."

;-)
