From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
Date: Sun, 27 May 2007 13:09:15 -0700
Message-ID: <7vejl2do5w.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
	<200705102006.08624.johan@herland.net>
	<alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
	<200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun May 27 22:09:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsP3O-0000D4-GJ
	for gcvg-git@gmane.org; Sun, 27 May 2007 22:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbXE0UJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 16:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbXE0UJR
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 16:09:17 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61805 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbXE0UJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 16:09:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070527200915.HQCI13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 27 May 2007 16:09:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4L9F1X0061kojtg0000000; Sun, 27 May 2007 16:09:15 -0400
In-Reply-To: <200705271608.02122.johan@herland.net> (Johan Herland's message
	of "Sun, 27 May 2007 16:08:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48574>

Johan Herland <johan@herland.net> writes:

> I've been working on combining tag objects and --decorate into a useful
> proof-of-concept that provides the after-the-fact commit annotations I
> requested above, and here's the result:
> ...

Very nicely presented. I appreciate [PATCH 0/N] summary for a
series like this that talks about not just what and how it does,
but focus more on why it does it in a particular way, on design
issues, and decisions.  It makes it very pleasant to comment on
the series to have a well written summary like this, because in
the early stage of a review cycle, we would want to talk about
the design, ignoring implementation details.

> However, there are still some remaining questions:
>
> - Is the creation of a unique tag name (i.e. the 'tag' field _inside_ the
>   object) for note objects really necessary? Which parts of the system rely
>   on these names to be unique across tag objects?

None.  Although your use of note-X{40} would make "recovering"
easier, I would imagine.

> - Should notes have their own object type instead of piggy-backing on "tag"?
>
> - What about having a note object type with minimal header fields, and make
>   tags just a special case of a note object with an extra tag name header?

Two things struck me:

 - The "reverse" mapping 'note' tag uses uses FS as a database.
   Clever but would not scale well.

 - *BUT* the reverse mapping 'note' tag uses is exactly what we
    would want to use for tags that are not notes, for tools
    like gitk to attach little flags to commits.

So maybe we _should_ not even need to call this a new 'notes'
system.  I am just saying your second point above in a different
way, but I suspect all what is needed is to make the filtering
and presentation of tag objects a bit more flexible, and making
use of the 'peeled' (see .git/packed-refs, for example) mapping
ultra cheap for ordinary tags.

What you would need are:

 - Ultra-cheap reverse lookup: "I have an object; which tags
   point at this?"

   You solved it with refs/notes/<sha1-of-tagged>/, but it would
   be useful to extend this to any tag in general.

 - Easy way to filter the above question: "I have an object;
   which tags of this particlar class point at this?"

   You are essentially prefiltering by only making notes tags
   available via refs/notes/ hierarchy, but you can also filter
   with your naming convention "tag notes-<sha1>".  We _could_
   (I am not seriously suggesting this yet as I haven't thought
   through the issues yet) allow "keyword" header to tag
   objects, and allow --decorate='kwd1,kwd2,...' to limit the
   tags we take object decorations from the ones that has one of
   the specified keywords.  If we do that, I suspect your
   'notes' system would naturally fall out as regular tags that
   happen to have a keyword header with 'note' on it.

> - What about notes on notes? How are tags on tags treated? How should they be
>   treated?

You can create a tag object that points at another tag.  When we
peel a tag using "^{}" notation, currently it is peeled all the
way until we hit a non tag, so if you need to look at
intermediate tags, you need to parse them yourself.  IOW, there
is no Porcelain feature to let you take advantage of this
capability, easily.  But we could use this to say "I attest that
he tagged that object".

> - Currently noted objects (notees?) are treated as reachable from their
>   associated notes, i.e. like tags. This means that an otherwise dangling
>   object will not be detected and removed if it has associated notes.

I think it largely depends on how you intend to use 'notes' if
this is a problem.

The reachability issue is not limited to cruft removal; it also
affects the fetching.

I would imagine the intended use of a 'note' is to annotate
objects (mostly commits, but not necessarily) after the fact,
e.g. "this is reported to fix the issue 35833".  You may or may
not want to propagate this across repositories, and the way you
implemented it is to have a ref pointing at the note -- then it
would make it fetchable by other people.  Otherwise it would not.
With your implementation, unfortunately, not having a ref under
refs/notes/ would also make the information unavailable to
yourself.

I think the semantics you would want, when a 'note' object that
points at another object (pointee) exists, is to allow creating
a fake (reverse) reachability that says "pointee points at the
note".  When such a reachability exists:

 - A fetch from such a repository that transfers out the pointee
   will drag the note attached to it along with it (so you would
   teach rev-list/upload-pack about the extended reachability).

 - Incidentally, having a ref that points at the pointee is
   enough to protect the note that points at the pointee from
   getting pruned (so you would teach fsck/prune about the
   extended reachability).

Othewise, the 'note' is subject to garbage collection.  This is
pretty much an extension to the existing 'grafts' mechanism,
which can only override commit and its parents; what is done in
the above is to add (not override) to existing reachability to
any object (not just commit, but anything that can get 'noted').
