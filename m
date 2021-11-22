Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749ABC433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 12:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbhKVMww (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:52:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59596 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhKVMwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 07:52:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7A5911FCA3;
        Mon, 22 Nov 2021 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637585384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UwHrPiuiW9MtohTR0EgDD/WqU1sQnt0BwHaVw9A19M=;
        b=A4sOVzvBmM05j7+N6zGLIiZDJ5/5o+bdHL28uYpajHh/gqvePGTFmEP7Me/gINEuPDGpeF
        EZJCKEKOIqf/XjjlWyJGmHmQir4cyK947jLbtRbmhXR8s7YVk38mFVQ3M+H+EhouUc30gG
        ywXP9rvJwz4eDwcShx/qaU6CuYxC7Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637585384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UwHrPiuiW9MtohTR0EgDD/WqU1sQnt0BwHaVw9A19M=;
        b=2KFlI7aufGpr7FEY0YRhVAleGpBpVE55Dj83jg1EtLkUFcvK8AmI4cmugdJ+baUzEjKaMB
        ZdenadIYNMvItwCQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 6DB00A3B89;
        Mon, 22 Nov 2021 12:49:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 581EA1F2B50; Mon, 22 Nov 2021 13:49:44 +0100 (CET)
Date:   Mon, 22 Nov 2021 13:49:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Chris Torek <chris.torek@gmail.com>, Jan Kara <jack@suse.cz>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 03/27] bisect: Fixup test bisect-porcelain/20
Message-ID: <20211122124944.GE24453@quack2.suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
 <20211118164940.8818-4-jack@suse.cz>
 <CAPx1Gvfe46JFeNT8nW6NcFFy7bnR+eWYKS0-5soPVTmPxxJccA@mail.gmail.com>
 <YZbPY9is4+4q2rxF@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZbPY9is4+4q2rxF@nand.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu 18-11-21 17:10:43, Taylor Blau wrote:
> On Thu, Nov 18, 2021 at 12:13:21PM -0800, Chris Torek wrote:
> > On Thu, Nov 18, 2021 at 10:39 AM Jan Kara <jack@suse.cz> wrote:
> > > diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> > > index f8cfdd3c36d2..13f7deea4d81 100755
> > > --- a/t/t6030-bisect-porcelain.sh
> > > +++ b/t/t6030-bisect-porcelain.sh
> > > @@ -240,8 +240,13 @@ test_expect_success 'bisect skip: cannot tell between 3 commits' '
> > >  test_expect_success 'bisect skip: cannot tell between 2 commits' '
> > >         test_when_finished git bisect reset &&
> > >         git bisect start $HASH4 $HASH1 &&
> > > -       git bisect skip &&
> > > -       test_expect_code 2 git bisect good >my_bisect_log.txt &&
> > > +       if [ $(git rev-parse HEAD) == $HASH2 ]; then
> > > +               results=('good' 'skip')
> > > +       else
> > > +               results=('skip' 'good')
> > > +       fi &&
> > > +       git bisect ${results[0]} &&
> > > +       test_expect_code 2 git bisect ${results[1]} >my_bisect_log.txt &&
> >
> > These are also not available in old POSIX shell - consider using two
> > separate variables to hold the two strings.
> 
> Or just inlining the commands that you actually want to run inside of
> the if statement above:
> 
>     if test "$HASH2" = "$(git rev-parse HEAD)
>     then
>       git bisect good &&
>       test_expect_code 2 git bisect skip >my_bisect_log.txt
>     else
>       git bisect skip &&
>       test_expect_code 2 git bisect good >my_bisect_log.txt
>     fi && #...
> 
> Here (and in the previous patch) it might be helpful to add a short note
> in these conditionals, maybe along the lines of:
> 
>     # HASH2 and HASH3 are equivalent choices, but we only want to mark
>     # HASH2 as "good". Handle either ordering:
> 
> Same note on the brevity of the subject line applies here, too.

Sure, I'll fix these. Thanks for review.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
