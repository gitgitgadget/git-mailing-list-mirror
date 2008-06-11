From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Consolidate SHA1 object file close
Date: Wed, 11 Jun 2008 10:25:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806110952290.3101@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org> <20080611074309.GB28629@artemis.madism.org> <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org> <20080611154020.GE28629@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 19:27:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6U6A-0000Uh-QI
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 19:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbYFKR0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 13:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbYFKR0F
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 13:26:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36209 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751088AbYFKR0E (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2008 13:26:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BHPT4Q027838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jun 2008 10:25:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BHPSDc008836;
	Wed, 11 Jun 2008 10:25:28 -0700
In-Reply-To: <20080611154020.GE28629@artemis.madism.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.374 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84625>



On Wed, 11 Jun 2008, Pierre Habouzit wrote:
> > 
> > Hmm. Very interesting. That definitely sounds like a cache coherency 
> > issue (ie the "fsck" probably doesn't really _do_ anything, it just 
> > delays things and possibly causes memory pressure to throw some stuff out 
> > of the cache).
> > 
> > What clients, what server?
> 
>   Server uses NFSv3 kernel server from Debian's 2.6.18 etch (up to
> date).

Ok, it's almost impossible to be a server-side issue then - I could 
imagine that if you had some fancy cluster server or something, but in 
that kind os straightforward situation the only thing that is going to 
matter is the client-side caching.

I stopped using NFS so long ago that the only case I ever worried about 
and knew anything about was the traditional v2 issues. But iirc, v3 does 
nothing much to change the caching rules (v4, on the other hand, does add 
delegations and explicit caching support).

> Clients are various Unbuntu/Debian's with at least 2.6.18 kernels, some 
> .22 .24 and .25.

I'll ask Trond if he has any comments on this from the NFS client side. We 
_did_ hit some other NFS client bug with git long ago, I forget what it 
was all about (pread/pwrite?).

What is quite odd, though, is that exactly because of how git works, I 
would normally expect each client to not even *try* to look up objects 
that are written by other clients until long long after they have been 
written.

IOW, access to new objects is not something a git client will do just 
because the object suddenly appears in a directory - after the file is 
written and closed, it will not just be moved to the right position, but 
there has to be *other* files modified (ie the refs) to tell other clients 
about the changes too!

And that matters because even though there can be things like local 
directory caches (and Linux does support negative caching - ie the caching 
of the fact that a file was *not* there), those caches should be empty 
simply because other clients that didn't create the file shouldn't even 
have tried to look up non-existent objects!

If it's a directory content caching issue, then adding an fsync() won't 
matter. In fact, the fsync() should matter only if the client who wrote 
the object didn't write it out to the server at close() time, and that 
really sounds very unlikely indeed. So my personal guess is that the 
fsync() won't make any difference at all.

Do you have people using special flags for your NFS mounts? And do you 
know if there is some pattern to the client kernel versions when the 
problem happens?

		Linus
