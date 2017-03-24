Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3636E1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 16:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966104AbdCXQMD (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 12:12:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51783 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936279AbdCXQLC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 12:11:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F75673FBB;
        Fri, 24 Mar 2017 12:10:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BUd2feUIGv0hNLDqIVqi7aS/wXg=; b=JAz/++
        yWIdix0+e91JfU87Gvbid/a0/wBeoWlNEJQrAg9xGEVHzTiRucCl0ONC+g7R+S2Y
        zd3ohlwqg94DB6sudclRgUNXiHSrJRNfzqMF4jddY3/ICKALUW4t0hziENlsJfki
        S9HgZWlZ2nW2/J1eI3g2ky7wk4u7XFQbhS/iY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lQypHFNipHGt7Bsa5J9FbqwUiQZeCs4t
        VjFmi+//kDjWTRY4joWdJdGbo1eRvnhn8V0HhNXVEiYF6WZbGdnUXBjnt9F/Nxhy
        XK7vX7usd7IyAQtam8q7q1D4qzkbzbKcJ4zTeCBUduDCV+xZgA+fZ31w2ChUGqN+
        vMMJ74X3L7k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7835473FBA;
        Fri, 24 Mar 2017 12:10:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDE2C73FB9;
        Fri, 24 Mar 2017 12:10:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Ben Peart <peartben@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder\@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/3] sub-process: refactor the filter process code into a reusable module
References: <20170322165220.5660-1-benpeart@microsoft.com>
        <20170322165220.5660-3-benpeart@microsoft.com>
        <xmqqk27gfrga.fsf@gitster.mtv.corp.google.com>
        <BL2PR03MB32308D0F2BB1C7D6F04141BF43E0@BL2PR03MB323.namprd03.prod.outlook.com>
Date:   Fri, 24 Mar 2017 09:10:22 -0700
In-Reply-To: <BL2PR03MB32308D0F2BB1C7D6F04141BF43E0@BL2PR03MB323.namprd03.prod.outlook.com>
        (Ben Peart's message of "Fri, 24 Mar 2017 12:39:07 +0000")
Message-ID: <xmqqpoh68xld.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62FC2454-10AC-11E7-B5AD-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> How about I squash the last two patches together so that its more
> apparent that it's just a refactoring of existing code with the before
> and after in a single patch?

I do not think making a pair of patches, each already does too much,
into one patch would make things easier to chew.  It would make it
even harder to understand.

I offhand do not know how many patches the ideal split of this
series should be, but I know it shouldn't be one.

More likely that it should be N+1, and I know the last one should be
"Now all data structures and variables have been renamed, all helper
functions have been renamed and generalized for reuse while the
original code these helper functions came from have been updated to
call them, we can move them from convert.c to sub-process.[ch];
let's create these two files".  This last step will be moving lines
from an old file to two new files, almost without any modification
(of course, "#ifndef SUB_PROCESS_H", "#include sub-process.h", etc.
would be new lines so this will not be strictnly pure movement, but
all readers of this message are intelligent enough to understand
what I mean).

What would the other N patches before the last step should contain,
then?

For example, your name2process_cmp() is just a renamed version of
the original.  Some of its callers may also just straight rename.
These "only renaming, doing nothing else" changes can go into a
single large patch and as long as you mark as such, the review
burden can be lessened.  It would be a "boring mechanical" part of
the whole thing.

On the other hand, your subprocess_start() shares quite a lot with
the original start_multi_file_filter() but the latter does some more
than the former (because the latter is more specific to the need of
convert.c).  

A patch series must be structured to make it easier to review such
changes, because they are the likely places where mistakes happen
(both in implementation and in the helper API design).  To get from
the original start_multi_file_filter() to a new version that calls
subprocess_start(), such a patch would _MOVE_ bunch of lines from
the old function to the new function, the new function may acquire
its own unique new lines, the old function would lose these moved
lines but instead call the new function, etc.  You can call it as "I
refactored subprocess_start() out of start_multi_file_filter() and
updated the latter to call the former." and that would be a single
logical unit of the change.  To make patches easier to understand,
these logical unit would want to be reasonably small.

And for something of sub-process.[ch]'s size, I suspect that it
would have more than 1 such logical unit to be independently
refactored, so in total, I would suspect the series would become

    1 (boring mechanical part) +
    2 or more (refactoring) +
    1 (final movement)

i.e. 4 or more patches?
