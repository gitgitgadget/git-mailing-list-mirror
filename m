Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B64E20988
	for <e@80x24.org>; Wed, 19 Oct 2016 04:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750800AbcJSEXv (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 00:23:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56173 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750712AbcJSEXt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 00:23:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE0DA49EA5;
        Wed, 19 Oct 2016 00:23:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=dwbY
        ZmnX3cAmfs6HdX4HXAzZDKQ=; b=LUQ8oH6H7Bi/pNgjG74XqYQOc4pMBolXW34/
        ZGWGzy7u9bVBfSLjYB7mccKKBD5UKqxK5ua74utrqaaztheSiljUAFkx2qdMY8XB
        nUX4mOyui/Nmq7RZUt0iRMiNkQEiT0zxru+ZfCGOXUR5M1v3YziEvEP2od9cdZj2
        eanBOYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=l7N6Zv
        db6LEhkCA/tXvTGU/q3KoZwhwkq2HAeG+QSuH2vw4XXqMpdRMQLnb55r5Ku8YmqU
        20jAbAsmBAwBxDSMj//e7aAttmg0CQfSsPWi4oERtAuCdZWEvaZrbUmHlrpfMspG
        msuI0p07EvbnGOmD6FH7TNdYUeXzLtjW4U66E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B652749EA4;
        Wed, 19 Oct 2016 00:23:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 361F849EA3;
        Wed, 19 Oct 2016 00:23:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/7] Rejecting useless merge bases
Date:   Tue, 18 Oct 2016 21:23:38 -0700
Message-Id: <20161019042345.29766-1-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-631-gb2c64dcf30
In-Reply-To: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
References: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: D4267CF2-95B3-11E6-B38E-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a continuation of

    http://public-inbox.org/git/xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com

In a workflow where topic branches are first merged to the 'next'
integration branch to be tested before getting merged down to the
'master' integration branch to be consumed by the end users, merging
the 'master' branch back to the 'next' happens after topics graduate
to 'master' and release notes entries are written for them.

Git finds many merge bases between 'master' and 'next' while
creating this merge.  In addition to the tip of 'master' back when
we made such a merge back from 'master' to 'next' was made the last
time, which is the most reasonable merge base to explain the
histories of both branches, all the tips of topic branches that
graduated recently are merge bases.  Because these tips of topic
branches were already in 'next', the tip of 'next' reaches them, and
because they just graduated to 'master', the tip of 'master' reaches
them, too.  And these topics are independent most of the time (that
is the point of employing the topic-branch workflow), so they cannot
be reduced.

The merge-recursive machinery is very inefficient to compute this
merge, because it needs to create pointless virtual merge-base
commits across these many merge bases.  Conceptually, the point
where the histories of 'master' and 'next' diverged was the tip of
'master' back when we created such a merge back from 'master' to
'next' the last time, and in practice that is the only merge base
that matters.

The series allows us to ignore these tips of topics, which are
uninteresting merge bases, when running "git merge".  The example
merge with 12 merge bases:

    git checkout 4868def05e && git merge 659889482a

in our history takes about 1.22-1.33 seconds without the series,
while running the latter "git merge" with the "--fp-base-only"
option takes about 0.54-0.59 seconds.

Junio C Hamano (7):
  commit: simplify fastpath of merge-base
  sha1_name: remove ONELINE_SEEN bit
  merge-base: stop moving commits around in remove_redundant()
  merge-base: expose get_merge_bases_many_0() a bit more
  merge-base: mark bases that are on first-parent chain
  merge-base: limit the output to bases that are on first-parent chain
  merge: allow to use only the fp-only merge bases

 Documentation/git-merge-base.txt |  8 +++-
 Documentation/merge-options.txt  |  9 +++++
 builtin/merge-base.c             | 10 +++--
 builtin/merge.c                  | 15 ++++++--
 commit.c                         | 81 ++++++++++++++++++++++++----------------
 commit.h                         |  7 +++-
 object.h                         |  3 +-
 sha1_name.c                      | 10 ++---
 8 files changed, 94 insertions(+), 49 deletions(-)

-- 
2.10.1-631-gb2c64dcf30

