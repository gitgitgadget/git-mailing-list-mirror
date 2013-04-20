From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Some observations on log -L
Date: Sat, 20 Apr 2013 17:24:59 +0200
Message-ID: <87bo99usvo.fsf@hexa.v.cablecom.net>
References: <CALkWK0k+LYro8jpmfRPmX8Wsj6aEWzyq3DYa6waDMsh5B=X7Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 17:25:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZf9-0003Ay-K1
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 17:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396Ab3DTPZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 11:25:07 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:15320 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755367Ab3DTPZG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 11:25:06 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 20 Apr
 2013 17:24:57 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 20 Apr
 2013 17:25:02 +0200
In-Reply-To: <CALkWK0k+LYro8jpmfRPmX8Wsj6aEWzyq3DYa6waDMsh5B=X7Tg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 20 Apr 2013 15:26:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221869>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Ever since 'git log -L' made it to `pu`, I've been playing with it to
> see how it can be useful.  Here are some of my observations:
>
> 1. Specifying line ranges by hand are too painful.  I would really
> love it if it could parse the lines off a patch prepared by
> format-patch or something.

True, but I'm not sure that starting from a patch is the right thing.
At least in my case, when I have a patch ready, I longer need to
investigate anything ;-)

Perhaps a "line-log all the ranges touched by this commit" would be more
useful.

You can achieve both with some hack like

  eval git log 1640632 $(git show 1640632 | perl -ne '
    $h=1 if /^diff /;
    $f=$1 if $h and m{\+\+\+ ./(.*)$};
    if (/@@ .* \+(\d+)(?:,(\d+))/) {
      print " -L$1,+$2:$f"; $h=0;
    };
  ')

Note that you need to specify the commit in two places.  I think I'll
actually make that a script and try it to see if it's worth
implementing.  Quoting of the -L args is of course an exercise left to
the reader ;-)

> 2. Specifying regex ranges are really useful to see the history of a
> function.  But I think it could really benefit from a tool that
> actually understands the language (using Clang Tooling).  If we were
> to build such a tool, git-core could benefit immensely from it: we'd
> have smarter merges too, for instance.

Is there any research on this?

I imagine you would use whatever parser you have at hand to process the
input into a syntax tree, then run diff over those trees.  There should
be some research on how to get meaningful diffs of them?  And then you
somehow have to turn the tree-diff into a human-readable output.

In any case you could start by prototyping such a diff algorithm on a
file basis; people could then start using it as an external diff driver.

> 3. Often, I want to know the people to contact for a segment of code.
> Blame is useless here, because it only considers the most recent
> commit, when I want to know the authors of all the commits that helped
> shaped that segment of code.  So, I think shortlog could really
> benefit from a -L.  Is this easily doable?

Not really.  You're touching on a sore point of the current
implementation, which is that it's not properly tied into the log and
diff infrastructures.  I figured that would block it for too long, so I
gave up on trying to do that for the first version.

So it just runs captures the history that log walks, does a separate
processing step and handcrafts a diff in its own output machinery, which
isn't very nice for many reasons, including that we can't run any other
diff- or log-like stuff on top of log -L output.

That precludes many uses, like shortlog you mentioned, or color-words.
I think Junio and me hashed out some ideas for how it *should* be tied
together in some earlier thread.  The gist of it is that there are
really three separate things going on here:

* Pathspec-like filtering with proper -M support.  This should be
  unified with --follow.  That's actually the next thing I want to try,
  because it should give a properly implemented --follow along the way.

* A pass of commit filtering based on intersecting the ranges we're
  interested in with the diffs of commits, and mapping them "across".
  This should be hooked as a cleanly separated step into the log
  machinery.

* Diff output filtering based on the ranges that we found.  This should
  be done as a filter somewhere in the diff machinery, preferably before
  word-diff.

(The first step is actually a performance optimization, but it would not
be a practical algorithm without it.)

Thanks for the input.  Let me know if you manage to break it somehow :-)


And for a bit of shameless pluggery (you probably saw it on IRC already,
but mainly for other curious readers):

  git://github.com/trast/git.git tr/gitk-line-log

has a version of gitk that supports -L.  I hacked it up yesterday, and
while it seems to work, I want to play with it a little until I'm
satisfied that I didn't break gitk for other uses.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
