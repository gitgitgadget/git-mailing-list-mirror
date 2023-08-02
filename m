Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192F6C04E69
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 16:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjHBQdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 12:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjHBQdE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 12:33:04 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CDB2101
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 09:33:02 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C9DD19E8D7;
        Wed,  2 Aug 2023 12:32:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S4S63ELVNjMdUG3TTOv+EJodpr7BKblkl6KIzd
        Bbp2w=; b=iu+dzvtwuH2nsJuDLahw30eRtP9E/6rj0p1n5hFei8I8qbBEz5H/9V
        njbjMl7GHHdyjjv0ZjUrjb5R76fdJh+t0j6NdHWQpb9XmhtKe29MUNvWCyCdHqWv
        PNS3hqKjb6CPQcOJvDJOgHMU+EkByvwTqFsgAvFEWsBtm705EeXCo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 359C419E8D6;
        Wed,  2 Aug 2023 12:32:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9681319E8D5;
        Wed,  2 Aug 2023 12:32:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Question] git rev-parse verify for non-existent object
References: <CAOLTT8RvAbmS1SwFja8_+NSBBoL0gTH1RgpSN5CYtDWZscMYZA@mail.gmail.com>
        <CAP8UFD02tYrz+bxoR_GQfYuxxrmv5=BXjcZuiqXbX3m7N2dPaQ@mail.gmail.com>
        <CAOLTT8TXYpyadp=Z6K44G59iSar5ieyLwmSph4ypwxGo9doHYA@mail.gmail.com>
Date:   Wed, 02 Aug 2023 09:32:57 -0700
In-Reply-To: <CAOLTT8TXYpyadp=Z6K44G59iSar5ieyLwmSph4ypwxGo9doHYA@mail.gmail.com>
        (ZheNing Hu's message of "Wed, 2 Aug 2023 21:03:25 +0800")
Message-ID: <xmqq1qgl9zgm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DA423DC-3152-11EE-AEA7-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>>       --verify
>>           Verify that exactly one parameter is provided, and that it
>> can be turned into a raw 20-byte SHA-1 that can be used to access the
>> object database. If so, emit it to the standard output;
>>           otherwise, error out.
>>
>
> So why doesn't "git rev-list --verify" check if 20-byte SHA-1 can
>  "access the object database"?

Hysterical Raisins.

"rev-parse" can do many things, and one of them is about expanding
strings (like "9e4df4da", "jt/path-filter-fix", "seen~7^2", and
"9e4df4da0786797b1d51ed8fd3dfc18970772a91") given from the command
line into hexadecimal strings of the full length (they are often
called "revision").  "--verify" tells the command that on the
command line there must be ONE and only one "revision", give the
full length hexadecimal string for it.  The command fails if the
command line argument cannot be turned into a hexadecimal string of
the full length.

Now, among the ones given as examples in the above, "9e4df4da",
needs to look at the object database to turn it into a hexadecimal
string of the full length, because it is likely to be an abbrevation
(although it could be a branch name, too).  "jt/path-filter-fix" and
"seen~7^2" needs to look at the refs and probably into the object
database (to see what the 7th generation grandparent is and what the
second parent of that commit is) before they can be turned into
hexadecimal strings of the full length.

But "9e4df4da0786797b1d51ed8fd3dfc18970772a91" is already a full
hexadecimal, so it is given back as a "revision" without checking if
there is such an object in the object database.

Checking if it can be turned into the form that can be used to query
the object database, and checking the object database using it to
find out if such an object exists, are two distinct steps low-level
tool authors, who would want to use the plumbing tools, may need.
The current option set allows the separation (and ^{object} suffix
lets you do the both at the same time, too).

