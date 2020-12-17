Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F7CC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7558823339
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgLQT3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 14:29:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55297 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgLQT3K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 14:29:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A52DE967AE;
        Thu, 17 Dec 2020 14:28:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hx6uFxt7i8DuqGQ7nhtlbBVrmzo=; b=nMVkRu
        CxEBPf4MvmxrDO1AonBhAUjRB7rRho3DzzxNpHmLDa2iaxqR406e7Ekx2Yg64mwE
        F3tzyBtlQrw6oiTbrxzxMbYYjsU1bbICbHt5zVzKSqUwwbcqbybAINEKrdORyvXX
        SsYf4nLwFgSLCSG6EK6sJC8d/5nQZhBxGHVKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QDKYts8m4ynT4fzQ1hTnqWFyN4JjrsQ/
        QxJ4LrVrrqI/M1XJ55uJj8A8d5BWDf6CgM+bjLZSmCFIw5crmwk4JN9CqdKAR8hm
        sl1hPfk8BYTMCUjsmdqC52+0/hcHFo9aiQT3FhkFLNcg0ktIfIHLDLg+6vyfn+Zq
        v+4Ugni6sIg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B084967AD;
        Thu, 17 Dec 2020 14:28:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23F01967AC;
        Thu, 17 Dec 2020 14:28:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
        <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
        <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
        <5fdaef83a40ba_d0e26208f6@natae.notmuch>
        <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
        <20201217094424.GA75257@ellen> <5fdb3471c6bb7_d6d032087@natae.notmuch>
        <20201217175037.GA80608@ellen>
Date:   Thu, 17 Dec 2020 11:28:25 -0800
In-Reply-To: <20201217175037.GA80608@ellen> (Seth House's message of "Thu, 17
        Dec 2020 10:50:37 -0700")
Message-ID: <xmqq5z50z0yu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08CD994C-409E-11EB-BDB3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> Would you mind switching the autoMerge option to be per-tool rather than
> under the main mergetool config section?
>
> You're right that it will likely not cause any downstream errors; it's
> just a difference in preference. The tools that perform their own
> conflict resolution will likely want it off and most of the other tools
> will likely want it on. I could envision wanting to configure multiple
> mergetools -- some with and some without.

Thanks for a concise summary.

Many people may stick to just a single tool and may find a single
mergetool.autoMerge knob convenient (and it is OK for them if the
new behaviour broke a tool they do not use), but for those who use
more than one, being able to configure them differently would be
valuable.  So I agree that making it a per-tool option would be a
good thing to do.  Extra bonus for "this covers all" fallback default
perhaps like so:

	if test "$(git config --get --bool "mergetool.$merge_tool.automerge" ||
	           git config --get --bool "mergetool.autoMerge" ||
	           echo true)" = true
	then
		... do the new "reduce conflicts" thing ...
	else
		... do the "grab the original" thing ...
	fi

There is another thing that the final version may want to consider.

Would there be a reason for a tool to actively want to refuse the
end-user request to use the new autoMerge behaviour?  A tool that
can merge binary files may want to make sure it gets the original
three blobs that got involved in the conflict, and the above
would allow users to break such a tool.  We could say "don't do
that then" to users, or we can use the same mechanism to set up
diff_cmd() etc. per tool [*1*].  A tool that always wants to use
the autoMerge without letting end-user to opt out can be handled
with the same mechanism, but I think that is less likely.

Also, just for completeness (this is a comment made after seeing v3),
unlike the previous rounds, we do not have to worry about conflict
marker length attribute user may have and rely on the default
marker-size hardcoded at the xdl_merge() layer.  If we wanted to
make it even safer, "git merge-file --diff3" invocation can also
use a hardcoded --marker-size=7 option to protect from changes in
the underlying xdl_merge()'s default.

Unfortunately, it however also means that we can be confused when we
are seeing a conflicted outer merge of a recursive merge.  In such a
case, the virtual ancestor version in stage #1 can have conflict
markers from the inner merge that also conflicted, which uses marker
size a bit longer than what the user gave via the attribute
machinery.  If that "a bit longer" length happens to be the same as
the hardcoded assumption of 7 the sed script in v3 makes, the sed
script would not be able to tell between the existing markers in the
virtual ancestor version and the markers "git merge-file --diff3"
creates.

It is unlikely that the end-user sets conflict marker length to
anything shorter than the default 7, so I think it is OK to punt
this potential problem, and assume we are OK.  The limitation may
need to be documented, though.

> After work today I can go back through the list of mergetools reviewed
> in my post and grab screenshots of each with this option enabled so that
> everyone in this thread can quickly compare the before/after results.

Thanks.


[Footnote]

*1* If we were to go that extra mile for completeness, the result
    would roughly look like the following outline:

 1. git-mergetool--lib.sh::setup_tool() would define a new helper
    function 

	automerge_enabled () {
		true
	}

    to be used as the fallback

 2. a tool that wants to use the original without allowing the user
    to opt into automerge would add

	automerge_enabled () {
		false
	}

    in mergetools/$toolname (where toolname is like 'tkdiff',
    'vimdiff', etc.)

 3. then the "consult mergetool.<tool>.automerge and then
    mergetool.automerge in this order" if statement we saw above
    would first ask the new helper function, i.e.

	if automerge_enabled &&
	   test "$(git config --get --bool "mergetool.$merge_tool.automerge" ||
                   git config --get --bool "mergetool.automerge" ||
	           echo true)" = true
	then
		...

