Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56262055E
	for <e@80x24.org>; Sun, 29 Oct 2017 00:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbdJ2Av6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 20:51:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55068 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751209AbdJ2Av5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 20:51:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B65EEAC88F;
        Sat, 28 Oct 2017 20:51:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8gkVmwlSWczq
        /tSLQ/TXmIUiZwk=; b=FqgBHiCPnXeCnUgyOJwvBXaOZF0hyeA5R+wFXztgbBJm
        HGzZIoXezqyCiAtsgMEkuX2pCioQWCfhffy7+oN7bkoKDxlpLFi0bpOOcXWAvl0F
        fFyNfS4Qk2EPt4AZjEhDBt201/hzXH9kICeWhBfyGRa/NZU+l9bYoPQ5jnFVslw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CVXegF
        C/+PvmnOlJ0I8uXrcaUhR1Tp2Di0TJmClIeS87B0Ocfx7qf5lfSgUUi2WThOS4I/
        SDUbu9EQxSF1GpiKjYovKJiAu9/XSZH1oq6TjT11FY3UIh5srr1RkcR2HSW02li8
        jcRFWqftxIZmuZ/rLiutVSxD0crRK0hNYWC0Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEC5CAC88E;
        Sat, 28 Oct 2017 20:51:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A0F2AC88D;
        Sat, 28 Oct 2017 20:51:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Christopher Jefferson <caj21@st-andrews.ac.uk>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git rm VERY slow for directories with many files.
References: <BEEA4A16-5433-4E6C-A7D7-956C85F27DF3@st-andrews.ac.uk>
        <20171028223103.wevq5zf4rjl7ietd@genre.crustytoothpaste.net>
Date:   Sun, 29 Oct 2017 09:51:55 +0900
In-Reply-To: <20171028223103.wevq5zf4rjl7ietd@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Sat, 28 Oct 2017 22:31:04 +0000")
Message-ID: <xmqqbmkqbwt0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5CAEDD9C-BC43-11E7-8ED5-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> Looking at an optimized profile, all the time seems to be spent in =E2=
=80=9Cget_tree_entry=E2=80=9D =E2=80=94 I assume there is some huge objec=
t representing the directory which is being re-expanded for each file?
>
> Yes, there's a tree object that represents each directory.
>
>> Is there any way I can speed up removing this directory?
>
> First, make sure your working directory is clean with no changes.  Then=
,
> remove the directory (by hand) or move it somewhere else.  Then, run
> "git add -u".
>
> That should allow you to commit the removal of those files quickly.

If get_tree_entry() shows up a lot in the profile, it would indicate
that a lot of cycles are spent in check_local_mod().  Bypassing it
with "-f" may be the first thing to try ;-)

The way "git rm" makes repeated calls to get_tree_entry() with deep
pathnames would be an easy recipe to get quadratic behaviour like
the one reported in the first message on this thread, as it always
goes from the root level, grabs an tree object and scans it to get
the entry for the next level, and (worse yet) a look-up of a path
component in each of these tree object must be done as a linear
scan.

I wonder how fast "git diff-index --cached -r HEAD --", with the
same pathspec used for the problematic "git rm", runs in this same
50,000 path project. =20

If it runs in a reasonable time, one easy way out may be to revamp
the codepath to call check_local_mod() to:

 - first before making the call, do the "diff-index --cached" thing
   internally with the same pathspec to grab the list of paths that
   have local modifications; save the set of paths in a hashmap or
   something.

 - pass that hashmap to check_local_mod(), and where the function
   does the "staged_changes" check, consult the hashmap to see the
   path in question is different between the HEAD and the index.

