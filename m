From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problem with git-gui and relative directories
Date: Sat, 25 Aug 2007 04:15:25 -0400
Message-ID: <20070825081525.GB18160@spearce.org>
References: <868x81vynk.fsf@lola.quinscape.zz> <20070825031834.GW27913@spearce.org> <85veb4dqhv.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 10:15:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOqoF-0000gM-FG
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 10:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761487AbXHYIPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 04:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761482AbXHYIPb
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 04:15:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58286 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760939AbXHYIP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 04:15:28 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IOqnk-0006zs-I8; Sat, 25 Aug 2007 04:15:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3AB2220FBAE; Sat, 25 Aug 2007 04:15:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <85veb4dqhv.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56627>

David Kastrup <dak@gnu.org> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > +if {$_prefix ne {}} {
> > +	regsub -all {[^/]+/} $_prefix ../ cdup
> 
> I don't like this approach.  It assumes too much about the file system
> and cleanliness of paths.  It does all of the following:
> 
> /somedir/ -> /../
> /somedir -> /somedir
> //server/somedir -> //../somedir
> /somedir//someother -> /..//someother

OK, well, uh.  Go read the manpage for `git-rev-parse` and focus
in particular on the `--show-prefix` option of that command.
Its output is what we are using here.  Its very well defined within
Git, and should have the same definition on all operating systems,
including MinGW.

And if the MinGW folks did something funny its only a translation
of / to \, in which case its easy enough for git-gui to make that
decision on its own based on what type of git it is running on.
 
> and so on.  It can't deal with directory symlinks properly.

Depends on your definition of properly.  Here git-gui does exactly
what the C programs in core Git do, which is counter to what the
shell scripts do.  And people prefer the C behavior of going up
through the real parents, ignoring the symlinks that were used to
get to the directory the user started git-gui within.

> And the
> approach does not scale to Windows and other systems with diverging
> path syntaxes at all.

Yes, it does.  Because the format of --show-prefix is defined.

> Isn't it possible to move to the workdir root for the purpose of
> interpreting workdir root relative filenames?

Because I have always disagreed with the GIT_WORK_TREE mess.
I think its insane to say "I'm here in A, my repository is over
there in B and my files are here in C... now go run status!".
But apparently its a use case.

I guess I could use `git rev-parse --show-cdup` and that would just
handle this case.  But that's YAFAE (Yet Another Fork And Exec).

-- 
Shawn.
