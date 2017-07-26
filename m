Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27DA42047F
	for <e@80x24.org>; Wed, 26 Jul 2017 22:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbdGZWMO (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 18:12:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61892 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751553AbdGZWMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 18:12:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C89692883;
        Wed, 26 Jul 2017 18:12:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jii8LKoujThnwJ4ZbQfRXyCJJ7o=; b=nDXihr
        o1YvyJNSmU8Le/ntHGjb87xDhBpHr8sup6CZFS+rCTb5My3Kru9/7CBrsHEGV1c1
        I8B5SJHjfEBZSM66jWAdG7jFNzTn/HzMf0BbNPyhqrSlIiPNs6QSFspKi+3ToQYu
        8+PrvbHL5UVIoTgXjGl4wwgt442ooXmAHeVVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VMLB0wLc4B3qs8XHlQqFcHdh8j9baYVZ
        FVHlsa759MyYbWyvlzPZ5dQtYRWdENLODJQDAcAflUdTtMJW//+M9xJmRXvBglBO
        ntjM2/0i4mkUfmpGlw+ZUHHt7iN1tF7qMcWo8FT+vTY/cWttlZxRTvAbMZc57vKp
        TlncUzIMiv4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6426592882;
        Wed, 26 Jul 2017 18:12:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC62192880;
        Wed, 26 Jul 2017 18:12:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a rebase
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
        <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
        <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 26 Jul 2017 15:12:10 -0700
In-Reply-To: <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 26 Jul 2017 14:56:40 -0700")
Message-ID: <xmqq60eeq24l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 791A6DCC-724F-11E7-A4D2-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Hmph, this is interesting.
>
> "git rebase" does take "--rerere-autoupdate" option from the command
> line, and propagates it to a later invocation of "rebase --continue"
> by storing the value to $state_dir/allow_rerere_autoupdate file and
> reading the value from it.  $allow_rerere_autoupdate shell variable
> is used to hold the setting.  
>
> I'd expect that this variable to be used in invocations of "git am"
> in git-rebase--am.sh; but that does not seem to be the case.  I
> wonder if this was once working but over time we broke the feature
> without anybody noticing it, or if the support was added but not
> completed and the feature was a no-op from the beginning?

At least in v1.7.0 when doing "rebase -m", the rerere-autoupdate was
plumbed correctly through to the invocation of "git merge" that is
done inside git-rebase.sh.  I do not see the same option passed down
to the invocation of "git am", so perhaps nobody cared back then
about rerere during "git rebase" that does not use "git am" backend,
even though "git am" itself were capable of talking the option.

In any case, if you corrected the existing "git rebase" and its
backend so that "--rerere-autoupdate" works as advertised, I think
you are already 80% there without adding a yet another option, as I
suspect that the most of the need for avoiding "git add" during a
"git rebase" session is during a conflict resolution, and allowing
"rerere" to automatically update the index with auto-resolution will
leave _only_ changes to the paths the end user actually needs to
take a look and manually fix still not in the index.  And from the
workflow point of view, encouraging them to "git add" their manual
resolution after they are satisified with their changes by not doing
"git add" blindly for all changes, like your --autostage" does, is
probably a good thing.



