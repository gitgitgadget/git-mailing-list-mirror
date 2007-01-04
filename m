From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Thu, 4 Jan 2007 10:30:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701041016010.3661@woody.osdl.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> 
 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> 
 <204011cb0701031816hda8af9bw4d4a469c2b111339@mail.gmail.com>
 <204011cb0701040956p11ea2cepe3efaaf396056ac0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 19:31:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2XMi-00038Q-Da
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 19:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbXADSa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 13:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbXADSa5
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 13:30:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:42260 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965065AbXADSa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 13:30:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l04IUhWi025187
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 4 Jan 2007 10:30:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l04IUhjb027114;
	Thu, 4 Jan 2007 10:30:43 -0800
To: Chris Lee <clee@kde.org>
In-Reply-To: <204011cb0701040956p11ea2cepe3efaaf396056ac0@mail.gmail.com>
X-Spam-Status: No, hits=-0.673 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.166 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35944>



On Thu, 4 Jan 2007, Chris Lee wrote:
>
> Unfortunately, that's how the KDE repo is organized. (I tried arguing
> against this when they were going to do the original import, but I
> lost the argument.) And git-svnimport doesn't appear to have any sort
> of method for splitting a gigantic svn repo into several smaller git
> repos.

Well, the good news is, I think we could probably split it up from within 
git. It's not fundamentally hard, although it is pretty damn expensive 
(and it would require the subproject support to do really well).

So ignore that issue for now. I'd love to see the end result, if only 
because it sounds like you have a test-case for git that is four times 
bigger than the mozilla archive - even if it's just because of some really 
really stupid design decisions from the KDE SVN maintainers ;)

(But I would actually expect that KDE SVN uses SVN subprojects, so 
hopefully it's not _really_ one big repository. Of course, I don't know if 
SVN really does subprojects or how well it does them, so that's just a 
total guess).

The real problem with a SVN import is that I think SVN doesn't do merges 
right, so you can't import merge history properly (well, you can, if you 
decide that "properly" really means "SVN can't merge, so we can't really 
show it as merges in git either").

I think both git-svn and git-svnimport can _guess_ about merges, but it's 
just a heuristic, afaik. Whether it's a good one, I don't know.

> Yeah. I haven't bothered hacking git-svnimport yet - but it looks like
> having it automatically repack every thousand revisions or so would
> probably be a pretty big win.

That, or making it use the same "fastimport" that the hacked-up CVS 
importer was made to use. Either way, somebody who understands SVN 
intimately (and probably perl) would need to work on it. 

That would not be me, so I can't really help ;)

> By default, if I had, say, one pack with the first 1000 revisions, and
> I imported another 1000, running 'git-repack' on its own would leave
> the first pack alone and create a new pack with just the second 1000
> revisions, right?

Yes. It's _probably_ better to do a full re-pack every once in a while 
(because if you have a lot of pack-files, eventually that ends up being 
problematic too), but as a first approximation, it's probably fine to just 
do a plain "git repack" every thousand commits, and then do a full big 
repack at the end.

The big repack will still be pretty expensive, but it should be less 
painful than having everything unpacked. And at least the import won't 
have run with millions and millions of loose objects.

So doing a "git repack -a -d" at the end is a good idea, and _maybe_ it 
could be done in the middle too for really big packs.

Again, doing what fastimport does avoids most of the whole issue, since it 
just generates a pack up-front instead. But that requires the importer to 
specifically understand about that kind of setup.

> This is on a dual-CPU dual-core Opteron, running the AMD64 variant of
> Ubuntu's Edgy release (64-bit kernel, 64-bit native userland). The
> pack-file was around 2.3GB.

Ok, that should all be fine. A 31-bit thing in OpenSSL would explain it, 
and doesn't sound unlikely. Just somebody using "int" somewhere, and it 
would never have been triggered by any sane user of SHA1_Update(). The git 
pack-check.c usage really _is_ very odd, even if it happens to make sense 
in that particular schenario.

		Linus
