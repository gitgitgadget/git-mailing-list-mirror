Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29CDD207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 16:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbcILQBc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 12:01:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60227 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751962AbcILQBa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 12:01:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2174B39A57;
        Mon, 12 Sep 2016 12:01:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=91NPTD195qbBB7ePsxxjeR996Lk=; b=SGaKYh
        VNBGoOjoBjDbs+3hIRBX3XIjxfv1KS9oeCpU6v8ntO256PcQzlM4dXZEdLGQ+gwa
        szyD8/TjiYvAwSKHYVpume6/p197pu1N3WHY8mDE+ylZZNrVwSik96bpQ9BbQSMf
        wIEQIEq+0cy6ryMZUJ8m1hrqF/gqVYB2kq4w8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C2fPqw+eHGLdk5RsQdMW4ZDOWHSQBxbM
        lkVnyRxb59QBSMErwAmAYAQ1GWcH3PlshDvY5Au73wr3PWaw6NOGx6JCMCCdOFVm
        w3qHh5lySEAnjGzFuM5laoEvAIRXyKc0hmbgPl+vnTQK+UvMyYYocvPXssu64cHv
        jU9MQ6aWxs4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A59439A55;
        Mon, 12 Sep 2016 12:01:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86B2739A54;
        Mon, 12 Sep 2016 12:01:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] ls-files: adding support for submodules
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
        <xmqqh99o8ypm.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaWNykEAZcjZ2Y19j2_3TF+qcz+vb8zSi1U+me3k+06LA@mail.gmail.com>
        <xmqqmvje6qbe.fsf@gitster.mtv.corp.google.com>
        <20160912005106.fj7adhmtfklv4vir@sigill.intra.peff.net>
        <20160912005229.6njhgfq7h6cb34s4@sigill.intra.peff.net>
Date:   Mon, 12 Sep 2016 09:01:26 -0700
In-Reply-To: <20160912005229.6njhgfq7h6cb34s4@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 11 Sep 2016 20:52:30 -0400")
Message-ID: <xmqqmvjd3y5l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A2A3D42-7902-11E6-A15E-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I do not use submodules myself, but I could imagine that you may have
>> scripts outside of git that do not care about the submodule divisions at
>> all, and would be happy with the flat block. ...
>> git-grep does not (I don't use "ack", but perhaps "git ls-files
>> --recurse-submodules -z | xargs --null ack ..." is something people
>> would want to do).
>
> None of that negates your point, btw, which is that this does not seem
> like a great building block for "git grep --recurse-submodules". Just
> that it seems plausible to me that people could find recursive
> "ls-files" useful on its own.

I do think it is a good argument why ls-files (with or without -z)
that recurses into submodules would help "git grep" that does not
look at the object store and does the search in the working tree
files that are tracked.  In normal Git world view, if you want a
list of files that are tracked, you are the one who is supposed to
go to the repository and look at the index there, but if you can
somehow magically get that list out-of-band, the "in the working
tree files" mode of "git grep" can work just like the "xargs -z ack"
pipeline in your example.

So I tend to agree that the enhancement in question is a useful
thing on its own, at least the part that gives a list of paths in
the index.

I do not know if all other operationg modes are useful, though.  For
eaxmple, the mode that lists untracked paths might be useful to do a
recursive "git clean".  On the other hand, "ls-files -s" with the
patch may produce the "correct" result (i.e. the object name given
for each path would be the same one that are found in the index of
the submodule the path was taken from), but the correctness may not
necessarily translate to usefulness, exactly because you need to
know which submodule's repository has the named object that is not
given by the flattened list.

Having to say that "this command produces correct result, but not
all correct things are necessarily useful" makes me wonder if that
is the direction in which we would want to go.  For example, what
would be our answer to an end-user question: I now know that the
recursive ls-files can give me all the untracked files in the
top-level and submodules.  How can I feed that to "git add" to
update their respective index files with them?

I am not convinced that we would always want to make "git add
lib/Makefile" to automagically run "git -C lib/ add Makefile" when
lib/ is a submodule (for that matter, even if we wanted to, I do not
know if that is something we can efficiently do with pathspecs that
have wildcards).

So...



