From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 - a true git library
Date: Mon, 03 Nov 2008 14:08:16 +0100
Message-ID: <490EF7C0.3000909@op5.se>
References: <20081031170704.GU14786@spearce.org> <490CAB6D.90209@op5.se> <20081101204259.GC15463@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 14:09:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwzBh-0003UO-9H
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 14:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbYKCNIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 08:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755169AbYKCNIa
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 08:08:30 -0500
Received: from mail.op5.se ([193.201.96.20]:53918 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbYKCNI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 08:08:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 088FB1B80062;
	Mon,  3 Nov 2008 14:03:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fDriVAoyPwPE; Mon,  3 Nov 2008 14:03:15 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id B7EFB1B8004E;
	Mon,  3 Nov 2008 14:03:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081101204259.GC15463@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99938>

Shawn O. Pearce wrote:
> Andreas Ericsson <ae@op5.se> wrote:
>> Shawn O. Pearce wrote:
>>> During the GitTogether we were kicking around the idea of a ground-up
>>> implementation of a Git library.
>> Having looked briefly at the code, I've got a couple of comments:
>> * GIT_EXTERN() does nothing. Ever. It's noise and should be removed.
> 
> I feel the same way.
> 
> But I was also under the impression that the brilliant engineers
> who work for Microsoft decided that on their platform special
> annotations have to be inserted on functions that a DLL wants to
> export to applications.
> 
> Hence any cross-platform library that I have seen annotates their
> exported functions this way, with the macro being empty on POSIX
> and expanding to some magic keyword on Microsoft's OS.  I think it
> goes between the return type and the function name too...
> 
>>  Instead it would be better to have GIT_PRIVATE(),
> 
> I can see why you said this; needing GIT_PRIVATE() is a lot more
> rare than needing GIT_EXTERN().  Only a handful of cross-module,
> but private, functions are likely to exist, so it makes sense to
> mark the smaller subset.  But see above.  *sigh*
> 

Thanks for the detailed explanation.

>> * Prefixing the files themselves with git_ is useless and only leads
>>  to developer frustration. I imagine we'd be installing any header
>>  files in a git/ directory anyway, so we're gaining absolutely
>>  nothing with the git_ prefix on source-files.
> 
> Yes, I realized that this morning.  I plan on changing that mess
> around so we have "include/git/oid.h" and library and application
> code can use "#include <git/oid.h>".  Library modules should just
> be "src/oid.c" then.
> 

I noticed when I fetched the latest head today that it's already
done. I fail to understand why headers need to be in a separate
path so that oid.c can't just '#include "oid.h"'.

With the risk of nitpicking you to death, put public headers in a
separate dir (I'd suggest public/%.h in Make-speak, but I have no
strong preference) and keep private headers next to %.c. Always
#include the public header file from the private one (that should
probably be in CONVENTIONS).

>> Apart from that, it seems you've been designing a lot rather than
>> trying to use the API to actually do something.
> 
> I wanted to get a solid idea of what our API conventions should be,
> before we started writing a lot of code around them.  Part of the
> problem with the git.git code is we don't have conventions that are
> really suited for use in a shared library (assuming we even have
> conventions in there) so we can't use that code as a library today.
> 

Right. I guess I'm too firm a believer in system evolution by constant
refactoring (with fluctuating api's, yes) rather than thinking initial
design can ever be done exactly right.

>> It would, imo, be
>> a lot better to start development with adding functionality shared
>> between all programs and then expand further on that, such as
>> incorporating all functions needed for manipulating tags into the
>> library and then modify existing code to use the library to get
>> tag-ish things done.
> 
> Tags are mostly pointless.  Its a tiny part of the code that isn't
> that interesting to most people.  And it requires object database
> access anyway if you want to talk about parsing or reading a tag.
> There's almost no point in a git library that can't read the on
> disk object database, or write to it.
> 

True, but designing top-down means you'll need to write one more
API to get the first stuff working, so you'll always be using the
new code you write immediately and for something real. IMO, that
makes it much more fun and productive to write the lib itself.

>> I also think it's quite alright to not strive *too* hard to make
>> all functions thread-safe, as very few of them will actually need
>> that. It's unlikely that a user program will spawn one thread to
>> write a lot of tags while another is trying to parse them, for
>> example.
> 
> Oh really?
> 
> Maybe true for tags, just because they are such an unimportant part
> of the git suite compared to everything else.
> 
> But right now I'm running a production system using a threaded server
> process that is operating on Git repositories.  Fortunately threads
> suck less on Java than they do on POSIX, and we have a 100% pure
> Java library available for Git.
> 
> It would be nice if a library created in the late part of 2008
> recognized that threads exist, aren't going to disappear tomorrow,
> and that consumers of libraries actually may need to run the library
> within a threaded process.
> 
> Or are you one of those developers who think threads only exist
> in the giant monolithic kernel land, and all user space should
> be isolated process?  I often wonder who such people can justify
> the kernel address space being multi-threaded but userland being
> stuck to single threaded applications.  Oh, right, the kernel has
> to go fast...
> 

No, I'm one of those developers who think that if implementing a
function as thread-safe means it'll take 50 times longer than just
writing something that works, the right decision is to go with the
faster way to get the job done and then expand on it later when the
need arises. Reading my original post, I realize I should have made
that more clear. Sorry for making your gall rise unnecessarily.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
