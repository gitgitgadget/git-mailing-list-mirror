Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF72A1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 22:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932740AbcJQW2x (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 18:28:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51906 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932610AbcJQW2w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 18:28:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6CAB48350;
        Mon, 17 Oct 2016 18:28:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=e
        0MXDC9nhYk62zRBs5usDUbCpU4=; b=YN1RCRMkooOBBcUSyM4Lfq1tR3ULBqfyl
        4ku6OVYEVXruRes9NBOv33wD/jBBcfaPq9O3kwJfqLnsH9uCgHkTCWzuHjnOiO7p
        D0N3FNXnbSmhoEX8CUUVCzQe388fvtZuRFd9WHxeyRNHzsqQ2c4tv1GcGus6PRwd
        5YszTbYYPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=MOs
        DAekNLCKv3mE94//L5kmaUOo5tUIF1R5Xz5ue9m03n8y5ZzGvp9qkq9eQjJvNUk0
        8vm7rVUBxcp6YJXrUDM10g8q8UQwKzr8lrBgRV66RHQB7VpNRk0pgCd4aCJ3NW8O
        48sv8IvPdlgmtRc3YORnJeD3UDFid6NlFYIEe8Sw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF52C4834F;
        Mon, 17 Oct 2016 18:28:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 200F94834A;
        Mon, 17 Oct 2016 18:28:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [RFD] should all merge bases be equal?
Date:   Mon, 17 Oct 2016 15:28:48 -0700
Message-ID: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13AEB66A-94B9-11E6-91E0-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

People can see how fast the usual merges I see everyday are by
looking at output from

    $ git log --first-parent --format='%ct %s' master..pu

and noticing the seconds since epoch.  Most of the days, these are
recreated directly on top of 'master' from scratch, and they get
timestamps that are very close to each other (or the same), meaning
that I am getting multiple merges per second.

Being accustomed how fast my merges go, there is one merge that
hiccups for me every once in a few days: merging back from 'master'
to 'next'.  This happens after having multiple topics (that by
definition have to be the ones that were already merged to 'next'
some time ago) to 'master', and 'master' may also have its own
commit (e.g. update to "RelNotes") and merges of side branches that
were not in 'next' (e.g. merge from submaintainers like i18n, etc.)

The reason why this merge is slow is because it typically have many
merge bases.  For example, today's tip of 'next' is:

    commit 6021889cc14df07d4366829367d2c4a11d1eaa56
    Merge: 4868def05e 659889482a
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Mon Oct 17 14:02:05 2016 -0700

        Sync with master

        * master:
          Tenth batch for 2.11
          l10n: de.po: translate 260 new messages
          l10n: de.po: fix translation of autostash
          l10n: ru.po: update Russian translation

which is a merge that has 12 merge bases:

    $ git merge-base --all 4868def05e 659889482a | git name-rev --stdin
    3cdd5d19178a54d2e51b5098d43b57571241d0ab (ko/master)
    641c900b2c3a8c3d385eb353b3801a5f49ddbb47 (js/reset-usage)
    30cfe72d37ed8c174cae43923769730a94549dae (rs/pretty-format-color-doc-fix)
    654311bf6ee0fbf530c088271c2c76d46f31f82d (da/mergetool-diff-order)
    72710165c932edb2b8552aef7aef2f357dde4746 (sb/submodule-config-doc-drop-path)
    842a516cb02a53cf0291ff67ed6f8517966345c0 (js/regexec-buf)
    62fe0eb4804c297486a1d421a4f893865fcbc911 (jk/quarantine-received-objects)
    a94bb683970a111b467a36590ca36e52754ad504 (rs/cocci)
    e8c42cb9ce6a566aad797cc6c5bc1279d608d819 (jk/ref-symlink-loop)
    22d3b8de1b625813faec6f3d6ffe66124837b78b (jk/clone-copy-alternates-fix)
    7431596ab1f05a13adb93b44108f27cfd6578a31 (nd/commit-p-doc)
    5275c3081c2b2c6166a2fc6b253a3acb20f8ae89 (dt/http-empty-auth)

The tip of each topic that was merged recently to 'master' since
'master' was last merged to 'next' becomes a valid merge-base by
design of the workflow.  We merge a topic to 'master' whose tip
has been already in 'next' for a while, so the tip of 'next' before
merging 'master' back is a descendant of the tips of these topics,
and the tip of 'master' before I make this merge has just become a
descendant of the tips of these topics.  That makes them common
ancestors between 'master' and 'next'.

But for the purpose of figuring out the 3-way merge result, I
suspect that they are pretty much useless common ancestor to use as
the merge base.  The first one in the list, the old 'master' that
was merged the last time to 'next', would be a lot more useful one.

And of course, if I do this:

    $ git checkout next
    $ git merge master ;# this is slow due to the 12-base above
    $ git checkout HEAD^ ;# detach at the previous state
    $ git merge-recursive ko/master -- HEAD master

the merge is instantaneous.  I'd get only what truly happened
uniquely on 'master', e.g. RelNotes update and i18n merge.

I am wondering if it is worth trying to optimize it by taking
advantage of the specific workflow (i.e. give me an option to use
when merging 'master' back to 'next') and allows me to exclude the
tips of these topic branches.  Would I be making the result open to
the criss-cross merge gotchas the "recursive merge" machinery was
designed to prevent in the first place by doing so?  Offhand, I do
not think that would be the case.

Assuming that it is a good idea, there is another question of how to
tell the more meaningful merge bases (ko/master in this case) out of
the less useful ones (all the others).  I think it would be
sufficient to reject commits that are not on the first-parent chain
of neither branch being merged.  Among the 12 merge bases, ko/master
is the only one that appears on the first-parent chain from 'master'
being merged (it does not appear on the first-parent chain from
'next').  All others were topic tips that by definition were merged
as second parent to integration branches ('next' and later 'master').
The place to do this would be a new option to 'merge-base'; instead
of "--all", perhaps "--major" option gives only the major merge bases
(with the definition of 'major' being the above heuristics), and then
"git merge-recursive" would learn "-Xmajor-base-only" strategy option,
or something along that line.

Thoughts?
