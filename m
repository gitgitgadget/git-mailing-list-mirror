Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D13CC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED43600EF
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhFCK13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 06:27:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50020 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCK13 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 06:27:29 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 26CC4219D7;
        Thu,  3 Jun 2021 10:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622715944;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cZJBCRtT1ELw6dkTzAbcE6+F5s7IW/n8Eb6llqxk028=;
        b=YTwAYVBjW50Aj5sXbmFNJwKRISGcXcsnTwGmQzxCX8Zb9VNGkffyLae+TFNSsyiWa6UL4/
        x+RLoz/viKT5pLqqvaSOt4Z2VjPgXkscYiUX0/0aRxLMteR+Z30RKtmb6FNInd8QDfJk6c
        JR88C57Tx8L92I3I7F4RgZWTTd0p/U8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622715944;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cZJBCRtT1ELw6dkTzAbcE6+F5s7IW/n8Eb6llqxk028=;
        b=WLafq4mrilE0X6kdHPDQ9nakrEN9DI1cxjIYfKBLcx4OMFFzQGCOi7Xu0x+6awyHWcpRn2
        XqHV8t+mRDDkM8Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 18FA5A3B91;
        Thu,  3 Jun 2021 10:25:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 408C6DA734; Thu,  3 Jun 2021 12:23:03 +0200 (CEST)
Date:   Thu, 3 Jun 2021 12:23:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     git@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: git feature request: git blame --ignore-cleanup/--ignore-trivial
Message-ID: <20210603102303.GX31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        git@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 11:20:35AM -0400, Mathieu Desnoyers wrote:
> Following a discussion with Peter Zijlstra about whether code cleanup
> and functional changes done to the Linux kernel scheduler belong to separate
> patches or should be folded together, the argument for folding cleanup
> and function changes came to be mainly motivated by the current behavior
> of git blame: code cleanup patches end up burying the important changes so
> it becomes cumbersome to find them using git blame.
> 
> Considering the added value brought by splitting cleanups from functional changes
> from a maintainer perspective (easier reverts) and from a reviewer perspective
> (easier to focus on the functional changes), I think it would be good to improve
> the git tooling to allow easily filtering out the noise from git blame.
> 
> Perhaps a new git blame "--ignore-trivial" and/or "--ignore-cleanup" could solve
> this by filtering out "trivial" and "cleanup" patches from the history it considers.
> 
> Tagging patches as trivial and cleanup should be done in the patch commit message
> (possibly in the title), and enforcing proper tagging of commits is already the
> responsibility of the maintainer merging those cleanup/trivial commits into the
> Linux kernel anyway.
> 
> Under the hood, I suspect it could use something similar to git log --grep=<pattern>
> --invert-grep.
> 
> This should allow git blame users to easily filter out the noise and focus on the relevant
> functional changes.
> 
> Any maybe the patterns associated to "cleanup" and "trivial" commits should be something
> that can be configured through a git config file.

As long as the subsystem policy is consistent, eg. always split cleanups
from functional changes, and make the trivial cleanups really obvious
either from code or mentioned in the changelog, I don't see a need for
a tooling.

Going through unrelated cleanups when digging in the git history is
annoying and I think it's up to maintainers' and developers' decision
what kind of cleanups are desired (because they make the code better,
not just because they're trivial).  Mandating some sort of tagging is
just another burden, if it's not applied consistently it won't be
reliable so it won't help much.
