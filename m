Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ADEC433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 19:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB62F610E5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 19:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347260AbhIBTFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:05:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54936 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347239AbhIBTFM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 15:05:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9003E0BC1;
        Thu,  2 Sep 2021 15:04:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YtNv+ouZHFARo9EJHEUn2DsDAkTJUvBB8gmZQc
        rhlY4=; b=xQQsmQY18F7LcXs/c/t0JxZEl8QHjk1EFBDgg4XjpSKf5MVXqR0Xt1
        /QH6Vy5XakZt8D4MYlRiviFEwdr6js8oHE84iZRrJERSGxlvDuzS2ESxDwk67xYV
        wXgVZdfeXbRPErLxithDroFLrZck3qnQr8mTmc8M4XuYmNc91qtMc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1265E0BC0;
        Thu,  2 Sep 2021 15:04:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CC93E0BBF;
        Thu,  2 Sep 2021 15:04:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     sobomax@gmail.com, sobomax@sippysoft.com
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org,
        philipoakley@iee.email, Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v2] Make ident dynamic, not just a hardcoded value of
 "$Id".
References: <pull.1074.v2.git.git.1629952119446.gitgitgadget@gmail.com>
        <20210826203713.45139-1-matheus.bernardino@usp.br>
        <xmqqr1e77q01.fsf@gitster.g>
Date:   Thu, 02 Sep 2021 12:04:11 -0700
In-Reply-To: <xmqqr1e77q01.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        01 Sep 2021 17:58:06 -0700")
Message-ID: <xmqqmtoukdec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F4838B2-0C20-11EC-A1BF-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If we are not restricting the characters that can be used in the
> custom ID placeholder, we probably should have tests that use
> allowed but unusual characters.

There is a test in t/t0021-conversion.sh that ensures that we
recognise expanded and unexpanded keyword strings using various
lines that has placeholder-lookalike on it, which starts like this:

    # If an expanded ident ever gets into the repository, we want to make sure that
    # it is collapsed before being expanded again on checkout
    test_expect_success expanded_in_repo '
            {
                    echo "File with expanded keywords"
                    echo "\$Id\$"
                    echo "\$Id:\$"
                    echo "\$Id: 0000000000000000000000000000000000000000 \$"
                    echo "\$Id: NoSpaceAtEnd\$"
                    echo "\$Id:NoSpaceAtFront \$"
                    echo "\$Id:NoSpaceAtEitherEnd\$"
                    echo "\$Id: NoTerminatingSymbol"
                    echo "\$Id: Foreign Commit With Spaces \$"
            } >expanded-keywords.0 &&
	    ...

It would be good to have a copy of this test with the placeholder
customized to something unusual like " Id:", "Id: $ $", ":", "$ $"
etc. to make sure we can parse out the keyword correctly without
imposing the letters that can be used in the placeholder.

    Side note.  I of course do not literally mean to "copy" and make
    the number of tests explode.  I think it can be done with a loop
    to test various custom strings, which may begin like ...

	for kwd in "Id" " Id:" "Id $" "Id: $ $" ":" "$ $"
	do
		cat >expanded-keywords.0 <<-EOF &&
		\$$kwd\$
		\$$kwd:\$
		\$$kwd: 0000000000000000000000000000000000000000 \$
		\$$kwd: NoSpaceAtEnd\$
		\$$kwd:NoSpaceAtFront \$
		\$$kwd:NoSpaceAtEitherEnd\$
		\$$kwd: NoTerminatingSymbol
		\$$kwd: Foreign Commit With Spaces \$
		EOF
		...

If we can do without restriction, that would be even better, but I
do not think it is the end of the world if we found some corner case
that a certain customized placeholder can make the syntax ambiguous
and we cannot recognise expanded keywords in the working tree files,
as it is reasonable to limit the letters we allow in placeholders.

One thing we should not do is to tell users that they can use
anything as their customized Id string, and then later find such a
corner case and tell them now we forbid certain letters.  To avoid
such a mistake, it is better to start reasonably tight, allowing
what we know will never cause problems (like alphanumerics) and
forbidding what we know will not be missed in real-world usecases
(like whitespaces and punctuations).  After we discover that certain
things that we initially forbid have real uses in the future, we can
loosen the restriction.  "Start loose and then tighten" will lead to
a regression when viewed from the end-user's workflow.  "Start tight
and then loosen" will not have that problem.
