Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9838C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896BA6124C
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhESWKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 18:10:12 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57573 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESWKL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 18:10:11 -0400
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5F7E66000B;
        Wed, 19 May 2021 22:08:48 +0000 (UTC)
Date:   Wed, 19 May 2021 15:08:46 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Standardized escaping to store a .git in git?
Message-ID: <YKWMbh/j1ZiMZiGs@localhost>
References: <YKV8hEAxIzolnROX@localhost>
 <YKWDlF59jWoyE+xJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKWDlF59jWoyE+xJ@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 02:31:00PM -0700, Jonathan Nieder wrote:
> Josh Triplett wrote:
> > On rare occasions, a project may need to store and version a .git
> > directory in a git repository. For instance, a project that interacts
> > with git repositories may need test cases. Or, a project using git to
> > store backups may also want to back up git repositories. `.git` is the
> > only filename that git can't transparently store and version.
>
> My take on this might be a bit surprising, but it's probably worth
> spelling out anyway: Git is first and foremost a source code
> management tool, and ".git" directories are not a good interchange
> format, so while I have sympathy for this use case, I do _not_ think
> that Git should make changes that hurt other use cases in order to
> support it.

I absolutely agree that such changes would be entirely inappropriate if
they hurt other use cases. That's part of why I'm suggesting that I
don't think any *defaults* in git should change. My hope is more to have
some kind of guidance along the lines of "if you need to do escaping, do
it this way", to lead towards having one canonical way to do such
escaping rather than multiple incompatible ways.

Part of my motivation, here, is that I'm looking to implement one such
escaping mechanism (in a tool built atop libgit2 that needs to handle
and version arbitrary files), and rather than inventing something
bespoke I'd love to interoperate. And since I've seen various approaches
used in the wild, I didn't want to add Yet Another distinct approach
before starting a design conversation about it.

> Instead, I recommend doing one of the following, in order from most to
> least preferred:
> 
>  1. Make the test case run git commands to create a Git repository.
>     This makes it obvious what the test is trying to do, without
>     having to deal with unrelated details also recorded in ".git".
>     This is what Git's test suite does, for example.
> 
>  2. Check in a fast-import file and use "git fast-import" to make a
>     Git repository out of it.
> 
>  3. Check in a "git bundle" file and use "git clone" to make a Git
>     repository out of it.

For the test-case approach, these are potentially workable, though they
only work if you just need a git repo with a given set of semantics,
rather than a binary-identical test case.

For the storing-arbitrary-files case, these wouldn't apply.

>  4. Check in an archive file (e.g., tar) containing a .git directory.
>     (I consider this preferable over checking in a .git directory
>     directly because it prevents a user from accidentally "cd"-ing
>     into it and running git commands within the checked-in repository
>     that they intended to run in the top-level repository.  That seems
>     especially worth preventing because the checked-in repository can
>     contain git aliases and other settings such as core.pager that
>     cause automatic code execution, as you mentioned.)

Storing as an archive is an option, but that would then require tools
that want to track arbitrary files to distinguish between "tar file that
should be unpacked" and "tar file that was originally a tar file". It's
also a harder format to interoperate with.

To clarify, I don't think the default behavior of git should be to
un-escape this escaping mechanism. Rather, I think the default behavior
should be to treat the filenames as literal, and the user could opt in
to un-escaping on checkout and escaping on check-in.
