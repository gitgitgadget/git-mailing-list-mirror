From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
Date: Mon, 28 May 2007 17:35:11 -0400
Message-ID: <20070528213511.GB7044@spearce.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org> <200705281840.50814.johan@herland.net> <alpine.LFD.0.98.0705280957070.26602@woody.linux-foundation.org> <200705281948.27329.johan@herland.net> <7vwsysbrtg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 28 23:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsms8-0006U3-9Q
	for gcvg-git@gmane.org; Mon, 28 May 2007 23:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbXE1VfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 17:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbXE1VfT
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 17:35:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58813 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbXE1VfR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 17:35:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hsmro-00086h-4R; Mon, 28 May 2007 17:35:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C37D120FBAE; Mon, 28 May 2007 17:35:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vwsysbrtg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48649>

Junio C Hamano <junkio@cox.net> wrote:
> Johan Herland <johan@herland.net> writes:
> > Ok. But the reverse mapping will help with this, won't it?
> > We'll look up the interesting commits and find their associated
> > note objects directly.
> 
> The issue Linus brought up worries me, too.
> 
> The "efficient reverse mapping" is still handwaving at this
> stage.  What it needs to do is an equivalent to your
> implementation with "refs/notes/<a dir per commit>/<note>".  The
> "efficient" one might do a flat file that says "notee note" per
> line sorted by notee, or it might use BDB or sqlite, but the
> amount of the data and complexity of the look-up is really the
> same.  A handful notes per each commit in the history (I think
> Linus's "Acked-by after the fact" example a very sensible thing
> to want from this subsystem).

Please, don't use BDB or sqllite.  I really don't trust either.
I've lost data to both.  I've *never* lost data to a Git packfile.
;-)

I'm actually thinking pack v4.  OK, I know its just a virtual hand
waving thing still, but there's really no reason Nico and I cannot
get the damn thing finished before we both wind up buying the farm.

What if we use a "slow" storage by "refs/notes/$objname/$notename",
and we also allow them to appear in the packed-refs file.  But during
a repack we instead stick the annotations into the same packfile as
$objname, and we also include a list of $notename after $objname's
other data.

This way we have quick access to the $notename(s) of all notes of
$objname through the pack, and we can lazily go get the notes raw
data if we need them.  This isn't too different from what we do
with parent fields.  We initialize the commit_list when we parse
the commit but we don't parse the parents until we really need them.

Once packed we delete the note ref (if loose) and during a repack
of the packed-refs file we delete the note if $notename exists in
the packfile.

If someone wants notes we can check to see if refs/notes exists; if
it does then we enumerate all refs and catalog the notes we found
in memory.  Note search then works off the in-memory list and off
the packfiles.  If refs/notes doesn't exist (and we should delete it
when we prune away those ref files or prune them out of packed-refs)
then we can skip the ref enumeration and just go straight to the
packfile(s).  Most notes will be in the packfiles.  I think most
people repack often enough that the handful of unpacked notes before
the next repack won't be a major bottleneck.  Especially since we
can get the target $objname directly from a readdir() call, or by
splitting the string in the packed-refs file.

>From an object enumeration standpoint during packfile generation
the notes for a given object are treated like the parent fields in
a commit; they come after the object itself, but unlike the parent
fields they are always output if the object itself was output.
(Hence an --objects-edge enumeration would include the notes only
if the commit itself had been included.)

Unfortunately that doesn't cover the case of a note being added
months later and needing to distribute it to clients that already
have the object the note is attached to.


I haven't been following this discussion very closely, but I'd also
like to suggest that if annotated tags are being used for notes
that the "tag <name>" field be left out of them.  I don't see why
a note should be given a specific name that sits in a (roughly)
global namespace.

-- 
Shawn.
