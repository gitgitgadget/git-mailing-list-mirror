From: Jeff King <peff@peff.net>
Subject: Re: Git Notes idea.
Date: Wed, 17 Dec 2008 04:38:44 -0500
Message-ID: <20081217093843.GA18265@coredump.intra.peff.net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Govind Salinas <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 10:40:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCssz-0002ek-65
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 10:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbYLQJiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 04:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbYLQJiv
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 04:38:51 -0500
Received: from peff.net ([208.65.91.99]:2178 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbYLQJit (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 04:38:49 -0500
Received: (qmail 25144 invoked by uid 111); 17 Dec 2008 09:38:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Dec 2008 04:38:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Dec 2008 04:38:44 -0500
Content-Disposition: inline
In-Reply-To: <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103328>

On Tue, Dec 16, 2008 at 12:43:55PM -0600, Govind Salinas wrote:

> I was thinking I would do my first implementation in pyrite and if I find
> that it works well I will port it.

OK, though your performance will probably suck unless you dump the notes
tree into a local hash at the beginning of your program. And looking up
every commit's note during revision traversal is one of the intended
uses (e.g., decorating git-log output, or filtering commits based on a
particular note).

And as Dscho mentioned, most of what you need is already there in C.
You are welcome to implement whatever you want in pyrite, of course, but
there is a desire to have this accessible to the revision traversal
machinery. And that means if you want your version in pyrite to be
compatible with what ends up in git, the data structure design needs to
be suitable for both.

> I just read the proposal from Johannes, he seems to want to use a
> similar layout.  However, I would like to modify my proposal slightly
> to make it work better when a gc is run.  I would modify the tree to
> look like this...
> 
> let 1234567890123456789012345678901234567890 be the
> id of the item that is annotated.
> 
> let abcdef7890123456789012345678901234567890 be the
> id of the note to be attached
> 
> root/
>      12/
>          34567890123456789012345678901234567890/
>              abcdef7890123456789012345678901234567890
> 
> This way all the notes are attached to a tree, so that gc won't
> think they are unreferenced objects.

But you have lost the ordering in your list, then, since they will not
be ordered by sha1 of the note contents. I don't know if you care. The
second sha1 is pointless, anyway, since nobody will know that number as
a reference; why not just name them monotonically starting at 1?

One of the things I don't like about having several notes is that it
introduces an extra level of indirection that every user has to pay for,
whether they want it or not. If a note can be a blob _or_ a tree, then
those who want to use blobs can reap the performance benefit. Those who
want multiple named notes in a hierarchy can pay the extra indirection
cost.

I haven't measured how big a cost that is (but bearing in mind that we
might want to do this lookup once per revision in a traversal, even one
extra object lookup can have an impact).

I'm also still not convinced the fan-out is worthwhile, but I can see
how it might be. It would be nice to see numbers for both.

> Perhaps I am missing something, how is it a linear search?.  Since we

I think Johannes explained in detail in another message, but it is a
linear search to look up directly in a tree object. Of course you can
build a hash or a sorted fixed-size list as an index.

> Also, how large do you expect the list to be under reasonable
> circumstances.

As many notes as there are commits is my goal (e.g., it is not hard to
imagine an automated process to add notes on build status). Ideally, we
could handle as many notes as there are objects; I see no reason not to
allow annotating arbitrary sha1's (I don't know if there is a use for
that, but the more scalable the implementation, the better).

> >  Some thoughts from me on naming issues:
> >  http://article.gmane.org/gmane.comp.version-control.git/100402
> 
> On naming.  I strongly support a ref/notes/sha1/sha1 approach.  If
> having a type to the note is important, then perhaps the first line of
> a note could be considered a type or a set of "tags".  This way you

I don't think we are talking about the same thing. What I mean by naming
is "here is a shorthand for referring to notes" that is not necessarily
coupled with the implementation. That is, I would like to do something
like:

  git log --notes-filter="foo:bar == 1"

and have that "foo:bar" as a shorthand on each commit for:

  refs/notes/foo:$COMMIT/bar

Without a left-hand side (e.g., "bar"), we get:

  refs/notes/default:$COMMIT/bar

Or without a right-hand side (e.g., "foo:"), we get:

  refs/notes/foo:$COMMIT

So you can group related notes in the same tree (which gives you fast
lookup if you are looking at multiple ones, since you only have to do
the tree lookup once), or you can keep notes in separate trees (which
means you can distribute some but not others).

I think your "list of notes" proposal on top of that would be for any
note resolution to provide a tree instead of a blob, with sequenced
elements. I.e., foo:bar might have multiple notes, like:

  refs/notes/foo:$COMMIT/bar/1
  refs/notes/foo:$COMMIT/bar/2
  refs/notes/foo:$COMMIT/bar/3

> drawback is that you have to open the blob to see the type.  A hybrid
> approach that uses refs/notes/acked/sha/sha which is one lookup if

Right, that is possible, but implementing only half of what I suggested
above. I think you should be flexible enough to have grouped notes for
fast lookup, or ungrouped notes for more flexibility.

-Peff
