Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31262C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 10:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjDXKPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjDXKPm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 06:15:42 -0400
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5D230E2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 03:15:33 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <admin@game-point.net>)
        id 1pqtEI-00DOnQ-Jb
        for git@vger.kernel.org; Mon, 24 Apr 2023 12:15:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=game-point.net; s=selector2; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
        bh=HK6ZBvuKA6wSO33K6cRu//DdhFWSRMXQP1dQrjeh2sU=; b=PvICIb1QZzYPvgknuNr/3gRumA
        9ri16ZcmwU53jBruLh4FOgovnBAMmOFIJJEM22NEDK8J/3PtrJhPhT+1j8Wu+z8Uw1zSjBzrI6mK6
        dzl/N98fuhjfkhWRbrZKbUIgRhVxezEWzNYkOK5NJ5Y8a/nwcHr4HXi6UOvxZtxmAAXYhTVspWKiT
        iPN7yf5c+IsPktUu4Oyq3NJwebYHIr95KNl66mptmlzeVpaHYGmIAR7Fw0k6Va3P2driSJdEHNvKt
        KJXcQSh2pU5li/v5P4CwG5NHrWL1R65yd1H9JX4VFt9L7L6eHiwUtom4Q9L525zclb/iaI5XgZxlK
        r655t/JQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <admin@game-point.net>)
        id 1pqtEI-00017R-5j; Mon, 24 Apr 2023 12:15:30 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (956903)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1pqt9x-0005pY-1Q; Mon, 24 Apr 2023 12:11:01 +0200
Subject: Re: Proposal: tell git a file has been renamed
To:     Chris Torek <chris.torek@gmail.com>
Cc:     git@vger.kernel.org
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
From:   Jeremy Morton <admin@game-point.net>
Message-ID: <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
Date:   Mon, 24 Apr 2023 11:10:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/04/2023 02:43, Chris Torek wrote:>> [renames are a problem]
> 
> I have long wondered if there was a way to improve this
> experience myself.
> 
> (I also note that most of the followup messages up to this point
> have missed the point.  It's true that you can run `git mv` and
> `git commit`, but you've already said that this becomes
> particularly painful when you realize that it's appropriate *after
> the fact*, when you've already made intermediate commits and/or
> staged changes or whatever.)
> 
> The index *currently* has no room to store anything like this: it
> is, in effect, just the proposed next commit, stored as a
> flattened tree.  There are, however, extra marker records that
> can be added.  So:
> 
> If `git mv` (or a new command) had a flag to say "make a special
> index entry so that the next `git commit` does a double commit",
> we could in fact make this work.  Alternatively, we could have a
> command -- similar to `git commit --only` in effect -- that uses
> the current (HEAD) commit to construct a renames-only commit, in
> which 100%-identical-file matching would (in general) find the
> desired renames -- and make it, perhaps also co-ordinating with
> `git mv` of existing files in the index.  (I'd also like to have

I'm not sure what the utility of the --only thing would be - to detect 
renames that didn't have changed content so that all renames could be 
done in one pre-commit?

> `git mv --after`, in the same vein as `hg mv --after`; I long ago
> wrote a cheesy script to achieve this, but it would be nice to
> have a proper command.)

Huh, I just read the docs on that... does that mean hg already has 
this functionality of being able to store a "this was renamed" marker 
in its index?

> On top of this, it might be nice to have a standardized commit
> message and/or other marker (in the commit header?) for a "rename-
> only" commit, which this kind of extra-rename-commit operation
> would use.  Then `git log` and `git blame` and other commands
> could easily detect such commits and default to an automatic
> `--follow` style following, and `git log` might be allowed to omit
> the *display* of such a commit by default, by showing all the
> renames as renames in the subsequent commit (though this would
> presumably require an internal verification step to check for
> spoofed renames that are not in fact rename-only operations).

I'm surprised --follow isn't the default, actually... isn't the whole 
point of detecting renames to allow content history to be tracked back 
through renames?

Another one that jumped to mind for me is bisect.  As rename-only 
commits are liable to create broken builds, it should skip over them 
to the 'content' commit.

> In any case, this *idea* is easy, like many ideas.  It really
> comes down to implementation.  If someone thinks this is a great
> idea, someone (perhaps me) should work on *implementing* it. :-)

If you do please feel free to CC me in an email about it, it'd be good 
to know if this became available!

-- 
Best regards,
Jeremy Morton (Jez)
