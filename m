Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07E6B2035F
	for <e@80x24.org>; Thu,  1 Sep 2016 20:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755007AbcIAUy6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 16:54:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59547 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753629AbcIAUyw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 16:54:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4D7C3AA96;
        Thu,  1 Sep 2016 14:37:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tAve5lITxVXdBYzBj+KV4vbxPaw=; b=VZWPpw
        oI6BqaVooEnPHfWoTDiHYFV2562uziS0inTpBP9kowLpejE952FLkXbDmYCfH3Ui
        5F02EZSdI/pAvxsmsyL3xhWZqS9VWaWJYGjq6gXn0wxtKIKPe/bTS6tF+KUnoJMM
        zh+V1KqrvJ2l9IVV6QpxacWhcORceb38bemtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wZMraKswBT4ZHIfqVNExslXZtCQ5KrTf
        qhZH4SsCMr0VzxpBrk/JtAQFc9D7jxgho7ljkeozVFJYf4nYFe+ogrQ54+slIT2o
        sYYN7D7Zr+NoKxnfe67NbZtDcbWHzAC7Y57qXrCrVO2kBCHIMnHf0ORC5ACu5btm
        LTvxDFLFaAM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBBC83AA95;
        Thu,  1 Sep 2016 14:37:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64DCE3AA94;
        Thu,  1 Sep 2016 14:37:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 09/22] sequencer: completely revamp the "todo" script parsing
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <163aaa2a64ddf6dfb28c77c821726e14cc78619e.1472457609.git.johannes.schindelin@gmx.de>
        <135c9ac7-49a6-8aa1-fc10-02c2a1fd0b1a@gmail.com>
        <CAGZ79kYP6jYyuEOwQPC6pcOxCMVNNQ24pVLoQVrv6nNrGsDTKA@mail.gmail.com>
        <alpine.DEB.2.20.1609010830110.129229@virtualbox>
Date:   Thu, 01 Sep 2016 11:37:05 -0700
In-Reply-To: <alpine.DEB.2.20.1609010830110.129229@virtualbox> (Johannes
        Schindelin's message of "Thu, 1 Sep 2016 08:35:50 +0200 (CEST)")
Message-ID: <xmqqinufwjou.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 160374E2-7073-11E6-9B83-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> git continue as a shorthand for `git <relevant-cmd> --continue` sounds great.
>
> Before we get ahead of ourselves:
>
> 1) this has nothing to do with the patch series at hand, and
>
> 2) if we were to introduce `git continue`, we would need to think long and
>    hard about the following issues:
>
> 	I) are there potentially ambiguous <relevant-cmd>s that the user
> 	   may want to continue?
>
> 	II) what about options? You can say `git rebase --continue
> 	    --no-ff`, for example, but not `git cherry-pick --continue
> 	    --no-ff`...
>
> 	III) Would it not be confusing to have a subcommand `continue`
> 	     that does *not* serve a *single* purpose? It's kinda flying
> 	     into the face of the Unix philosophy.

The above reasoning applies equally to "git abort".  I do not think
"git continue" would help.

If it were that anything you can do with Git can be --continue'ed
the same way (e.g. all uses one sequencer to rule them all), it
might be achievable, but I do not think it isn't, and will never be.

"git commit" may say "You haven't added anything yet" and refuse to
do anything.  Should "git continue" do "git commit -a" by noticing
that the last thing you tried to do was "git commit" and guess that
it is likely you wanted to commit all changes?  I think not.
