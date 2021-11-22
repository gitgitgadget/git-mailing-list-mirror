Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA8C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 12:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbhKVMQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:16:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49148 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbhKVMQP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 07:16:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E455D218BB;
        Mon, 22 Nov 2021 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637583187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nyb/1b5Q+g9G0/yc+2Q1BGiA2SlZuZSHvwQUVZFS4pY=;
        b=w1weHFqrFd/BZLq/n+t18FsZF0ZMn/UfAdZace+MqOwMI5VUsLT2EM4RCbQmroKdxzb3lx
        QL6SbpDzVLNqf81013gKPD5fgWSpFrsWb4+ZJwfwtAc/kosz10uJwKN4oFvdwfyWMm44aM
        SejlqX3GPqMvpF1TpdIUSE0SOcqd/Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637583187;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nyb/1b5Q+g9G0/yc+2Q1BGiA2SlZuZSHvwQUVZFS4pY=;
        b=LoH8a6ft2/ftEAUZUcPAl9D9P6wTyO6U5Ud2zThFDeJkR1g7Jmcq4YGhmCxJt/l2EYRZg0
        EPSKiPhI8jGUxoDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id D36AAA3B83;
        Mon, 22 Nov 2021 12:13:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B173B1E3C6D; Mon, 22 Nov 2021 13:13:07 +0100 (CET)
Date:   Mon, 22 Nov 2021 13:13:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jan Kara <jack@suse.cz>, git@vger.kernel.org
Subject: Re: Stochastic bisection support
Message-ID: <20211122121307.GB24453@quack2.suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
 <YZbYjFpA1bpeebx+@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZbYjFpA1bpeebx+@nand.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu 18-11-21 17:49:48, Taylor Blau wrote:
> On Thu, Nov 18, 2021 at 05:49:13PM +0100, Jan Kara wrote:
> 
> > The first part of the series improves some tests so that they accept
> > other valid decisions for bisection points. This is needed because to
> > make it easier to share some logic between normal and stochastic
> > bisection, I needed to slightly change some bits for normal bisection
> > and then since commit weights will be computed in a somewhat different
> > order, also chosen bisection points are sometimes different.
> 
> I have only looked through a couple of the first half of your patches,
> but I'm not sure I understand why non-stochastic bisection needs to
> change at all in order to support stochastic bisection.
> 
> In other words, if we're tweaking all of these tests to allow picking
> equivalent bisection points, why can't we simply leave them alone? It
> would be nice if normal bisection didn't change as a result of adding a
> new feature on top.

The big part of why results for normal bisection change are the changes in
"bisect: Reorganize commit weight computation" to function
do_find_bisection() where previously we didn't call approx_halfway() on the
commits at the end of chain (looks like unintended omission) while after my
changes we call approx_halfway() for all commits. And I have reorganized
do_find_bisection() because I reuse it for stochastic bisection as well and
the code is IMO easier to understand after reorganization so it is still
comprehensible after I add there complexity of stochastic bisection.

I understand the churn in the tests is unwelcome but long-term it seems
like a low enough cost to pay for more maintainable code. But if git
maintainers think otherwise I can try keeping classic bisection code
decisions without changes. Just let me know what you prefer.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
