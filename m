Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639B7C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 00:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167FD64DF8
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 00:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhBEA5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 19:57:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63033 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhBEA5E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 19:57:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9EC3C11D549;
        Thu,  4 Feb 2021 19:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q+SwcBKR+Loqy1H2iCf14gvRbww=; b=Zd9G/z
        uraoyuF3w2z9GWAD/mrMXE0uDND6382I3TVjX0Tb2GipdI675uRSJqRztLnn+QoK
        jeZCVJMVjwvPGpJ1sYMJ0aDYW2OqGNel7GwSBtePSIBP4qBR/sNaBFWyYMJnWeqI
        Yu6lcYgNLaVOINOhkWSsxYQ/a0jr5TsIJDAlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aha6R2R/EU7HnQXoxWFDoD3LVf+4BmQU
        GzrNOw/sBUhlKmMvyv/Eop8109rZmWtveA8nMXUNZckaa4YIh7BZokE7JHQzy/xF
        Y4sjZzck2wU1bc9Ug4ZB/0ZdrhtPB/PWjuMfLJr5EU0gXwK6cUl/7oi9OYh64HZ7
        6TPGWgaTo+s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 987EE11D547;
        Thu,  4 Feb 2021 19:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E4CF911D544;
        Thu,  4 Feb 2021 19:56:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Optionally restrict range-diff output to "left" or
 "right" range only
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
        <xmqqtuqr4frw.fsf@gitster.c.googlers.com>
        <YBx5rmVsg1LJhSKN@nand.local>
Date:   Thu, 04 Feb 2021 16:56:16 -0800
In-Reply-To: <YBx5rmVsg1LJhSKN@nand.local> (Taylor Blau's message of "Thu, 4
        Feb 2021 17:48:14 -0500")
Message-ID: <xmqqtuqr2uz3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F45811C4-674C-11EB-B840-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Feb 04, 2021 at 02:41:39PM -0800, Junio C Hamano wrote:
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>> > One of my quite common workflows is to see whether an ancient topic branch I
>> > have lying about has made it into Git. Since my local commit OIDs have
>> > nothing to do with the OIDs of the corresponding commits in git/git, my only
>> > way is to fire up git range-diff ...upstream/master, but of course that
>> > output contains way more commits than I care about.
>> > ...
>> Makes sense.
>
> I'd add an additional use-case, which is ignoring new commits from
> upstream when displaying a range-diff in rerolled patch series.
>
> Oftentimes I'll find that the automatically-prepared range diff that
> 'git format-patch --cover-letter --range-diff' generates will include
> new commits from upstream, so these new options should help me ignore
> those in the output.

Do you mean that the new round is based on an updated upstream
commit, while the old series was based on a bit older upstream?
After rebasing your topic, "range-diff @{1}..." would find the
updates in the base (made in the upstream) plus the new round of
your work on the right hand side of the symmetric range, while the
left hand side solely consists of your old round (unless the
upstream rewound their work, which should not happen).  But that
must not be it, I guess, because in such a case, among the commits
in @{1}..HEAD, we cannot (eh, at least range-diff cannot) tell which
one came from upstream and which one came from our fingers.

So I am a bit puzzled there.

> As an aside: I am curious if I'm missing something when you say the
> "only way" is to ask for a 'git range-diff ...@{u}'. IIUC what you're
> describing, I often resort to using 'git cherry' for that exact thing.
> But, I may not be quite understanding your use-case (and why git-cherry
> doesn't do what you want already).
>
> My latter question is purely for satisfying my own curiosity; I don't
> have any problem with a '--{left,right}-only' option in range-diff. From
> my quick read of the patches, it all looks pretty sane to me.

The question is addressed to Dscho, and I am also somewhat curious.
Perhaps the reason would be that the output from cherry is not as
easy to read as range-diff, without any post-processing.

I do find "range-diff ...@{u}" a bit too blunt and heavy a hammer
for that task, but as they say, when you are familiar with and fond
of a hammer, all tasks look like nails ;-).

