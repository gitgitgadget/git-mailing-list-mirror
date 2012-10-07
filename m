From: Jeff King <peff@peff.net>
Subject: Re: Bug report
Date: Sun, 7 Oct 2012 19:52:44 -0400
Message-ID: <20121007235244.GA5536@sigill.intra.peff.net>
References: <506D122E.2050404@emsoftware.com>
 <CABURp0rhHTSqQFiXEb12iKLAAjMW3+Jn-ubMy-9jNWc5068toA@mail.gmail.com>
 <506DB500.4010803@emsoftware.com>
 <20121006133146.GD11712@sigill.intra.peff.net>
 <5070E7BF.8040102@emsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: John Whitney <jjw@emsoftware.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:53:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL0eY-0003RD-Ni
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 01:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab2JGXwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 19:52:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44120 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab2JGXwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 19:52:47 -0400
Received: (qmail 19970 invoked by uid 107); 7 Oct 2012 23:53:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Oct 2012 19:53:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2012 19:52:44 -0400
Content-Disposition: inline
In-Reply-To: <5070E7BF.8040102@emsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207218>

On Sat, Oct 06, 2012 at 09:23:59PM -0500, John Whitney wrote:

> >You said in your test script:
> >
> >   # Committing test.txt or clearing .gitattributes does clear
> >   # the "modified" status, but those options are undesirable
> >
> >Why is the commit undesirable? You have decided that CRs will no longer
> >be tolerated in your repository (by setting .gitattributes). Now you
> >need to record that change in history with a commit that strips out the
> >CRs.
> In some cases it's undesirable. In my example, all I want to do is
> merge in the change that deletes the file, so I don't want to have to
> add that extra commit when I'm just going to delete the file anyway.

Yes, but that is conflating two operations. You only don't want to do
the commit because you are anticipating what is coming next (the
cherry-picked deletion). But if you want to conflate, then you could
also realize that you can simply delete the file, CRs or no, and you do
not need to care about its modified state.

I think a much stronger argument for your position is that the cherry
pick would not happen without a conflict after such a commit, because it
would be deleting files with two different sets of content (the
cherry-pick would want to delete the CR version, but you would not have
that version).

In other words, you want the cherry-pick to happen and ignore the
modification that could be committed, because you know the modification
is not relevant (but git does not). But there is not a way to do that
(even once you overcome the confusion), because the usual way to do so
is to drop the local modification with "git reset" (which would not work
in this case).

> >It is not about having CRs in the working tree file. Those are now
> >considered uninteresting and stripped by git when comparing to the HEAD.
> >The problem is that what's in your _repository_ has CRs.
> Yes, but does that really have to be an issue? Is there any technical
> or practical reason you can think of that the repository shouldn't
> ignore those CRs?

It's significantly less efficient. Right now git only has to do the
conversion when updating the index cache of what's on the filesystem
(i.e., when it would be doing a sha1 over the file contents _anyway_).
And then it can compare sha1s internally, because it knows that all of
the sha1s it has computed are for the canonical in-repo versions of the
file.

If we assume that the in-repo file might need to have CRs stripped, then
we need to actually follow up every sha1 mismatch with an actual content
diff in order to discover if it really is different or not. We could
cache the "true" sha1 of the canonical stripped version to avoid this,
but now we are getting much more complex. In most cases it is sufficient
to just commit the cleaned up contents and then never worry about it
again.

> You're right, we can't magically avoid all the line ending issues
> that people will run into. In this case, though, I think git can
> sidestep a fairly obnoxious problem. My example was simple, but when
> you've got multiple branches that need to be rebased/merged, it can
> get pretty hairy. The repository will never be truly "clean" unless
> you rewrite the whole thing (using filter-branch, for instance).

Right. Git's current approach is very hairy when you are looking at
history that crosses a CRLF flag-day boundary. It's definitely a
weakness of the canonicalization approach. But other approaches also
have downsides; I don't want to catalogue them all here, but you can
certainly search the archive for various discussions and flamewars about
how line endings are handled.

> Maybe my above suggestion is more of a feature request than a bug,

Fair enough. I think your complaint is real, but I think nobody has been
clever enough yet to devise a solution that does not have too many other
downsides. And of course you are free to propose such an approach if you
have thought of one. :)

> but there is the obvious bug that after changing .gitattributes, git
> still doesn't notice that files are "modified" until you modify them
> again in some way (touch works). I only noticed the CRs in our own
> repository after I tried to rebase a branch and got strange errors.
> To make git notice all the files, I had to "find . -type f -exec
> touch {} \;".

I think the idea has been floated before of unconditionally refreshing
the index when you update the crlf config via "git config". But of
course that can only fix a fraction of the cases. You might edit it with
an editor. Or they may be new lines in .gitattributes. Or a change of
wildcard lines in .gitattributes.

Really, the issue is that the index contains a cache of what's in the
files that is considered valid unless the stat information of the file
changes. But that is obviously not the full story, as the
canonicalization rules (CRLF handling or smudge/clean filters) can
change, too, and that is not considered as part of the cache's validity.
Doing it "right" would mean that anytime the attributes or config files
changed, we would consider the cache entry dirty and re-read (and
re-canonicalize) the file.

But that has either:

  1. Bad complexity. It means our cache validity needs to know about
     exactly which rules were applied to yield the cached sha1. And
     those rules can be complex, consisting of wildcard matching,
     cross-referencing custom filters from config, etc.

  2. Bad performance. If you instead just invalidate cached sha1s when
     the gitattributes or .git/config file changes, you catch way too
     many cases. E.g., if you checkout a branch that changes
     .gitattributes, we have to re-read every file in the repository,
     even though most of them will not be affected.

So I think it's possible to handle this case correctly, but doing it
right is quite complex. So we have the "just manually poke the files
when you make such a change". Which is a horrible user experience, but
works OK in practice (and many people do not run into it at all, because
on new projects they set the filter attributes very early on, before
they have an existing history).

IOW, no, it is not pretty, but these are all known issues that nobody
has felt it worth tackling yet.

-Peff
