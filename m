Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07ADA20954
	for <e@80x24.org>; Wed, 29 Nov 2017 00:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753603AbdK2A6n (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 19:58:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56544 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753585AbdK2A6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 19:58:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6688AF28B;
        Tue, 28 Nov 2017 19:58:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TyB470ZpjPC3ZsyOF/NBWkZsftw=; b=Ph27Yy
        Pw5bSeKoAsOBws5mFrxaK3ElDm6kflPyFw+rkAG5JTOapNV16NvoS7BPB3Q4M+l2
        QMf5w/5UjMuN2O3r3AcuelKmd4ZAza36qQNjC0b8xi8R/5G5H1uNUu2KnLYJc/0h
        o/nCiE8RjHo/cZN3jKfA9WdcEX1pNZYpTFxZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NoA/O3LSLJ9YWdR1jRUrgyaHKhgRsrfQ
        zGJJZ2C57RalSFh5aR1bQ9zNmOTxNQQHXn4TpliM1bplSZ0sxrnal/GJlM7tjsvF
        kl1amZ3aB1dh5QuvYwgTqT0g9cCwf2wkao9u5OrY66ZhCgCp4bS1kQIesmeH9Qo+
        Cgs5PCmz73M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEFCEAF28A;
        Tue, 28 Nov 2017 19:58:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53528AF289;
        Tue, 28 Nov 2017 19:58:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>
Subject: Re: bug deleting "unmerged" branch (2.12.3)
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de>
Date:   Wed, 29 Nov 2017 09:58:38 +0900
In-Reply-To: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de> (Ulrich
        Windl's message of "Tue, 28 Nov 2017 15:21:49 +0100")
Message-ID: <xmqqtvxd6gu9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FCB78B6-D4A0-11E7-8663-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

> I think if more than one branches are pointing to the same commit,
> one should be allowed to delete all but the last one without
> warning. Do you agree?

That comes from a viewpoint that the only purpose "branch -d" exists
in addition to "branch -D" is to protect objects from "gc".  Those
who added the safety feature may have shared that view originally,
but it turns out that it protects another important thing you are
forgetting.

Imagine that two topics, 'topicA' and 'topicB', were independently
forked from 'master', and then later we wanted to add a feature that
depends on these two topics.  Since the 'feature' forked, there may
have been other developments, and we ended up in this topology:

    ---o---o---o---o---o---M
        \   \          
         \   o---A---o---F
          \         /  
           o---o---o---o---B

where A, B and F are the tips of 'topicA', 'topicB' and 'feature'
branches right now [*1*].

Now imagine we are on 'master' and just made 'topicB' graduate.  We
would have this topology.

    ---o---o---o---o---o---o---M
        \   \                 /
         \   o---A---o---F   /
          \         /       /
           o---o---o---o---B

While we do have 'topicA' and 'feature' branches still in flight,
we are done with 'topicB'.  Even though the tip of 'topicA' is
reachable from the tip of 'feature', the fact that the branch points
at 'A' is still relevant.  If we lose that information right now,
we'd have to go find it when we (1) want to further enhance the
topic by checking out and building on 'topicA', and (2) want to
finally get 'topicA' graduate to 'master'.

Because removal of a topic (in this case 'topicB') is often done
after a merge of that topic is made into an integration branch,
"branch -d" that protects branches that are yet to be merged to the
current branch catches you if you said "branch -d topic{A,B}" (or
other equivalent forms, most likely you'd have a script that spits
out list of branches and feed it to "xargs branch -d").

So, no, I do not agree.


[Footnotes]

*1* Since the 'feature' started developing, there were a few commits
    added to 'topicB' but because the feature does not depend on
    these enhancements to that topic, B is ahead of the commit that
    was originally merged with the tip of 'topicA' to form the
    'feature' branch.
