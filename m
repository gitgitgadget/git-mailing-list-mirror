Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11AB20281
	for <e@80x24.org>; Tue,  3 Oct 2017 01:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbdJCBMV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 21:12:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53150 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750984AbdJCBMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 21:12:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCAF2B3455;
        Mon,  2 Oct 2017 21:12:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qSUVH0xuXAcVqSmVDClKVifHeUk=; b=i60wkY
        7hwmRtZynMle1zAjpD++ITBBcdhVnGt1JodbYcAsLpYit/gyURldLjdS2PLWkKAs
        thc7JcI6NNdp1EaKH5uh2UGA27E6u06wGypI6QfWQcDDHYbm6btNmko6binq6S1h
        pTR05ZpPE6iEVb2XAQw1eqWcZPFdQYrXWEHlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jAtgjn6jJbedo9yaAGZmTGdm/323xOmX
        yHXOEHUPJNo2XBx0qEHLv4/ftAORANCMiTaBTtndEJl5fNzxWZgZweJ0NpZekVDN
        0pu80lldysCQVK3t8VgpQGNiOj3WP28gu/n4LzfYw0Zog4EJK5pjcasDD81s3SkG
        KKWracZYios=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3FB2B3454;
        Mon,  2 Oct 2017 21:12:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 36F61B3453;
        Mon,  2 Oct 2017 21:12:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Loic Guelorget <loic@google.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Security of .git/config and .git/hooks
References: <20171002234517.GV19555@aiede.mtv.corp.google.com>
Date:   Tue, 03 Oct 2017 10:12:18 +0900
In-Reply-To: <20171002234517.GV19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 2 Oct 2017 16:45:17 -0700")
Message-ID: <xmqqtvzhkpal.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6F9C474-A7D7-11E7-8DBA-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Proposed fix: because of case (1), I would like a way to tell Git to
> stop trusting any files in .git.  That is:
>
>  1. Introduce a (configurable) list of "safe" configuration items that
>     can be set in .git/config and don't respect any others.

The list of "safe" things are configurable by having something in
~/.gitconfig, perhaps?

How would this work, from the end-user's point of view, with "git
config --global" and "git config --local"?

>  2. But what if I want to set a different pager per-repository?
>     I think we could do this using configuration "profiles".
>     My ~/.config/git/profiles/ directory would contain git-style
>     config files for repositories to include.  Repositories could
>     then contain
>
> 	[include]
> 		path = ~/.config/git/profiles/fancy-log-pager
>
>     to make use of those settings.  The facility (1) would
>     special-case this directory to allow it to set "unsafe" settings
>     since files there are assumed not to be under the control of an
>     attacker.

Meaning, "include" is not in "safe" category, but a value that
begins with "~/.config/git/" are excempt???

>  3. Likewise for hooks: my ~/.config/git/hooks/ directory would
>     contain hooks for repositories to make use of.  Repositories could
>     symlink to hook files from there to make use of them.

I am not sure what this means.  .git/hooks/pre-commit being a
symbolic link to "~/.config/git/hooks/pre-commit-fancy"
(i.e. readlink gives the path with tilde unexpanded), so that the
attacked sysadmin will not run it from ~attacker/.config/git/hooks?  

And the code that finds a hook to run sees .git/hooks/pre-commit,
resolves the symlink manually and makes sure it leads to somewhere
inside ~/.config/...  (otherwise it rejects) and then uses the
pointed-at copy?

At that point, we are not taking any advantage of symbolic-link-ness
of the entity, so .git/hooks/pre-commit being a text file that has a
single like, e.g.

	# safe-hook: pre-commit-fancy

may be sufficient (and we do not have to worry about systems without
symbolic links)?  The machinery that used to manually resolved symlink
instead reads it, finds "pre-commit-fancy" in ~/.config/git/hooks/
and runs it, and you get the same behaviour, no?

> One downside of (3) is its reliance on symlinks.  Some alternatives:
>
>  3b. Use core.hooksPath configuration instead.  Rely on (2).
>  3c. Introduce new hook.* configuration to be used instead of hook
>      scripts.  Rely on (2).

I guess I invented 3d. without reading ahead X-<.  None of the 3x
variants other than 3 proper will not work for scripts and existing
code that sees that .git/hooks/pre-commit is an executable and runs
it, and 3 proper will not work without symbolic links, so this means
we'd need "git locate-hook pre-commit" (and underlying locate_hook()
helper API) that returns "/home/me/.git/config/hook/pre-commit-fancy"
or fails when we do this transition.  In an unconverted repository,
it may return $PWD/.git/hooks/pre-commit, or failure if we are
running under the paranoid mode.

Sounds workable.
