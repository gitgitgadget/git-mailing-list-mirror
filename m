From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 2 Oct 2007 13:00:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710021212310.9321@iabervon.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
 <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
 <7v3awunjup.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:00:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icl6T-0003uR-RW
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 19:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbXJBRAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 13:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037AbXJBRAF
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 13:00:05 -0400
Received: from iabervon.org ([66.92.72.58]:51973 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbXJBRAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 13:00:04 -0400
Received: (qmail 9735 invoked by uid 1000); 2 Oct 2007 17:00:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Oct 2007 17:00:01 -0000
In-Reply-To: <7v3awunjup.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59699>

On Mon, 1 Oct 2007, Junio C Hamano wrote:

> * db/fetch-pack (Mon Oct 1 00:59:39 2007 +0100) 49 commits
>  + fetch/push: readd rsync support
>  + Introduce remove_dir_recursively()
>  + bundle transport: fix an alloc_ref() call
>  + Allow abbreviations in the first refspec to be merged
>  + Prevent send-pack from segfaulting when a branch doesn't match
>  + Cleanup unnecessary break in remote.c
>  ...
> 
> Has been cooking for quite long time.
> 
> There was a regression that made me quite unhappy about the
> rewrite, but Daniel fixed it, so I should be happy.  There is
> another usability regression: http transport is now totally
> silent.

I think this is due to passing through equal verbosity levels, when the 
non-verbose case for the native protocols was a lot less silent than the 
non-verbose case for http. "git fetch -v -v" does show everything. I think 
just replacing "transport->verbose" with "1" on line 347 of transport.c 
would give the old default behavior, but fetch probably needs a more quiet 
setting than the default, as well as the current more verbose than 
default. I'll put together a patch for this when I get a chance.

> Even when you fetch daily, if the other end frequently
> repacks everything into one big ball of wax like repo.or.cz
> does, you will end up transferring quite a large pack every
> time, and the total lack of progress report is unacceptably
> unnerving.  At least we should reinstate "Fetching blah from URL
> using http", and preferrably "walk $object_name" lines.  The
> latter could be replaced with just series of CR + "walked N
> commits..." if we do not like many output from the current "walk
> $object_name" lines scrolling the other information away.

The right thing for now is probably to match the old git-fetch's behavior, 
once I can remember what it is. (I've been using my C version for my 
personal use long enough that I can't remember everything the shell 
version did. My new version should be sufficiently flexible to accomodate 
most things without too much trouble, but I've lost my ability to notice 
differences without prompting.)

After the implementation change is in, we can look at improving 
user-visible things. I think a display like the "counting objects" display 
(number that counts up in place), plus progress bars for big downloads, would 
be ideal.

> I am not sure the quality of "rsync" transport near the tip,
> either, but at least the change should not affect other
> transports.  Nobody should using about rsync transport these
> days anyway.  Perhaps we should put a deprecation notice in the
> release notes to 1.5.4, and remove it three months later.

I think that rsync should be kept until we've got sftp in place, which 
should cover the same cases and be better overall. 

	-Daniel
*This .sig left intentionally blank*
