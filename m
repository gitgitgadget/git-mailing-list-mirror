From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 10:02:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702210934470.4043@woody.linux-foundation.org>
References: <20070221164527.GA8513@ginosko.local> <20070221165636.GH25559@spearce.org>
 <20070221171738.GA9112@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 19:02:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJvnQ-0004DP-GZ
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 19:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422736AbXBUSCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 13:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbXBUSCW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 13:02:22 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35527 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422736AbXBUSCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 13:02:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1LI26hB029710
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Feb 2007 10:02:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1LI254e021366;
	Wed, 21 Feb 2007 10:02:06 -0800
In-Reply-To: <20070221171738.GA9112@fieldses.org>
X-Spam-Status: No, hits=-0.464 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40311>



On Wed, 21 Feb 2007, J. Bruce Fields wrote:
> 
> Reconstructing history with a bunch of merges seems like something that
> could be a huge pain.  (Though with some tools it might be doable.)

It's not actually that painful, but it *is* expensive.

I wrote git-convert-cache (now "git convert-objects") back when we did the 
SHA1/compression switchover changes and the date format translation, so 
we've actually had a tool that can do history rewriting pretty much since 
day 1 (well, "day 14", to be exact, but still.. April 2005).

BUT:

 - I'm not guaranteeing that it works any more. We haven't changed the 
   fundamental object format since, so that particular program has never 
   gotten any testing. It still compiles, but does it work? I dunno.

   I actually tested it on git itself. It converted the top of the git 
   tree successfully, and generated a *new* git history. Why? Because it 
   will actually rewrite the old git tree entries that have permission 
   0664 into 0644: the *data* will be identical (and no git tools except 
   for "git fsck --pedantic" will even notice the difference), but the 
   converted tree avoids one of the legacy decisions that we never fixed 
   in the git repository itself.

   So it works at least to *some* degree, but I would suggest you be very 
   very careful!

 - it can be slow. For something like git, which isn't *that* big, and 
   where we actually don't need to do a lot of rewriting (ie all the blobs 
   stay the same, and only a few trees have to be rewritten, and so it's 
   really just rewriting commits), it's not that bad. It actyally 
   converted the whole git history in less than ten seconds for me.

   But if you have a *huge* tree, and you actually convert objects too 
   (say, you started using git on Windows before the "autocrlf" thing, and 
   want to convert the old blobs from CRLF -> LF), it would

    (a) require some extensions to convert-object.c to do the blob 
        conversion
    (b) be *much* slower
    (c) generate tons of unpacked objects (because git-convert-objects 
        doesn't know to pack in between, and doesn't use anything 
        newfangled like "git-fast-import" to do anything clever)

   For the kernel, it took 2 minutes, but again, it was exactly the same 
   thing: just a few old tree objects that it rewrote, and as a result, 
   every single commit SHA1 changed. Still, it was almost _only_ commits 
   (it generated 49521 new objects, 49332 of which was the new commit 
   history)

   If you want to rewrite a *lot* (ie somethign that exists in more than 
   just a few trees), and you have lots of history, it can be very 
   expensive indeed.

 - It currently doesn't convert the SHA1 numbers that show up in commit 
   messages. It could, and it should. But it doesn't. So once you convert 
   a git project, it doesn't do the nice "gitk does links from the SHA1 
   text in a commit message to the commit it talks about" any more.

   Somebody should fix that.

Anyway, git-convert-objects does kind of give you a starting point. It 
should be fixed to use "git-fast-import" or repack once in a while (so 
that it doesn't leave tons and tons of unpacked objects), and it should be 
fixed to fix up any commit messages that mention SHA1's that it has 
already converted to something else, but it seems to still work. It would 
not be impossible at all to extend the tree-rewriting logic to remove some 
file or a particular SHA1 object you want to replace.

			Linus
