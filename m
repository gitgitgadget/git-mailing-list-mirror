From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Tue, 1 Mar 2011 16:59:07 -0500
Message-ID: <20110301215907.GA23945@sigill.intra.peff.net>
References: <20110225133056.GA1026@sigill.intra.peff.net>
 <201102251658.22678.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 22:59:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuXax-00030H-Sc
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 22:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765Ab1CAV66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 16:58:58 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50470 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574Ab1CAV65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 16:58:57 -0500
Received: (qmail 10823 invoked by uid 111); 1 Mar 2011 21:58:56 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 21:58:56 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 16:59:07 -0500
Content-Disposition: inline
In-Reply-To: <201102251658.22678.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168261>

On Fri, Feb 25, 2011 at 04:58:22PM +0100, Johan Herland wrote:

> > I'm curious what people think. Do others find this useful? Does it
> > seem harmful?
> 
> I _really_ like the idea. :)

Thanks. Everybody seems to like it, so I'm going to polish it up and
submit a nicer version.

> Maybe we should use a slightly more verbose separator (i.e. more 
> unlikely to trigger false positives). As you say, we already have to 
> watch out for "---" because of "am", but that only applies to projects 
> that _use_ "am" (i.e. mailing-list-centric projects like git.git and 
> the Linux kernel). Other projects (e.g. github-centric projects or most 
> centralized "$dayjob-style" projects) seldom or never use "am" at all, 
> so I wouldn't expect those developers think of "---" as "special" in 
> any way.
> 
> What about using something like "--- Notes ---" instead?

Yeah, it is true that many git users will never care about the
patch-through-mail workflow. And I think these days that is OK, because
rebase will take care to keep their commit message intact even if it
doesn't format well in a "format-patch | am" pipeline.

I really wanted to keep it short and natural, though. Because eventually
I'd like to have this on all the time via a config option, and I don't
want to see "--- Notes ---" in every commit that doesn't have notes. But
I _do_ want to be able to quickly say "oh, let me make a note on this"
and just add a quick separator.

It wouldn't be a regression if people had to opt into the feature using
the command-line or config option. So in theory they could learn about
"---" then, unless we turn it on by default (but why would we? A user
has to know about this feature to use it, so they can easily turn on the
option).

Or maybe the divider should be configurable and default to something
long. But clueful people can set it to "---". That kind of seems like
overkill, though.

> What if you combine --notes with --verbose (i.e. including the 
> diff-to-be-committed in the commit message template)?
> 
> AFAICS, stripspace() doesn't know how to remove the diff (there's a 
> separate section in cmd_commit() discarding everything 
> following "\ndiff --git ").

Ugh. Yeah, I looked at that in an earlier iteration but then forgot
about it in the final. We will end up with "-v" crap in the notes. I'll
fix that in the next revision.

I also think it will be worth making a nice test script of all of these
different cases.

> > How should this interact with the commit-msg hook? In my
> > implementation, it sees the whole thing, message and notes. Should we
> > be picking apart the two bits after the editor and rewriting the
> > COMMIT_EDITMSG before the hook sees it?
> 
> I'm not sure about this, but I suspect we should follow the same 
> behaviour as --verbose (i.e. does the commit-msg hook see the entire 
> diff inline in the commit message?).
> 
> A short look at builtin/commit.c indicates that we should leave 
> everything in there for the commit-msg hook (AFAICS, the commit-msg 
> hook is invoked from prepare_to_commit(), which is invoked from 
> cmd_commit() _before_ the verbose diff part is removed.)

Yeah, I think the commit-msg hook sees everything. Which is arguably not
the most convenient behavior, but it is the most flexible. Sort of. The
hook doesn't actually know whether "-v" was supplied, so it has to guess
at what is "-v" junk and what is not. I wonder if anyone actually uses
"-v" these days. It seems like "git add -p" would have superseded it in
most workflows.

> > How should this interact with the post-rewrite hook? I obviously need
> > to set that up for my workflow, too, but I haven't yet. This patch
> > does nothing, but I'm pretty sure it should turn of "git commit
> > --amend" calling the rewrite hook if we are using --notes (since the
> > user has already seen and edited the notes, and we've written them
> > out).
> 
> I don't see what this has to do with the post-rewrite hook. Currently, 
> the post-rewrite documentation ("git help hooks") states that it is run 
> _after_ the automatic notes copying. AFAICS, your --notes simply 
> replaces the usual automatic notes copying with a 
> semi-automatic "edit-and-copy" instead. But this all happens before the 
> port-rewrite hook is called, and thus shouldn't affect it.

I think this was just me showing my cluelessness about how the notes
rewriting code worked. I was thinking you needed to have a post-rewrite
hook to make it work at all, but it looks like it does the rewrite and
then lets you tweak it. So my code doesn't turn off the existing copy,
but it probably should. Should the post-rewrite hook run after this? I'm
not really sure what people use post-rewrite hooks for, to be honest.

> > @@ -730,6 +780,9 @@ static int prepare_to_commit(const char
> > *index_file, const char *prefix, strbuf_release(&sob);
> >  	}
> >
> > +	if (edit_notes && amend)
> > +		add_notes_from_commit(&sb, "HEAD");
> 
> I haven't read the sources closely enough to figure out when/where the 
> commit diff is added to the commit message (in case of --verbose), but 
> I trust that it happens _after_ the above lines (so that the notes part 
> doesn't end up after the diff)

I think so, but I'll double check. I agree that it's important for it to
go right after the commit message (and before the "#" comment lines, I
think).

> Otherwise, this looks good to me from a precursory review.

Thanks. I'll work on some tests for the --cleanup and -v cases so we can
be sure that it's behaving as we want, and then hopefully submit a nicer
version.

-Peff
