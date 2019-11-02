Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D341F454
	for <e@80x24.org>; Sat,  2 Nov 2019 04:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfKBEtl (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 00:49:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55655 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKBEtk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 00:49:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DCE336D66;
        Sat,  2 Nov 2019 00:49:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=baniZoXLKucr2lFN08iVm5L43Bg=; b=BXJveI
        Jf1Hhw7+hbhKfry0fWxGftQsDNZBX+lvv2JpLKYERTl7xoIuqHO+ZuNSvDhLa5eL
        PLLVnjozOyEjmtDoA8peKKvFUik+BuXn+146vzgtOLVKUHhZi1D26NN0hrjPvkJw
        hHAMcP1SPHCEq6fdcue6sb7qSo7ozIbi5YX80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LHlU62OUD4NDSo/0SALS6wg8D0egeoJp
        JZWi4zPQCdqTxBGTbtJPNohERAKFfiy5ndr4+9F9bjRp0alchraJGk0ANezhWQg5
        D5FbKUWw3L1DlO4yx+LJB6qnUMAi3DnD6xdIXFLS4qcU1WjkiD3wNEvbyCgJDjJi
        DoFGwbniSK8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75E8536D64;
        Sat,  2 Nov 2019 00:49:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D66B836D61;
        Sat,  2 Nov 2019 00:49:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     git@vger.kernel.org
Subject: Re: 'git reset -- NonExistingFile' succeeds
References: <f6d853ce-6f27-ed58-a850-d9a6f245509a@syntevo.com>
Date:   Sat, 02 Nov 2019 13:49:36 +0900
In-Reply-To: <f6d853ce-6f27-ed58-a850-d9a6f245509a@syntevo.com> (Alexandr
        Miloslavskiy's message of "Wed, 30 Oct 2019 17:29:13 +0100")
Message-ID: <xmqqo8xu51cv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C86ABAA-FD2C-11E9-858F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> Is that expected?
>
> Other commands seem to not like that:
>
> $ git checkout NonExistingFile
> error: pathspec 'NonExistingFile' did not match any file(s) known to git

It's sort of expected ;-)

"git $subcmd -- pathspec" is defined to perform $subcmd to the paths
that match the given pathspec.  "git checkout -- pathspec" checks
out the contents out of the index for such paths and "git reset --
pathspec" resets the contents in the index to that of HEAD for such
paths.

Historically, we did not consider it is an error for users to
specify an empty set (i.e. a pathspec with an element that does not
match any path).  Because it is easy to mistype "git checkout --
*.rv", let the shell pass "*.rv" literally (because in a project
where you meant to say "*.rb", it is very plausible that there is no
such path for the glob to match) to "git checkout" and nobody would
give you any indication of an error, we made it an error for "git
checkout" to be fed a pathspec element that does not match [*1*].

It is expected that other commands that may benefit from a similar
handholding mechanism against end-user typos have not learned to do
so, simply because nobody bothered to bring it up ;-).



[Footnote]

*1* This cuts both ways and it used to hurt a lot more back when it
was introduced.

When you have many tracked *.rb files and some throwaway *.rb files
that are not tracked,

    git checkout -- \*.rb

may checkout only the ones that are tracked (i.e. known to git---in
this case, known to the index) without molesting the untracked ones.
But people being people, they can be lazy and say

    git checkout -- *.rb

instead (notice the lack of quoting for the asterisk).  This would
first let your shell expand it and match untracked ones, and then
feed the resulting paths as a pathspec to "git checkout", so one of
the pathspec elements may be the "untracked.rb" throw-away file.
With the "it is an error for a pathspec element not to match any"
rule, such a use will now error out.

The good thing is that people can learn, and after getting such an
error message, they learn to quote the asterisk from the shell when
they want to Git expand it.  So it may not hurt that much these
days as it used to.

