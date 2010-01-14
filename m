From: Jeff King <peff@peff.net>
Subject: Re: touching a file causes it to be listed using git diff-files
Date: Thu, 14 Jan 2010 01:39:39 -0500
Message-ID: <20100114063939.GA17565@coredump.intra.peff.net>
References: <p0624080ec7740ddc4caf@[63.138.152.134]>
 <20100114030204.GB1878@coredump.intra.peff.net>
 <p06240810c774498d4a2e@[63.138.152.134]>
 <20100114052658.GA13973@coredump.intra.peff.net>
 <p06240813c77462aa2cfb@[63.138.152.134]>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 07:40:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVJNF-0007z5-U3
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 07:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab0ANGjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 01:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313Ab0ANGjn
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 01:39:43 -0500
Received: from peff.net ([208.65.91.99]:37698 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837Ab0ANGjm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 01:39:42 -0500
Received: (qmail 4587 invoked by uid 107); 14 Jan 2010 06:44:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 Jan 2010 01:44:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2010 01:39:39 -0500
Content-Disposition: inline
In-Reply-To: <p06240813c77462aa2cfb@[63.138.152.134]>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136953>

On Thu, Jan 14, 2010 at 12:57:05AM -0500, Stephen Bannasch wrote:

> >> 'git diff' also stats the files but strangely 'git diff --quiet' doesn't ???
> >
> >I can't reproduce that behavior here on the current "master". Old
> >versions of git used to not do the index refresh for "diff". What
> >version of git are you using?
> 
> The most recent test was on:
> 
> $ git --version
> git version 1.6.6

Ah, OK, I figured it out. It is due to the early return of "--quiet".
Since we know we are simply returning a status of "all the same" or "at
least one difference", we can quit after finding the first difference.

So if you have two files, "a" and "b", you can try:

  $ touch a
  $ echo changes >b
  $ git diff --quiet
  $ git diff-files

and you will see that 'a' has been updated, because we traverse the
files in sorted order and quit only after seeing 'b'.

But if you do instead:

  $ touch b
  $ echo change >a
  $ git diff --quiet
  $ git diff-files

we quit after 'a' and never refresh 'b'.

I don't think it should be considered a bug, though. "git diff" produces
the correct result, and it is under no obligation to produce its side
effect. If a caller really wants the index refreshed, he should use
update-index instead.

-Peff
