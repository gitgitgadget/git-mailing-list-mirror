Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A542055E
	for <e@80x24.org>; Sun, 29 Oct 2017 03:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbdJ2Dwf (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 23:52:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60700 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751524AbdJ2Dwf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 23:52:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F320AE491;
        Sat, 28 Oct 2017 23:52:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YCHz8Cf1ZnyWNCNj9p2zIUByzWg=; b=mXGGUH
        g7dK2ZpCc+pdF6i5E6G4+JPCY+SFW0rRdBps/TFGtXcKR9PI+CAawHqQmVShASax
        5mDpmloxxbPWdu4Wu3+/OLiaiMWE4t4ptLSvBDbfQdl782WRajf3ubTdArQI3gcb
        swNcDSL74g1xe0OTDbPeZInTQ9QvJ1Bkmr8Ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TUYVVuqvtq/1hCPhPivX26Eq2Lk/rmp6
        nUdUws0kIxLWDDsqQAWifMkFmLni3rK4/9bknpwOSBjzhfErf/3gp2546bPZgf2a
        fD5e5aUUZVSQnxDjYja9GsaicEkmZ80fMGW11Kx1U3HjZdRosQaz/bbpX8PNBOqw
        yJ1aSo/GNrs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66312AE490;
        Sat, 28 Oct 2017 23:52:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7ABDAE48F;
        Sat, 28 Oct 2017 23:52:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Christopher Jefferson <caj21@st-andrews.ac.uk>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git rm VERY slow for directories with many files.
References: <BEEA4A16-5433-4E6C-A7D7-956C85F27DF3@st-andrews.ac.uk>
        <20171028223103.wevq5zf4rjl7ietd@genre.crustytoothpaste.net>
        <xmqqbmkqbwt0.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 29 Oct 2017 12:52:32 +0900
In-Reply-To: <xmqqbmkqbwt0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 29 Oct 2017 09:51:55 +0900")
Message-ID: <xmqqbmkqa9vj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98761548-BC5C-11E7-A1ED-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder how fast "git diff-index --cached -r HEAD --", with the
> same pathspec used for the problematic "git rm", runs in this same
> 50,000 path project.  
>
> If it runs in a reasonable time, one easy way out may be to revamp
> the codepath to call check_local_mod() to:
>
>  - first before making the call, do the "diff-index --cached" thing
>    internally with the same pathspec to grab the list of paths that
>    have local modifications; save the set of paths in a hashmap or
>    something.
>
>  - pass that hashmap to check_local_mod(), and where the function
>    does the "staged_changes" check, consult the hashmap to see the
>    path in question is different between the HEAD and the index.

And if we want to try a more localized band-aid, another approach
may be to add a caching version of get_tree_entry() where we keep
track of (stack of) tree, the path component we found during the
last call to the helper and the tree_desc.  That way, when we get
the next call, we descend that stack as long as the leading path
components are still the same, and when we see that the path
component we are looking for is different from what we used in the
last call, we either (1) reuse the tree_desc and keep going forward
if the name we looked for the last sorts before what we are looking
for, or (2) discard and reopen the tree, rewinding the tree_desc to
the beginning and do the scan.

That way, the caller of the check_local_mod() does not have to know
the trick, and because the loop in check_local_mod() iterates over
the list that is already sorted in the index order, we'd not just
reduce the number of times we open the trees but also reduce the
number of times we scan and skip the entries in trees to find the
entries we are after.
