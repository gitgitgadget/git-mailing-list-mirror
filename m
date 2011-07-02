From: Jeff King <peff@peff.net>
Subject: Re: Gitweb 1.7.5 and Textconv Configuration
Date: Sat, 2 Jul 2011 14:57:24 -0400
Message-ID: <20110702185724.GA14390@sigill.intra.peff.net>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
 <20110702104313.GA10245@sigill.intra.peff.net>
 <20110702104437.GA10538@sigill.intra.peff.net>
 <CALWDD1woB0ytL6T-DwD92f824dnpz0mek=SYgz5jwqR0efnkpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Al Haraka <alharaka@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 21:00:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd5QV-0005D9-D4
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 21:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab1GBS51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 14:57:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48681
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140Ab1GBS50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 14:57:26 -0400
Received: (qmail 18685 invoked by uid 107); 2 Jul 2011 18:57:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jul 2011 14:57:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jul 2011 14:57:24 -0400
Content-Disposition: inline
In-Reply-To: <CALWDD1woB0ytL6T-DwD92f824dnpz0mek=SYgz5jwqR0efnkpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176564>

On Sat, Jul 02, 2011 at 02:14:30PM +0300, Al Haraka wrote:

> # Enable textconv
> push @diff_opts, '--textconv';
> 
> Reloaded the webpage; still does *not* show text diffs.  Any way to
> debug what is going wrong?

You could try setting "$ENV{GIT_TRACE} = 1", which will dump all of the
git commands being called to stderr (and presumaby your log). That would
double-check that the option is being passed.

I think what might be happening, though, is that git does not do a good
job checking .gitattributes files inside trees; it only checks the
.gitattributes in the working tree, even if you are diffing a tree. But
in the case of a bare repository, we don't even have a working tree at
all.

You can try working around it like this:

  cd /path/to/bare/repo.git
  git show HEAD:.gitattributes >info/attributes

which will make the repository-wide non-version-controlled gitattributes
the same as the last committed version. The problem is that it won't be
automatically updated as you commit and push changes to .gitattributes.

So I think it's a bug in git. It seems like the tree being diffed is an
obvious place for git to load gitattributes from. Though I'm not sure of
the precedence rules for interacting with the version of .gitattributes
in the worktree (if any). In a situation like this:

  $ git checkout master
  $ git show master~50

You would probably want the more recent worktree attributes to take
precedence over the ones in the older tree.

But in this:

  $ git checkout master~50
  $ git show master

you would probably want the more recent tree attributes to take
precedence over what's in the working tree.

-Peff
