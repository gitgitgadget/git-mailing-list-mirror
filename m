Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513ECEB64DD
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 17:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjFWRXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjFWRXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 13:23:18 -0400
X-Greylist: delayed 99 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 10:23:15 PDT
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB7E1FC2;
        Fri, 23 Jun 2023 10:23:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2805A18FA40;
        Fri, 23 Jun 2023 13:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zqa+oQst+Yt3IgH3DzEpxq6pgQHFt70qow0xS8
        qFkv4=; b=pu8jW/xxCVh7aCnzJVqZpF14nnRd+I6QI0/fZthVdh9u3UC2ndAg2j
        vog9mfVCGEkoQ5B07lQRHTDs2hu8eQQl/rOtv14bCDRA0L+ZWCIoorj22/9IGRWx
        C7YtFQGoGi81/SEH8LMcPtXAPlMHse85BKwqvMVqWv94SsGFhIhTs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2148518FA3D;
        Fri, 23 Jun 2023 13:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 855E018FA3C;
        Fri, 23 Jun 2023 13:21:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jovial Joe Jayarson <jovial7joe@hotmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, majordomo@vger.kernel.org
Subject: Re: Feature: Use $HOME instead of /home/username in ~/.gitconfig
References: <OSZP286MB1968CC1BD59489496919D16B8F23A@OSZP286MB1968.JPNP286.PROD.OUTLOOK.COM>
Date:   Fri, 23 Jun 2023 10:21:33 -0700
In-Reply-To: <OSZP286MB1968CC1BD59489496919D16B8F23A@OSZP286MB1968.JPNP286.PROD.OUTLOOK.COM>
        (Jovial Joe Jayarson's message of "Fri, 23 Jun 2023 13:52:39 +0530")
Message-ID: <xmqqh6qyayci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 672554D8-11EA-11EE-A693-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jovial Joe Jayarson <jovial7joe@hotmail.com> writes:

> I'm sharing my `.dotfiles` across systems, so I'd prefer
> `/home/username` be replaced with `$HOME` or even with `~/`.
>
> ```ini
> [maintenance]
>     repo = $HOME/.znap/repos/asdf
> ```

It probably is closer to our norm to use ~/ or ~username/ in our
configuration files.  $VAR syntax is unlikely to fly, as it will
imply allowing arbitrary environment variables, whose security
implications we would rather not have to worry about.

On the execution side, builtin/for-each-repo.c:run_command_on_repo()
already knows to call interpolate_path() on the supplied pathname,
which comes from the configuration variable (internally) specified,
which is "maintenance.repo", so setting the variable to "~jjj/path"
should already make it work, I would imagine (note: I am not a user
of the feature).

The registration side is messier, though.

The path to your current repository is discovered, and then it gets
canonicalized by going through strbuf_realpath().  This happens all
inside builtin/gc.c:get_maintpath() and it is why the configuration
variables store the absolute names.  It also makes duplicate detection
simpler to store the absolute names (otherwise, you'd need to compare
each existing key after canonicalizing it with canonicalized new
candidate repository, in order to avoid duplicates).

Turning "~jjj/hello.git" into "/home/jjj/hello.git" (or further into
"/mnt/home3/jjj/hello.git", if "/home/jjj" is a symbolic link to
"/mnt/home3/jjj") is easy, but there is no standard way to reverse
it from "/mnt/home3/jjj/hello.git", which would be what get_maintpath()
would be seeing.

If (and I do not know how) you manage to find a way for get_maintpath()
to turn "/mnt/home3/jjj/hello.git" into "~jjj/hello.git", then there
are a few changes needed:

 * builtin/gc.c:maintenance_register() has a loop to avoid
   duplicates; before entering the loop, pass "maintpath" to
   interpolate_path() and then strbuf_realpath() to canonicalize it
   (and call it $canon_maintpath).  In the loop, run the same
   canonicalization for each existing path (in item->string), and
   compare it with $canon_maintpath, to detect duplicates.  If the
   repository is not currently registered, use "maintpath" (not
   $canon_maintpath) to register.

 * builtin/gc.c:maintenance_unregister() has as loop to see if the
   "maintpath" exists, and then remove all associated values.  This
   will have to be modified heavily, to account for the directory
   aliases you are now introducing.  When get_maintpath() says that
   you are in "~jjj/hello.git" and unregistering the repository, you
   would need to catch all "maintenance.repo" configuration whose
   values are one of "~jjj/hello.git", "/home/jjj/hello.git", or
   "/mnt/home3/jjj/hello.git".


