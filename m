From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Tue, 15 Jan 2008 22:56:14 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801152226000.13593@iabervon.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
 <7vhched3kw.fsf@gitster.siamese.dyndns.org> <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org> <7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 04:56:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzOP-0007Bp-JZ
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 04:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757106AbYAPD4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 22:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756404AbYAPD4Q
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 22:56:16 -0500
Received: from iabervon.org ([66.92.72.58]:40183 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754199AbYAPD4P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 22:56:15 -0500
Received: (qmail 16983 invoked by uid 1000); 16 Jan 2008 03:56:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jan 2008 03:56:14 -0000
In-Reply-To: <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70613>

On Tue, 15 Jan 2008, Linus Torvalds wrote:

> On Tue, 15 Jan 2008, Junio C Hamano wrote:
> >
> > If a non-standard prefix is used by --no-prefix, --src-prefix,
> > or --dst-prefix options, the resulting diff becomes something
> > git-apply would not grok.  In such a case, we should not trigger
> > the more strict check git-apply does for patches in "diff --git"
> > format.
> 
> I think this is wrong.
> 
> If we do any git-specific stuff, we need to have that "--git" thing there. 
> That is *not* just limited to the prefix, but to all the other things git 
> diffs can do: renames, mode changes, etc.

Well, part of the issue is that, if you drop the prefix, then *git* can't 
understand the resulting patch (because --git causes git-apply to use 
open-coded -p1 handling of names, which won't be right).

I suppose the other option is to have the header in this case be:

diff --git --src-prefix= --dst-prefix= filename filename

so that apply can figure out what diff did correctly.

> > Metainformation (e.g. "index", "similarity", etc.) lines will
> > safely be ignored by patch and git-apply (even when the latter
> > parses a non-git diff output), so this patch does not bother
> > stripping them away.
> 
> It's not necessarily safe to ignore some of them, like the rename info. If 
> you see a rename patch and don't understand it as a rename, it's 
> pointless.
> 
> So I would argue that you need something stronger to say "don't do a git 
> diff", and that should also disallow rename detection at a minimum. Quite 
> frankly, any program that is so stupid as to not accept current git 
> patches (ie TortoiseSVN), then we damn well shouldn't just disable the 
> most trivial part of it. We should make sure that we do not enable *any* 
> of the rather important extensions: even if ToirtoiseSVN would ignore 
> them, if ignoring them means that it mis-understands the diff, it 
> shouldn't be allowed at all.
> 
> So maybe a --standard-diff option that removes the "--git" part, but also 
> removes everything else.

That seems wise to me. We should be able to generate patches that are 
accessible to programs that can't follow any clever instructions. I think 
the point of the "Index:" header is that these programs will freak out if 
two filenames don't match (or, more likely, break in some way), and it 
means you can't sensibly generate patches that upset them for deletes or 
creates.

	-Daniel
*This .sig left intentionally blank*
