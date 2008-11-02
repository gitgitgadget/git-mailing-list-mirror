From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 18:56:11 -0700
Message-ID: <20081102015611.GH15463@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org> <20081101173042.GE26229@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 02:57:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwSDu-0007en-IE
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 02:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbYKBB4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 21:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYKBB4N
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 21:56:13 -0400
Received: from george.spearce.org ([209.20.77.23]:59469 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbYKBB4M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 21:56:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D11963835F; Sun,  2 Nov 2008 01:56:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081101173042.GE26229@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99799>

Pierre Habouzit <madcoder@debian.org> wrote:
> On Fri, Oct 31, 2008 at 06:41:54PM +0000, Shawn O. Pearce wrote:
> > How about this?
> > 
> > http://www.spearce.org/projects/scm/libgit2/apidocs/CONVENTIONS
> 
> FWIW I've read what you say about types, while this is good design to
> make things abstract, accessors are slower _and_ disallow many
> optimizations as it's a function call and that it may clobber all your
> pointers values.

Yea, optimizing C is a bitch.

I'm in favor of accessors *IN THE APPLICATION*.

Within the library's own C code, I think we should expose the struct,
and use its members where it makes sense to.  Especially in the
really tight loops where we don't want to introduce more overhead.

My rationale here is that we can change the struct at any time,
and yet not change the ABI.

> For types that _will_ be in the tight loops, we must make the types
> explicit or it'll bite us hard performance-wise. I'm thinking what is
> "struct object" or "struct commit" in git.git. It's likely that we will
> loose a *lot* of those types are opaque.

Yes, but I'm arguing they should be opaque to the application, and
visible to the library.  Today the application is suffering from
massive fork+exec overhead.  I really don't give a damn if the
application's compiler has to deal with a function call to read
from a private member of an opaque type.  Its still thousands of
CPU instructions less per operation.

Come back to me a year after libgit2 has been widely deployed on
Linux distros and we have multiple applications linking to it.
Lets talk then about the harmful performance problems caused by
making these types opaque to the application.  About that time
we'll also be talking about how great pack v4 is and why its a good
thing those types were opaque, as we didn't have to break the ABI
to introduce it.
 
> It's IMNSHO on the matter that core structures of git _will_ have to be
> made explicit. I'm thinking objects and their "subtypes" (commits,
> trees, blobs). Maybe a couple of things on the same vein.

Sure, but in the library only.

-- 
Shawn.
