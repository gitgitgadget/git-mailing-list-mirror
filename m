From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Compatibility between git.git and jgit
Date: Fri, 1 May 2009 18:59:50 -0700
Message-ID: <20090502015950.GG23604@spearce.org>
References: <20090415182754.GF23644@curie-int> <alpine.LFD.2.00.0904151443030.6741@xanadu.home> <7vy6tj109a.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0905011616130.6741@xanadu.home> <7v4ow4v0xl.fsf@gitster.siamese.dyndns.org> <20090502000123.GF23604@spearce.org> <alpine.LFD.2.00.0905012032590.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat May 02 04:00:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M04Wz-0001x9-TD
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 04:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbZEBB7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 21:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbZEBB7u
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 21:59:50 -0400
Received: from george.spearce.org ([209.20.77.23]:50667 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbZEBB7t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 21:59:49 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 117F83807D; Sat,  2 May 2009 01:59:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905012032590.6741@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118117>

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 1 May 2009, Shawn O. Pearce wrote:
> 
> > On an unrelated note, someone asked me recently, how do we ensure
> > compatibility in implementations between git.git and jgit?
> 
> Well... this is not exactly easy.  As I said in the past 
> (http://marc.info/?l=git&m=121035043412788&w=2), I think that the C 
> version must remain the reference with regards to protocols and on-disk 
> data structures.

I agree fully.

> If people go wild with JGit and start making changes 
> to data structures then it simply won't be Git compatible anymore and 
> the user base will get fragmented.

Agree.  We may see some prototyping happen in JGit first on some
topics, and JGit may even support something earlier than git.git,
e.g JGit has an amazon-s3:// transport that git.git doesn't have.
But it also isn't widely used.

> A formal compatibility test suite would imply that every Git 
> reimplementation should be compatible with the reference C version.  
> You could add some tests in your test suite which are performed in 
> parallel using JGit and the C git, and make sure that the produced 
> results are identical, etc.

Yea, and to some extent we try to do that already in JGit, but our
tests aren't complete enough in that area.
 
> But to which extent should the C version remain backward compatible with 
> other implementations?  Let's suppose a future protocol extension is 
> made and old unsuspecting C clients work just fine but some other 
> implementation crashes with it?

This is what I think scares both myself and the folks that have
recently asked me about compatibility.

If JGit gets a broader user base, and suddenly it stops working
against a newer C git-daemon because of a protocol change, those
users are going to be pissed.  Its no worse than the "github can't
ever upgrade past 1.6.1" issue we had not too long ago.

I think we're doing better these days about embedding file format
version numbers into files (e.g. pack idx v2) to help alert older
clients that the format is different.  But we also have a something
of a history of looking for "holes" in older C git parsers in
order to wedge in new features where we didn't plan for them in
the first place.  E.g. the protocol capability slots we have now.

I think that as reimplementations become more popular, we need to
rely less on extending things by exploiting parser quirks in older
C git.git code, and rely more on at least explicit version markers
that everyone can work with.

> And the reference implementation cannot be held back because 
> of bugs in all alternative implementations.

I agree.  A bug is a bug.  But I'd really like to get away from the
trend where we exploit bugs in older C git.git implementations to
add new functionality, because maybe JGit doesn't have that same
bug and will fall flat on its face with that exploit.

> As long as they're futzing^Wdeveloping on top of Jgit then 
> interoperability shouldn't be at risk.  If people would start adding new 
> object types and pack formats and the like without obtaining a consensus 
> with people around the C version then I might get extremely worried (and 
> pissed) though.

That's why JGit is BSD, so everyone can use the one f'king library
and not risk fragmenting the Java market further.

But yea, I'd be really pissed too if someone hacked up JGit and made
it incompatible with anything else.  Its a risk that the liberal
BSD license permits.

I'm really sort of hoping that the development momentum around
git.git and JGit trying to keep up will keep them coming back
to the canonical JGit for updates, forcing them to give back any
hacks^Wimprovements they have made.  If the improvements really are
worthwhile, they can be easily ported over to C before they become
widely used in JGit.
 
> One defensive approach we could adopt is to use a capability slot to 
> identify the software version of each peer involved in the network 
> communication.  The advantage would be for a later Git version to avoid 
> doing some things that are known to break with client X or Y.  Of course 
> even such a scheme can be abused and misused, like on some web sites if 
> you don't have the "right" browser, leading some of them to allow faking 
> the User-Agent string, etc.  But maybe the upsides are more important 
> than the downsides.  This doesn't help with on-disk interoperability, 
> but this is probably less important than communication interoperability.

Blargh.  I'm with you about the whole User-Agent mess.

Asking clients and servers to identify with implementation and
version markers might be useful for analysis of who-is-using-what,
but I don't think its a good way to negotiate between the peers of
what functionality to enable or disable, or what bug workarounds
to use.  Reminds me of the Apache hack during output to work around
an HTTP header parsing bug in Netscape 2 when the "\r\n" pair was
exactly at byte 256 in the stream.  *shudder*


FWIW, an EGit user recently complained that some random Git hosting
site they were using couldn't work with EGit, but EGit worked fine
with other sites, e.g. GitHub.  Apparently this site's SSH forced command
filter script didn't like EGit asking for "git upload-pack 'path.git'".

Its not strictly a Git protocol issue, how the client launches
the remote process over SSH, but this random hosting site was
apparently relying on C git's current calling convention of
"git-upload-pack 'path.git'".

Long story short, I claimed it was the hosting site's bug.  :-)

-- 
Shawn.
