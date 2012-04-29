From: Jeff King <peff@peff.net>
Subject: Re: Bug in git-stash(.sh) ?
Date: Sun, 29 Apr 2012 18:01:32 -0400
Message-ID: <20120429220132.GB4491@sigill.intra.peff.net>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
 <87wr4za9mr.fsf@gmail.com>
 <m2pqasb8mr.fsf@linux-m68k.org>
 <xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
 <CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
 <20380.33897.666338.766096@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Hodique <yann.hodique@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eli Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw@plane.gmane.org>,
	git@vger.kernel.org,
	Eli Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw@plane.gmane.org>,
	magit@googlegroups.com
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon Apr 30 00:01:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOcBa-0007M4-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 00:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218Ab2D2WBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 18:01:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51176
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002Ab2D2WBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 18:01:35 -0400
Received: (qmail 17478 invoked by uid 107); 29 Apr 2012 22:01:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 29 Apr 2012 18:01:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Apr 2012 18:01:32 -0400
Content-Disposition: inline
In-Reply-To: <20380.33897.666338.766096@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196516>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196516>

On Sat, Apr 28, 2012 at 07:59:37PM -0400, Eli Barzilay wrote:

> > How exactly do you make magit generate these calls?  AFAICT, Magit
> > should operate on whatever "git stash list" outputs, meaning
> > stash@{N}. So I guess I'm missing something.
> 
> ... right: the offending configuration I had was log.date = iso.  This
> calls for a simple chane for git-stash.sh to use `--date default':
> 
> 	git log --date default --format="%gd: %gs" -g "$@" $ref_stash --

I seem to remember dealing with this once a long time ago. And while
"--date=default" works, it is papering over the symptom of a larger
problem, which is that "log" should not use a non-commandline date to
make the stash selector decision. Searching turned up this discussion:

  http://thread.gmane.org/gmane.comp.version-control.git/128569

which led to f4ea32f (improve reflog date/number heuristic, 2009-09-24).
That fixed the case of:

  git config log.date iso
  git log -g --oneline

But later, 8f8f547 (Introduce new pretty formats %g[sdD] for reflog
information, 2009-10-19) added another way to show selectors, and it did
not respect the date_mode_explicit flag from f4ea32f. Which I think is a
bug.

So the right solution is to pass the date_mode_explicit flag through to
the pretty-print --format code, and then pass it along to the reflog
code.

> Another point is being able to see these dates, eg, make "stash list"
> show the stash{N} and also show the dates.

You can do so with:

  git stash list --date=iso

but there is no way to do it automatically via config (and indeed, you
can see that it creates problems for scripts when you do so. :) ).

> It looks to me like the date code in get_reflog_selector() should be
> *removed* since it can be printed with "%cd" or "%ad" in the log line.

No, all three are distinct dates. For example, from my git.git reflog:

  $ git log -g --format='%gd / %cd / %ad' --date=short
  HEAD@{2012-04-29} / 2009-09-29 / 2009-09-24

That's a commit (which happens to be f4ea32f) that was written on
2009-09-24 (author date), sent as a patch to the list and applied
upstream on 2009-09-29 (committer date), and reached my HEAD reflog via
"git checkout f4ea32f" three years later.

-Peff
