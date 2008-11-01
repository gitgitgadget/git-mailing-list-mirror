From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 13:29:22 -0700
Message-ID: <20081101202922.GB15463@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org> <20081101173042.GE26229@artemis.corp> <490CA37C.1070107@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 01 21:30:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwN7E-0007Rt-EK
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 21:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbYKAU3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 16:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbYKAU3X
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 16:29:23 -0400
Received: from george.spearce.org ([209.20.77.23]:41209 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbYKAU3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 16:29:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1944E3835F; Sat,  1 Nov 2008 20:29:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <490CA37C.1070107@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99773>

Andreas Ericsson <ae@op5.se> wrote:
> Pierre Habouzit wrote:
>> On Fri, Oct 31, 2008 at 06:41:54PM +0000, Shawn O. Pearce wrote:
>>> How about this?
>>>
>>> http://www.spearce.org/projects/scm/libgit2/apidocs/CONVENTIONS
>>
>> FWIW I've read what you say about types, while this is good design to
>> make things abstract, accessors are slower _and_ disallow many
>> optimizations as it's a function call and that it may clobber all your
>> pointers values.

True, accessors slow things down.  But I'm not sure that the
accessors at the application level are going to be a huge problem.

Where the CPU time really matters is inside the tight loops of the
library, where we can expose the struct to ourselves, because if
the layout changes we'd be relinking the library anyway with the
updated object code.

I would rather stick with accessors right now.  We could in the
future expose the structs and convert the accessors to macros or
inline functions in a future version of the ABI if performance is
really shown to be a problem here from the *application*.

Remember we are mostly talking about applications that are happy to
fork+exec git right now.  A little accessor function call is *still*
faster than that fork call was.

>> struct object in git has not changed since 2006.06. struct commit hasn't
>> since 2005.04 if you ignore { unsigned int indegree; void *util; } that
>> if I'm correct are annotations, and is a problem we (I think) have to
>> address differently anyways (I gave my proposal on this, I'm eager to
>> hear about what other think on the subject). So if in git.git that _is_
>> a moving target we have had a 2 year old implementation for those types,
>> it's that they're pretty well like this.
>>
>> It's IMNSHO on the matter that core structures of git _will_ have to be
>> made explicit. I'm thinking objects and their "subtypes" (commits,
>> trees, blobs). Maybe a couple of things on the same vein.
>
> I agree. "git_commit", "git_tree", "git_blob" and "git_tag" can almost
> certainly be set in stone straight away.

Eh, I disagree here.  In git.git today "struct commit" exposes its
buffer with the canonical commit encoding.  Having that visible
wrecks what Nico and I were thinking about doing with pack v4 and
encoding commits in a non-canonical format when stored in packs.
Ditto with trees.

Because git.git code goes against that canonical buffer we cannot
easily insert pack v4 and test the improvements we want to make.
The refactoring required is one of the reasons we haven't done pack
v4 yet.  _IF_ we really are going through this effort of building
a different API and shifting to its use in git.git I want to make
sure we at least initially leave the door open to make changes
without rewriting everything *again*.

Accessor functions can usually be inlined or macro'd away.  But
they cannot be magically inserted by the compiler if they aren't
there in the first place.  This isn't Python...  :-)

-- 
Shawn.
