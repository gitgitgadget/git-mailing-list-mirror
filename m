Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5D12036B
	for <e@80x24.org>; Fri,  6 Oct 2017 06:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdJFGot (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 02:44:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64816 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751659AbdJFGos (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 02:44:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEFD19D463;
        Fri,  6 Oct 2017 02:44:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BXbapw1P95dEXH5aEoBqtj4sUCA=; b=pCAsip
        JKAHPYXhWVWJDJNLByK3bHIB/vquQto1C+RDvw0ONlVgm+wPwdHImgxbvbMaSWVL
        +W0U0DgK6wnV8RoquypQOi7bATp+HtQ4P5o8Y9gk2z26rFLrJauMd9rw5MBhcmF+
        /RbdeoiINEREMriRY7eg5hwcrqyHN5WP9e/6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vsKSAvY7clCTrNS8+QlE7Take0ycvSkf
        hFZZMuvc4bG0R1nEmyyIgA9Riu7ZBLz/QQ7K0yM3RMAmSLafd1zM0L656KfZSKbA
        sgPf50SfjP947UOyMlK5p0Ocq2uLUyXlvzF3WWQCaPuojXR8mbOAXgGtFfe9TsIL
        fBbAYV/0FUY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B36789D462;
        Fri,  6 Oct 2017 02:44:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B8139D461;
        Fri,  6 Oct 2017 02:44:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] interpret-trailers: introduce "move" action
References: <20171005132243.27058-1-pbonzini@redhat.com>
Date:   Fri, 06 Oct 2017 15:44:45 +0900
In-Reply-To: <20171005132243.27058-1-pbonzini@redhat.com> (Paolo Bonzini's
        message of "Thu, 5 Oct 2017 15:22:39 +0200")
Message-ID: <xmqq8tgowzaa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D815A7DE-AA61-11E7-8F62-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> The purpose of this action is for scripts to be able to keep the
> user's Signed-off-by at the end.  For example say I have a script
> that adds a Reviewed-by tag:
>
>     #! /bin/sh
>     them=$(git log -i -1 --pretty='format:%an <%ae>' --author="$*")
>     trailer="Reviewed-by: $them"
>     git log -1 --pretty=format:%B | \
>       git interpret-trailers --where end --if-exists doNothing --trailer "$trailer" | \
>       git commit --amend -F-
>
> Now, this script will leave my Signed-off-by line in a non-canonical
> place, like
>
>    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>    Reviewed-by: Junio C Hamano <gitster@pobox.com>
>
> This new option enables the following improvement:
>
>     #! /bin/sh
>     me=$(git var GIT_COMMITTER_IDENT | sed 's,>.*,>,')
>     them=$(git log -i -1 --pretty='format:%an <%ae>' --author="$*")
>     trailer="Reviewed-by: $them"
>     sob="Signed-off-by: $me"
>     git log -1 --pretty=format:%B | \
>       git interpret-trailers --where end --if-exists doNothing --trailer "$trailer" \
>                              --where end --if-exists move --if-missing doNothing --trailer "$sob" | \
>       git commit --amend -F-
>
> which lets me keep the SoB line at the end, as it should be.
> Posting as RFC because it's possible that I'm missing a simpler
> way to achieve this...

While I think "move" may turn out to be handy in some use case, an
example to move S-o-b does not sound convincing to me at all.  

If anything, the above (assuming that you wrote a patch, sent out
for a review with or without signing it off, and then after getting
a review, you are adding reviewed-by to the commit) does not
demonstrate the need for "move".  The use of "move" in the example
looks like a mere workaround that reviewed-by was added at the wrong
place (i.e. --where end) in the first place.

But that is not the primary reason why I find the example using
S-o-b convincing.  If the patch in your example originally did not
have just one S-o-b by you, but yours was at the end of the chain of
patch passing, use of "move" may become even more problematic.  Your
friend may write an original, sign it off and pass it to you, who
then signs it off and sends to the mailng list.  It gets picked up
by somebody else, who tweaks and adds her sign off, then you pick it
up and relay it to the final destination (i.e. the first sign-off is
by your friend, then you have two sign-offs of yours, one sign off
from somebody else in between, and the chain records how the patch
"flowed").  And then Linus says "yeah, this is good, I throughly
reviewed it."  Where would you place that reviewed-by?  Before your
second (and last) sign-off?  What makes that last one special?
Would it more faithfully reflect the order of events if you added
Linus's reviewed-by and then your own sign-off to conclude the
chain?

So I am not opposed to the idea of "move", but I am not sure in what
situation it is useful and what use case it makes it easier to use.
The example makes me suspect that what we want is not a new
operation, but a way to specify "where" in a richer way.
