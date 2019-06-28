Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE7D1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 18:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfF1SFK (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 14:05:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57339 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfF1SFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 14:05:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8E0982388;
        Fri, 28 Jun 2019 14:05:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ekiJhJ/WRnU5uo09H0rI1JHkJiU=; b=KcVUHp
        m6kuMnZduSflcyTrM7BD8fQxhUXXS+Q8lKYj1eW2cie8loY+RcmEyMH7a/51KgMd
        +m+4qdTNP65u2DMczT1JPwVuZlT6iKiL9uZEv+NHjeZhl1XNS0GJ6I8okMk7r0CZ
        bupP7OeiF6gyiH7wACiUPWhPWORKYP+vY249k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QJoMEGD0YqtGm+A/NzRkytCBLWOHH3vu
        Xj12r/EfYuA7CcC+Vx6yfLHHuWpOJ2B/HEXoubcn62Qr6K9coVC5Pe5BWf/VUGtQ
        Q5jd8XtexO4naaYIMQ75/iQJB2+78tGrh5hs1qAtS0xWjZ5qHY364vfOjznDHFbg
        Qyuxl3dS9fs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFE8F82387;
        Fri, 28 Jun 2019 14:05:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1060B82386;
        Fri, 28 Jun 2019 14:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
References: <20190628093751.GA3569@sigill.intra.peff.net>
        <20190628093911.GA27329@sigill.intra.peff.net>
        <2d4410a9-fd3e-8b9f-00b5-f8eba4d51b42@gmail.com>
Date:   Fri, 28 Jun 2019 11:05:03 -0700
In-Reply-To: <2d4410a9-fd3e-8b9f-00b5-f8eba4d51b42@gmail.com> (Derrick
        Stolee's message of "Fri, 28 Jun 2019 08:35:28 -0400")
Message-ID: <xmqqh8898u28.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42480C24-99CF-11E9-99DF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> way to do this loop. The top thing on my mind are the 'eval "echo X"'
> lines. If they start processes, then we can improve the performance.
> If not, then it may not be worth it.

Sigh.  

Do you mean 'echo' run inside 'eval' is one extra process?  In most
modern shells, it is a built-in and you need another process.

Do you mean 'eval' running anything is one extra process?  Because
anything done inside eval must be visible to the shell running it,
e.g.

	var=myvar; eval "$var=val"

would evaluate string 'myvar=val' inside that shell itself and it
must be able to update the value of $myvar, whatever it does must
not add any extra process.

The primary reason why the loop in question uses eval is to allow
the callers to pass $n in single-quote to have it interpolated
lazily.

	message='message $n'
	for n in 1 2 3
	do
		echo "$message"
		eval "echo \"$message\""
	done

Each iteration, the first line gives

	message $n

which is the thing that gets passed to 'echo' in the second line, so
you'll see

	message $n
	message 1
	message $n
	message 2
	message $n
	message 3

as the result.
