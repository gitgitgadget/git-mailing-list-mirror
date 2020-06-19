Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A61EC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15912100A
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f7VrnaMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbgFSUbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:31:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56728 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387641AbgFSUbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 16:31:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BCD571C21;
        Fri, 19 Jun 2020 16:31:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NqBOgkiY3nAbiGcG5cW5NmhPPBg=; b=f7Vrna
        MAWZuGNKZgJVAUmkZ8OwUPxM8blnhgR72ozUusn/x5vBwxbB77DhnIs5vcZTL2L7
        MgLmwUCKxFRKXW3dosiPCHeIVUCn4V+5KIx0A1o/Tfl9WpcKZCvqONUjAJkX8NhF
        u7GpbarxFP7RbHjSY2/EHRy1CJ/lE2w2H//vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uz+a+Lr4qqb+ujWppRKH+WlOT2vvXzQB
        sYpJGG1kxT0YRwme95Mev6IqL580Q2ZSiwfaM6Bof5+Sk/+enHYHoiYqYtXpfybi
        BbNF5Jq8Aqtj+urhXMXg+W+ifQF+lndJLtN2dn/UFGe74yynl1bbp40FeKQX55M+
        0HO/tVjEAak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34A1B71C20;
        Fri, 19 Jun 2020 16:31:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BCFD971C1F;
        Fri, 19 Jun 2020 16:31:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Annoyance wrt ref@{1} and reflog expiry
References: <xmqqzh8zgcfp.fsf@gitster.c.googlers.com>
        <87o8pe3ou6.fsf@osv.gnss.ru>
Date:   Fri, 19 Jun 2020 13:31:42 -0700
In-Reply-To: <87o8pe3ou6.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        19 Jun 2020 21:14:25 +0300")
Message-ID: <xmqqwo42g5ld.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3003C1C-B26B-11EA-81D7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> But then if you do
>>
>>     $ git reflog expire --expire=now refs/heads/newbranch
>>     $ git commit --allow=empty -m two
>>     $ git show -s newbranch@{1}
>> ...
>> And it is unintuitive.  It is understandable to the users that all
>> the ref history before "reflog expire" is lost---it was what the end
>> user asked Git to do.  But after creating one commit on the state
>> (or do anything else that moves the ref) and finding it regrettable,
>> "git reset --hard @{1}" should be a viable way to recover from the
>> mistake made _after_ the reflog entries were expired.

And the expiration does not have to be --expire=now; what happens
more often is when I expire entries older than (say) a week, the
reflog for a topic branch that hasn't seen any activity may become
empty.  Then I "git am" the new round on the same base, compare and
then update, perhaps like so:

    ... git reflog expire has emptied the log for so/topic ...
    $ git checkout so/topic
    $ git log master.. ;# remind myself what the previous round had
    $ git checkout master... ;# detach HEAD at the previous base
    $ git am -s ./+so-v2-topic ;# apply
    $ git range-diff @{-1}... ;# compare
    $ git checkout -B so/topic

Now, I'm used to see this work after the above:

    $ git range-diff @{1}... ;# compare again just to be sure

but because there is only one entry in the reflog, which was created
when the last "checkout -B" updated the so/topic branch, "there is
only one entry" error kicks in.

> Makes sense. The first solution that comes to mind is immediately record
> current state after "reflog expire", so that there will be 2 entries for
> the case in question.

Perhaps.  

Or we could change the lookup side to use the value of the ref
itself when asked for @{0}, and use the "old" side of the only entry
when asked for @{1}.  That way, we do not need to play games with an
artificial entry at all, which may be a better solution.

I dunno.
