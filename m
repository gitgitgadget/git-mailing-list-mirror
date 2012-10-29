From: Jeff King <peff@peff.net>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with
 textconv filter
Date: Mon, 29 Oct 2012 18:47:05 -0400
Message-ID: <20121029224705.GA32148@sigill.intra.peff.net>
References: <508C29E4.5000801@arcor.de>
 <20121028120104.GE11434@sigill.intra.peff.net>
 <508D8DF7.7040007@arcor.de>
 <20121029060524.GB4457@sigill.intra.peff.net>
 <508EE4E4.1080407@arcor.de>
 <20121029223521.GJ20513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 23:47:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSy78-0006sU-5x
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 23:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761172Ab2J2WrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 18:47:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43169 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761120Ab2J2WrI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 18:47:08 -0400
Received: (qmail 25049 invoked by uid 107); 29 Oct 2012 22:47:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 18:47:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 18:47:05 -0400
Content-Disposition: inline
In-Reply-To: <20121029223521.GJ20513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208655>

On Mon, Oct 29, 2012 at 06:35:21PM -0400, Jeff King wrote:

> The patch below fixes it, but it's terribly inefficient (it just detects
> the situation and reallocates). It would be much better to disable the
> reuse_worktree_file mmap when we populate the filespec, but it is too
> late to pass an option; we may have already populated from an earlier
> diffcore stage.
> 
> I guess if we teach the whole diff code that "-G" (and --pickaxe-regex)
> is brittle, we can disable the optimization from the beginning based on
> the diff options. I'll take a look.

Hmm. That is problematic for two reasons.

  1. The whole diff call chain will have to be modified to pass the
     options around, so they can make it down to the
     diff_populate_filespec level. Alternatively, we could do some kind
     of global hack, which is ugly but would work OK in practice.

  2. Reusing a working tree file is only half of the reason a filespec
     might be mmap'd. It might also be because we are literally diffing
     the working tree. "-G" was meant to be used to limit log traversal,
     but it also works to reduce the diff output for something like "git
     diff HEAD^".

I really wish there were an alternate regexec interface we could use
that took a pointer/size pair. Bleh.

-Peff
