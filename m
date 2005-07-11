From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] Support for packs in HTTP
Date: Mon, 11 Jul 2005 16:03:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507111519380.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0507111040251.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 02:09:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds8Ka-0001Cl-DT
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 02:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVGKULp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbVGKUIs
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 16:08:48 -0400
Received: from iabervon.org ([66.92.72.58]:58629 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262524AbVGKUGR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 16:06:17 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Ds4VQ-0008HK-00; Mon, 11 Jul 2005 16:03:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507111040251.17536@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 11 Jul 2005, Linus Torvalds wrote:

> 
> 
> On Mon, 11 Jul 2005, Daniel Barkalow wrote:
> > On Sun, 10 Jul 2005, Linus Torvalds wrote:
> > 
> > > 
> > > You really _mustn't_ try to create the pack directly to the
> > > $GIT_DIR/objects/pack subdirectory - that would make git itself start
> > > possibly using that pack before the index is all done, and that would be
> > > just wrong and nasty.
> > >
> > > So you really should _always_ generate the pack somewhere else, and then 
> > > move it (pack file first, index file second).
> > 
> > It's currently fine ignoring index files without corresponding
> > pack files (sha1_file.c, line 470).
> 
> That doesn't help.

Well, it means that the order you move them doesn't matter, because it
will ignore the pair if either hasn't been moved.

> Redgardless of which order you write them (and you _will_ write the 
> pack-file first), you'll find that at some point you have both files, but 
> one or the other isn't fully written, ie they are unusable.

(Off topic: note that git-http-pull writes the _index_ first, because it
fetches it to determine if it should fetch the pack)

> And yes, you can handle that by always checking the SHA1 of the files when 
> you open them, but the fact is, you shouldn't need to, just to use it. 
> Checking the SHA1 of the pack-file in particular is very expensive (since 
> it's potentially a huge file, and you don't even want to read all of it).

IIRC, we check the size of the pack file and there are hashes around the
ends of the two files which have to match; but this is a die() check, not
an ignore check, so we just crash with a clear error message rather than
doing crazy stuff (like reading from beyond the end of the mmap).

> So that's what I decided the rule is: never ever have a partial file, and 
> thus you can by definition use them immediately when you see both files.
> 
> But that requires that you write them under another name than the final 
> one. And since you want that _anyway_ for other uses, you don't hide that 
> inside "git-pack-objects", but you make it an exported interface.

We should never write anything under the final name, anyway, for just this
reason; we already use open/write/close/rename for objects, refs, and
cache (maybe not working directory files, though). I think we're actually
agreeing on this.

My position is that the temporary location should be something like
{final-name}.part, such that it doesn't match *.idx or *.pack beforehand
(so it doesn't look like a complete file that you might want to send to
someone) and it doesn't have to worry about EXDEV on the rename. Also, I
would ideally like to be able to resume an interrupted download, which
means that it would have to find the partial file in a predictable
location, given what it's supposed to contain.

	-Daniel
*This .sig left intentionally blank*
