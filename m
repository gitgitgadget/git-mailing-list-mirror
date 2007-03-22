From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 08:58:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703220847540.6730@woody.linux-foundation.org>
References: <200702281036.30539.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703200832150.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
 <200703210956.50018.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 16:58:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUPgZ-0007Ta-3c
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 16:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933295AbXCVP6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 11:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933701AbXCVP6k
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 11:58:40 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37291 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933295AbXCVP6j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 11:58:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2MFwbG9008483
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Mar 2007 08:58:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2MFwamc023959;
	Thu, 22 Mar 2007 08:58:36 -0700
In-Reply-To: <200703210956.50018.litvinov2004@gmail.com>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42861>


[ Sorry, I got sidetracked, have been looking at kernel bugs and git 
  optimizations. I added back the git mailing list, since there is no 
  private file data here any more, and I'd like others to follow this
  saga too ]

On Wed, 21 Mar 2007, Alexander Litvinov wrote:
>
> > Oh, btw, before I do that - do you by any chance have the *uncorrupt*
> > version of the file that should be this object? In other words, do you
> > have object 03312463e194d68d0d677b51e09b47cb29ca926a in another
> > repository? It should be a version of your file.
>
> It is pity, but I don't have that version. It was broken at my last commit and 
> I will redo it again. I remeber the changes I have done.
> 
> The new file has different sha1 sum but I attach it to show you the real file 
> content.

Sadly, I actually would need to compare it to the exact object it *should* 
have generated, and that means that I'm not actually all that interested 
in the "real file content" per se, I really would need to see the exact 
blob, so that I can generate the object it should have been, and then 
compare that against the corrupt one... 

It's the binary data I'd like to compare, so that I can tell (for example) 
if there is just a chunk missing in the middle, or something like that. 
But since even slight differences in the source data will lead to 
different binary data, and since the compressed and corrupt data I have 
from you earlier doesn't make sense on its own, I do care about the exact 
object that got corrupted.

> By the way, I now I am using git (3ba7a10) taken from next with tree your 
> patches:
> 1. disables the hardlinking code for CYGWIN, and it also checks for errors 
> from "close()"
> 2. Don't ever return corrupt objects from "parse_object()"
> 3. Be more careful about zlib return values.

Ok, apart from #1, those should be in current -git now, along with better 
validation checks (by Nico) when packing. So hopefully at least when there 
is corruption in a loose object, we will now always notice when we do a 
"git repack", and will never generate a broken pack-file. Knock wood.

Of course, I actually wonder if the bug might be in your version of zlib 
(miscompiled or some other thing), in which case *any* amount of 
pre-validation won't really help, because it will become corrupted when we 
deflate it prior to writing. For example, if "deflateBound()" sometimes 
doesn't give a valid upper bound and we allocate too little space..

> Yesterday brakage was made by git with only first patch.

I see that you seem to be able to reproduce it again - I'll answer that 
email separately just so that the git list sees that message too. But it 
boils down to: if it's reproducible, I'd *really* like to see the 
corrupted object and the exact file that it should have been generated 
from..

		Linus
