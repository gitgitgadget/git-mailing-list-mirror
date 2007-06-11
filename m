From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with a push
Date: Mon, 11 Jun 2007 16:03:53 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: plexq@plexq.com
X-From: git-owner@vger.kernel.org Tue Jun 12 01:04:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxsvq-0006CH-3j
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 01:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbXFKXEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 19:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbXFKXEI
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 19:04:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51672 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752591AbXFKXEC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2007 19:04:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5BN3weZ002091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2007 16:03:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5BN3rNi031322;
	Mon, 11 Jun 2007 16:03:53 -0700
In-Reply-To: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
X-Spam-Status: No, hits=-2.711 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49896>



On Mon, 11 Jun 2007, Alex R.M. Turner wrote:
> 
> I get the following error when pushing after a merge:
> 
> updating 'refs/heads/master'
>   from c18f9e4350c26e6b45d0a282ff32991784becbdd
>   to   39b7d927720c9f2810e0af5311975119c0d7c7bd
> updating 'refs/remotes/origin/HEAD'
>   from 1e631edb3078ec3a4d1fa598c8f410f6a61659b0
>   to   c18f9e4350c26e6b45d0a282ff32991784becbdd
> updating 'refs/remotes/origin/master'
>   from 1e631edb3078ec3a4d1fa598c8f410f6a61659b0
>   to   c18f9e4350c26e6b45d0a282ff32991784becbdd

Ok, pushing out remote branches is a bit odd in the first place. As in 
"you probably shouldn't do that". The "remote" branches are really local 
to each repo, and updating them by pushing is really quite suspect.

So the regular "master" branch pushed out fine:

> refs/heads/master: c18f9e4350c26e6b45d0a282ff32991784becbdd -> 39b7d927720c9f2810e0af5311975119c0d7c7bd

and that part is all ok.

However, I think the problem is this:

> refs/remotes/origin/HEAD: 1e631edb3078ec3a4d1fa598c8f410f6a61659b0 ->  c18f9e4350c26e6b45d0a282ff32991784becbdd

You updated the HEAD file, but that actually is a _symbolic_ ref, which 
normally points to refs/removes/origin/HEAD, and that in turn explains the 
other errors:

> ng refs/remotes/origin/master failed to lock
> error: Ref refs/remotes/origin/master is at c18f9e4350c26e6b45d0a282ff32991784becbdd but expected 1e631edb3078ec3a4d1fa598c8f410f6a61659b0
> error: failed to lock refs/remotes/origin/master
> error: failed to push to 'ssh://aturner@svn.mintpixels.com/data/git/mls'

What happened is that the "remotes/origin/master" branch already got 
updated when you updated HEAD, so now git is complaining that you are 
trying to update it again, but it no longer has the same value that it had 
originally (since you changed it).

> but when I try it again, it just says Everything up-to-date.

Right. Because the HEAD update really already did all the changes (to 
_both_ remotes/origin/HEAD _and_ remotes/origin/master, since it was a 
symref), so next time around there is nothing to push, and you won't see 
this issue any more.

So I don't think there was anything reall bad going on, except for the 
fact that you really shouldn't try to push out remote branches.

What was the command line?  In particular, was this a "git push --all" or 
something? I think we should make sure that we do *not* push remotes by 
default (and if you really *really* want to push remotes, you'd have to 
specify them explicitly).

			Linus
