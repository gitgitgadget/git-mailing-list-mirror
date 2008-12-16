From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: Git Notes idea.
Date: Tue, 16 Dec 2008 12:43:55 -0600
Message-ID: <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
	 <20081216085108.GA3031@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 16 19:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCeyx-0004ts-Fo
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 19:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbYLPSsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 13:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbYLPSsE
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 13:48:04 -0500
Received: from mail-gx0-f16.google.com ([209.85.217.16]:37207 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbYLPSsC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 13:48:02 -0500
Received: by gxk9 with SMTP id 9so5179219gxk.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 10:48:00 -0800 (PST)
Received: by 10.151.113.11 with SMTP id q11mr15230554ybm.90.1229453035952;
        Tue, 16 Dec 2008 10:43:55 -0800 (PST)
Received: by 10.151.74.12 with HTTP; Tue, 16 Dec 2008 10:43:55 -0800 (PST)
In-Reply-To: <20081216085108.GA3031@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103287>

On Tue, Dec 16, 2008 at 2:51 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 16, 2008 at 02:15:47AM -0600, Govind Salinas wrote:
>
>> I was thinking about possible ideas for my little pet project and I
>> had and idea for way to tack on notes to a commit, or any object
>> really.  I know that the idea has been flying around for a long time
>> but there has never been any implementation or a concept that people
>> liked enough to use (unless I have missed something).
>
> I think you look at the previous suggestions, because yours is very
> similar. Which is good, I think, because the current status is that the
> design is good, but nobody has gotten around to working on it yet. So
> maybe you can fix that. :)
>

I was thinking I would do my first implementation in pyrite and if I find
that it works well I will port it.

>> .git/refs/notes  contains a tree-id (assuming that using a tree-id
>> will not cause any problems, otherwise a commit object can be used.
>> it does not *need* a history, but it *could* have one).
>
> That is the same as the current proposal, except:
>
>  - the proposal is to use a commit, so your notes are version-controlled
>
>  - I have suggested supporting multiple note "bases" in the refs/notes
>   namespace. This would allow you to share some notes but not others
>   (e.g., if you had some automated notes related to a build/test
>   system, you might not want to mix those with your human-written
>   notes).
>
>> That tree has a structure similar to the layout of .git/objects, where
>> it is 2 letter subdirectories for the notes objects.
>
> I don't think this has been suggested yet, but I'm not sure it is a good
> idea. The usual reason for this split is that many filesystems handle
> large directories badly; that isn't a problem here.
>

I just read the proposal from Johannes, he seems to want to use a
similar layout.  However, I would like to modify my proposal slightly
to make it work better when a gc is run.  I would modify the tree to
look like this...

let 1234567890123456789012345678901234567890 be the
id of the item that is annotated.

let abcdef7890123456789012345678901234567890 be the
id of the note to be attached

root/
     12/
         34567890123456789012345678901234567890/
             abcdef7890123456789012345678901234567890

This way all the notes are attached to a tree, so that gc won't
think they are unreferenced objects.

> It does reduce the size of the resulting tree objects when a note is
> modified (we make updates to two smaller trees instead of one big tree).
> I don't know if this really matters all that much, since the trees
> will end up deltified in a pack anyway.
>
> And it does make the implementation slightly less simple, since we have
> to deal with two levels of trees.
>
>> Given a git object (commit, tree, blob, tag), use its sha as the
>> path/filename in this tree.
>>     If I have a commit 1234567890123456789012345678901234567890 then
>> the notes tree will have a file
>> 12/34567890123456789012345678901234567890
>>
>> That file has a list of sha1s (one per line).  These shas are object
>> IDs for blobs that have the notes or whatever that you want attached
>> to the item.
>
> This is slightly different than the current proposal. You are proposing
> that each item have a "list of notes". My thinking was to have "named
> notes" using a tree for each entry full of blobs. So you could look up
> the "foo" note for a given commit, but that note would be a single
> scalar (which could, of course, be interpreted according to its name).
>


>> I think you get the idea.  When looking up an item, it should be
>> fairly easy to have the notes tree and subtrees available for doing
>> lookups.  And as far as I know stuff under .git/refs can be
>
> It is easy, but it's slow because we have to do a linear search in the
> (potentially huge) notes tree. And that's what held up the initial
> implementation. I did a proof-of-concept a month or so ago that
> pre-seeded an in-memory hash using the tree contents and got pretty
> reasonable performance.
>

Perhaps I am missing something, how is it a linear search?.  Since we
are keying off of the sha of the annotated object, using a hashtable for
a cache should be a fairly quick binary search.  If you just wanted to
use the tree objects, that should work almost as well since the first tree
will split them up nicely for you.

Also, how large do you expect the list to be under reasonable
circumstances.

>> pushed/pulled even if its not under heads or remotes or tags using
>> already existing machinery.  I am not sure, but I think that would
>> satisfy gc operations as well.  Also, these trees and blobs never have
>> to be put in the working directory.
>
> Right, though I think one of the benefits of this approach is that you
> _could_ do a checkout on the notes tree if you wanted to do very
> flexible editing.
>

Sure, why not.

>> Does this sound like something that is workable?  I thought it might
>> appeal since it uses only features that are already present.
>
> Yes, it sounds workable, though if you diverge from what has already
> been discussed, I think you should make an argument about why your
> approach is better.
>

Well after reading Johannes proposal, I find it to be surprisingly similar
since I had not seen it before.  However I think mine is a win in a few ways.
One, it allows multiple notes per object.  Two, it plays well with gc.  From
what I could follow, the files in his layout just have a ref to the note object
but gc would be required to know about this feature and not remove those
note blobs.  Third it allows multiple sets of notes.  Although it seems that
at least 1 and 3 have been discussed at some length.

>> This could be extended so that you have different sets of notes under
>> .git/refs/notes/<my note set> or whatever.  So that you can have some
>> notes you keep private and some that you publish or whatever.
>
> Oops, I should have read your whole mail. Yes, that is a good idea. :)
>
> For reference, here are the previous discussions that I think are
> relevant:
>

Thanks for the pointers, a couple quick thoughts...

>  Some discussion of the interaction of notes and rebase:
>  http://thread.gmane.org/gmane.comp.version-control.git/100533
>

On rebasing, I have a couple thoughts.  1) I think it only really makes
sense to make a public annotation to a commit that is public, and
once a commit is public it should not be rebased.  2) We could also
annotate the commit's tree instead of the commit.  That would make
it somewhat resistant to rebases, cherry-picks and amends.  And
once a tree has changed, the notes are probably less reliable
although the user should be able to force a note or notes to be
carried along.

>  Some thoughts from me on naming issues:
>  http://article.gmane.org/gmane.comp.version-control.git/100402
>

On naming.  I strongly support a ref/notes/sha1/sha1 approach.  If
having a type to the note is important, then perhaps the first line of
a note could be considered a type or a set of "tags".  This way you
have both naming/typing and one lookup per sha.  The only
drawback is that you have to open the blob to see the type.  A hybrid
approach that uses refs/notes/acked/sha/sha which is one lookup if
you know the type and the sha of the annotated object before hand
might be worth considering.  This would be similar to the public or
private notes that i mentioned before.

>  Some thoughts from me on the tree speedup:
>  http://article.gmane.org/gmane.comp.version-control.git/101460
>

I guess I must be missing something.  I have seen several references
to this not being a binary search several times in the links that you have
here.  But I fail to see why a binary search cannot be done.  That said, I
would still think that the existing hash table would be the way to go.

> which I think should bring you up to speed. :)

Thanks again.

-Govind
