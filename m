Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01E520229
	for <e@80x24.org>; Fri, 21 Oct 2016 19:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935010AbcJUTDQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 15:03:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51581 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754986AbcJUTDP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 15:03:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49A9148FA6;
        Fri, 21 Oct 2016 15:03:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+NfqAdZx1H75JUc1pD+vqYA6GXg=; b=aqeOwX
        zIkAC6vpaHAsPY7q/laaJl11m3Un9a+APyvJHN13LILtv9cuJRLGE2kgFispyS8x
        CtCCaAwO2wk8YnJXaiWLGqtMb31O0GQI2h/T/yNnZePYErnJcmRcvtQnlP8jRgaO
        Sp1sn12wDGT6GqKP2g9LKa+8NU+Zy7uaraQqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aWze4Snmz4ztbMBDab/EPQhpoLq/n/m8
        rYVe0wFNeqBq3P1gsMl8GY6f+vYOHboRqprIXeFB3nk6euolQLIY/9luEL2bi/bO
        YP3nhTewFLqcPwxu5B+6H6eAro0t0jBPURBG2bjFrOCPwjWPF5gcopDET2qfRV0Q
        q16/0rZkAZs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40D9148FA5;
        Fri, 21 Oct 2016 15:03:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A737548FA3;
        Fri, 21 Oct 2016 15:03:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: RFC Failover url for fetches?
References: <CAGZ79kaPdSfY_DXL6BDQ9pAma8p61r4m1n81VTxPHYi8zQuZfA@mail.gmail.com>
Date:   Fri, 21 Oct 2016 12:03:11 -0700
In-Reply-To: <CAGZ79kaPdSfY_DXL6BDQ9pAma8p61r4m1n81VTxPHYi8zQuZfA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 21 Oct 2016 11:19:42 -0700")
Message-ID: <xmqqeg39bk40.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 043E4212-97C1-11E6-9FE1-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So when pushing it is possible to have multiple urls
> (remote.<name>.url) configured.
>
> When fetching only the first configured url is considered.
> Would it make sense to allow multiple urls and
> try them one by one until one works?

I do not think the two are related.  Pushing to multiple is not "I
want to update at least one of them" in the first place.

As to fetching from two or more places as "fallback", I am
moderately negative to add it as a dumb feature that does nothing
more than "My fetch from A failed, so let's blindly try it from B".
I'd prefer to keep the "My fetch from A is failing" knowledge near
the surface of end user's consciousness as a mechanism to pressure A
to fix it--that way everybody who is fetching from A benefits.
After all, doing "git remote add B" once (you'd need to tell the URL
for B anyway to Git) and issuing "git fetch B" after seeing your
regular "git fetch" fails once in a blue moon is not all that
cumbersome, I would think.

Some people _may_ have objection based on A and B going out of sync,
especially B may fall behind even yourself and cause non-ff errors,
but I personally am not worried about that, because when somebody
configures B as a fallback for A, there is an expectation that B is
kept reasonably up to date.  It would be a problem if some refs are
expected to be constantly rewound at A (e.g. 'pu' in my tree) and
configured to always force-fetch, though.  A stale B would silently
set such a branch in your repository back without failing.



