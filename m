From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 22:58:25 +0100
Message-ID: <490CD101.1030604@op5.se>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org> <20081101173042.GE26229@artemis.corp> <490CA37C.1070107@op5.se> <20081101202922.GB15463@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 23:01:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwOXG-0004Tg-7L
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 23:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbYKAV6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 17:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbYKAV6o
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 17:58:44 -0400
Received: from mail.op5.se ([193.201.96.20]:39089 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbYKAV6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 17:58:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2BA5126A0E5B;
	Sat,  1 Nov 2008 22:53:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ce2hNOU2iU6; Sat,  1 Nov 2008 22:53:29 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id E9BA624B0005;
	Sat,  1 Nov 2008 22:53:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081101202922.GB15463@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99778>

Shawn O. Pearce wrote:
> Andreas Ericsson <ae@op5.se> wrote:
>> Pierre Habouzit wrote:
>>> On Fri, Oct 31, 2008 at 06:41:54PM +0000, Shawn O. Pearce wrote:
>>>> How about this?
>>>>
>>>> http://www.spearce.org/projects/scm/libgit2/apidocs/CONVENTIONS
>>> FWIW I've read what you say about types, while this is good design to
>>> make things abstract, accessors are slower _and_ disallow many
>>> optimizations as it's a function call and that it may clobber all your
>>> pointers values.
> 
> True, accessors slow things down.  But I'm not sure that the
> accessors at the application level are going to be a huge problem.
> 
> Where the CPU time really matters is inside the tight loops of the
> library, where we can expose the struct to ourselves, because if
> the layout changes we'd be relinking the library anyway with the
> updated object code.
> 
> I would rather stick with accessors right now.  We could in the
> future expose the structs and convert the accessors to macros or
> inline functions in a future version of the ABI if performance is
> really shown to be a problem here from the *application*.
> 
> Remember we are mostly talking about applications that are happy to
> fork+exec git right now.  A little accessor function call is *still*
> faster than that fork call was.
> 
>>> struct object in git has not changed since 2006.06. struct commit hasn't
>>> since 2005.04 if you ignore { unsigned int indegree; void *util; } that
>>> if I'm correct are annotations, and is a problem we (I think) have to
>>> address differently anyways (I gave my proposal on this, I'm eager to
>>> hear about what other think on the subject). So if in git.git that _is_
>>> a moving target we have had a 2 year old implementation for those types,
>>> it's that they're pretty well like this.
>>>
>>> It's IMNSHO on the matter that core structures of git _will_ have to be
>>> made explicit. I'm thinking objects and their "subtypes" (commits,
>>> trees, blobs). Maybe a couple of things on the same vein.
>> I agree. "git_commit", "git_tree", "git_blob" and "git_tag" can almost
>> certainly be set in stone straight away.
> 
> Eh, I disagree here.  In git.git today "struct commit" exposes its
> buffer with the canonical commit encoding.  Having that visible
> wrecks what Nico and I were thinking about doing with pack v4 and
> encoding commits in a non-canonical format when stored in packs.
> Ditto with trees.
> 

Err... isn't that backwards? Surely you want to store stuff in the
canonical format so you're forced to do as few translations as
possible? Or are you trying to speed up packing by skipping the
canonicalization part? If so, that would slow down reading (or
rather, presenting) the commits, wouldn't it?

> Because git.git code goes against that canonical buffer we cannot
> easily insert pack v4 and test the improvements we want to make.
> The refactoring required is one of the reasons we haven't done pack
> v4 yet.  _IF_ we really are going through this effort of building
> a different API and shifting to its use in git.git I want to make
> sure we at least initially leave the door open to make changes
> without rewriting everything *again*.
> 

Well, if macro usage is adhered to one wouldn't have to worry,
since the macro can just be rewritten with a function later (if,
for example, translation or some such happens to be required).
Older code linking to a newer library would work (assuming the
size of the commit object doesn't change anyway), but newer code
linking to an older library would not. Otoh, they wouldn't even
build unless they used the wrong header files, so there is nothing
to worry about there.

> Accessor functions can usually be inlined or macro'd away.  But
> they cannot be magically inserted by the compiler if they aren't
> there in the first place.  This isn't Python...  :-)
> 

What I meant was this (I'm a tad drunk, so read the spirit, not
the letter):

in "foo-api.h":
--%<--%<--
#ifdef BUILDING_FOR_DEPLOYING
#include "git_foo_decls.h"
# define git_foo_get_buf(git_foo) (git_foo->buf)
#else
#include "git_foo_fwd_decls.h"
extern const char *git_foo_get_buf(git_foo *foo);
#endif
--%<--%<--

foo.c
--%<--%<--
#include "foo-api.h"
#include "git_foo_decls.h"
#ifndef BUILDING_FOR_DEPLOYING
const char git_foo_get_buf(git_foo *foo)
{
	return foo->buf;
}

/* other accessors go here */
#endif

/* rest of git_foo manipulators go here */
--%<--%<--

It's almost certainly not worth it for libgit2 though, as git@vger
provides a good review system.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
