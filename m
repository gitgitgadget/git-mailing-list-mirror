From: Jeff King <peff@peff.net>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with
 textconv filter
Date: Tue, 30 Oct 2012 08:17:48 -0400
Message-ID: <20121030121747.GA4231@sigill.intra.peff.net>
References: <508C29E4.5000801@arcor.de>
 <20121028120104.GE11434@sigill.intra.peff.net>
 <508D8DF7.7040007@arcor.de>
 <20121029060524.GB4457@sigill.intra.peff.net>
 <508EE4E4.1080407@arcor.de>
 <20121029223521.GJ20513@sigill.intra.peff.net>
 <20121029224705.GA32148@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 13:18:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTAlj-0007P6-0S
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 13:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933654Ab2J3MRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 08:17:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43739 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933545Ab2J3MRv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 08:17:51 -0400
Received: (qmail 31998 invoked by uid 107); 30 Oct 2012 12:18:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Oct 2012 08:18:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2012 08:17:48 -0400
Content-Disposition: inline
In-Reply-To: <20121029224705.GA32148@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208699>

On Mon, Oct 29, 2012 at 06:47:05PM -0400, Jeff King wrote:

> On Mon, Oct 29, 2012 at 06:35:21PM -0400, Jeff King wrote:
> 
> > The patch below fixes it, but it's terribly inefficient (it just detects
> > the situation and reallocates). It would be much better to disable the
> > reuse_worktree_file mmap when we populate the filespec, but it is too
> > late to pass an option; we may have already populated from an earlier
> > diffcore stage.
> > 
> > I guess if we teach the whole diff code that "-G" (and --pickaxe-regex)
> > is brittle, we can disable the optimization from the beginning based on
> > the diff options. I'll take a look.
> 
> Hmm. That is problematic for two reasons.
> 
>   1. The whole diff call chain will have to be modified to pass the
>      options around, so they can make it down to the
>      diff_populate_filespec level. Alternatively, we could do some kind
>      of global hack, which is ugly but would work OK in practice.
> 
>   2. Reusing a working tree file is only half of the reason a filespec
>      might be mmap'd. It might also be because we are literally diffing
>      the working tree. "-G" was meant to be used to limit log traversal,
>      but it also works to reduce the diff output for something like "git
>      diff HEAD^".
> 
> I really wish there were an alternate regexec interface we could use
> that took a pointer/size pair. Bleh.

Thinking on it more, my patch, hacky thought it seems, may not be the
worst solution. Here are the options that I see:

  1. Use a regex library that does not require NUL termination. If we
     are bound by the regular regexec interface, this is not feasible.
     But the GNU implementation works on arbitrary-length buffers (you
     just have to use a slightly different interface), and we already
     carry it in compat. It would mean platforms which provide a working
     but non-GNU regexec would have to start defining NO_REGEX.

  2. Figure out a way to get one extra zero byte via mmap. If the
     requested size does not fall on a page boundary, you get extra
     zero-ed bytes. Unfortunately, requesting an extra byte does not
     do what we want; you get SIGBUS accessing it.

  3. Copy mmap'd data at point-of-use into a NUL-terminated buffer. That
     way we only incur the cost when we need it.

  4. Avoid mmap-ing in the first place when we are using -G or
     --pickaxe-regex (e.g., by doing a big read()). At first glance,
     this sounds more efficient than loading the data one way and then
     making another copy. But mmap+memcpy, aside from the momentary
     doubled memory requirement, is probably just as fast or faster than
     calling read() repeatedly.

I am really tempted by (1).

Given that (2) does not work, unless somebody comes up with something
clever there, that would make (3) the next best choice.

-Peff
