Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C45DC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 06:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiANG1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 01:27:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57351 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiANG1P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 01:27:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3485D10CAA2;
        Fri, 14 Jan 2022 01:27:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3+JkdfIETEWnHWgU2zT1jbWKaX+wlpWfk9Herj
        ybQ3A=; b=fkK1xvAYv949UVN6rrMejPWjJ6mpK0HrDbr542VYfTLMf3yjSXc5Q5
        eI5hRtzztgXU5sPeQiOqPfJRz4aFUzDcnLPGW00XYoK8pyFAlRS8q6ofPGxqA0km
        aMIS8YNdfRbwQm+8dHpXWNxju0gtvnDQ2vldpXhDyQ+/4vJ93dEIk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C7D110CAA1;
        Fri, 14 Jan 2022 01:27:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99E0610CAA0;
        Fri, 14 Jan 2022 01:27:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
References: <cover.1642129840.git.dyroneteng@gmail.com>
        <xmqqfspqeun5.fsf@gitster.g>
Date:   Thu, 13 Jan 2022 22:27:12 -0800
In-Reply-To: <xmqqfspqeun5.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        13 Jan 2022 21:47:10 -0800")
Message-ID: <xmqqy23ide7z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02F2A6DA-7503-11EC-B826-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Teng Long <dyroneteng@gmail.com> writes:
>
>> +test_must_fail 'Exchange the order of "--heads" and <remote>' '
>> +    git --version &&
>> +    git init "test.git" &&
>> +    test_commit -C "test.git" one &&
>> +    git -C "test.git" ls-remote --heads ./. > result.1 &&
>> +    git -C "test.git" ls-remote ./. --heads > result.2 &&
>
> I would say that this is working exactly as designed.  As with the
> unix tradition, after the command name, first come options
> (e.g. "--heads", "-v", etc. that begin with a dash or two dashes),
> then arguments like "origin", "master", "." that are not dashed
> options/flags.

I failed to say one important thing (I was again fooled by the "it
is too obvious to say" that led "gitcli" not to mention this, too).

"dashed-options first and then args" rule means that generally we
scan the command line from left to right one by one, and as long as
the one we are looking at begins with "-", we try to interpret it as
a dashed option, possibly eat the next one as an argument given to
the option (e.g. "--abbrev 7"), and keep repeating, until the one we
are at right now does not begin with "-".  And then everything after
that, we do not interpret it as an option.  That is how "--heads" on
the second example above, since we have seen . and took it as an
argument (not a dashed option) is considered as a pattern.

> ...
> Apparently, it is not a common knowledge at least for you (and
> probably others).  Perhaps we should add a paragraph to the cli help
> and explicitly mention "options first and then args", before we go
> on to say "among args, revs first and then pathspecs".

