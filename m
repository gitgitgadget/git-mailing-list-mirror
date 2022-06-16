Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780FAC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 21:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378315AbiFPVwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiFPVwY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 17:52:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5219E5DA3A
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:52:23 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 794CB1912E3;
        Thu, 16 Jun 2022 17:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9EHneiXIeJ6QYISi83aurqPEMtVJjM/tcwvgdu
        Z/r+8=; b=DXyDVGDQ3Q3ug8Md5zh45K1nr8v9Y69pk6OcqG6hpi3i7yPbwfBGUE
        XQXTlH6D9NBncliAbXkbBig/3he49VuHWXULMJl+rGc88lzrlXwl8mZ3eCmG5Rsa
        s/eRnoCVJUPlKtn2P59gZ6hhy8J8jdB/7ehvuVm+9L3SDaOyr5Kxo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71B8E1912E2;
        Thu, 16 Jun 2022 17:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 213721912E1;
        Thu, 16 Jun 2022 17:52:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Subject: Re: [PATCH] remote: handle negative refspecs in git remote show
References: <20220614003251.16765-1-jacob.e.keller@intel.com>
        <xmqqzgidy52c.fsf@gitster.g>
        <CA+P7+xpS0v9Oi3t4S76AcNRazdzJEEj6HxzO+z+dAFDPJ=yHJA@mail.gmail.com>
Date:   Thu, 16 Jun 2022 14:52:17 -0700
In-Reply-To: <CA+P7+xpS0v9Oi3t4S76AcNRazdzJEEj6HxzO+z+dAFDPJ=yHJA@mail.gmail.com>
        (Jacob Keller's message of "Thu, 16 Jun 2022 13:41:26 -0700")
Message-ID: <xmqqletwqnse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 980297E2-EDBE-11EC-BBFA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> This is somewhat curious.  Do we really need to destroy the
>> fetch_map like the above?  I know by removing skipped items from the
>> list, the existing loop (below) can stop having to worry about them,
>> but the caller of get_ref_states() may later want to iterate over
>> the full fetch_map for other reasons (even if the current one does
>> not, a future version of the caller may have a reason to do so that
>> we do not know right now yet).
>>
>
> Good point. I'll fix this. I think we can just move the
> omit_name_by_refspec into the other loop.
>
>> > +
>> >       for (ref = fetch_map; ref; ref = ref->next) {
>> >               if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
>> >                       string_list_append(&states->new_refs, abbrev_branch(ref->name));
>>
>> IOW, is adding a new condition to this existing loop insufficient?
>>
>
> The tricky part here is that we don't have a simple check, and we're
> currently iterating over all of the refspecs each time. But we have to
> do that regardless so I think this makes sense. Will fix.

Another thing that worries me is that get_stale_heads() will not see
the filtered refs with your original implementation, because you cull
them from the fetch_map in the extra loop upfront.

I do not know offhand what its effect would be, but it probably is
worth testing.  In your original scenario, if we locally have
refs/remotes/jdk19/old and refs/remotes/jdk19/pr/1 (perhaps obtained
before we configured ^refs/pr/* negative refspec), we'd want to see
that pr/1 exists here but will not be updated.

  * remote jdk19
    Fetch URL: git@github.com:openjdk/jdk19.git
    Push  URL: git@github.com:openjdk/jdk19.git
    HEAD branch: master
    Remote branches:
      master tracked
      old    stale
      pr/1   stale
      pr/2   skipped
      pr/3   skipped
    Local ref configured for 'git push':
      master pushes to master (fast-forwardable)
