Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2078B20A10
	for <e@80x24.org>; Fri, 29 Sep 2017 05:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdI2FAL (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 01:00:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54914 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751114AbdI2FAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 01:00:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 939AA9B3B6;
        Fri, 29 Sep 2017 01:00:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o1EMdraL5+T64CCzBSW3gkpA57U=; b=tmcc5L
        gqK9MzKFUaI/exaJLxLWJ2+GZSvKcV2FMOG9WIshF2q2z1fzGcdgO/PyCYzIgogI
        YRuqKiaL2E+bQygKoJINYgcje4Zh0uHKu+aMK3cZiYB08BjtkEhH/DJ6xkFA4bUv
        xNs0NY9y++ekYCglRJaS3XHO5CHTq6Ke6FiwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rtYKC/lgttLEu+Y8hU5eYn+pfqOeS2Y9
        Mrmotoc84F06lDk8fhMpvC6wga/RxjfFGB+up22wNXp53QUYI4xMBEcIiPVId2CT
        v7Ow/M6iQoU7rKMmbhFSvuaTMhkfR5TuiE/uQhxs+6oN4+nmxzHr+/mLsiPZh2vo
        T6V7MT/97AY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84BE19B3B5;
        Fri, 29 Sep 2017 01:00:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F6869B3B0;
        Fri, 29 Sep 2017 01:00:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dridi Boukelmoune <dridi.boukelmoune@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-sh: Avoid sourcing scripts with git --exec-path
References: <20170928223134.GA30744@varnish>
Date:   Fri, 29 Sep 2017 14:00:05 +0900
In-Reply-To: <20170928223134.GA30744@varnish> (Dridi Boukelmoune's message of
        "Fri, 29 Sep 2017 00:31:34 +0200")
Message-ID: <xmqqh8vmxfoq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10BEF62E-A4D3-11E7-A2DE-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dridi Boukelmoune <dridi.boukelmoune@gmail.com> writes:

> For end users making use of a custom exec path many commands will simply
> fail. Adding git's exec path to the PATH also allows overriding git-sh-*
> scripts, not just adding commands. One can then patch a script without
> tainting their system installation of git for example.

I think the first sentence is where you went wrong.  It seems that
you think this ought to work:

    rm -fr $HOME/random-stuff
    mkdir $HOME/random-stuff
    echo "echo happy" >$HOME/random-stuff/git-happy
    chmod +x $HOME/random-stuff/git-happy
    GIT_EXEC_PATH=$HOME/random-stuff
    export GIT_EXEC_PATH
    # then...
    git happy

But that is not the right/officially sanctioned/kosher way to add
custom git commands (adding your directory that has git-happy in it
to $PATH is).  GIT_EXEC_PATH is for the git-cmd binaries and scripts
we ship; it always is used to find non built-in commands, and even
for built-in commands, the command found via alias look-up is invoked
that way.

By insisting on overriding GIT_EXEC_PATH and not populating with
the stuff we ship, you'd need a workaround like your patch just to
make the scripts "work" again.  I have a feeling that even with your
patch you wouldn't be able to make non built-in commands, unless you
copy them (or write a thin wrapper that exec's the real thing).

So, instead of the two GIT_EXEC_PATH steps in the above example,
you can do

	PATH=$HOME/random-stuff:$PATH

and you'll see "git happy" to work, I would think, without breaking
other things.
