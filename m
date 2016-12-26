Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C02E31FCC7
	for <e@80x24.org>; Mon, 26 Dec 2016 03:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbcLZDZO (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Dec 2016 22:25:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59619 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752480AbcLZDZN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2016 22:25:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D8715C2D3;
        Sun, 25 Dec 2016 22:25:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tm7KOqyJpws7gCyv/8xCCwJSj6I=; b=RFZFdq
        TIHG0S6assMhHH1zM+52lhW3XaiXQMqXUwgImxbqnpZaE1ae8tzm9fEeJaJKRNx6
        P50ZjcqfmsxAPrsNcalUgVgAc8NaIojmGQNsO7QEyOAoGGfr+xT+hprBUduy4eAR
        TJrTp9/GxdcQnXUj7Tkp3PM6Q4RQVNwq4tyyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mf3HViOSsyqtDgwbHHAazxo0NTrWBhap
        7FtsTzWL5IiBp5KiApkiGebP6ZdsnL31qTIlgPBYqRwpTfnQf6Tdw972VUeDwVAQ
        7kFX9TBHe+WLdNe2PtQEE+i4ZBkSDDQ3eTGdczRRKWab4/3G4esSoLBAUxfPuL65
        kY/4A9HVVYU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 828D55C2D0;
        Sun, 25 Dec 2016 22:25:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0319A5C2CF;
        Sun, 25 Dec 2016 22:25:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-apply: warn/fail on *changed* end of line (eol) *only*?
References: <ac97f925-d930-0592-0a2a-66c9218b1417@gmail.com>
Date:   Sun, 25 Dec 2016 19:25:10 -0800
In-Reply-To: <ac97f925-d930-0592-0a2a-66c9218b1417@gmail.com> (Igor Djordjevic
        BugA's message of "Mon, 26 Dec 2016 00:49:24 +0100")
Message-ID: <xmqqvau7cqy1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9032F8E-CB1A-11E6-8763-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic BugA <igor.d.djordjevic@gmail.com> writes:

> In short -- git-apply warns on applying the patch with CRLF line endings
> (new), considered whitespace errors, even when previous hunk version
> (old) has/had that very same CRLF line endings, too, so nothing actually
> changed in this regards. Even worse, it happily applies a patch with LF
> line endings (new) without any warning/hint, even though previous (old)
> line endings were CRLF, thus effectively (and silently) breaking the
> (previous) line endings.

Let me see if I understood your problem description correctly.

Imagine that the project wants LF line endings, i.e. it considers
that a line with CRLF ending has an unwanted "whitespace" at the
end.  Now, you start from this source file:

    1 <CRLF>
    3 <CRLF>
    5 <CRLF>

and a patch like this comes in:

     1 <CRLF>
    -3 <CRLF>
    +three <CRLF>
     5 <CRLF>

You think that "3 <CRLF>" was replaced by "three <CRLF>", and the
claim is "the 'previous' contents already had <CRLF> ending, so the
change is not making things worse".

But what if the patch was like this?

     1 <CRLF>
    -3 <CRLF>
    +three <CRLF>
    +four <CRLF>
     5 <CRLF>

Do you want to warn on "four <CRLF>" because it does not have any
"previous" corresponding line?

Extending the thought further, which line do you want to warn and
which line do you not want to, if the patch were like this instead?

     1 <CRLF>
    -3 <CRLF>
    +four <CRLF>
    +three <CRLF>
     5 <CRLF>

Extending this thought experiment further, you would realize that
fundamentally the concept of "previous contents" has no sensible
definition.

Incidentally, not realizing "there is no sensible definition of
'previous contents'" is a source of another often seen confusion by
new users of Git and any version control systems regarding the
"blame" feature.  When given the final answer by "blame", they often
say "what content did the line have _before_ the commit blame gave
me?"  As there is no sensible definition of 'previous contents' that
corresponds to the line, that question does not in general have a
sensible answer.
