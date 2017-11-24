Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3B2202F2
	for <e@80x24.org>; Fri, 24 Nov 2017 01:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbdKXBoE (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 20:44:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57390 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751400AbdKXBoE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 20:44:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E83DA9511;
        Thu, 23 Nov 2017 20:44:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HMvPM4vvblRr2KKvmlHiptOdzao=; b=lBwWlm
        Y9eGkmIo/OqPuylXZnZPOSepkJ62oOurw50bFnivgYEaTU6MgAbdQNJyRbqV3ujc
        ViUKXA8Fju+7xiS+Fs8eOJ1CnpQ/eueUkpN3eCLehqyJ7NTubr33k41ZBFFLuQPJ
        NyRd3EETv5L04IsFIPy0Cu2ztXJJUkTCle5ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fSkpD9OW8XMtkjtSGiMoflEHM406TFOt
        2GS9j5dPFHoRTLZJXFXUuU9Oj8aVyD2FV7EUK17EtvC+BJ3Q69+a68/u0IBJh68k
        DhWU7srYyxQA9erzdEtbKwa/a16HZdNCp3+HnRlwUQIJutkb6ZiDI21uB0TxuT4t
        ZunGNdeXrGQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34F98A9510;
        Thu, 23 Nov 2017 20:44:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89DB1A950B;
        Thu, 23 Nov 2017 20:44:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc-Antoine Ruel <maruel@chromium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] grep: Add option --max-line-len
References: <20171123154159.17408-1-maruel@chromium.org>
Date:   Fri, 24 Nov 2017 10:44:01 +0900
In-Reply-To: <20171123154159.17408-1-maruel@chromium.org> (Marc-Antoine Ruel's
        message of "Thu, 23 Nov 2017 10:41:59 -0500")
Message-ID: <xmqqwp2gpi1q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2E71656-D0B8-11E7-8952-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc-Antoine Ruel <maruel@chromium.org> writes:

> This tells git grep to skip files longer than a specified length,
> which is often the result of generators and not actual source files.
>
> ...
> +-M<num>::
> +--max-line-len<num>::
> +	Match the pattern only for line shorter or equal to this length.
> +

All the excellent review comments from Eric I agree with.

With the name of the option and the above end-user facing
description, it is very clear that the only thing this feature does
is to declare that an overlong line does _not_ match when trying to
check against any pattern.

That is a much clearer definition and description than random new
features people propose here (and kicked back by reviewers, telling
them to make the specification clearer), and I'd commend you for that.

But it still leaves at least one thing unclear.  How should it
interact with "-v"?  If we consider an overlong line never matches,
would "git grep -v <pattern>" should include the line in its output?

Speaking of the output, it also makes me wonder if the feature
really wants to include an overlong line as a context line when
showing a near-by line that matches the pattern when -A/-B/-C/-W
options are in use. Even though it is clear that it does from the
above description, is it really the best thing the feature can do to
help the end users?

Which leads me to suspect that this "feature" might not be the ideal
you wanted to achive, but is an approximate substitution that you
found is "good enough" to simulate what the real thing you wanted to
do, especially when I go back and read the justfication in the
proposed log message that talks about "result of generators".

Isn't it a property of the entire file, not individual lines, if you
find it uninteresting to see reported by "git grep"?  I cannot shake
the suspicion that this feature happened to have ended up in this
shape, instead of "ignore a file with a line this long", only
because your starting point was to use "has overlong lines" as the
heuristic for "not interesting", and because "git grep" code is not
structured to first scan the entire file to decide if it is worth
working on it, and it is extra work to restructure the codeflow to
make it so (which you avoided).

If your real motivation was either

 (1) whether the file has or does not have the pattern for certain
     class of files are uninteresting; do not even run "grep"
     processing for them; or

 (2) hits or no-hits may be intereseting but output of overlong
     lines from certain class of files I do not wish to see;

then I can think of two alternatives.

For (1), can't we tell "result of generators" and other files with
pathspec?  If so, perhaps a negative pathspec can rescue.  e.g.

    git grep <pattern> -- '*.cc' ':!*-autogen.cc'

For (2), can't we model this after how users can tell "git diff"
that certain paths are not worth computing and showing textual
patches for, which is to Unset the 'diff' attribute?  When you have

    *-autogen.cc	-diff

in your .gitattributes, "git diff" would say "Binary files A and B
differ" instead of explaining line-by-line differences in the patch
form.  Perhaps we can also have a 'grep' attribute and squelch the
output if it is Unset?  

It is debatable but one could propose extending the use of existing
'diff' attribute to cover 'grep' too, with an argument that anything
not worth showing patch (i.e. 'diff' attribute is Unset) is not
worth showing grep hits from.
