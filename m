Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E527A20133
	for <e@80x24.org>; Sat,  4 Mar 2017 00:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbdCDA2N (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 19:28:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53342 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752026AbdCDA2I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 19:28:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7428167FE2;
        Fri,  3 Mar 2017 18:52:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xmxkOiYZZv/6YseL4xI+fJiq1Ys=; b=mzE8Dj
        6IinkdVL85gcvVZPq66pKmB44ozhY9v/d8hibD3xR8AH2nBMT3/GTN/nKra3ErLg
        JJ2rh/0Bu4qkKOIj0jW6yxm019Tlt8Wx2f/WACFIHc6Tt/JmPws+w66OgqUmSusJ
        POTLvuQ7V9bwTQ65KORxmudAoAPrZxbO6ZyZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QE8l5nNbqzGNNlOSbSTmujhGSP8jPI3a
        AVdNeU+YsSLbwEnt3T2DXPkt2MeLYffnhDkZge3CstEUy0RpA4tqi28pTizONFzU
        ZsfUaFX/2BKJ6QrTWlidZptYAoszQv3Xmef0Jxja58E1T+kQyYA2GgZOhoZoTor+
        J1e2fg3vavo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22CED67FDF;
        Fri,  3 Mar 2017 18:52:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 051E067FDE;
        Fri,  3 Mar 2017 18:51:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>
Subject: Re: bisect-helper: we do not bisect --objects
References: <xmqqvarq9vzo.fsf@gitster.mtv.corp.google.com>
        <D9E30A61FAC84D3B90981B388C9699D0@PhilipOakley>
Date:   Fri, 03 Mar 2017 15:51:58 -0800
In-Reply-To: <D9E30A61FAC84D3B90981B388C9699D0@PhilipOakley> (Philip Oakley's
        message of "Fri, 3 Mar 2017 23:27:45 -0000")
Message-ID: <xmqqd1dx7wbl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 647AE914-006C-11E7-89B4-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> Bikeshedding: If the given boundary is a tag, it could be tagging a
> blob or tree rather than a commit. Would that be a scenario that
> reaches this part of the code?

I do not think it is relevant.

Bisection is an operation over a "bisectable" commit DAG, where
commits can be partitioned into "new" (aka "bad") and "old" (aka
"good") camp, all descendants of a "new" commit are all "new", all
ancestors of an "old" commit are all "old".  Think of the "new"-ness
as a 100% inheritable disease that happens spontaneously and without
cure.  Once you are infected with "new"-ness, all your descendants
are forever "new".  If you know you are free of the "new"-ness, you
know that all your ancestors are not with the "new"-ness, either.

The goal of the operation is to find a "new" commit whose parents
are all "old".

The bisectability of the commit DAG is what allows you to say "this
commit is new" to a commit somewhere in the middle of the history
and avoid having to test any descendants, as they all inherit the
"new"-ness from it (similarly when you have one commit that is
"old", you do not have to test any ancestor), thereby reducing the
number of test from N (all commits in good..bad range) to log(N).

There is no room for a tree or a blob to participate in this graph
partitioning problem.  A "bad" tree that is "new" cannot infect its
children with the "new"-ness and a "good" tree cannot guarantee the
lack of "new"-ness of its parents, because a tree or a blob does not
have parent or child commits.
