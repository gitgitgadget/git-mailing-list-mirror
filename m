From: Jeff King <peff@peff.net>
Subject: Re: Git Notes - Track rebase/etc + reverse-lookup for bugs ideas
Date: Mon, 10 Nov 2008 14:11:35 -0500
Message-ID: <20081110191134.GA3329@sigill.intra.peff.net>
References: <6A0F154C-B9FE-4770-BF70-82A5BEBF907C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Harning <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:13:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzcC1-0006cs-V0
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbYKJTLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 14:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbYKJTLi
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:11:38 -0500
Received: from peff.net ([208.65.91.99]:2401 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbYKJTLi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 14:11:38 -0500
Received: (qmail 28439 invoked by uid 111); 10 Nov 2008 19:11:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 10 Nov 2008 14:11:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2008 14:11:35 -0500
Content-Disposition: inline
In-Reply-To: <6A0F154C-B9FE-4770-BF70-82A5BEBF907C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100546>

On Mon, Nov 10, 2008 at 12:37:20PM -0500, Thomas Harning wrote:

> Just wondering, has there been any looking into whether the git-notes  
> concept can track rebases?

Not that I know of, but then again, I'm not sure exactly what you mean
by "track rebases".

> Reading over what git-notes is leads me to think it could be a good  
> mechanism for the distributed bug-tracking idea I had some time ago.
> The only gotcha I see is that there would have to be some reverse mapping 
> / fast lookup to track the commit objects that given notes are attached 
> to.... and to facilitate individual assignment... notes applied to notes.

You can really think of the notes facility as a way of mapping
SHA1 -> SHA1. So the oft-discussed concept of "attach some text
to this commit" would be a commit sha1 mapping to a blob that
contains the text.  You have the commit, and you want to look up
the attached text.

How fast you can do a reverse lookup depends on what you are given. If
you are saying "I want to look through the list of all notes, and see
which commits they are attached to" that is quick. You are iterating
through the mapping, so you just look at the left hand side.

But if you are given a SHA-1 (say, of a blob with some text) and
ask "which commits map to this blob", then you will have to
linearly search through the mapping. Which really _isn't_ that
painful, if you are doing one such search per user request, but
can be slow if you want to do it for 10,000 notes.

And in the latter case, I would suggest simply building a reverse
mapping. Which you _could_ make as a parallel notes namespace,
but then you have to keep the two in sync. I would suggest
instead simply building a hash table on the fly for the reverse
mapping (which is basically what the forward-lookup does, anyway,
since our tree lookup is necessarily linear).

As far as attaching notes to notes, again it depends what you
mean. If you mean "map a blob SHA-1 to another blob SHA-1", then
that is simple. E.g., if you have some commit mapping to the text
note "foo", then you can map another note "bar" onto "foo".

But if you want to put a note onto the actual mapping, that is a
bit different. Since notes are a commit history of trees, I would
think you would simply make a new commit, and put your note into
the commit message. And if you need to do so after the fact, then
of course it is just putting a note onto the commit in the notes
history.

But bear in mind that the whole point of notes is annotating
commits after the fact, since commits must remain immutable. So
might it not be simpler to just update the note itself, with the
new information, rather than creating a note of a note?

> Operations for bug-tracking:
>
> 1) List all 'BUG'-type items that would refer to individual notes
> 2) List 'BUG' items reachable from a point
>    Perhaps with criterion that a certain 'bug note' attribute is not  
> set...
>    or that a 'BUG_CLOSED' note is not attached to the given 'bug note'

I'm not sure that doing bug tracking in this way makes sense with
notes. If notes are a mapping of a commit sha-1 to a blob, then
how do I have a commit with _two_ bugs? I think a bug database
should be indexed by bug id, not by commit id which has the bug.

-Peff
