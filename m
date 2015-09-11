From: Stephen Connolly <stephen.alan.connolly@gmail.com>
Subject: [Feature Request] git blame showing only revisions from git rev-list --first-parent
Date: Fri, 11 Sep 2015 11:47:30 +0100
Message-ID: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 12:47:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaLrq-0003D7-QY
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 12:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbbIKKrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 06:47:32 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34797 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbbIKKrb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 06:47:31 -0400
Received: by lbbmp1 with SMTP id mp1so37464237lbb.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=sgWAptc62BGn/iTC+A6R83ZqcpWoQ5B/joBG6SHGCec=;
        b=hD4uN6Nepb8q9tZiPmmBBD3UNeYHjoO+cNW0yG+zxkpa2E/2bYPzGVH38VhsA75gnh
         cA7Vj4lRZoIRq1K6KgTzlRfVBtxFqxN1dN60THS6fNrSbAlpT6II9ts9t0rzNA0jTbZK
         ppt1/tW6NGU0dJNpUOZYvXxkbKKZm/ZtWXRPtLVGEC+q9F2Io9YKK3C5J+h+UeVVUL7q
         n+sKhSq5i7FQjBM/xq4J86aPu3gdpTm4D8k2lAg2xVOV1HLqd1Jz5VLeIOmVYiD52tpy
         L0CFzTM46VrHcqbU39W+iPSDXzLOW4HipNqpKpKAdS4f3V8mBx8cC22KES6GvwqkLnVa
         L5MA==
X-Received: by 10.112.198.66 with SMTP id ja2mr766478lbc.22.1441968450497;
 Fri, 11 Sep 2015 03:47:30 -0700 (PDT)
Received: by 10.25.20.28 with HTTP; Fri, 11 Sep 2015 03:47:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277658>

Background
===

My colleagues and I disagree on how exactly to handle feature
development in branches.
There are approximately two camps:

Camp 1: All feature branches should be squashed after code review to a
single commit before merging.

Camp 2: Leave the history of development alone, being able to trace
why the feature evolved that way is useful information, never squash
commits after code review.

Being somebody who leans towards the second camp I have been trying to
understand the first camps objections...

Those objections seem to boil down to tracing when the feature was introduced.

I have been able to get past some of the objections by pointing out
the `--first-parent` option available to `git log` and `gitk`. With
that command line option they are presented with a single history of
the branch and all merge commits are shown *as if squashed* (or at
least that is what it looks like from my testing)

The only remaining objection is around `git blame`...

You see a problem on one line in the file, you run `git blame
file.txt` and it says <rev1> was when it changed...

Now <rev1> is not on the main line of the branch but actually is a
commit that was merged from one branch to another before finally being
merged into the current branch in <rev2>

That is a complex nest of commits to detangle, especially when we have
had some refactoring branches with multiple experiments that drag on
over the course of a couple of weeks with many commits... all they
want to know is <rev2>.

Yes I could (and I do try to) teach them how to find the commit where
that SHA was merged into the current branch, but really they just want
to be able to see the current branches SHAs only.

Doing some reading in the git blame sources I discovered that git
blame takes the rev-list command line options... so I thought "hey
--first-parent should work"

Except it doesn't

I suspect that this is because of how blame uses rev-list

Request
===

A command line option to `git blame HEAD -- path` that instructs that
the revisions of blame be the revisions where the change was applied
to the current branch not the revision where the change first
originated (i.e. limit commits to `git rev-list --first-parent HEAD`)

I can get what I want with the following:

git rev-list --first-parent HEAD | awk '{print p " " $0}{p=$0}' >
tmpfile && git blame -b -S tmpfile HEAD -- path && rm tmpfile

But that is a rather ugly command. Could we have something built in to
git blame to make this much easier for users?

Thanks
