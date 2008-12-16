From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Notes idea.
Date: Wed, 17 Dec 2008 00:48:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812170003540.14632@racer>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>  <20081216085108.GA3031@coredump.intra.peff.net> <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 00:50:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCjg9-0003fQ-BA
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 00:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbYLPXs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 18:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbYLPXs7
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 18:48:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:46281 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751317AbYLPXs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 18:48:58 -0500
Received: (qmail invoked by alias); 16 Dec 2008 23:48:55 -0000
Received: from pD9EB298D.dip0.t-ipconnect.de (EHLO noname) [217.235.41.141]
  by mail.gmx.net (mp047) with SMTP; 17 Dec 2008 00:48:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1821QwXsuo2fQVB3+hJ12l1ESWRYTU+gV+WBZXBbR
	6W6nBdV5UbOHPd
X-X-Sender: gene099@racer
In-Reply-To: <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103297>

Hi,

On Tue, 16 Dec 2008, Govind Salinas wrote:

> I was thinking I would do my first implementation in pyrite and if I 
> find that it works well I will port it.

Given that there are a lot of building blocks in C already, I think it 
would be a waste of your time.

> I just read the proposal from Johannes, he seems to want to use a 
> similar layout.  However, I would like to modify my proposal slightly to 
> make it work better when a gc is run.  I would modify the tree to look 
> like this...
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

In my proposal back then, your root/12/345... would be a blob, in Peff's, 
it would be a tree, and in both cases the blobs/trees would be referenced 
by refs/notes, so git gc would not kill them either.

The bigger issue is that commit objects can be gc'ed, and then their notes 
should be gc'ed, too.

And of course, there is the rebase issue (which I completely missed; I 
will read the mail Jeff referenced tomorrow).

Speaking about the blobs vs trees issue, I think it is no issue, as Peff 
and me already discussed: the notes could check if it is a tree or a 
blob, and handle both easily.

> Peff wrote:
>
> > It is easy, but it's slow because we have to do a linear search in the 
> > (potentially huge) notes tree. And that's what held up the initial 
> > implementation. I did a proof-of-concept a month or so ago that 
> > pre-seeded an in-memory hash using the tree contents and got pretty 
> > reasonable performance.
> 
> Perhaps I am missing something, how is it a linear search?

Yes, you are missing what I wrote in the original thread: tree objects 
must be read in a forward direction, one by one.

IIRC back then, Junio and/or Linus suggested that you could backward 
search with heuristics finding the beginning of a tree entry, and thus you 
could kind of bisect the tree to search for a specific tree entry (since 
tree objects have the contents sorted), but I presented a case where this 
breaks down at the GitTogether:

Tree entries consist of a mode (as 6-byte ASCII representing the octal 
value), then SPC, then a NUL-terminated path, and then a 20-byte SHA-1.  
(Just hexdump the output of "git cat-file tree HEAD:" in any repository to 
see it).

The only heuristic you could apply to find your way backward (or forward) 
to find the beginning of a tree entry would be to find the NUL character 
and verify that exactly 20 bytes after it, either the tree object ends, or 
there is a valid octal number followed by a SPC.

The only thing you would need for this heuristic to break down is a SHA-1 
which contains a \x00 (which is then mistaken for a string termination), 
and part of a filename that could be mistaken to be an octal number.

Take for example the SHA-1 of git-gui in v1.6.0.5, which has a NUL its 
14th byte, and just assume that the next tree entry has mode 100644 
and name "4040000 Some financial record.txt".

Then, the NUL could be mistaken for the end of the previous tree entry, 
and "040000 " as the mode for the next one, whose name would be assumed to 
be "Some financial record.txt".

Granted, if you find two NULs in 21 bytes, one of them must be the 
termination of the path, but which one?

Worse, even if you would find a method (complicated, and therefore 
necessarily fragile) to find the boundary of the tree entries reliably, 
you would _still_ have a linear time unpacking the darned tree object in 
the first place.

So you cannot do that for every commit you encounter and expect not to die 
of boredom in the process.

Peff's very cute idea was to decouple that process from the per-commit 
procedure, and basically make it a one-time cost (per Git call, and only 
when notes were asked for).

It will still be linear in the number of notes, but it would then be in a 
hashmap, with an expected linear cost per commit.

> Also, how large do you expect the list to be under reasonable 
> circumstances.

We did not intend Git to be used as a backup tool, did we?

One of the _worst_ design decisions is to limit yourself by expectations.

> >  Some discussion of the interaction of notes and rebase:
> >  http://thread.gmane.org/gmane.comp.version-control.git/100533
> 
> On rebasing, I have a couple thoughts.
>
> 1) I think it only really makes sense to make a public annotation to a 
>    commit that is public, and once a commit is public it should not be 
>    rebased.

Again, do not limit your design by your expectations.  People already talk 
about having cover letters for their patch series as notes, and Pasky 
seems to discuss tracking explicit renames with notes when he does not 
play Go, instead of maintaining repo.or.cz and git.or.cz.

> 2) We could also annotate the commit's tree instead of the commit.  
>    That would make it somewhat resistant to rebases, cherry-picks and 
>    amends.

To the contrary.  When I rebase, the tree _does_ change, otherwise I would 
have rebased onto something that had the same original tree as my 
rebase-base to begin with, which would make the rebase rather pointless.

> >  Some thoughts from me on naming issues: 
> >  http://article.gmane.org/gmane.comp.version-control.git/100402
> 
> On naming.  I strongly support a ref/notes/sha1/sha1 approach.

I think you meant refs/notes:<first byte in hex>/<rest of bytes>/<some 
arbitrary SHA-1>?

I am rather supporting refs/nots:<first byte in hex>/<rest of bytes> being 
either a blob, or a tree containing human readable tags, such as "bugfix" 
or "review" or some such.

> If having a type to the note is important, then perhaps the first line 
> of a note could be considered a type or a set of "tags".

That would be horrible!  Just to know if you need to unpack the blob, 
you'd have to unpack it!

Hth,
Dscho
