From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Wed, 7 Jan 2009 15:29:26 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
References: <20081209093627.77039a1f@perceptron>  <1231282320.8870.52.camel@starfruit>  <alpine.LFD.2.00.0901062005290.26118@xanadu.home>  <1231292360.8870.61.camel@starfruit>  <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>  <1231314099.8870.415.camel@starfruit>
  <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 00:32:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKhsw-00015q-Df
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 00:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758345AbZAGXak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 18:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbZAGXak
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 18:30:40 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48557 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757298AbZAGXai (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 18:30:38 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n07NTQax013964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 15:29:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n07NTQIq011697;
	Wed, 7 Jan 2009 15:29:26 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1231368935.8870.584.camel@starfruit>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.949 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104850>



On Wed, 7 Jan 2009, R. Tyler Ballance wrote:
>
> >    git process - ie a wild pointer, or perhaps a race condition (but we 
> >    don't really use threading in 1.6.0.4 unless you ask for it, and even 
> >    then just for pack-file generation)
> 
> I have a feeling it's something like this, one of our operations guys
> did some research while I was looking at code and he came across this:
> 
>         On Wed, 2009-01-07 at 14:17 -0800, Ken Brownfield wrote:
>         git-merge is using too much RAM, and failing to malloc() but
>         NOT  
>         > reporting it.  This is all sorts of bad:
>         > 
>         >   A) using an unscalable amount of RAM
>         >   B) failing to detect malloc() failure
>         >   C) reporting file corruption instead

Well, I dont' think that's exactly it. git internally doesn't really use 
malloc at all, and uses xmalloc() instead which will die() if the malloc 
fails. So there's almost certainly no "failing to detect failures"

Yes, there's a few places that don't use the wrapper, but they should be 
safe (eg either they SIGSEGV, or they are like create_delta_index() and 
just create a sub-optimal pack with a warning).

HOWEVER:

>         > I was able to reproduce this.
>         >
>         > limit ~1.5GB -> corrupt file
>         > limit ~3GB -> magically no longer corrupt.

That is interesting, although I also worry that there might be other 
issues going on (ie since you've reported thigns magically fixing 
themselves, maybe the ulimit tests just _happened_ to show that, even if 
it wasn't the core reason).

BUT! This is definitely worth looking at.

For example, we do have some cases where we try to do "mmap()", and if it 
fails, we try to free some memory and try again. In particular, in 
xmmap(), if an mmap() fails - which may be due to running out of virtual 
address space - we'll actually try to release some pack-file memory and 
try again. Maybe there's a bug there - and it would be one that seldom 
triggers for others.

> I think you're correct insofar that our major site-specific alteration
> has come up on the mailing list before (okay maybe two site-specific
> things). 
> 	* Our Git repo is ~7.1GB
> 	* ulimit -v is set to ~1.5G

It is certainly possible. It's too bad that it's private, because it makes 
it _much_ harder to try to pinpoint this.

				Linus
