Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA36EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 18:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGUSyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 14:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGUSyS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 14:54:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE793599
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:54:17 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FD822F73D;
        Fri, 21 Jul 2023 14:54:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=io73DRp6TYAQnsyQ56+zpybFtXTxKbI9QwHndE
        IMIkQ=; b=Rn6ymEFWWEZqxRnvcSmP11P2AH4HGlAfhwvhff66zDJLdGlkGTggAg
        K9dexzkZxPj9AANBnkwoV/YuRDtJySHc8LGwrUd8Xvnaldh7+Joo3Si0MKHpD9Sq
        kpU+qZY5fPGUnW7u1Qsu4jknLc198lcOadPaZ2L63tDJakKGwT0O4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 489B92F73B;
        Fri, 21 Jul 2023 14:54:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B63832F739;
        Fri, 21 Jul 2023 14:54:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/5] t/lib-commit-graph.sh: allow `graph_read_expect()`
 in sub-directories
References: <cover.1689960606.git.me@ttaylorr.com>
        <084822126301c0e723155fd76942f2e259b77158.1689960606.git.me@ttaylorr.com>
        <CAPig+cQ2h+67Oxnt7FvZL-LrMF9RazfjLm5pkw4FUh3UU0T+4Q@mail.gmail.com>
        <ZLrPin9L9LtaDHaC@nand.local>
Date:   Fri, 21 Jul 2023 11:54:12 -0700
In-Reply-To: <ZLrPin9L9LtaDHaC@nand.local> (Taylor Blau's message of "Fri, 21
        Jul 2023 14:33:46 -0400")
Message-ID: <xmqqo7k5umcr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC41C150-27F7-11EE-B43D-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Jul 21, 2023 at 01:41:06PM -0400, Eric Sunshine wrote:
>> > diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
>> > @@ -32,6 +32,13 @@ graph_git_behavior() {
>> >  graph_read_expect() {
>> > +       DIR="."
>> > +       if test "$1" = -C
>> > +       then
>> > +               shift
>> > +               DIR="$1"
>> > +               shift
>> > +       fi
>> > @@ -47,12 +54,15 @@ graph_read_expect() {
>> > -       cat >expect <<- EOF
>> > +       cat >$DIR/expect <<- EOF
>>
>> It may not matter for any of the current callers, but we'd normally
>> want to quote the expansion of $DIR. Also, as I recall, some versions
>> of bash complain if the target of '>' is not quoted. So:
>>
>>     cat >"$DIR/expect" <<-EOF

Correct.  

Documentation/CodingGuidelines spells out this shell redirection
rule and it applies not just to tests but our scripted porcelains
(if any remains, that is).

> Hmm. I'm certainly happy to make this change, but there are many other
> spots within our tests that would need similar updates. Looking through
> the output of:
>
>     $ git grep -E '>\$[[:alnum:]_]+/.*' -- t/**/*.sh
>
> I see 25 such instances (including this one) that would need similar
> treatment.

Let's not make things worse.

Thanks.
