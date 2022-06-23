Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DCC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 16:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiFWQTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiFWQTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 12:19:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5300419FAC
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 09:19:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE4BD1A5B2B;
        Thu, 23 Jun 2022 12:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GKLNAWBIO4DtsKldFCg5kq5zm9GqfADXDzomji
        aWwkI=; b=evHrR2Y3ZIOtZFqt2Slm0M3Yb4V9DBTP+7bwLOVGpOXT/KVzqNY4rN
        ROqrdXaNev39Ulekbst1cIAkAAk1fp2cZ7AhrWyklam1aT0mgWwvsM2HFR6HMvhb
        JEL1vWmyUln5Z4auOsIvFU+eT78H/UkYoh7eXv481ocUvMuyneFJE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A73961A5B2A;
        Thu, 23 Jun 2022 12:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 48C341A5B29;
        Thu, 23 Jun 2022 12:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        newren@gmail.com
Subject: Re: [WIP v3 0/7] mv: fix out-of-cone file/directory move logic
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
        <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
        <d3aa35e4-5bad-2bbb-2a25-d82064d6ec81@github.com>
        <553ea547-9641-eb95-a474-db046fdc05dc@github.com>
Date:   Thu, 23 Jun 2022 09:19:38 -0700
In-Reply-To: <553ea547-9641-eb95-a474-db046fdc05dc@github.com> (Derrick
        Stolee's message of "Thu, 23 Jun 2022 11:06:47 -0400")
Message-ID: <xmqqr13f1het.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47E8E430-F310-11EC-9FA1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 6/21/2022 7:30 PM, Victoria Dye wrote:
>> Shaoxuan Yuan wrote:
>>> But I think it worth discuss if we should implement in-cone to 
>>> out-of-cone move, since it will be nice (naturally) to have it working.
>>>
>>> However, I noticed this from the mv man page:
>>>
>>> "In the second form, the last argument has to be an existing directory; 
>>> the given sources will be moved into this directory."
>>>
>>> I think trying to move out-of-cone, the last argument has to be an non-existent
>>> directory? I'm a bit confused: should we update some of mv basic logic to 
>>> accomplish this?
>>>
>> 
>> I suspect this requirement is related to the POSIX 'mv' [1] (and
>> corresponding 'rename()', used in 'git mv'), which also requires that the
>> destination directory exists. I personally don't think this requirement
>> needs to apply to 'git mv' at all, but note that changing the behavior would
>> require first creating the necessary directories before calling 'rename()'. 
>> 
>> As a more conservative solution, you could do the parent directory creation
>> *only* in the case of moving to a sparse contents-only directory (using
>> something like the 'check_dir_in_index()' function you introduced to
>> identify).
>> 
>> I'm also interested in hearing what others have to say, especially regarding
>> historical context/use cases of 'git mv'.
>> 
>> [1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/mv.html
>
> I wanted to reply here to maybe get more attention on this point.
>
> My personal opinion is that `git mv` should move to the location requested,
> even if it requires adding parent directories. Changing that behavior might
> need to come as its own topic, before doing the in-cone-to-out-of-cone work.
> Knowing if this behavior can change (or must stay the same) informs how that
> sparse case will work.

When a particular checkout excludes directory, say, Documentation/,
from its cone of interest, we may not have that directory in the
working tree.  In such a scenario, if you did 

    $ git mv new.txt Documentation/technical/

the index may not even know if "Documentation/" (which most likely
is represented as a sparse "tree entry in the index") has the
"technical" subdirectory in it, so it may have to expand it
on-demand.  I do not have an objection against making it easier for
users to do this.

As part of its implementation, you may have to do an equivalent of
"mkdir -p Documentation/technical/" before you can even materialize
the "new.txt" file in the directory.  I do not think that breaks the
parallel to POSIX "mv" in that case, as Documentation/technical/ is
*NOT* really a destination directory that does not exist.
Conceptually, the directory (and all the directories in the full
tree) exists---it is just the sparse-checkout is hiding it from the
view.

A corollary to the above is what should happen when you did

    $ git mv new.txt Documentation/no-such-directory/

i.e. you try to do a move that would fail even if you weren't using
the sparse-checkout feature.  I think that *SHOULD* fail, if we
wanted to be parallel to what POSIX "mv" does.

Thanks.








