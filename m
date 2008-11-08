From: Jeff King <peff@peff.net>
Subject: Re: How it was at GitTogether'08 ?
Date: Sat, 8 Nov 2008 09:17:27 -0500
Message-ID: <20081108141727.GA17100@coredump.intra.peff.net>
References: <200811080254.53202.jnareb@gmail.com> <200811080441.25796.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 15:18:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyoeQ-0001zP-Ol
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 15:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbYKHORd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 09:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753060AbYKHORc
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 09:17:32 -0500
Received: from peff.net ([208.65.91.99]:1744 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbYKHORb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 09:17:31 -0500
Received: (qmail 6270 invoked by uid 111); 8 Nov 2008 14:17:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 08 Nov 2008 09:17:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2008 09:17:27 -0500
Content-Disposition: inline
In-Reply-To: <200811080441.25796.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100402>

On Sat, Nov 08, 2008 at 04:41:25AM +0100, Johan Herland wrote:

> > * Discussion on notes
> 
> Can someone elaborate on this? AFAIK, notes have popped up on this list 
> often enough that I'm convinced it would be a _really_ useful feature. The 
> only drawback I was aware of, was the lack of an efficient implementation, 
> but then Jeff comes out of the blue and posts some interesting numbers [1] 
> a week or so ago. Does this mean there are no remaining obstacles?
> 
> [1]: http://article.gmane.org/gmane.comp.version-control.git/99415

The discussion was along the lines of "here are some more cool things we
could do, if we had notes." I don't remember the specifics of the cool
things, but they were related to annotating patches with review
information. Shawn can probably elaborate more.

That led to a "notes as a tree are nice, but too slow because looking up
a tree entry is linear" (and obviously you do a ton of lookups in the
notes tree during "git log"). Dscho had posted an implementation with a
persistent notes cache long ago. Since I failed to actually look at
that, I started on a slightly different approach, which is simply doing
an in-memory hash table to speedup the notes tree. And those are the
numbers and patch I posted.

My eventual plan was to re-work Dscho's patches with this performance
approach. But it is not at the top of my queue, so if somebody else
wanted to pick it up, I would be very happy. Everything I have done so
far is in the post you referenced.

The only other thing I remember discussing was notes namespaces. The two
obvious approaches are:

 1. a separate ref for each notes namespace, with each note ending up a
    blob in a tree. So you might have refs/notes/acked-by:$SHA1 as a
    blob.

 2. one notes ref, with the notes tree pointing a sub-tree that has
    named entries, one for each note type. So you might have
    refs/notes:$SHA1/acked-by as a blob.

The advantage of '1' is that it keeps your different note types
separate, which means it is easy to distribute one type but not the
other. The advantage of '2' is that I do one lookup per-commit, and then
I can see all of the notes, which keeps performance nice when you want
to annotate with several note types.

After some discussion, I think Dscho and I came to the conclusion that
supporting both might be desirable. And it should be pretty
straightforward. You can just have multiple note refs (but default to a
"main" one), and within each one, either point to a tree or blob (and we
will see which and use it appropriately).

And then depending on which notes the user wants, they can refer to them
appropriately. My suggestion for naming (and this wasn't discussed
earlier, so Dscho has not endorsed this) would be something like
"$X:$Y", which would mean "to get the notes for $SHA1, look at the tree
in refs/notes/$X for the file $SHA1/$Y". If $Y is empty, then expect
$SHA1 to be a blob (if it's a tree, maybe look at $SHA1/default). If
"$X" is empty, then use "refs/notes/default". If there is no colon,
assume we have "$Y".

So you could have a bunch of notes in some "main" namespace just by
calling them some name; without a name, you get some "default" note. But
if you wanted a separate database (say, for SVN information), you could
use "svn:" or "svn:name".

-Peff
