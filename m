From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Strange "beagle" interaction..
Date: Tue, 13 Nov 2007 16:03:54 -0500
Message-ID: <20071113210354.GD22590@fieldses.org>
References: <alpine.LFD.0.9999.0711131241050.2786@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is2vz-0007Lk-QS
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760587AbXKMVET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760508AbXKMVET
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:04:19 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38617 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760086AbXKMVES (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:04:18 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Is2vK-0008SH-Gz; Tue, 13 Nov 2007 16:03:54 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0711131241050.2786@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64864>

On Tue, Nov 13, 2007 at 12:56:19PM -0800, Linus Torvalds wrote:
> 
> Ok, I've made a bugzilla entry for this for the Fedora people, but I 
> thought I'd mention something I noticed yesterday but only tracked down 
> today: it seems like the beagle file indexing code is able to screw up git 
> in subtle ways.
> 
> I do not know exactly what happens, but the symptoms are random (and 
> quite hard-to-trigger) dirty index contents where git believes that some 
> set of files are not clean in the index.
> 
> I *suspect* that beagle is playing games with the file access times, 
> causing the ctime on disk to not match the ce_ctime in the index file. But 
> that's just a guess.
> 
> I'm posting here in case somebody on the list knows what beagle does, or 
> somebody has been bitten by strange behaviour and realizes that he has 
> beagle running and prefers to fix the problem by just disabling beagle 
> (which will also be a great boon for performance - beagle seems to be very 
> good at flushing your file caches, but I guess that's not a bug, but a 
> "feature").

Last I ran across this, I believe I found it was adding extended
attributes to the file.  I think it's something like

	getfattr -d

to show all the extended attributes set on the file.  Does that show
anything?

Yeah, I just turned off beagle.  It looked to me like it was doing
something wrongheaded.

--b.

> 
> The easiest way I have found so far to trigger this is to run
> 
> 	while ./t7003-filter-branch.sh -i; do echo ok; done
> 
> in the git t/ directory, while at the same time telling beagle to index 
> just that git/t/ directory. That seems to trigger a failure on subtest 17 
> fairly reliably (not the first time through the loop, but *eventually* - 
> it takes a few minutes). I think it's because "git filter-branch" requires 
> the index to be clean.
> 
> (But I've also seen it fail on subtest 4).
> 
> I opened bugzilla
> 
> 	https://bugzilla.redhat.com/show_bug.cgi?id=380791
> 
> for this, since I consider it a beagle bug (indexing shouldn't change 
> directory state, and if beagle wants to avoid changing access times, it 
> should use O_NOATIME). But I don't actually know exactly what it is that 
> causes problems, so if somebody is interested and tries to figure this 
> out, that would probably be good.
> 
> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
