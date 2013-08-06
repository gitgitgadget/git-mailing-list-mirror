From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (Aug 2013, #01; Thu, 1)
Date: Tue, 6 Aug 2013 11:12:27 +0200
Message-ID: <87pptryyh0.fsf@linux-k42r.v.cablecom.net>
References: <7vbo5hqe6r.fsf@alter.siamese.dyndns.org>
	<87a9kz3uy4.fsf@hexa.v.cablecom.net>
	<7vsiyonp2w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 11:12:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6dJj-0001BH-Qa
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 11:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab3HFJMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 05:12:31 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:51389 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266Ab3HFJM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 05:12:29 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 6 Aug
 2013 11:12:26 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.253) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 6 Aug 2013 11:12:27 +0200
In-Reply-To: <7vsiyonp2w.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 5 Aug 2013 08:18:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231732>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> * tr/log-full-diff-keep-true-parents (2013-08-01) 1 commit
>>>  - log: use true parents for diff even when rewriting
>>>
>>>  Output from "git log --full-diff -- <pathspec>" looked strange,
>>>  because comparison was done with the previous ancestor that touched
>>>  the specified <pathspec>, causing the patches for paths outside the
>>>  pathspec to show more than the single commit has changed.
>>>
>>>  I am not sure if that is necessarily a problem, though.  Output
>>>  from "git log --full-diff -2 -- <pathspec>" without this change
>>>  will be applicable to some codebase, but after this change that
>>>  will no longer be true (you will get only tiny parts of the change
>>>  that were made by the two commits in question, while missing all
>>>  the other changes).
>>
>> Hmm.  Uwe's original complaint was that --stat -- as in "what other
>> things are touched when we modify foo" -- is nonsensical.
[...]
> I am not so worried about actually applying that kind of patch, but
> more about reviewing what happened in each of the single logical
> step shown.  If you made two changes in two far-apart commits to
> files you are interested in and want to look at the changes made to
> other files to make each of them a complete solution, depending on
> how the change was split across files, you would get useful to
> useless result with your patch.  In one extreme, if your commits are
> too fine-grained and you committed one path at a time, then
> "full-diff" will not show anything useful, as the commits that hit
> the pathspec do not have changes to any other paths.  In another
> extreme, you may have preparatory changes to other paths in commits
> that immediately precede the commit that hits the pathspec and then
> finally conclude the topic by introducing a caller of the prepared
> codepath in other files to the file you are interested in, and your
> patch will show only the endgame change without showing the
> preparatory steps, which may or may not be useful, depending on what
> you are looking for.
>
> So while I do understand why sometimes you wish to see full diff 
> "git log --full-diff -- <pathspec>" to match output from "git show"
> without pathspec, I am not sure doing it unconditionally and by
> default like your patch does is the best way to go.

I'm utterly unconvinced.

First, note that the behavior only shows when you use an option that
enables parent rewriting, such as --graph or --parents.

So if we went with a default-off option, there would be something like
--diff-original-parents.  The user would have to discover this option,
and use it whenever he wants to use --full-diff in combination with
--graph.  To obtain the same diffs as without --graph.

How do you explain that to a user?  "git-log has about 150 options.
Some of them interact badly, but don't worry, there are options in there
somewhere that make the weirdness go away."

  [No, I didn't actually count, but it seems a good estimate from
  looking at

    git grep -c -E '^-.*::' Documentation/rev-list-options.txt Documentation/diff-options.txt

  ]


Second, gitk's option "Limit diffs to listed paths", corresponding to
the inverse of --full-diff, shows the commits as with git-show.  (Not
internally, but still, the format is very similar.)  In particular it
only shows the changes from the commit itself.


Third, the only actual user data point I have is Uwe, who clearly
expected his diffs to remain the same across --graph.  There's a lot of
selection bias in this, because a happy user would not have complained,
but we can look at his example again (I added a right-hand side to the
range to make it reproducible).

With the patched version:

  $ git log --parents --stat v3.8..v3.9 --full-diff -- drivers/net/ethernet/freescale/fec.c
  commit 8d7ed0f051caf192994c02fbefb859eac03d1646 14109a59caf93e6eae726a34bf2f0897508ec8c1
  [...]
      net: fec: fix regression in link change accounting
  [...]
   drivers/net/ethernet/freescale/fec.c | 1 +
   1 file changed, 1 insertion(+)

With current master:

  commit 8d7ed0f051caf192994c02fbefb859eac03d1646 14109a59caf93e6eae726a34bf2f0897508ec8c1
  [...]
      net: fec: fix regression in link change accounting
  [...]
   Documentation/sound/alsa/ALSA-Configuration.txt    |    5 +-
   MAINTAINERS                                        |   22 +-
   Makefile                                           |    2 +-
   arch/alpha/Makefile                                |    2 +-
  [...]
   509 files changed, 9507 insertions(+), 7014 deletions(-)

509 files.  I don't know about you, but I think that's completely
useless for reviewing anything.


The only compromise I can see flying is using something like
--diff-parents=original and --diff-parents=rewritten, defaulting to
'original'.  Behind the scenes they would toggle the appropriate
machinery: 'rewritten' would enable parent simplification even when it
is not otherwise enabled, and 'original' would enable saving parents
whenever simplification is enabled.  Naturally all of this only applies
with --full-diff.


> In the meantime:
>
>     git rev-list --header --parents HEAD -- <pathspec> |
>     git -p diff-tree -p --stdin
>
> would be one way to do so.

Well, as a data point on how realistic this is, consider two things:

* I've hacked around on git for about five years now, and do not
  remember ever noticing or using --header.  Nor, for that matter, ever
  using rev-list|diff-tree for actual work.

* It doesn't work at my end: it doesn't show any diffs.  Removing
  --header helps, but then you lose the log messages.  --pretty again
  breaks the diffs.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
