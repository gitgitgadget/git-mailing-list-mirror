Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD71F1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 21:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeAJVrT (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 16:47:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57637 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeAJVrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 16:47:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67846D311B;
        Wed, 10 Jan 2018 16:47:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZaCOgW4zVSg2YgXsDB6M/15O0jU=; b=Q5ZB9v
        3muiO4J9+CHY2u1p8HON0Dpwa83VpbMvC1r7pN5WAFrXabGFkxPvowTkqr80/OMb
        VjGFck/KYU6Asf9c4OOiFOYh8TB9eOOt+HRhGIIIxc8S6yskR6Qer39ZATWRUW/3
        ElFA9mlCrCIDm7wO31bI4OIFejRBWgkQKbykg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wvgo5m0WPiIJKteKc1oY58fxlyebMF3P
        J2x1e/2F6Q079Sm73341KMP+IWMt6E4gkegAzlzQH1HlsOhk5qGO9UPyZ0q12tMp
        P4hQIJWPduEv72K1WvTubmm++dzzNZNsduWWaNjMU5kl43SpVNm4glDhNmfFBl4o
        ZeRi8byIYUI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E8F2D311A;
        Wed, 10 Jan 2018 16:47:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BDC8FD3116;
        Wed, 10 Jan 2018 16:47:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v1 2/2] submodule: port submodule subcommand 'deinit' from shell to C
References: <20180109175703.4793-1-pc44800@gmail.com>
        <20180109175703.4793-3-pc44800@gmail.com>
        <xmqq7esq4tf6.fsf@gitster.mtv.corp.google.com>
        <CAME+mvXaL4AcK1ib2rDZKdH0eLc7te+3e9zYv8pNqNj-4cyT3Q@mail.gmail.com>
Date:   Wed, 10 Jan 2018 13:47:16 -0800
In-Reply-To: <CAME+mvXaL4AcK1ib2rDZKdH0eLc7te+3e9zYv8pNqNj-4cyT3Q@mail.gmail.com>
        (Prathamesh Chavan's message of "Thu, 11 Jan 2018 01:52:58 +0530")
Message-ID: <xmqqo9m1z8rf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4034806-F64F-11E7-B3CB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> Thanks for pointing out that we can introduce the flag REMOVE_DIR_KEEP_TOPLEVEL
> which solves the issue. And for the case where no directory exists: we
> create an empty
> directory.Since this won't be similar to what happens in the shell
> script, this change
> can be included in a saperate patch as an imporvement.

Exactly.  The way the shell script does it is to _always_ honor
user's umask and recreate the directory, so before that separate
improvement, tweaking "mode" based on the returned value from an
extra lstat() is an unneeded change of behaviour.  Just passing 0777
and let mkdir() take the umask into account to come up with the
final permission bits is more in line with the original scripted
version, I would think.

Thanks.

