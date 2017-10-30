Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1347A202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 01:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbdJ3Bgb (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 21:36:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60727 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750764AbdJ3Bga (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 21:36:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 920B3BA694;
        Sun, 29 Oct 2017 21:36:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B3qkd/rbx2AVWUheAj8jENk6D+E=; b=a9BAqL
        5hAoiZFGKhtygQCn4DFVRMVbUXrTgUoiYP3TI4eEztQNcJD5p0h7asqP4JbNcQPs
        ZvbvuAB+UbzgzV6MO4/SjYpHP2Z9TyiPzDPsBZa8YyKXCaILdez+98B5PvgenGfX
        Hbm8RcSOFHQwinXMAjxN8CW0hyculawbRoyLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WNSpM2iuxl1ZbHVdgd3GbUWFjLJXtaix
        +MzakhF1Qo1/LLk+a4lbNFqYbBjjnTcoBHHY5k20OmeskoRqGZHz+8eFuKftDBLW
        m8j0gv7veMBO4pByc5rUq+Wic30yJxaMwtmlwDQrpqCoIVK+XXu0MQUjBoZ5Q+UQ
        /GLUyNB65nI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88783BA693;
        Sun, 29 Oct 2017 21:36:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0177BA692;
        Sun, 29 Oct 2017 21:36:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Christopher Jefferson <caj21@st-andrews.ac.uk>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git rm VERY slow for directories with many files.
References: <BEEA4A16-5433-4E6C-A7D7-956C85F27DF3@st-andrews.ac.uk>
        <20171028223103.wevq5zf4rjl7ietd@genre.crustytoothpaste.net>
        <xmqqbmkqbwt0.fsf@gitster.mtv.corp.google.com>
        <20171029165244.si4a5furgf6trqe3@genre.crustytoothpaste.net>
Date:   Mon, 30 Oct 2017 10:36:27 +0900
In-Reply-To: <20171029165244.si4a5furgf6trqe3@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Sun, 29 Oct 2017 16:52:44 +0000")
Message-ID: <xmqqbmkp8lic.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C00F6A62-BD12-11E7-BE5E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Sun, Oct 29, 2017 at 09:51:55AM +0900, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> > First, make sure your working directory is clean with no changes.  Then,
>> > remove the directory (by hand) or move it somewhere else.  Then, run
>> > "git add -u".
>> >
>> > That should allow you to commit the removal of those files quickly.
>> 
>> If get_tree_entry() shows up a lot in the profile, it would indicate
>> that a lot of cycles are spent in check_local_mod().  Bypassing it
>> with "-f" may be the first thing to try ;-)
>
> That is indeed faster.  I tested my solution by creating a directory
> with 20,000 files in a temporary repo.  git rm -r took 17.96s, and git
> rm -rf took .12s.  (This is on an SSD.)
>
> That's also a nicer and more intuitive solution than mine.

Heh, the above was meant as a joke, though.  "-f" is bypassing an
important safety valve.  In fact in my early draft of the message,
the paragraph that followed started with "Jokes aside, ..." ;-)

>> I wonder how fast "git diff-index --cached -r HEAD --", with the
>> same pathspec used for the problematic "git rm", runs in this same
>> 50,000 path project.
>
> I'll let the original poster answer this one as well, but it was very
> fast in my test repo.  I'm not very familiar with the code path in
> question, but it definitely looks like we're avoiding the quadratic
> behavior in this case.

Because of the way "diff-index --cached" iterates over the index and
the tree in parallel, it should be a lot faster than doing
get_tree_entry() for each and every path you care about.  In
addition, the "--cached" form is further optimized to take advantage
of the cached-tree index extension, so you often can tell "all index
entries in this directory are untouched" without descending into
deep subdirectories.
