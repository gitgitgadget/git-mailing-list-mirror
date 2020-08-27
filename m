Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60577C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD0B2080C
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WHsSpEaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgH0EVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:21:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51228 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgH0EVf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 00:21:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4957B6DD9B;
        Thu, 27 Aug 2020 00:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Pv06P4W74MwlvoCcgvkGMfNAwU=; b=WHsSpE
        aMDYVyDppeguqbkhrL9MonaxdphGWu6GROSHhzyweQmermbzf6evWvM9DX6uMTra
        YJlgBlsKRYLZ3d09knNNWud1efT436e5dL4Jayo6FkteGXjIs/+jq6XMmKseJF+d
        KYNzoVdRVVHQXM4bp41v0Bwg2WWmyEvSJNRZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WtcU1qrTsSrKb5f3M6MqONo9N3OTSbZm
        uTsQLklBuzcLTl8laNJyj2Uz4nIWmZYCCM327SaP8kgUUeoPoqPGvcINjgojITdk
        oExUtt4Tl1mn3KuEZ90ITxB5K0aq+EZcOu4rjNwZdxl7TRO8NUtkVaHh+oKK5J3K
        YhSRyrn+DWQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 407016DD9A;
        Thu, 27 Aug 2020 00:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABE716DD99;
        Thu, 27 Aug 2020 00:21:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean Barag <sean@barag.org>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH] clone: add remote.cloneDefault config option
References: <xmqqeentuqk5.fsf@gitster.c.googlers.com>
        <20200827033854.130005-1-sean@barag.org>
Date:   Wed, 26 Aug 2020 21:21:30 -0700
In-Reply-To: <20200827033854.130005-1-sean@barag.org> (Sean Barag's message of
        "Wed, 26 Aug 2020 20:38:54 -0700")
Message-ID: <xmqqpn7csoqd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C900BEF4-E81C-11EA-827A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean Barag <sean@barag.org> writes:

>> It is somewhat sad that we have the git_config(git_default_config)
>> call so late in the control flow.  I wonder if we can update the
>> start-up sequence to match the usual flow
>> ...
>> One oddity "git clone" has is that it wants to delay the reading of
>> configuration files (they are read only once, and second and
>> subsequent git_config() calls will reuse what was read before [*]) so
>> that it can read what clone.c::write_config() wrote, so if we were to
>> "fix" the start-up sequence to match the usual flow, we need to
>> satisfy what that odd arrangement wanted to achieve in some other way
>> (e.g. feed what is in option_config to git_default_config ourselves,
>> without using git_config(), as part of the "main control flow uses the
>> variable" part), but it should be doable.
>
> Sounds like a pretty big change! I'm willing to take a crack at it,
> but given that this is my first patch I'm frankly a bit intimidated :)
> How would you feel about that being a separate patch?

It definitely needs to be a separate patch.  

In order to realize any new feature that needs to read the existing
(i.e. per-machine or per-user) configuration files to affect the
behaviour of "git clone", whether it is the "give default to
--origin option" or any other thing, first needs to fix the start-up
sequence so that the configuration is read once before we process
command line options, which is the norm.  Only after that is done,
we can build the clone.defaultRemoteName and other features that
would be affected by the settings of clone.* variables on top, and
it is not wise to mix the foundation with a new feature that uses
the foundation.  So I would imagine it would at least be 3-patch
series:

 - [1/3] would be to whip the start-up sequence into the normal
   order.  This may be the most tricky part.  I identified that the
   handling of option_config might need adjustment, but there may be
   others.  This may not need any new tests, but if the existing
   tests for "clone -c var=val" do not catch breakage when we
   naively move the git_config(git_default_config) call early
   without doing any other adjustment, we might need to add more
   tests to cover the option.  If we find things other than
   option_config needs adjustment, they also need test coverage.

 - [2/3] would be to tighten the error checking of option_origin
   that was lost when the command was reimplemented in C (already
   discussed).  This would need new tests to see "--origin $bogus"
   command line option is flagged as an error.

 - [3/3] would be to read option_origin from the configuration file.
   The start-up sequence fixed by [1/3] would allow us to write the
   config callback in a more natural way, compared to what you wrote
   and what I suggested to rewrite.  Error checking code in [2/3]
   would directly be reusable in the code added in this step.  We'd
   need tests similar to we add in [2/3] for the configuration, and
   combination of configuration and command line (you already wrote
   most of these).

Thanks.


