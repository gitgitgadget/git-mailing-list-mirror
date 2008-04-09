From: Jeff King <peff@peff.net>
Subject: Re: git annoyances
Date: Wed, 9 Apr 2008 10:57:59 -0400
Message-ID: <20080409145758.GB20874@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Apr 09 16:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjblC-00004s-W8
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 16:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbYDIO6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 10:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbYDIO6D
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 10:58:03 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3211 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471AbYDIO6B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 10:58:01 -0400
Received: (qmail 3113 invoked by uid 111); 9 Apr 2008 14:57:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 09 Apr 2008 10:57:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Apr 2008 10:57:59 -0400
Content-Disposition: inline
In-Reply-To: <20080409101428.GA2637@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79113>

On Wed, Apr 09, 2008 at 12:14:28PM +0200, Ingo Molnar wrote:

>  $ cd linux-2.6-sched-devel.git
> 
>  $ git-remote add ~/linux-2.6-x86.git
> 
>  $ git-remote show x86
>   * remote x86
>     URL: /home/mingo/linux-2.6-x86.git
>   New remote branches (next fetch will store in remotes/x86)
>   base for-akpm for-linus latest master testing
> 
>  $ git-merge x86/latest
>  x86/latest - not something we can merge

As you figured out later, the problem was that "git remote add" doesn't
actually fetch the remote's contents: it just sets up the remote. There
is a "-f" option which does the fetch automagically after adding.

In this case, had "-f" been the default, it would have Just Worked for
you. So that's something for us to consider, but I'm not sure if we
would annoy more users who _didn't_ want the fetch.

>  $ git-fetch x86/latest
>  fatal: 'x86/latest': unable to chdir or not a git archive
>  fatal: The remote end hung up unexpectedly

This is another place where we might have DWYM, by seeing that your
repository name started with "<name of a remote>/" and splitting it into
"<remote> <branch>". This could affect current usage, but it seems
unlikely that people have remote names which are exact prefixes (with
trailing slash) of non-remote repositories they are trying to fetch.

Reading "git help fetch" should show you the synopsis:

  git-fetch <options> <repository> <refspec>

which maybe gives a clue about the syntax. But I think the problem here
is that there are two different syntaxes for what is _almost_ the same
thing. The ref refs/remotes/x86/latest, which you can call "x86/latest"
as a shorthand, and the (remote, refspec) pair (x86, latest).

>  $ git-pull x86 latest
> 
> (that fetch+merge went problem-free.)

Unless you are planning on merging this remote a lot, the common usage
is probably to just forget the remote stuff and do:

  git pull ~/linux-2.6-x86.git latest

> then i tried git-remote show -a (to list all repositories, etc.) - what 
> i didnt figure out was to show all repositories is to do a simple 
> "git-remote". I think "git-remote show" should output all repositories, 
> or at least indicate it in its help line what to do to get such a list. 
> (for us poor sobs forgetting commandline details ;)

Yes, just showing the remotes would be consistent with what other
commands do (e.g., git-branch, git-tag). I'll post a patch in a minute.

> also, the first natural thing i did was to just type:
> 
>  $ git-merge ~/linux-2.6-x86.git/
> 
> which i naively assumed would sort things out for me and provide some 
> reasonable default behavior - but instead it just gave an annoyingly 
> unhelpful error message:
> 
>  /home/mingo/linux-2.6-x86.git/ - not something we can merge

That is an annoying message. Perhaps we could notice that it looks like
a file path (because it begins with '.') and suggest "maybe you wanted
to "git pull ..."?

-Peff
