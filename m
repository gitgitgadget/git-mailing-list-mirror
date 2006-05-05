From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] binary patch.
Date: Fri, 05 May 2006 16:07:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605051547420.24505@localhost.localdomain>
References: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605042241240.28543@localhost.localdomain>
 <7vwtd10xyd.fsf@assigned-by-dhcp.cox.net>
 <7vy7xgzsiu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605051128100.28543@localhost.localdomain>
 <7vejz8z80p.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605051431390.24505@localhost.localdomain>
 <7vac9wxom0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 22:07:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc6aX-0002wx-0W
	for gcvg-git@gmane.org; Fri, 05 May 2006 22:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWEEUHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 16:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWEEUHm
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 16:07:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15799 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751513AbWEEUHl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 16:07:41 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYT00FAP6KSQ270@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 05 May 2006 16:07:40 -0400 (EDT)
In-reply-to: <7vac9wxom0.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19638>

On Fri, 5 May 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Fri, 5 May 2006, Junio C Hamano wrote:
> >
> >> The delta is going to be deflated and hopefully gets a bit
> >> smaller, so if we really care that level of detail, it might be
> >> worth to do (deflate_size*3/2) or something like that here, use
> >> delta with or without deflate whichever is smaller, and mark the
> >> uncompressed delta with a different tag ("uncompressed delta"?).
> >> And for symmetry, to deal with uncompressible data, we may want
> >> to have "uncompressed literal" as well.
> >
> > Nah...  Please just forget that.  ;-)
> 
> I was serious about the above actually.

And I think this is overkill.

First, if a deflated delta is to be _larger_ than its inflated version 
this is because the delta data is really really short, most probably 
shorter than a single base85 line.  Same for literal data.

So I truely think the pretty special and rare case where not deflating 
might be smaller is simply not worth the added complexity.

> BTW, this "binary patch" opens a different can of worms.
> 
> Currently, the diff uses a heuristic borrowed from GNU diff 
> (I did not look at the code when I did it, but it is described
> in its documentation) to decide if a file is binary (look at the
> first few bytes and find NUL).  I am sure people will want to
> have a way to say "that heuristic fails but this _is_ a binary
> file and please treat it as such".
> 
> There are two, both valid, I think, ways to do it.
> 
>  - give an option to "diff" that says "treat this path as binary
>    for this invocation of the program".
> 
>  - give an attribute to blob object that says "this blob is
>    binary and should be treated as such".
> 
> The latter is probably the right way to go in the longer term.

I'm not sure I agree.

> A blob being binary or not is a property of the content and does
> not depend on where it sits in the history, so unlike "recording
> renames as a hint in commit objects", the attribute is at the
> blob level, not at the commit nor the tree that points at the
> blob.

Well, sort of.

> But "binaryness" affects only certain operations that extract
> the data (e.g. diff and grep) and not others (e.g. fetch).
> Also, it makes sense to being able to retroactively mark a blob,
> which was not marked as such originally, is a binary.  So I do
> not think it should be recorded in the object header.

Agreed.

> Which suggests that we may perhaps want to have notes that can
> be attached to existing objects to augment them without changing
> the contents of the data, and have tools notice these notes when
> they are available.  Another example is to associate correct
> MIME types to blobs so, gitweb _blob_ links can do sensible
> things to them.

I think blobs are the wrong level to attach such notes.  If you go that 
path you'll have to add as many entries for the number of blobs many 
revisions of the same file might have.

Instead I think it should be attached to files.  After all being a 
binary or not is a file attribute regardless of its revision.  And 
implementation wise I'd do it as a .gitbin file listing all names of 
files that should be considered as binaries, with path globing and all, 
just like .gitignore currently lists files that should be ignored.

And the advantage is that those .gitbin files can be distributed and 
revision-controlled just like the .gitignore files.

And in addition to those files you could have a section in the repo 
config file listing default name patterns for files that are considered 
binaries.  Or even a section, if present, that lists patterns for files 
that are _not_ binaries since that list might certainly be shorter.  
There could be a corresponding .gittext as well.

And in the absence of any of those then the default automatic euristic 
applies.


Nicolas
