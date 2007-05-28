From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Mon, 28 May 2007 02:29:08 +0200
Message-ID: <200705280229.08870.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705271608.02122.johan@herland.net>
 <7vejl2do5w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 28 02:29:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsT70-0003yj-6U
	for gcvg-git@gmane.org; Mon, 28 May 2007 02:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbXE1A3R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 20:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbXE1A3R
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 20:29:17 -0400
Received: from smtp.getmail.no ([84.208.20.33]:46891 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbXE1A3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 20:29:16 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIQ00I036OR4C00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 02:29:15 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIQ001XQ6OMDI50@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 02:29:10 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIQ00CXB6OMK870@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 02:29:10 +0200 (CEST)
In-reply-to: <7vejl2do5w.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48601>

On Sunday 27 May 2007, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> 
> > I've been working on combining tag objects and --decorate into a useful
> > proof-of-concept that provides the after-the-fact commit annotations I
> > requested above, and here's the result:
> > ...
> 
> Very nicely presented. I appreciate [PATCH 0/N] summary for a
> series like this that talks about not just what and how it does,
> but focus more on why it does it in a particular way, on design
> issues, and decisions.  It makes it very pleasant to comment on
> the series to have a well written summary like this, because in
> the early stage of a review cycle, we would want to talk about
> the design, ignoring implementation details.

Thanks, no problem. You're doing a really good job keeping all this crazy
development on track. The very least I can do is make your job easier. :)

> > However, there are still some remaining questions:
> >
> > - Is the creation of a unique tag name (i.e. the 'tag' field _inside_ the
> >   object) for note objects really necessary? Which parts of the system rely
> >   on these names to be unique across tag objects?
> 
> None.  Although your use of note-X{40} would make "recovering"
> easier, I would imagine.

Yeah, I'd rather just use _one_ identifier for all notes, instead of
generating yet another SHA1 sum, just to make each note (unecessarily)
unique.

> > - Should notes have their own object type instead of piggy-backing on "tag"?
> >
> > - What about having a note object type with minimal header fields, and make
> >   tags just a special case of a note object with an extra tag name header?
> 
> Two things struck me:
> 
>  - The "reverse" mapping 'note' tag uses uses FS as a database.
>    Clever but would not scale well.

Agreed.

>  - *BUT* the reverse mapping 'note' tag uses is exactly what we
>     would want to use for tags that are not notes, for tools
>     like gitk to attach little flags to commits.

For notes, it's obvious, as they aren't very useful unless we have a fast
reverse mapping, but it makes sense that other types of tag objects would
want this as well.

> So maybe we _should_ not even need to call this a new 'notes'
> system.  I am just saying your second point above in a different
> way, but I suspect all what is needed is to make the filtering
> and presentation of tag objects a bit more flexible, and making
> use of the 'peeled' (see .git/packed-refs, for example) mapping
> ultra cheap for ordinary tags.

Agreed. The peeled mapping makes a lot of sense here. I didn't know
about it when I first designed this, and I somehow managed to miss it
when I made the patches to pack-refs and show-refs.

Actually, I thought about something similar to the peeled mapping when
I designed the note refs. I basically had 3 reverse mapping options lined
up:

1. Put _all_ note refs in a single two-column file, noted objects
   ("notees") in the first column, and note objects in the second.
   Keep the file sorted by object name (first column), and keep the
   notes per object sorted chronologically. This would provide one of
   the fastest possible lookups for "git-note -l". However, the file
   would probably grow extremely large, slowing down insertion (and
   lookup) considerably.

2. One file per object with notes. Notes sorted chronologically within
   that file. This is sort of an intermediate between (1) and (3).

3. Keep a two-level hierarchy with one subdir per noted object, and one
   file per note. This is what I ended up with, mostly because it fit
   perfectly into the existing layout of refs/, and required very little
   code to implement.

Of course, now that I know about the peeled mapping, it makes more sense
to use a variation on that (maybe together with (1) or (2)).

> What you would need are:
> 
>  - Ultra-cheap reverse lookup: "I have an object; which tags
>    point at this?"
> 
>    You solved it with refs/notes/<sha1-of-tagged>/, but it would
>    be useful to extend this to any tag in general.
> 
>  - Easy way to filter the above question: "I have an object;
>    which tags of this particlar class point at this?"
> 
>    You are essentially prefiltering by only making notes tags
>    available via refs/notes/ hierarchy, but you can also filter
>    with your naming convention "tag notes-<sha1>".  We _could_
>    (I am not seriously suggesting this yet as I haven't thought
>    through the issues yet) allow "keyword" header to tag
>    objects, and allow --decorate='kwd1,kwd2,...' to limit the
>    tags we take object decorations from the ones that has one of
>    the specified keywords.  If we do that, I suspect your
>    'notes' system would naturally fall out as regular tags that
>    happen to have a keyword header with 'note' on it.

Yeah, I was thinking somewhat similarly; basically making tag objects
simpler and more versatile by replacing the "tag" header (which is
fundamentally unimportant to my notes) with a "tagtype" header which
could be set to "tag" for tag objects, "note" for note objects, etc.
Each tagtype could then further define headers specific to that tagtype.
For example could "tagtype == tag" objects reintroduce the "tag" header.

The tagtype field could then serve pretty much the same purpose as the
keyword header you suggest above.

> > - What about notes on notes? How are tags on tags treated? How should they be
> >   treated?
> 
> You can create a tag object that points at another tag.  When we
> peel a tag using "^{}" notation, currently it is peeled all the
> way until we hit a non tag, so if you need to look at
> intermediate tags, you need to parse them yourself.  IOW, there
> is no Porcelain feature to let you take advantage of this
> capability, easily.  But we could use this to say "I attest that
> he tagged that object".

Yeah, I'm still undecided on whether we want to allow notes on notes.
Some might argue that a note on a note should really be just another note
on the original noted object, and that nested notes doesn't make sense.
But then, on the other hand, there might be a use for nested notes.
Say, what about allowing threaded discussion on commits represented as
nested note objects? ;-P

In my current implementation, "git-note <tag>" will create a note on the
tag object, and not on the commit pointed to by the tag object. I'm not
sure that's the default behaviour I want; at least I would probably want
the note to show up when looking at the commit pointed to by that tag

> > - Currently noted objects (notees?) are treated as reachable from their
> >   associated notes, i.e. like tags. This means that an otherwise dangling
> >   object will not be detected and removed if it has associated notes.
> 
> I think it largely depends on how you intend to use 'notes' if
> this is a problem.
> 
> The reachability issue is not limited to cruft removal; it also
> affects the fetching.
> 
> I would imagine the intended use of a 'note' is to annotate
> objects (mostly commits, but not necessarily) after the fact,
> e.g. "this is reported to fix the issue 35833".

Yep, sounds about right, although other people might have other,
just as valid, ideas.

> You may or may 
> not want to propagate this across repositories, and the way you
> implemented it is to have a ref pointing at the note -- then it
> would make it fetchable by other people.  Otherwise it would not.
> With your implementation, unfortunately, not having a ref under
> refs/notes/ would also make the information unavailable to
> yourself.
> 
> I think the semantics you would want, when a 'note' object that
> points at another object (pointee) exists, is to allow creating
> a fake (reverse) reachability that says "pointee points at the
> note".  When such a reachability exists:
> 
>  - A fetch from such a repository that transfers out the pointee
>    will drag the note attached to it along with it (so you would
>    teach rev-list/upload-pack about the extended reachability).
> 
>  - Incidentally, having a ref that points at the pointee is
>    enough to protect the note that points at the pointee from
>    getting pruned (so you would teach fsck/prune about the
>    extended reachability).
> 
> Othewise, the 'note' is subject to garbage collection.

Yeah, the current implementation does not allow for this reverse/weaker
relationship at all.

I agree that fetchability and prunability of a note depends on the
fetch-/prunability of its pointee. Furthermore, a note on an otherwise
dangling object should not keep that object alive, but rather allow that
object to be pruned (automatically causing the note to be pruned as well).

> This is 
> pretty much an extension to the existing 'grafts' mechanism,
> which can only override commit and its parents; what is done in
> the above is to add (not override) to existing reachability to
> any object (not just commit, but anything that can get 'noted').

I'll have to read up on the 'grafts' mechanism, but it already sounds
like a much better way to encode these relationships than my crude
attempts in 'refs/notes'.

Thanks a lot for the feedback.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
