From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 29 Mar 2010 20:42:01 +0200
Message-ID: <201003292042.01549.trast@student.ethz.ch>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com> <201003282120.40536.trast@student.ethz.ch> <41f08ee11003282114m34aa0f61w536b996dce6cecab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	<git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 20:42:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwJug-0001Tj-9w
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 20:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab0C2SmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 14:42:08 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:48137 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab0C2SmG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 14:42:06 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 29 Mar
 2010 20:42:03 +0200
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 29 Mar
 2010 20:42:02 +0200
User-Agent: KMail/1.13.1 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.1; x86_64; ; )
In-Reply-To: <41f08ee11003282114m34aa0f61w536b996dce6cecab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143507>

Bo Yang wrote:
> Draft proposal(v3): Line-level History Browser
> 
> =====Purpose of this project=====
> "git blame" can tell us who is responsible for a line of code, but it
> can't help if we want to get the detail of how the lines of code have
> evolved as what it is now. For example, in Git, commit 93fc05e(Split
> off the pretty print stuff into its own file) split out
> pretty_print_commit() from commit.c into pretty.c, and it is hard to
> verify without much hassle that the code split was really only a code
> split, rather than a split with an evil change.

Is this really the right use-case?  AFAICT the answer to the implied
question is given by simply running 'git blame -M 93fc05e:pretty.c'.

(Coming up with a better example should be easy; the way I currently
think of the feature means that it will mostly replace git-blame for
me...)

> Note that, the history may not always be a single thread of commits.
> If there are more than one commits which produce the specified line
> range, or there are more than one source of code move/copy, the thread
> of history will split. And this utility may stop and provide all
> commits with its code changes to the user, let the user to select
> which one to trace next. Or, it may also use 'git log --graph' way to
> display the splitted history, we will provide options to control this.

I would, by far, prefer the latter.  So far 'git log' has always been
noninteractive, and there's no really good way to make it interactive
because it also goes through the pager.  (In the case of blame this is
solved in 'git gui blame', which might also be a reasonable approach.)

OTOH, if you can really fake a history walk, then just about any
log-oriented tool should be able to work with it.  You'd get graphical
output for free with gitk and git log --graph.  I haven't really
thought through the ramifications, though.

> =====Work and technical issues=====
> ==Scenario==
> For how we use the line level browser and how the utility should act
> to us, here is an scenario:
> http://article.gmane.org/gmane.comp.version-control.git/143024/match=line+level+history+browser
> It contains code movement between files but not code copy and fuzzy matching.

I would prefer if you could inline a short example, perhaps starting
at your second diff snippet.  Examples are good ;-)

Even if not, please drop the /match= parameter since it is very
distracting.

> 5. Simply fuzzy matching for code move/copy. Provide an option to
> control whether we start a fuzzy matching for performance reason. This
> can help us to find whether some code is really literally moved to
> here or with some evil changes. And this may also help in some
> situation like if we move some Java class to another file with only
> its class name changed. Anyway, fuzzy matching can help much on code
> detection. And there can be many fuzzy detect strategies, but we will
> only try to support the simplest one in this summer for time reason.
> Maybe a strategy like: 90% of the lines between two ranges of code are
> identical or 90% of words are identical. This will be discussed again
> before coding I think.
> 
> 6. Provide a configurable way for how to display the history. A 'git
> log --graph' way or stop to ask users when we meet history splitting.

See above.

> 7. Reuse 'git log' existing options as many as possible.

One thing that IMO is missing from this list, is a plumbing mode that
just feeds the raw data to a (presumed) frontend.  It could be as
simple as supporting

  git log -L ... --pretty=raw --raw

or similar, if this provides sufficient information.  Compare 'git
blame --porcelain'.

> ==Design and implementation==
> Git store all the blobs instead of code delta, so we should traverse
> the commit history and directly access the tree/blob objects to
> compute the code delta and search for the diff which contains the
> interesting lines. Since git use libxdiff to format its diff file, we
> should iterate through all xdiff's diff blocks and find what the code
> looks like before the commit. This will be done using the callback
> mechanism. Here, we will find a new line range which is the origin
> code before this commit. And then start another search from the
> current commit and the new line range. Recursively, we can find all
> the modification history. We will stop when we find that the current
> interested line range is added from scratch and is not moved from
> other place of the file. Here, if the user want to trace code copy,
> more work will be done to find the possible code copy. We may also
> stop the traverse when we reach the max search depth. Also, if the
> thread of change history split into two or more commits, we stop and
> provide the users all the related commits and corresponding line
> range.
> 
> Generally,
> 1. New callback for xdi_diff to parse the diff hunk and store line
> level history info.
> 2. builtin/line-log.c will be added to complete most of the new features.
> 3. builtin/log.c will be changed to add this new utility to the front end.
> 4. Documents will be updated to introduce this new tool.

This section is too handwavy for my taste.  I think in most cases you
say "we can" when you really mean "git-blame already does it, so we
can just use a similar algorithm".  Which is fine, but I'd rather see
it spelled out so as to see what is not already covered by blame's code.

> =====Milestones and Timeline=====
> In this summer, we will add support of line level history browser for
> only one file. The multiple ranges support is currently not in this
> project.

I agree with what Dscho pointed out earlier in the thread: multiple
ranges will be an easy exercise once you can follow a "blame split"
where half the lines blame to some file and half the lines blame to
another.

Other than that I think the milestones look sensible.  As a theory
guy, I'm not a huge believer in timelines, so lets hope someone else
comments on it.

> And there is one milestone for each week nearly, so every week, I will
> post a stutas update to the list to let the community know the project
> progress. And, patches will be sent for feature completion but not
> milestone.

Push the code somewhere public as you go, even between feature
completions.  Post RFCs once you have workable features so people can
comment.  Generally try to be visible.

Bonus points if you can think of something visible to do during the
period where you look at code,

> April 26 - May 23:
> 1st week, follow the bird's eye view on Git's source code.
> 2nd week, have a look at the code of merge-base, analyze the rev-listmachinery
> 3rd week, have a look at builtin/log.c,
> 4th week, understand blame.c

whether it be documenting your learnings in some way, improving docs
as you go, or documenting the APIs you find.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
