From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH] Supporting non-blob notes
Date: Tue, 18 Feb 2014 15:46:28 +0100
Message-ID: <CALKQrgff4tnekfkQn9JpJbGrNJzNBYNv=sW6vc3FE+hySkjf3g@mail.gmail.com>
References: <OF23F26261.C9E4823A-ONC1257C82.0032DA0B-C1257C82.0040D57A@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: yann.dirson@bertin.fr
X-From: git-owner@vger.kernel.org Tue Feb 18 15:46:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFlwZ-00014O-4V
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 15:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbaBROqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 09:46:36 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:45233 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364AbaBROqe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 09:46:34 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WFlwO-00033v-Dt
	for git@vger.kernel.org; Tue, 18 Feb 2014 15:46:32 +0100
Received: from mail-pd0-f181.google.com ([209.85.192.181])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WFlwN-000Kwc-Um
	for git@vger.kernel.org; Tue, 18 Feb 2014 15:46:32 +0100
Received: by mail-pd0-f181.google.com with SMTP id y10so16143651pdj.26
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 06:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0U5oU7U5W1W0Q6Kv+z6zHqkIWliOKCiYS0LzfCWaW3c=;
        b=XgVc+XmN78it5MXWXdXti2rd9X/2dE6PtcnuoaKCBXncVHhw6Ig9sHZCzQkr4svNZC
         riXOoHi/aLiom5uiO0d7wcrjAKTGiq8+tTQQrY9/5eoKhkxN40smM4gKIOwWuvWF15tT
         LnYGujt+V/7x+GycTqcxrf5pqKoMJHgq9FOEUMKmtuu+bSxDmV0nDUAZKteHX4mE/Npp
         7xVAt2GXxI85s/qQJhDBhROkiNaCBrahlHJ+7g7WJqEm9U1SiHbrexTKqKyTTZ87gnle
         SKsotpNt2J7qAj0azo21UxAc87onZH1Xi/H7vTqXKe3HM/kA5MVXFK1UfK59IXj5cF7G
         rR+A==
X-Received: by 10.66.27.13 with SMTP id p13mr33187790pag.76.1392734788227;
 Tue, 18 Feb 2014 06:46:28 -0800 (PST)
Received: by 10.70.48.228 with HTTP; Tue, 18 Feb 2014 06:46:28 -0800 (PST)
In-Reply-To: <OF23F26261.C9E4823A-ONC1257C82.0032DA0B-C1257C82.0040D57A@local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242327>

On Mon, Feb 17, 2014 at 11:48 AM,  <yann.dirson@bertin.fr> wrote:
> The recent "git-note -C changes commit type?" thread
> (http://thread.gmane.org/gmane.comp.version-control.git/241950) looks
> like a good occasion to discuss possible uses of non-blob notes.
>
> The use-case we're thinking about is the storage of testrun logs as
> notes (think: being able to justify that a given set of tests were
> successfully run on a given revision).

I think this is a good use of notes, and organizing the testrun logs
into a tree of files seems like a natural way to proceed.

> Here is a proof-of-concept patch (that applies to 1.8.4.2) I've been
> playing with.  Because of the -C behaviour described in this other
> thread, I opted for a new -o flag that would not mess with the object
> argument.  This patch is very minimalist, and just allows storing a
> tree note (currently any type of object, but that's easy to restrict
> if we want to), and retrieving it.

I think we must think _very_ carefully about which object types we
allow to be stored in notes trees.

As far as I can see, you use case (storing testrun logs) is covered
nicely by allowing tree objects as notes, and I think that's where we
should start. The note tree is itself a tree object, and storing
sub-trees of that is not new or unusual to Git at all. Reachability is
nicely covered by how Git already handles sub-trees. Obviously we must
flesh out how the notes-related parts of the code deal with trees (see
below), but that does not really affect the rest of Git, and should
therefore be relatively uncontroversial.

If we go on to _commit_ objects, they are currently only referenced
from tree objects as "gitlink"s (with a special "160000" mode). If you
were to put one of these in a notes tree, you would get the same
semantics as a "gitlink", i.e. git handles that part of the tree as a
submodule where a different submodule repo is (to be) checked out. The
commit is NOT considered/required to be reachable, and would therefore
not be automatically communicated by a fetch or push.

So if you want commits in a notes tree to be handled differently from
commits-as-gitlinks, you would have to tweak all the code in Git that
deal with gitlinks. You would have to introduce a differentiation
between your "commits-as-gitlinks" and "commits-as-notes", either by
reserving another special mode number, or by otherwise making the rest
of Git notes-aware. All of this comes in addition to teaching the
notes-related code how to deal with commits (i.e. how to display them,
etc.).

In other words, before you embark on this, you need a convincing
argument for why allowing commits-as-notes is really necessary and
worth it in the end. Please also consider that you _can_ support
commits-as-notes by the mechanism I suggested in the previous thread:
Store the commit SHA1 in a note-as-blob, and then amend the notes
commit to include the commit SHA1 as an additional parent. It's not
very elegant, but it solves the reachability problem.

If we go even further and want to allow ANY git object as a note, then
we must also consider tag objects, which AFAIK has never before been
stored inside a tree. Here we are really entering uncharted
territory...

So for now (and in lieu of a convincing use case for
notes-as-commits), I suggest you only look at notes-as-trees. The
first consequence of this is probably that your added -o/--object
option should be renamed. -t/--tree is not taken, AFAICS...

> Johan Herland wrote:
>> Obviously, it would not make sense to use refs/notes/history while
>> displaying the commit log ("git log --notes=history"), as the raw
>> commit object would be shown in the log.
>
> Currently, a non-blob commit is just not displayed at all.  And rather
> than displaying the raw object, we have a number of options available,
> starting with object's sha1, to more elaborate presentations depending
> on the type of object (commit info, tree hierarchy, etc, as "git notes
> show" already does).  This PoC shows that it can be dealt with later.

I'm only considering the notes-as-tree case here...

I assume that if you organize your notes in tree objects, then you
probably have more information in there than is useful to display in
the textual output from "git log". Also, you probably have
special-purpose scripts for initially generating those trees, and
later digging into the information stored therein. Hence we should
concentrate on getting the basics covered, to allow those scripts to
do their thing, and adding bells and whistles to "git log" for
displaying notes-as-trees is much less important. For now, "git log"
should probably show a short summary when encountering a
notes-as-tree. Whether that summary consists of merely the tree SHA1,
or in providing a (relatively short) tree listing, I leave up to you.
I also agree that this can be dealt with later (as long as the default
behaviour is not actively harmful/confusing).

> What I envision, would be viewers like gitk simply show the
> hyperlinked sha1, and (in the case of a tree note) open a tree view
> that allows to browse the contents of the note.

Agreed, although not important in v1.

> My (necessarily incomplete) list for what's missing:
> * more audit of impact (eg. seen "git fetch" complain about a non-blob
>   note on HEAD, have to check why; "git fetch" refuses to fetch a
>   non-blob note, pack-objects considering it is a corruption)
> * support in "notes append/merge", safeguards for commands
>   that won't know of to deal with non-blobs, tests

For trees, notes append/edit/merge sort of makes sense, in that is
should be possible to edit a notes-as-tree object, and merge it with a
different notes-as-tree object. Editing a notes-as-tree probably
involved checking out that tree into a temporary directory, and then
recording the new tree after the user have mucked about in there. This
is somewhat similar to how "git notes merge" works today, and these
operations probably will need to expand/reuse that code.

> * let --show-note display the sha1 (make that optional ?)

Displaying the SHA1 by default is good enough for v1. More options can
be added later.

> * extend gitk (and gitweb ?) as described above

Not important for v1. I guess most users of notes-as-trees will have
some domain-specific structure/convention imposed on their
notes-as-trees, which probably makes general notes-as-trees browsing
less useful, and domain-specific tools for processing the information
more or less required.

> * provide a <rev>^{note} / <rev>^{note:<noteref>} syntax for easy
>   access to notes contents

Yes. This is good, although somewhat orthogonal to the rest of this topic...


Hope this helps,

...Johan
