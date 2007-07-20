From: David Kastrup <dak@gnu.org>
Subject: Re: Empty directories...
Date: Fri, 20 Jul 2007 12:54:45 +0200
Message-ID: <86tzrzuyyy.fsf@lola.quinscape.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<200707201029.10358.johan@herland.net>
	<86hcnzxy9a.fsf@lola.quinscape.zz>
	<200707201220.15114.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 12:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBq8b-000645-80
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 12:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbXGTKzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 06:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbXGTKzF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 06:55:05 -0400
Received: from main.gmane.org ([80.91.229.2]:51722 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbXGTKzB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 06:55:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBq8N-0004fo-G8
	for git@vger.kernel.org; Fri, 20 Jul 2007 12:54:55 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 12:54:55 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 12:54:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:QYiFQxc5hYq8Dgy2cgCaJisGTDw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53082>

Johan Herland <johan@herland.net> writes:

> On Friday 20 July 2007, David Kastrup wrote:
>> Johan Herland <johan@herland.net> writes:
>> > Sorry for jumping in late...
>> 
>> It could have given you a chance to read up on what has already been
>> discussed.
>
> I have tried to keep on top of the discussion so far.
>
>> > Why do you want to add _all_ directories, and not just the ones we
>> > want to explicitly track (independent of whether they're empty or
>> > not).
>> 
>> Because the problematic cases are more often than not the
>> _implicit_ cases.  Do you check a directory tree for empty
>> directories before you archive it?  In order to archive every empty
>> directory explicitly?
>
> No, of course I don't. But then archiving (as in tar) is intended to
> recreate the "working copy" exactly as it was. Git (and other SCMs),
> however, is only interested in recreating the part of the working
> copy it explicitly tracks.

Yes, and
git-add some-dir
tells it to track _everything_ inside some-dir.  Which means that the
included files are tracked _implicitly_.  The included directories
(including some-dir itself) are not.

> Given the following working copy:
> /
> /tracked/
> /tracked/file
> /tracked/dir/
> /untracked/
> /untracked/file
> /untracked/dir/
>
> and the following commands:
> $ git add tracked
>
> $ git clone
>
> The cloned result could be any of the following:
>
> (1)
> /
> /tracked/
> /tracked/file
>
> This is the current behaviour; directories are not tracked at all, but only 
> added as necessary to support files.

And so your case (1) actually rather is a single line:

/tracked/file

Everything else is just part of representing /tracked/file and
disappears as soon as /tracked/file disappears.

> (2)
> /
> /tracked/
> /tracked/file
> /tracked/dir/
> /untracked/
> /untracked/dir/
>
> i.e. implicitly tracking _all_ directories. This is what you literally ask 
> for,

I don't see how you can possibly conclude that from what I have been
writing.

> but I think most would find this unreasonable.

And it is.  So please _don't_ put words into my mouth.  In my
proposal, the following (and nothing else) would get tracked:

/tracked/.
/tracked/file

and that's it.  That is what was requested, and that is what is
tracked.  There will be, incidentally, a tree "/tracked/" and a tree
"/" in the _repository_, but those collapse as soon as they are empty.
They are just an _abstract_ data structuring tool in the repository
that is _mapped_ to directories on checkout.

> /
> /tracked/
> /tracked/file
> /tracked/dir/
>
> i.e. recursively tracking directories (and files). This seems useful, but 
> there is nothing _implicit_ about this.

You did not ask for "/tracked/file" and you did not ask for
"/tracked/dir/" (whatever they may be).  That you wanted to track them
was _implied_ by your request of "/tracked/".

> I have a feeling that you're actually arguing for doing (3) by
> default.  What I am arguing is to do (1) by default, and (3) if
> given a suitable command-line option (i.e. "git add --with-dirs
> tracked").
>
> Note that this is really an interface question.

Not at all.  It is a _conceptual_ question: in order for this to work
at _all_ (instead of being an inconsistent heap of ugly surprises),
directories need a representation in the repo.  This representation,
as opposed to in the work file system, is _optional_: the repository
got perfectly well along without it up to now, and the fallback is
already implemented when there is a tree without corresponding
directory.

> How these entries are actually stored in the repo is a different
> discussion.

Sure.  But anything that requires four dozens of special cases instead
of four because one wanted to keep "things that are under some
specialized view separate separate" is not something I am going to
implement.  I am too old to juggle with complexity for the sake of
complexity.  I can make much more use of the existing infrastructure
by actually making file and directory entries quite similar.

ls -la
also has no special cases for "." and ".." because they are, at a very
fundamental level, very special in achieving a special purpose
_without_ being special-cased.

> Finally, let's look at the case of "git add tracked/file" followed
> by "git rm tracked/file". I'm arguing that "tracked/" should be
> automatically removed, since I never asked for it to be tracked by
> git.

Sure.  And nobody ever said otherwise.  In fact, I gave about a dozen
examples in that line and more special in the thread up to now.

> On the other hand, "git-add --non-recursive tracked" followed by the
> above two commands, should of course leave "tracked/" in place,
> since I now actually asked explicitly for the directory to be
> tracked.

Sure.  Use "--directory" instead of "--non-recursive" and you have a
somewhat more special option for that.

> My point is fundamentally that selectively tracking directories is a
> more powerful concept than just tracking _all_ directories by
> default.

Perhaps you might read up on some of the past discussion before
beating dead horses.  This has been covered already, and more than
once.  I never asked for "all directories" to be tracked.  I outlined
cases where they are tracked and where not, and I tested that the
mechanisms in "man gitignore" already work _perfectly_ with the
pattern "." for configuring the _implied_ tracking at directory,
repository, project, and user preference level.

> Note that if we support selectively tracking directories, tracking
> _everything_ (like you seem to want) is trivially implemented by
> _always_ supplying the appropriate option to git-add. If we track
> everything by design, we don't have the option of selectively
> tracking some directories.

But that means manual intervention all of the time.  It is fine when a
tool provides an option to shoot you in the arm instead of in the foot
as usual, but that's not really a fix, but an acerbation of the
problem.

>> > Basically, add a "--dir" flag to git-add, git-rm and friends, to
>> > tell them you're acting on the directory itself (rather than its
>> > (recursive) contents). "git-add --dir foo" will add the "040000
>> > 123abc... 0 foo" to the index/tree whether or not foo is an empty
>> > directory. "git-rm --dir foo" will remove that entry (or fail if
>> > it doesn't exist), but _not_ the contents of foo.
>> 
>> There is nothing wrong with implementing something like this in
>> _addition_ to treating directory entries implicitly.
>
> I don't agree. By _selectively_ tracking directories you can
> implement any policy you want on top of it.

No, you can't.  Because a "policy" means that things are _implied_.
Being able to do everything manually is not a policy.  It may be a
lifesaver at times, but then you have little business drifting in the
river in the first place.

>> But the important, the _really_ important thing are the implicit
>> behaviors.  If I have to hassle with every directory myself, I
>> don't need a content tracking system.
>
> I disagree. Just as you have to decide which files to track, you
>similarly should have to decide which directories to track. Of
>course, the tools make this easier for you by being able to
>recursively handle files. In the same way they should be able to do
>the same thing for directories.

--directory _explicitly_ is not working recursively, so it does not
solve that problem.

-- 
David Kastrup
