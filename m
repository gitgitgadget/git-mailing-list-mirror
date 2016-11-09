Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F432021E
	for <e@80x24.org>; Wed,  9 Nov 2016 22:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754657AbcKIWZR (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 17:25:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55196 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752576AbcKIWZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 17:25:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D7724D22C;
        Wed,  9 Nov 2016 17:25:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yQ7MePBblWixgO22pOgMPyv/b1o=; b=UUM4ee
        BSo7jQ2crj6Oxddee5fTt4MhhJta/jqIP8s/n1uM3+PAGC04vxTBVmoC/hyj4xUO
        w7vyWdq6vjrvLfz31mZrpeR1tYnpKG2X3QyAc3omBQhtfocrVYjON2whO2QTjjeC
        hhzOPb6Mwe3w/FusNul3c/pEnQHaA9eRWHcZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pstKAEn52MBETuB7pz1J3l51t5YJNoIy
        iTZFmRBiOHfx7giKcWNSJabGGT3i8+OkMuTZukLD3qsgRIZbl/7mSTixSsAe8KAX
        /Ul7F9NKbGHRlkvmN/NQSe1YIuc5T/URVCozYXgfpiQj9UgiVygNg/VWj7UBQu9A
        QixZVc4pSRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C1EE4D225;
        Wed,  9 Nov 2016 17:25:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DD404D21E;
        Wed,  9 Nov 2016 17:25:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 32/36] pathspec: allow querying for attributes
References: <20161022233225.8883-1-sbeller@google.com>
        <20161022233225.8883-33-sbeller@google.com>
        <xmqqzilp63yh.fsf@gitster.mtv.corp.google.com>
        <CACsJy8C2MLg4ncLBXXJGf+=mPF_rRoKs2vN6=+chZeNeXWZsbg@mail.gmail.com>
        <CAGZ79kZ=9QeZLKKrH27U2iE9x3WxgVe4RvCZpbdzZriMArV6Sg@mail.gmail.com>
Date:   Wed, 09 Nov 2016 14:25:13 -0800
In-Reply-To: <CAGZ79kZ=9QeZLKKrH27U2iE9x3WxgVe4RvCZpbdzZriMArV6Sg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 9 Nov 2016 10:08:45 -0800")
Message-ID: <xmqqy40s8f5i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62AADB58-A6CB-11E6-9F9F-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Nov 9, 2016 at 1:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, Oct 28, 2016 at 1:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> ...
>>> The strategy this round takes to make it unnecessary to punt
>>> preloading (i.e. dropping "pathspec: disable preload-index when
>>> attribute pathspec magic is in use" patch the old series had) is to
>>> make the attribute subsystem thread-safe.  But that thread-safety in
>>> the initial round is based on a single Big Attribute Lock, so it may
>>> turn out that the end result performs better for this codepath if we
>>> did not to make any call into the attribute subsystem.
>>
>> It does sound good and I want to say "yes please do this", but is it
>> making pathspec api a bit more complex (to express "assume all
>> attr-related criteria match")? I guess we can have an api to simply
>> filter out attr-related magic (basically set attr_match_nr back to
>> zero) then pass a safe (but more relaxing) pathspec to the threaded
>> code. That would not add big maintenance burden.
>
> So with the current implementation, we already have the shortcut as:
>
>      if (item->attr_match_nr && !match_attrs(name, namelen, item))
>
> i.e. if attr_match_nr is zero, we do not even look at the mutexes and such,
> so I am not sure what you intend to say in this email?

I am not sure what relevance the "we call into attribute subsystem
only when there is any need to check attributes" obvious short-cut
has to what is being discussed.

The issue is specific to what preloading is about.  It is merely an
attempt to run cheap checks that could be easily multi-threaded with
multiple threads early in the program that we _know_ we would need
to eventually refresh the index before doing some interesting work.
A full refresh_index() will be done eventually, and because it needs
to trigger thread-unsafe part of the API, it needs to be done in the
main thread.  Doing the preload allows us to mark index entries that
do not have to be scanned again in the upcoming refresh_index()
call.  It is OK for preload-index.c::preload_thread() to skip and
not mark some index entries (iow, its sole purpose is to leave a
note in each index entry "this is fresh, you do not need to look at
it again", and it can choose to skip an entry, which essentially
means "this I didn't check, so you, refresh_index(), need to check
yourself").

preload_thread() for example skips index entries that needs to
trigger "racy Git avoidance" logic that is heavyweight (it has to go
to the filesystem and the object store), and it is a sensible thing
to skip because they are rather rare.

The message by Duy you are responding to was his response to me who
wondered if the attribute based pathspec match also falls into the
same category.  Just like racy Git code was deemed too heavyweight
to be called from preloading codepath and CE_MATCH_RACY_IS_DIRTY bit
was added as a way to ask ie_match_stat() API to avoid it (and hence
we are skipping, the caller is also telling "if you suspect a racy,
without checking for real, just answer 'I cannot say it is
clean/fresh'"), if we invent a new flag and pass it through
match_pathspec() down to match_pathspec_item() and have that if()
statement you quoted also skip match_attrs() for a pathspec element
with attribute based narrowing (as we are skipping, the flag may
also have say "instead of checking the attributes, just pretend that
the path did not satisfy the attribute narrowing"), would it benefit
the overall performance?

To answer Duy's "would it make sense to force the caller to create a
new pathspec from an existing one by filtering out pathspec elements
with attr-based narrowing?" question, I do not think it does.

