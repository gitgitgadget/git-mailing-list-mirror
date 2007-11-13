From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Strange "beagle" interaction..
Date: Tue, 13 Nov 2007 16:21:21 -0500
Message-ID: <20071113212121.GE22590@fieldses.org>
References: <alpine.LFD.0.9999.0711131241050.2786@woody.linux-foundation.org> <20071113210354.GD22590@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3Ce-0005Jb-J7
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760291AbXKMVV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759779AbXKMVV0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:21:26 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56764 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760086AbXKMVVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:21:25 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Is3CD-0000O8-4L; Tue, 13 Nov 2007 16:21:21 -0500
Content-Disposition: inline
In-Reply-To: <20071113210354.GD22590@fieldses.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64869>

On Tue, Nov 13, 2007 at 04:03:54PM -0500, J. Bruce Fields wrote:
> On Tue, Nov 13, 2007 at 12:56:19PM -0800, Linus Torvalds wrote:
> > 
> > Ok, I've made a bugzilla entry for this for the Fedora people, but I 
> > thought I'd mention something I noticed yesterday but only tracked down 
> > today: it seems like the beagle file indexing code is able to screw up git 
> > in subtle ways.
> > 
> > I do not know exactly what happens, but the symptoms are random (and 
> > quite hard-to-trigger) dirty index contents where git believes that some 
> > set of files are not clean in the index.
> > 
> > I *suspect* that beagle is playing games with the file access times, 
> > causing the ctime on disk to not match the ce_ctime in the index file. But 
> > that's just a guess.
> > 
> > I'm posting here in case somebody on the list knows what beagle does, or 
> > somebody has been bitten by strange behaviour and realizes that he has 
> > beagle running and prefers to fix the problem by just disabling beagle 
> > (which will also be a great boon for performance - beagle seems to be very 
> > good at flushing your file caches, but I guess that's not a bug, but a 
> > "feature").
> 
> Last I ran across this, I believe I found it was adding extended
> attributes to the file.  I think it's something like
> 
> 	getfattr -d
> 
> to show all the extended attributes set on the file.  Does that show
> anything?

By the way, on Debian or Ubuntu, at least, that requires an "apt-get
install attr" first.

> 
> Yeah, I just turned off beagle.  It looked to me like it was doing
> something wrongheaded.

Just looking at the attribute names and taking a wild guess, it looked
to me like beagle was computing a checksum of each file's data and
comparing it to a checksum previously stored in an xattr, and using that
to decide whether to reindex the file data.

With the result that to check whether anything's changed when it starts
up again it has to read through the entire filesystem's data.

Maybe I'm wrong--I hope so.  I'd love to know.

--b.
