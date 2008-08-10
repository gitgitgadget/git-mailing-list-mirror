From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Make it scream by minimizing temp files
Date: Sat, 9 Aug 2008 18:46:25 -0700
Message-ID: <20080810014625.GA31438@hand.yhbt.net>
References: <1218235313-19480-1-git-send-email-marcus@griep.us> <20080809062521.GA10480@untitled> <489DBB8A.2060207@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Sun Aug 10 03:47:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS01q-0000U9-27
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 03:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYHJBq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 21:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbYHJBq1
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 21:46:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:58834 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbYHJBq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 21:46:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 5E9122DC01B;
	Sat,  9 Aug 2008 18:46:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <489DBB8A.2060207@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91798>

Marcus Griep <marcus@griep.us> wrote:
> Eric Wong wrote:
> > Perhaps a sysseek in addition to the seek above would help
> > with the problems you mentioned in the other email.
> > 
> > 		sysseek $TEMP_FILES{$fd}, 0, 0 or croak $!;
> > 
> > (It doesn't seem to affect me when running the test suite, though).
> 
> Sounds like a good idea, but I found the source of my cygwin issue,
> namely that /tmp (which perl uses for its temp files) was mounted
> in textmode.  I fixed that by remounting that folder in binmode.

Hmm.. Instead of relying on users on weird platforms to change their
mount options, git-svn should also set binmode on all filehandles
regardless.  Will that get around the problem you had with cygwin?

git-svn already sets binmode for all the rev_map files.

> Nonetheless, if consumers may use sysread, after getting the file handle
> then we'll want to use sysseek.
> 
> >> +	} else {
> >> +		$TEMP_FILES{$fd} = File::Temp->new(
> >> +									TEMPLATE => 'GitSvn_XXXXXX',
> >> +									DIR => File::Spec->tmpdir
> >> +									) or croak $!;
> > 
> > Way too much indentation :x
> 
> That's what I get for assuming a tab width of 4.  I'll redo it with
> about half as many tabs.

Tabwidth is 8 characters by default, and that is what git uses.

> > Also, this seems generic enough that other programs (git-cvsimport
> > perhaps) can probably use it, too.  So maybe it could go into Git.pm or
> > a new module, Git/Tempfile.pm?
> 
> I'd advocate the latter since it's not really Git functionality, but
> rather a support, so a submodule would perhaps be the better placement.
> 
> Also, I came up with one more optimization inside 'sub close_file', so
> I'll roll that in too.  Tell me where you/the community would prefer 
> the tempfile functionality, and I'll submit a new patch series with 
> one patch for the module and one patch for git-svn.
> 
> By then, I should have some better benchmark results.

Junio (or anybody else), any thoughts on what the submodule should be
named?  I'm not good at naming things :x

-- 
Eric Wong
