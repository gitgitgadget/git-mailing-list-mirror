From: Mike Hommey <mh@glandium.org>
Subject: Is there interest in a n-sect tool?
Date: Mon, 18 Jan 2016 16:56:53 +0900
Message-ID: <20160118075653.GA13911@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 08:57:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL4gT-0005Kg-SL
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 08:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbcARH5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 02:57:01 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33144 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbcARH5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 02:57:00 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aL4gH-0003pl-FV
	for git@vger.kernel.org; Mon, 18 Jan 2016 16:56:53 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284280>

Hi,

[Some background]
As you may be aware, I'm working on git-cinnabar, which allows to clone
mercurial repositories with git. I reached a point where I decided I
didn't want to do more without having a test suite that I can run in a
few minutes (or even better, seconds) instead of the hours that my
current testing setup takes (the multi-hour tests I run are still
valuable, though, but for different reasons).

Now, what I'm doing is compiling a list of changes to git-cinnabar
that affected how several mercurial repositories are cloned, to
identify the interesting patterns that I've encountered in the past
so that they appear in some form in the light test suite I want to
run on each commit.

Checking clones of the 4 mercurial repositories I've been using for
most of my testing so far takes more than half an hour (because one
of them is mozilla-central, and that's large). There are 300+ commits
in the git-cinnabar repository, so testing them one by one would take
150+ hours, or more than 6 days...

This is where binary search would be useful, but bisect only handles
two states. So what I was really after is n-sect. Which, in fact, is
kind of possible albeit cumbersome, with bisect. So I now have a semi
automatic half-broken setup that works for my use case.

What it does, essentially looks like this:
- I have a script that, for a given git-cinnabar commit, clones
  those four mercurial repositories, and determines a global state
  for the resulting repositories. (for example, the sha1sum of all
  the sha1s of the remote refs for all repositories)
- The script is run for the earliest commit and gives a sha1.
- Then I bisect run with a script wrapping the other, returning 0
  when the state is the same as the one for the earliest commit,
  or 1 otherwise.
- The result of that first bisection is the first state change.
- Then I bisect run again, using the state of the result of that first
  bisect instead of the earliest commit.
- The result of that second bisection is the second state change.
- And so on...

I do, in fact, cache the states for each iteration of each bisect,
so that I can do some smarter decisions than just start from the last
bisection for the next one.

I don't have that many state changes to track, but I do have different
kind of states that I want to track down, so I will be running this
a couple more times.

The question is, is there sufficient interest in a generic n-sect tool
for me to justify spending the time to do it properly, vs. just doing
the minimalist thing I did to make it work for my use case.

If there is, what should it look like, UX-wise? An extra mode to bisect?
A separate tool, which bisect could eventually become a special case of?
Other thoughts?

Cheers,

Mike
