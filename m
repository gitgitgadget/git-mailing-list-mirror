From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Wed, 7 Jan 2015 02:19:20 +0100
Message-ID: <CALKQrgcAVpcA1MiwC=XYMyXeKTvOYQwe8v4hpfJBEP4+ycic9g@mail.gmail.com>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
	<e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c>
	<xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
	<F6072C48-FA50-4F9D-AD26-0B4C4DD64B91@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Scott Chacon <schacon@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 02:19:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8fHb-0000XX-PP
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 02:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbbAGBTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 20:19:31 -0500
Received: from mail13.copyleft.no ([91.220.196.227]:38384 "EHLO
	mail13.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbbAGBTa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 20:19:30 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail13.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Y8fHT-0001dp-AL
	for git@vger.kernel.org; Wed, 07 Jan 2015 02:19:27 +0100
Received: from mail-pa0-f43.google.com ([209.85.220.43])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Y8fHS-00044p-Su
	for git@vger.kernel.org; Wed, 07 Jan 2015 02:19:27 +0100
Received: by mail-pa0-f43.google.com with SMTP id kx10so1359289pab.2
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 17:19:20 -0800 (PST)
X-Received: by 10.68.213.132 with SMTP id ns4mr507232pbc.148.1420593560681;
 Tue, 06 Jan 2015 17:19:20 -0800 (PST)
Received: by 10.70.105.4 with HTTP; Tue, 6 Jan 2015 17:19:20 -0800 (PST)
In-Reply-To: <F6072C48-FA50-4F9D-AD26-0B4C4DD64B91@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262120>

(This addresses some smaller specific questions from Kyle, and is not an
attempt to take focus away from the main direction of this thread)

On Jan 6, 2015 1:27 PM, "Kyle J. McKay" <mackyle@gmail.com> wrote:
> On Jan 6, 2015, at 02:20, Junio C Hamano wrote:

[...]

> At the point the dropped line runs, core.notesRef has been set to
> refs/notes/y which does not exist.

Merging into an empty or non-existing notes ref is not in itself an error.

> All of the tests in the 'fail to merge various non-note-trees' section
> fail with one of these errors:
>
>   1) Failed to resolve remote notes ref '<ref-being-tested>'
>
>   2) Cannot merge empty notes ref (<ref-being-tested>) into empty notes
>      ref (refs/notes/y)
>
>   3) error: object 6c99d48c... is a tree, not a commit
>
> The 3rd error comes from the "git notes merge x:" attempt.

Yes. We need an actual commit object which can become the second patent of
the notes merge.

> So despite the name of the test, the actual tree contents do not seem to
> be examined.

Correct. The test name should probably be improved. I have a bad habit of
using the term "notes tree" to refer to generic collection of notes, sometimes
meaning the notes ref, sometimes the commit referenced by a notes ref, and
sometimes the actual tree object referenced by the notes commit (or directly
referenced by the notes ref). In this case I guess a better name for the test
would be: "fail to merge various things that are not notes commits"

> When the notes ref checking is relaxed to leave refs/heads/master alone
> rather than turning it into refs/notes/refs/heads/master, the previous
> error (#2 in this case) goes away and since refs/notes/y does not exist,
> it is simply updated to the value of refs/heads/master without any checks.

This is the expected behaviour of merging an otherwise valid (notes) ref.

> Of course that refs/heads/master tree doesn't look like a notes tree.
>
> And if we do this:
>
>   git update-ref refs/notes/refs/heads/master master

(loading the gun and pointing it at your foot...)

> Then "git notes merge refs/heads/master" also succeeds without
> complaining that the refs/notes/refs/heads/master tree does not look
> like a notes tree and we didn't need to relax the refs/notes restriction
> and, as you point out, the name of the test seems to imply that would be
> rejected.

In this case, the test name is clearly misleading. As discussed elsewhere
in the thread, we cannot absolutely enforce a distinction between a "notes"
tree object (i.e. a git tree that contain ONLY notes entries) and a
"non-notes" tree object. There is only a strong convention/expectation that
a notes tree object contains only (or at least mostly) SHA1-named entries
(possibly with fanout).

That said, if you stick to the porcelain, you should not be able to create
a notes ref referencing a tree object that contains anything but notes.

> Interestingly, if we then attempt to merge refs/notes/x into this
> non-notes refs/notes/y tree, it also succeeds and even keeps the things
> that do not look like notes.  The reverse merge (y into x) succeeds as
> well, but the non-notes stuff in y is not merged in in that case.

The general policy for handling non-notes in notes code, is to ignore them
when querying, and preserve them when manipulating (t/t3304-notes-mixed.sh
has examples). In this case, we preserve the non-notes from the primary
parent (the notes tree from which the merge was started), and we ignore
any non-notes coming from subsequent parents. I can't remember if this
behaviour was explicitly desired, or if it's just an accident of
implementation. However, I will argue that it doesn't make sense for
notes-merge to attempt any meaningful merge of non-notes. That is simply
outside its scope.

>> Arguably, not being able to save notes tree anywhere outside of
>> refs/notes/ hierarchy may be too high a price to pay in order to
>> prevent refs/heads/master from being considered (hence to avoid such
>> end-user mistakes), but at the same time, losing this safetly may
>> also be too high a price to pay in order to allow people to store
>> their notes in somewhere outside e.g. refs/remote-notes/origin/foo.
>> "Somewhere outside" does not mean "Including other hierarchies like
>> refs/heads and refs/tags that have long established meaning".
>
> If we relax the refs/notes restriction, putting a notes ref in
> refs/heads/<whatever> doesn't necessarily seem like that's a terrible
> thing as long as it's really a notes tree if used with the notes
> machinery.  AIUI, the refs/heads convention only requires the ref to
> point to the tip of a commit chain which all of the refs under
> refs/notes satisfy.

At some point I remember having a discussion on whether we should
support notes refs pointing directly to a tree objects (to implement
"history-less" notes - sometimes the notes history itself is
uninteresting, if you're only interested in the current state of the
notes tree). However, I can't immediately find any tests exercising
this functionality, so it's likely unsupported (the convention here is
instead to use a commit object, but make sure to prepare the next notes
commit with zero parents; see notes-cache.{h,c} for an example of this.

> The refs/heads convention AIUI does not impose any requirement about
> the contents of the tree(s) those commits in the chain refer to.
> But at the same time I can't think of any particular reason I'd want
> to store notes refs in there either.
>
>> Although I am not fundamentally against allowing to store notes
>> outside refs/notes/, it is different from "anywhere is fine".
>> Can't we do this widening in a less damaging way?
>
> Without arbitrarily restricting where notes can be stored it seems to
> me the only option would be to have the notes machinery actually
> inspect the tree of any existing notes ref it's passed.  That would
> also catch the case where
> "git update-ref refs/notes/refs/heads/master master" was run as well.
> It also seems like a good check to have in place to help catch user
> errors.
>
> I'm not all that familiar with the notes code, perhaps there's already
> a function that does the tree check to make sure the tree actually
> looks like a notes tree that can easily be called?  Maybe Johan has
> some thoughts on this?

Nope, no such check. However, it's worth considering giving the user a
warning (maybe even - optionally - an error) when non-notes are found
in a notes tree. Search for non_note in notes.c to find relevant code.


Have fun! :)

...Johan
