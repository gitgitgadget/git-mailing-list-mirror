From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 13:42:59 -0700
Message-ID: <20081101204259.GC15463@spearce.org>
References: <20081031170704.GU14786@spearce.org> <490CAB6D.90209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 01 21:44:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwNKQ-0002DB-UJ
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 21:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbYKAUnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 16:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbYKAUnA
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 16:43:00 -0400
Received: from george.spearce.org ([209.20.77.23]:43577 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbYKAUnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 16:43:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8155C3835F; Sat,  1 Nov 2008 20:42:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <490CAB6D.90209@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99776>

Andreas Ericsson <ae@op5.se> wrote:
> Shawn O. Pearce wrote:
>> During the GitTogether we were kicking around the idea of a ground-up
>> implementation of a Git library.
>
> Having looked briefly at the code, I've got a couple of comments:
> * GIT_EXTERN() does nothing. Ever. It's noise and should be removed.

I feel the same way.

But I was also under the impression that the brilliant engineers
who work for Microsoft decided that on their platform special
annotations have to be inserted on functions that a DLL wants to
export to applications.

Hence any cross-platform library that I have seen annotates their
exported functions this way, with the macro being empty on POSIX
and expanding to some magic keyword on Microsoft's OS.  I think it
goes between the return type and the function name too...

>  Instead it would be better to have GIT_PRIVATE(),

I can see why you said this; needing GIT_PRIVATE() is a lot more
rare than needing GIT_EXTERN().  Only a handful of cross-module,
but private, functions are likely to exist, so it makes sense to
mark the smaller subset.  But see above.  *sigh*

> * Prefixing the files themselves with git_ is useless and only leads
>  to developer frustration. I imagine we'd be installing any header
>  files in a git/ directory anyway, so we're gaining absolutely
>  nothing with the git_ prefix on source-files.

Yes, I realized that this morning.  I plan on changing that mess
around so we have "include/git/oid.h" and library and application
code can use "#include <git/oid.h>".  Library modules should just
be "src/oid.c" then.

> Apart from that, it seems you've been designing a lot rather than
> trying to use the API to actually do something.

I wanted to get a solid idea of what our API conventions should be,
before we started writing a lot of code around them.  Part of the
problem with the git.git code is we don't have conventions that are
really suited for use in a shared library (assuming we even have
conventions in there) so we can't use that code as a library today.

> It would, imo, be
> a lot better to start development with adding functionality shared
> between all programs and then expand further on that, such as
> incorporating all functions needed for manipulating tags into the
> library and then modify existing code to use the library to get
> tag-ish things done.

Tags are mostly pointless.  Its a tiny part of the code that isn't
that interesting to most people.  And it requires object database
access anyway if you want to talk about parsing or reading a tag.
There's almost no point in a git library that can't read the on
disk object database, or write to it.

> I also think it's quite alright to not strive *too* hard to make
> all functions thread-safe, as very few of them will actually need
> that. It's unlikely that a user program will spawn one thread to
> write a lot of tags while another is trying to parse them, for
> example.

Oh really?

Maybe true for tags, just because they are such an unimportant part
of the git suite compared to everything else.

But right now I'm running a production system using a threaded server
process that is operating on Git repositories.  Fortunately threads
suck less on Java than they do on POSIX, and we have a 100% pure
Java library available for Git.

It would be nice if a library created in the late part of 2008
recognized that threads exist, aren't going to disappear tomorrow,
and that consumers of libraries actually may need to run the library
within a threaded process.

Or are you one of those developers who think threads only exist
in the giant monolithic kernel land, and all user space should
be isolated process?  I often wonder who such people can justify
the kernel address space being multi-threaded but userland being
stuck to single threaded applications.  Oh, right, the kernel has
to go fast...

-- 
Shawn.
