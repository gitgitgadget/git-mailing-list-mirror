Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63390C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 17:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245239AbiBJRk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:40:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245237AbiBJRkW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 12:40:22 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CC3109B
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 09:40:23 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B13B107EA7;
        Thu, 10 Feb 2022 12:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dOOHo5T1dsuxcolGd7688585RW9Kx6aL19gUx4
        Khs8A=; b=p753kXHesBi0cUoqmahiZM70WDFM7KmGfncrMFHKEP0Qg54XJgcprZ
        OcfDzos4vmy1OJBj9UO+IPHLDEcE/g1Uf7DeHTyX4Yb1jfIcKBpinrCQH4iaRlLj
        lqYxs6RdvIrLo+IHlG7CK4l6HLsUepAxDnMqdO64hEJs2sZJps9l4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 606A1107EA5;
        Thu, 10 Feb 2022 12:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA0CB107EA4;
        Thu, 10 Feb 2022 12:40:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/8] fetch --recurse-submodules: fetch unpopulated
 submodules
References: <20220210044152.78352-1-chooglen@google.com>
        <xmqqsfsrw67a.fsf@gitster.g>
        <kl6lzgmzdrz2.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 10 Feb 2022 09:40:20 -0800
In-Reply-To: <kl6lzgmzdrz2.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 10 Feb 2022 16:51:45 +0800")
Message-ID: <xmqqleyivcvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8557F86E-8A98-11EC-B290-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> It is OK to allow fetching into submodule that is not currently have
>> a checkout, but I think we should view it purely as prefetching.  We
>> do not even know, after doing such a fetch in the submodule, we have
>> the commit necessary for the _next_ commit in superproject we will
>> check out.
>
> Hm, I may be misreading your message, but by "tip of random branch in
> the submodule", did you mean "tip of random branch in the
> _superproject_"?

No, I meant something like "git submodule foreach 'git fetch --all'"
(or without '--all' to fetch whatever the refspec there tells us),
i.e. tips of branches in the submodule.

>> The real question is not "in which submodules we fetch", but "what
>> commits we fetch in these submodules".  I do not think there is a
>> good answer to the latter.
>>
>> Of course, we we take this sequence instead:
>>
>> 	git checkout branch-with-submodules
>> 	git fetch --recurse-submodules
>> 	git checkout --recurse-submodules branch-with-submodules
>> 	
>> things should work correctly (I think we both are assuming that the
>> other side allows to fetch _any_ object, not just ref), as "fetch"
>> knows what superproject commit it is asked to complete, unlike the
>> previous example you gave, where it does not have a clue on what
>> superproject commit it is preparing submodules for, right?
>
> So, given my prior description of recursive fetch, we actually _do_ know
> which superproject commits to prepare for and which submodule commits to
> fetch.

Just to make sure I understand what is going on, let me rephrase.

 * To find out which submodule commits we need to fetch, we find new
   commits in the superproject we just fetched, inspect the trees of
   these commits to see gitlinks that name commits we need to fetch
   into the submodule repositories.

 * For that to work well, we need to know, from the path these
   commits appear in the trees of the superproject, to find out from
   which submodule to fetch these commits from.  And to make the
   mapping from paths to submodule names, we need to read
   .gitmodules from the same superproject commit we found the
   submodule commit in (as during the history of the superproject,
   the submodule may have moved around).

If so, I understand why being able to read .gitmodules from
superproject commits is essential.  The flow would become like

 (1) fetch in the superproject

 (2) iterate over each new superproject commit:
     - read its .gitmodules
     - iterate over each gitlink found in the superproject commit:
       - map the path we found gitlink at into module name
       - find the submodule repository initialized for the module
         - if the submodule is not of local interest, skip
         - add the submodule commit pointed by gitlink to the
           set of commits that need to be fetched for the submodule [*]

 (3) iterate over each submodule we found more than one commits that
     need to be fetched in, and fetch these commits (we do not have
     to go over the network to re-fetch commits that exist in the
     object store and are reachable from the refs, but "fetch"
     already knows how to optimize that).

Am I on the right track?

Thanks.
