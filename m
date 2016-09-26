Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 686F9207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 16:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933550AbcIZQFl (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 12:05:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60399 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750754AbcIZQFk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 12:05:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA9204010F;
        Mon, 26 Sep 2016 12:05:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K5/x7l12Aj36GBo6WUevM4IfSHU=; b=J7wSda
        zEmwsroIv1jwhBPZOEBlHUkzPtTh9r4BTKlHAjtZAW4ITFk9iDgqHuejHB5TaGip
        Rai61SNunVJkX3fs4mUb3zxUmoz0m6sylc3U/Hqers0aRhiRJJ23zX/t9mQzFijx
        /aWCcsT2u5DOb83rIskkCTtwNurCa6HKGogPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I8No/wJGxVWOrINmI+G0oLD3lowojar/
        OFKxZF/rJHahtVlOjGTgA3QZNAxjoSQoHRxZwEgPtGD2mwUKbRIhFFcsT7j0mWPs
        1zXzgwkGPIKk7T/er+VutqEq4qIPK0Gpr6m8CXun61m39E1Sp2o+AGBoGz0yEurQ
        VqJ75BDx9GA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D29744010E;
        Mon, 26 Sep 2016 12:05:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 581454010D;
        Mon, 26 Sep 2016 12:05:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Amodio <eamodio@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: Git blame provides incorrect previous commit if the line is uncommitted
References: <CAJxnqO6oMG2RvwP7y0Yt_xTrfeqqO6ZOUn5HWF7-h1hcjY+=bg@mail.gmail.com>
Date:   Mon, 26 Sep 2016 09:05:36 -0700
In-Reply-To: <CAJxnqO6oMG2RvwP7y0Yt_xTrfeqqO6ZOUn5HWF7-h1hcjY+=bg@mail.gmail.com>
        (Eric Amodio's message of "Mon, 26 Sep 2016 08:29:44 -0400")
Message-ID: <xmqqk2dyve7j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10D7E3C4-8403-11E6-86E7-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Amodio <eamodio@gmail.com> writes:

> This is the first time I've reported a bug with Git so please forgive
> me if this isn't the right place, format, etc.
>
> If git blame --porcelain (or --line-porcelain or --incremental) is run
> on a file that has uncommitted changes any uncommitted lines have the
> wrong previous sha. Instead of the sha the last time that line was
> changed or even the last time the file was changed it seem to return
> the last commit in the repository.

This is not limited to the case where uncommitted changes getting
blamed to the working tree, I think.  Replace C in the following
description with "a fictional commit C that would have made as a
direct child of HEAD if you were to commit all these uncommited
changes" and read on.

When the command finds that a line is attributed to commit C,
"previous" field in the internal data structure the command uses to
keeps track of the ancestry is shown there.  What the field means is
this:

    The command compared C (the final answer) with this "previous"
    commit (typically a parent of it, but when you use -S or
    --reverse option it may be different), and it was found that C
    introduced this line.

So, no.  "previous" is not "what would the result of running another
'git blame' on the state _before_ C to blame the general area?"  It
is meant as a hint for _you_ (rather, whatever tool is reading the
incremental output) telling where to run another blame if you want
to dig further, and it does not waste cycles to compute another
blame on each and every output to show that before being asked.
