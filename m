Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAD72208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 01:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbdIFBwt (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 21:52:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60229 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753361AbdIFBws (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 21:52:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 244E7AF98D;
        Tue,  5 Sep 2017 21:52:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+GxHum8aox5jZHB/IMmZ2DkJZpI=; b=dKR7kp
        pL6oUH39clueA3bu1C+FiHc3QMUaNfOM8htcjEpA+GrVjzH5MM5dwaQiwnVJOZGo
        G0aXxyiWS3aJhaFG3qVqcwD9C3K81sTMwincZyT7vDK0tCgwSIC8i4OgYXd9tB0T
        5ePa3Wpar2Smhg9UElQpk+PSZydE22CI8Xtek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f5MPPz7p4oDfuz81LgGnwrFSbFdkYGdk
        II3PHmafYI0gPybqRSljKvY7vLQe59I24VFFpZ9QHXrWm79cOh5HAtkRMeiAY1a/
        f60P38+rbxoGskZBX5cU7E8goOCk1kAAuZMOhvlHDRXG+fM52HWqKLHJot9EcKOb
        g617VfQXI/I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CC00AF98C;
        Tue,  5 Sep 2017 21:52:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82067AF98B;
        Tue,  5 Sep 2017 21:52:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] parse-options: warn developers on negated options
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
        <20170905230845.17108-1-sbeller@google.com>
Date:   Wed, 06 Sep 2017 10:52:46 +0900
In-Reply-To: <20170905230845.17108-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 5 Sep 2017 16:08:45 -0700")
Message-ID: <xmqq8thsa901.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 152B71EA-92A6-11E7-98A2-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>   This patch disallows all no- options, but we could be more open and allow
>   --no-options that have the NO_NEG bit set.

"--no-foo" that does not take "--foo" is perhaps OK so should not
trigger an error.

A ("--no-foo", "--foo") pair is better spelled as ("--foo",
"--no-foo") pair whose default is "--foo", but making it an error is
probably a bit too much.

Compared to that, ("--no-foo", "--no-no-foo") pair feels nonsense.

Having said that, because the existing parse_options_check() is all
about catching the programming mistake (the end user cannot fix an
error from it by tweaking the command line option s/he gives to the
program), I do not think a conditional compilation like you added
mixes well.  Either make the whole thing, not just your new test,
conditional to -DDEVELOPER (which would make it possible for you to
build and ship a binary with broken options[] array to the end-users
that does not die in this function), which is undesirable, or add a
new test that catches a definite error unconditionally.

