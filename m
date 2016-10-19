Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E823720986
	for <e@80x24.org>; Wed, 19 Oct 2016 17:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943075AbcJSRmj (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 13:42:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50208 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S942808AbcJSRmi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 13:42:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 109C1468E5;
        Wed, 19 Oct 2016 13:42:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=CaPCNsRhyiXwzhS5WX2Vk1QAUnI=; b=cCP086ft6AgKaOtyh3rc
        QEkdgZldue3D5iZ1Uf/NgDeg/2cClyQBfNyWBSEenPv8eqyJ8eogu0v3Ino3vqqx
        qbzl0QrmDMs+NNU+SjP8oNSqT0qVfq4q2CwxIzi/n6KL7d1/V8A6Y1Aq1b3fTd6g
        To8cGI5MCOXRuX4Ij2DwmTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=hj/hALWBIkY/It+BlNtTnVr4MrJb+Y7dN7X2BgBNlNEYMSoTXWHEIEqK
        1UK4jt0BIohIrvN8R7NHXi0GmUbtw2oO6RjVOwteermXjQN2jP4uDWZMHAI64JvB
        HAzvxCHz24PFlK8AJkMqBa84pMF01O1fQKFez3bsRFB5AlEIBh4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08C23468E4;
        Wed, 19 Oct 2016 13:42:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AA6D468E3;
        Wed, 19 Oct 2016 13:42:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH 5/7] merge-base: mark bases that are on first-parent chain
References: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
        <20161019042345.29766-1-gitster@pobox.com>
        <20161019042345.29766-6-gitster@pobox.com>
Date:   Wed, 19 Oct 2016 10:42:34 -0700
Message-ID: <xmqq4m48me0l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C3ABC6E-9623-11E6-BF72-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In a workflow where topic branches are first merged to the 'next'
> integration branch to be tested before getting merged down to the
> 'master' integration branch to be consumed by the end users, merging
> the 'master' branch back to the 'next' happens after topics graduate
> to 'master' and release notes entries are written for them.
>
> Git finds many merge bases between 'master' and 'next' while
> creating this merge.  In addition to the tip of 'master' back when
> we made such a merge back from 'master' to 'next' was made the last
> time, which is the most reasonable merge base to explain the
> histories of both branches, all the tips of topic branches that
> graduated recently are merge bases.  Because these tips of topic
> branches were already in 'next', the tip of 'next' reaches them, and
> because they just graduated to 'master', the tip of 'master' reaches
> them, too.  And these topics are independent most of the time (that
> is the point of employing the topic-branch workflow), so they cannot
> be reduced.

The idea here is to exclude tips of topic branches as "obviously
less useful as merge bases than the mainline commit".  Aside from
the fact that the approach is purely a heuristic that heavily relies
on convention aka "topic branch workflow", there is a caveat (or
more that I haven't thought of yet).  

One is that there may be no merge base found that is on the first
parent chain with this particular patch.  When any of the topics
that just graduated to 'master' was forked off of 'master' after the
latest merge from 'master' to 'next' was made, then the merge base
on the first parent chain, i.e. the commit on 'master' that was
merged to 'next' the last time, will be an ancestor of the tip of
that recently forked topic, which is another common ancestor between
'master' and 'next' being merged (hence removed as redundant).  We
will be left with only the merge bases that are off first-parent
chain, and I think "git merge" will say "no related histories; I
won't merge them".

I do not know if that is a problem in practice, but if it turns out
to be, it probably can be corrected by updating the way how the
paint_down_to_common() function works.  It still stops traversal,
even with this patch, when a commit is found to be common and place
it to the "potential merge bases" list, but instead we could keep
digging until we hit a commit that is common between PARENT1 and
PARENT2 and also is on the first-parent chain, without declaring
that we found one result.

But that probably ends up being the same as ignoring all side
branches from merges and finding merge bases only paying attention
to the first-parent chain.
