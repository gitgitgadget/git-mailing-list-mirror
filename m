Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 260301F461
	for <e@80x24.org>; Wed, 15 May 2019 19:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEOTYB (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 15:24:01 -0400
Received: from thyrsus.com ([71.162.243.5]:52228 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfEOTYB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 15:24:01 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2019 15:24:00 EDT
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 21D394703049; Wed, 15 May 2019 15:16:05 -0400 (EDT)
From:   esr@thyrsus.com (Eric S. Raymond)
To:     git@vger.kernel.org
Subject: Finer timestamps and serialization in git
Message-Id: <20190515191605.21D394703049@snark.thyrsus.com>
Date:   Wed, 15 May 2019 15:16:05 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent increase in vulnerability in SHA-1 means, I hope, that you
are planning for the day when git needs to change to something like
an elliptic-curve hash.  This means you're going to have a major
format break. Such is life.

Since this is going to have to happen anyway, let me request two
functional changes in git. Neither will be at all difficult, but the
first one is also a thing that cannot be done without a format break,
which is why I have not suggested them before.  They come from lots of
(often painful) experience with repository conversions via
reposurgeon.

1. Finer granularity on commit timestamps.

2. Timestamps unique per repository

The coarse resolution of git timestamps, and the lack of uniqueness,
are at the bottom of several problems that are persistently irritating
when I do repository conversions and surgery.

The most obvious issue, though a relatively superficial one, is that I have
to thow away information whenever I convert a repository from a system with
finer-grained time.  Notably this is the case with Subversion, which keeps
time to milliseconds. This is probably the only respect in which its data
model remains superior to git's. :-)

The deeper problem is that I want something from Git that I cannot
have with 1-second granularity. That is: a unique timestamp on each
commit in a repository. The only way to be certain of this is for git
to delay accepting integration of a patch until it can issue a unique
time mark for it - obviously impractical if the quantum is one second,
but not if it's a millisecond or microsecond.

Why do I want this? There are number of reasons, all related to a
mathematical concept called "total ordering".  At present, commits in
a Git repository only have partial ordering. One consequence is that
action stamps - the committer/date pairs I use as VCS-independent commit
identifications in reposurgeon - are not unique.  When a patch sequence
is applied, it can easily happen fast enough to give several successive
commits the same committer-ID and timestamp.

Of course the commit hash remains a unique commit ID.  But it can't
easily be parsed and followed by a human, which is a UX problem when
it's used as a commit stamp in change comments.

More deeply, the lack of total ordering means that repository graphs
don't have a single canonical serialized form.  This sounds abstract
but it means there are surgical operations I can't regression-test
properly.  My colleague Edward Cree has found cases where git fast-export
can issue a stream dump for which git fast-import won't necessarily
re-color certain interior nodes the same way when it's read back in
and I'm pretty sure the absence of total ordering on the branch tips
is at the bottom of that.

I'm willing to write patches if this direction is accepted.  I've figured
out how to make fast-import streams upward-compatible with finer-grained
timestamps.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

