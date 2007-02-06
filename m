From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 11:56:30 -0500
Message-ID: <20070206165630.GB4949@spearce.org>
References: <20070206023111.GB9222@spearce.org> <Pine.LNX.4.64.0702052248070.19212@xanadu.home> <20070206054808.GA10508@spearce.org> <Pine.LNX.4.64.0702060829310.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 17:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HETcl-00030K-NC
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 17:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbXBFQ4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 11:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbXBFQ4h
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 11:56:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41791 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbXBFQ4g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 11:56:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HETcH-0001Kc-Ht; Tue, 06 Feb 2007 11:56:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7AB4420FBAE; Tue,  6 Feb 2007 11:56:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702060829310.8424@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38860>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 6 Feb 2007, Shawn O. Pearce wrote:
> > Nicolas Pitre <nico@cam.org> wrote:
> > > I think this is quite error prone, demonstrated by the fact that we 
> > > screwed that up ourselves on a few occasions.  I think that the frontend 
> > > should be relieved from this by letting it provide the time of change in 
> > > a more natural format amongst all possible ones(like RFC2822 for 
> > > example) and gfi should simply give it to parse_date().
> > 
> > This is a really good point.  Its a little bit of work to switch
> > to parse_date(); I'll try to get it done tomorrow night.
> 
> Actually, I disagree. We've traditionally have had _less_ bugs with the 
> pure integer format than we ever had with RFC2822 format.

Hmm.  Actually I think it depends on the source data.  :-)

If the source is only supplying RFC2822 date format and is reliable
in its formatting of such, having gfi parse that rather than
the frontend is probably more reliable.  (Git already has a well
tested date parsing routine.)  But if the source is easily able
to get a time_t then that is just as easily formatted out to gfi,
and reading that without error is child's play.

After reading your email I'm now contemplating making this a command
line flag, like `--date-format=rfc2822`, so a frontend could ask
gfi to use parse_date() and whatever error that might bring, or
stick with the pure integer format.
 
> Having a hard format, set in stone, and totally unambiguous, is really a 
> good thing. It actually ends up resulting in fewer bugs in the end, 
> because it just makes sure that everybody is on the same page.

Which is why gfi is very strict about its handling of whitespace.
It assumes *exactly* one space between input fields, or *exactly*
one LF between commands.  Anything else is assumed to be part of
the next field.  If spaces show up in the imported data, its the
frontend that is sending stuff incorrectly.

Right now however gfi is not validating the author or committer
command arguments.  At all.  Which means that although the
documentation says the format must be such-and-such, gfi doesn't
care.  Whatever comes in on the `author` or `committer` line is
copied verbatim into the commit object.  gfi probably should at
least verify that the timestamp part of the line actually contains
digits.  :)

-- 
Shawn.
