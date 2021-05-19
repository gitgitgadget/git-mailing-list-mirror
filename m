Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A730C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 21:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C30F6023B
	for <git@archiver.kernel.org>; Wed, 19 May 2021 21:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhESVCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 17:02:20 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43511 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhESVCR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 17:02:17 -0400
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7FC82240004
        for <git@vger.kernel.org>; Wed, 19 May 2021 21:00:55 +0000 (UTC)
Date:   Wed, 19 May 2021 14:00:52 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     git@vger.kernel.org
Subject: Standardized escaping to store a .git in git?
Message-ID: <YKV8hEAxIzolnROX@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On rare occasions, a project may need to store and version a .git
directory in a git repository. For instance, a project that interacts
with git repositories may need test cases. Or, a project using git to
store backups may also want to back up git repositories. `.git` is the
only filename that git can't transparently store and version.

I've seen projects take different approaches to work around this. For
instance, the libgit2 project renames the `.git` directory to `.gitted`,
and then their test framework copies that to a temporary directory as
`.git`.

Would it make sense to have a standardized escaping mechanism for this,
that git could then standardize the handling of in a safe way (taking
both project configuration and local configuration into account)? Such a
mechanism would not, by default, result in git checking out a `.git`
directory verbatim, as that wouldn't be safe (due to hook scripts and
due to searches for .git directories), but a user could configure their
own system to do so for a specific project, tools like `git archive`
could have a way to un-escape the directory in a generated archive, and
references to objects within a treeish could use such paths.
Standardizing this would allow tools to interoperate rather than each
inventing their own convention.

(Note that today, git *can* successfully check in, version, update, and
check out a bare repo.git directory, just not a non-bare .git
directory.)

As one possible escaping (absolutely subject to bikeshedding):

- Reserve names starting with a specified character (e.g. \x01); call
  that escape character E.
- Encode filenames that actually start with E to start with EE
- Encode .git as E.git
- Require an opt-in to interpret this escaping; tools that don't
  interpret this escaping will still be able to operate on the files, in
  much the same way that it's possible to operate on a symlink as if it
  were a file containing the target path.

There are tradeoffs here: using a more type-able escape character would
be convenient if a user ever had to deal with the raw name, but on the
other hand, using a more type-able escape character would make the need
to escape the escape character come up more often.

Regardless of the specific approach to escaping `.git`, does the general
idea of standardizing such escaping across tools seem like something git
could potentially do, to allow transparently storing *any* file or
directory in a git repository?

- Josh Triplett
