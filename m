Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592DE20C11
	for <e@80x24.org>; Tue, 28 Nov 2017 02:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbdK1CZP (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 21:25:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65413 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752055AbdK1CZO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 21:25:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFF83A3E0E;
        Mon, 27 Nov 2017 21:25:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CKc5GIPI/b4SeHqQU1DAupFk3vY=; b=CaszQz
        5+dbezWUmxtKy8cr5UqPoP/5OxV+yE9tMsN5gNXefEdh9Bl5/lyU5gQZ/i7Ehew6
        uBv/YkIF0y9pSvqRz1S9V8WrAJ295XdUdlISEGRPYkA0TJALvN+40W5eBdgrec2s
        Qx/4qoY5j4Rh9w/cuASkA1Odq/KH7jT7AmjtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BoU4UETI+uP6yYL8H+qq2JrNX8gRMja1
        MlOguwi0/IMiPiPqAk/eObnwrkalO8/MikiXE9ylTu4Nu7ZFbecLd+YVDzOqi5r3
        n6e+fosZfYNO2JmCHpWZfa3n51HH6IaQHT7SCjq3eB/KKnqwxeUwbAtTsLADFMS2
        6nXzCb6WdE8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D91D3A3E0D;
        Mon, 27 Nov 2017 21:25:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 576ABA3E0A;
        Mon, 27 Nov 2017 21:25:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] rebase: give precise error message
References: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
        <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
Date:   Tue, 28 Nov 2017 11:25:12 +0900
In-Reply-To: <20171127172104.5796-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 27 Nov 2017 22:51:01 +0530")
Message-ID: <xmqqpo8387hz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D42151E-D3E3-11E7-80A3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> 1. "git rebase <upstream> <remote_branch>" does nothing

Not limited to "rebase", you do not muck with remote-tracking branch
in your local repository, so it would be a bug if the above updated
where the remote-tracking branch points at.

The form of "git rebase" with one extra argument (i.e. not rebasing
the history that leads to the current checkout) is mere shorthand of
checking that extra thing out before doing the rebase, i.e.

	$ git rebase origin/next origin/maint

first checks out origin/maint (you'd get on a detached HEAD) and
rebase the history leading to the detached HEAD on top of
origin/next.  If it fast-forwards (and it should if you are talking
about 'maint' and 'next' I publish), you'll end up sitting on a
detached HEAD that points at origin/next.

There is nothing to see here.

> 2. It's possible to do "git rebase <upstream> <commit>"

Again, that's designed behaviour you can trigger by giving <commit>
(not <branch>).  Very handy when you do not trust your upstream or
yourself's ability to resolve potential conflicts as a trial run
before really committing to perform the rebase, e.g.

	$ git rebase origin master^0

