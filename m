Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0910C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 12:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbhKVMbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:31:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49730 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbhKVMbG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 07:31:06 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 61A25218ED;
        Mon, 22 Nov 2021 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637584079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPhgP/mNYh0D93oOMLOVuHr+hw6C1MV/jP56z1+M7is=;
        b=104RfXB0fSL8UCrMvtvz1PzGccN+KqiwON9CB18X0wISIH44ErcWM6zwnymsW8GcbnmS3y
        4EBX6yatLpbiJLj4yo8I7s3ht3oNfMzNaZ+sejm/P9o6U0+g4+UEAJXS3nlmQsDZclk6Ju
        6aMNw8dZ5kEbUK+mjNrkvwgRf9TIuvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637584079;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPhgP/mNYh0D93oOMLOVuHr+hw6C1MV/jP56z1+M7is=;
        b=ciqlJuSC70PRuuDhgdrOYCm0z49BPUm+XchfhGBpA4TyN8PthxWQPh/DXB86sWYG4gT4H/
        gEr3L3vcXKZ+drBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 55092A3B89;
        Mon, 22 Nov 2021 12:27:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 34D351E3C6D; Mon, 22 Nov 2021 13:27:59 +0100 (CET)
Date:   Mon, 22 Nov 2021 13:27:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jan Kara <jack@suse.cz>, git@vger.kernel.org
Subject: Re: [PATCH 02/27] bisect: Fixup bisect-porcelain/17
Message-ID: <20211122122759.GC24453@quack2.suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
 <20211118164940.8818-3-jack@suse.cz>
 <YZbOKgoYmeM/yLAs@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZbOKgoYmeM/yLAs@nand.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu 18-11-21 17:05:41, Taylor Blau wrote:
> On Thu, Nov 18, 2021 at 05:49:15PM +0100, Jan Kara wrote:
> 
> > Test 17 from t6030-bisect-porcelain.sh assumes that bisection algorithm
> > suggests first HASH3 where HASH2 and HASH3 are equivalent choices. Make
> > sure test correctly handles both choices, add test variant to properly
> > test commit skipping in the second case.
> 
> OK, makes sense-ish: at least in the context of preparing for the
> bisection algorithm to change. The subject line leaves a bit to be
> desired, though. Perhaps:
> 
>   t6030: handle equivalent bisection points gracefully

Sure, I can improve all subjects to test updates like this.

> > diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> > index 1be85d064e76..f8cfdd3c36d2 100755
> > --- a/t/t6030-bisect-porcelain.sh
> > +++ b/t/t6030-bisect-porcelain.sh
> > @@ -197,11 +197,27 @@ test_expect_success 'bisect skip: successful result' '
> >  	test_when_finished git bisect reset &&
> >  	git bisect reset &&
> >  	git bisect start $HASH4 $HASH1 &&
> > -	git bisect skip &&
> > +	if [ $(git rev-parse HEAD) == $HASH3 ]; then
> 
> This is somewhat uncommon style for Git's test suite. It might be more
> appropriate to write instead:
> 
>     if test "$HASH3" = "$(git rev-parse HEAD)"
>     then
>       git bisect skip
>     fi &&
>     # ...

Sure. Will do.

> > +# $HASH1 is good, $HASH4 is bad, we skip $HASH2
> > +# but $HASH3 is good,
> 
> It looks like this comment should have gone above the start of the test
> in the previous hunk.
> 
> But it looks like you accidentally duplicated this test in its entirety
> (with the addition of the misplaced comment) below instead.

No, I think the comment and the test are correct. The first test tests
situation

H1--H2--H3--H4
^   ^   ^   ^
|   bad |   bad
good    skipped

the second test tests situation

H1--H2--H3--H4
^   ^   ^   ^
|   skipped   bad
good    good

So in both cases we can decide about the bad commit besides the skipped
commit. And if the bisection algorithm picks H2 out of H2/H3 (which are
equivalent) then second test tests this situation fully, if the bisection
algorithm picks H3, then the first test tests this situation fully.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
