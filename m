Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A401BC432BE
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 22:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8482B60F45
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 22:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhH2W50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 18:57:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58608 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhH2W50 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 18:57:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D90ADF1FB;
        Sun, 29 Aug 2021 18:56:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y6FP392xJOLnSPi+TDTviHxOa28sjIU1/ag6+M
        YViQA=; b=qpDNHPt2RZ3hGqiCAEVt7uJjqQUDbXwKGnccLhr7o8kA6PDpctUQPA
        GneIcgxVrTgseAhn24fv88typ3aDTV7XaNWECkJvz2GGvCdxhJXY6JiBsnQuohRK
        1GSuPdqtGNiVowVrsFHQhX0vNRLoteQ1FA+rW0TOQo63ZpNVwDxQ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8C3FDF1F8;
        Sun, 29 Aug 2021 18:56:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6313BDF1F6;
        Sun, 29 Aug 2021 18:56:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
References: <cover.1629821743.git.me@ttaylorr.com>
        <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
        <xmqqa6l6oafd.fsf@gitster.g> <YSVX18UXh9vX+Zhp@nand.local>
        <xmqqr1eimtrp.fsf@gitster.g> <YSVjnSDaBXgXvT9W@nand.local>
        <xmqq35qymrcn.fsf@gitster.g> <xmqqy28qlcow.fsf@gitster.g>
        <YSVuUYFh7lmhNlEy@nand.local> <xmqqo89jbf49.fsf@gitster.g>
        <YSko4OwwPb7MwEMa@nand.local>
Date:   Sun, 29 Aug 2021 15:56:31 -0700
In-Reply-To: <YSko4OwwPb7MwEMa@nand.local> (Taylor Blau's message of "Fri, 27
        Aug 2021 14:03:12 -0400")
Message-ID: <xmqq4kb797xc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A87A240-091C-11EC-B66A-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Aug 26, 2021 at 11:01:26PM -0700, Junio C Hamano wrote:
>> It seems that the *.rev test (probably added by the other topic that
>> is a single patch fix) fails under sha256 hash.  I am not going to
>> dig it any further myself, but for the interested, CI breakage is
>> here:
>>
>>   https://github.com/git/git/runs/3440068613?check_suite_focus=true#step:5:1219
>>
>> Thanks.
>
> I saw the same error myself when integrating that patch into my series.
> I discussed it more in [1], but the failure is basically caused by the
> midx code using the_hash_algo even when operating in a different
> repository via --object-dir.
>
> If the_hash_algo doesn't match (as is the case when using `--object-dir`
> to point at a SHA-256 repository when invoking the builtin from a
> repository using SHA-1 or outside of a repository altogether), then
> we'll fail when trying to open the pack indexes.

My recollection is that "--object-dir" is mostly about the alternate
odb usecase---am I correct?  It is unfortunate that we didn't start
with "alternate repository" and said "we only care about the objects
in the object store they have, and we do not have to care what refs
they point into their object database or what configuration they
have" instead.

I wonder if it is safe to assume that in practice a directory given
to the "--object-dir" option is always the "objects" subdirectory in
a repository, and it is an error if there is no "config" file next
to the directory.  Then, we could check ../config relative to the
given directory and error out if they use different hash.

I do not recall offhand how careful link_alt_odb_entries() is, but I
suspect it isn't at all (back when I invented it, there weren't need
for configuration to switch between hashes, and since then I do not
recall seeing any heavy update to the alternate odb code).  Perhaps
we should tighten it so that we check the accompanying "config" file
first and ignore the entry with incompatible "hash" (and we may
later discover other trait on a repository that is incompatible with
the current one)?

Thanks.




