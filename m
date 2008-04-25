From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Problem with git fetch over http://
Date: Fri, 25 Apr 2008 18:04:16 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804251749390.19665@iabervon.org>
References: <63F7B390-32D1-458A-8ED9-D5AC62F46745@newartisans.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: John Wiegley <johnw@newartisans.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 00:05:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpW2c-0004GY-F1
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 00:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbYDYWEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 18:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbYDYWEW
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 18:04:22 -0400
Received: from iabervon.org ([66.92.72.58]:44459 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbYDYWEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 18:04:21 -0400
Received: (qmail 32170 invoked by uid 1000); 25 Apr 2008 22:04:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2008 22:04:16 -0000
In-Reply-To: <63F7B390-32D1-458A-8ED9-D5AC62F46745@newartisans.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80351>

On Fri, 25 Apr 2008, John Wiegley wrote:

> Hello, I'm using the Builtbot to pull sources from a Git repository, and have
> found that the Buildbot's Git step always uses git-fetch -- a detail of
> Buildbot which I currently have little control over.
> 
> This is no problem if the git:// protocol is used, but using fetch with
> http:// doesn't work.  This has been mentioned elsewhere:
> 
>  http://lists.berlios.de/pipermail/bitbake-dev/2007-November/000765.html
> 
> Here's a quick example of what I mean:
> 
>  cd /tmp ; mkdir foo ; cd foo ; git init
> 
>  git fetch git://newartisans.com/ledger.git	# works fine
> 
>  cd /tmp ; rm -fr foo ; mkdir foo ; cd foo ; git init
> 
>  git fetch http://newartisans.com/git/ledger.git  # fails
> 
> This is happening with git-1.5.5 on the server, Apache 2.2 and git-1.5.5.1 on
> the client.

John mentioned on IRC that clone works.

$ git-ls-remote http://newartisans.com/git/ledger.git
96751442d9eda537480867e599e4c604663f4530        refs/heads/master
365baca5174232cc35e4ed190fd8ce93c3611c84        refs/heads/v2.4.1
f972a89073843fdbb2a1bef969d9ca70509d4bfe        refs/heads/v2.5
6a81d760dc4ab9028b27430124702c28c0b894ed        refs/tags/cvs-20040410
fed3956a310a2ea8c8595b7fde7aaa0623492ca6        refs/tags/v0.1
...

$ git-ls-remote git://newartisans.com/ledger.git
96751442d9eda537480867e599e4c604663f4530        HEAD
96751442d9eda537480867e599e4c604663f4530        refs/heads/master
365baca5174232cc35e4ed190fd8ce93c3611c84        refs/heads/v2.4.1
f972a89073843fdbb2a1bef969d9ca70509d4bfe        refs/heads/v2.5
6a81d760dc4ab9028b27430124702c28c0b894ed        refs/tags/cvs-20040410
fed3956a310a2ea8c8595b7fde7aaa0623492ca6        refs/tags/v0.1
...

Looks like either server-info.c:update_info_refs() needs to also list 
HEAD, or transport.c:get_refs_via_curl() needs to guess that $url/HEAD 
exists and fetch it to add to the list, or both.

	-Daniel
*This .sig left intentionally blank*
