From: Jeff King <peff@peff.net>
Subject: Re: GIT_DIR vs. --git-dir
Date: Mon, 24 Sep 2012 10:49:29 -0400
Message-ID: <20120924144929.GA10349@sigill.intra.peff.net>
References: <5060097F.9050203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:49:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG9yj-0003Vp-D9
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab2IXOtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 10:49:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56965 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756122Ab2IXOtf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 10:49:35 -0400
Received: (qmail 32073 invoked by uid 107); 24 Sep 2012 14:50:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 10:50:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 10:49:29 -0400
Content-Disposition: inline
In-Reply-To: <5060097F.9050203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206277>

On Mon, Sep 24, 2012 at 09:19:27AM +0200, Michael J Gruber wrote:

> [mjg@localhost ~]$ GIT_DIR=~/.githome git rev-parse --show-toplevel
> /home/mjg
> 
> [mjg@localhost ~]$ git --git-dir=~/.githome rev-parse --show-toplevel
> fatal: Not a git repository: '~/.githome'
> 
> Huh? Ok, so most users probably would not try further and blame git, but:
> 
> [mjg@localhost ~]$ git --git-dir=/home/mjg/.githome rev-parse
> --show-toplevel
> /home/mjg
> 
> (All this is with core.worktree set to /home/mjg.)
> 
> So, while I do understand that we don't expand '~' in any of these cases
> and it's only a matter of bash tilde expansion kicking in or not, we
> might want to do something about it. (--git-dir=$HOME/.githome gets
> expanded, as well, and --git-dir=.githome works from the appropriate cwd
> only).

Bash is even weirder than you might think. Try this:

  $ echo ~/foo
  /home/peff/foo

  $ echo arg=~/foo
  arg=/home/peff/foo

  $ echo --arg=~/foo
  --arg=~/foo

That is, it expands on the right-hand side of an "=" (which, from my
reading of the bash manual, means it considers it a word split), but
refuses to expand after an "=" that is part of a long option.

The first one is definitely correct. It would be convenient for your use
case to expand the third one, and it logically follows from the second
one. However, dash does not expand the second one. I'm not sure if this
is a bug in bash, or simply a grey area where the two shells do not
agree.

But it makes me wonder if the world would be better served by a bash
option to always enable tilde expansion after an "=". That would solve
your issue, and it would make the same feature work for every other git
long option, as well as for other programs.

-Peff
