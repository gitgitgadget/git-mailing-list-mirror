Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C861FCA9
	for <e@80x24.org>; Mon, 12 Sep 2016 01:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756512AbcILBr1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 21:47:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63946 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756500AbcILBrX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 21:47:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C93003DEC3;
        Sun, 11 Sep 2016 21:47:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ovOh7ANVieSW+1y4RQrkqkgoSt0=; b=wTkxNw
        /M0m/f9/S9XECYQAYgI+piStrNDmsoRF5GiRr2PeqN1ROj4xOrjpswDn6TSKVNhS
        ETYQykFt89Fdw6Gy0/3RrEkmbPYGDyX4zaphvWZ+G5U+7bQe12D68JU4uPll1wGA
        OgKgL0WvR+TA5F4kUxXsjHHfF9+O6N+DwMy54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sSICjOChljR9ZN2QnqSWA5CB1SqbdZjI
        esdM97LRV6yJ8LNGb9H6nB3X+oKve/wQGmA+e90GsysMa0szDz9ggrCYHr4fH7Al
        MYXgP2Us6lcWUZ4a9cw36WSHaCX1hIIS4Oft4Y9nCNheygEv/A6uteCUzVqIiJ0G
        L4kuWgGyjd8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1FB53DEC2;
        Sun, 11 Sep 2016 21:47:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DC643DEC1;
        Sun, 11 Sep 2016 21:47:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] ls-files: adding support for submodules
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
        <xmqqh99o8ypm.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaWNykEAZcjZ2Y19j2_3TF+qcz+vb8zSi1U+me3k+06LA@mail.gmail.com>
        <xmqqmvje6qbe.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 11 Sep 2016 18:47:19 -0700
In-Reply-To: <xmqqmvje6qbe.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 11 Sep 2016 15:10:13 -0700")
Message-ID: <xmqqlgyx6g9k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D86E3C0A-788A-11E6-83AF-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So a "ls-files" that is done internally in the end-user facing "git
> grep --recurse-submodules" needs to be run _without_ recursing
> itself at least once to learn "lib/" is a submodule.  A flat "here
> are everything we have" does not sound like a good building block.

... unless you are _only_ interested in grepping (or in general
working outside Git repository) in the files in the working tree,
i.e. "git grep" without <tree-ish> nor "--cached".

A lot of the time you are interested in the current state of files,
not even in "the state recorded in the tip of the history" but in
"the state as I have in my working tree, the state as my compiler
sees it".

I am a bit torn.  Clearly this is an important special case, but it
would make the codepath for object database case and working tree
case even further apart between "git grep [--cached | <tree-ish>]"
and the "find in the working tree" codepath, which does not sound
friendly to the codebase.

