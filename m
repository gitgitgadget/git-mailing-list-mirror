From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] clean: add a flag to back up cleaned files
Date: Tue, 27 May 2014 14:48:57 -0400
Message-ID: <20140527184857.GA32097@sigill.intra.peff.net>
References: <1401200254-4592-1-git-send-email-kusmabite@gmail.com>
 <20140527163700.GB29693@sigill.intra.peff.net>
 <CABPQNSbo-cUHfu-uGZELntYJ6ymNUzOZjL3z2-OppK__fZ+KqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 20:49:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpMQq-0006N3-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 20:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbaE0StA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 14:49:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:60410 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752703AbaE0Ss7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 14:48:59 -0400
Received: (qmail 25817 invoked by uid 102); 27 May 2014 18:48:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 May 2014 13:48:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 May 2014 14:48:57 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSbo-cUHfu-uGZELntYJ6ymNUzOZjL3z2-OppK__fZ+KqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250187>

On Tue, May 27, 2014 at 08:12:52PM +0200, Erik Faye-Lund wrote:

> > I've definitely considered doing something like this before (and for
> > "git reset --hard"). My biggest concern would be poor performance in
> > some cases. But since it's optional, and one can presumably override it
> > with --no-backup for a specific large cleanup, it would not hurt anybody
> > who does not want to play with it.
> 
> I also made it opt[...]in rather than opt[...]out by default. Perhaps it
> shouldn't be, though - dunno.

I like starting with it optional, and then people who are interested in
the feature can experiment with it, giving it a chance to prove itself
(and for us to work out any downsides) before turning it on by default.

BTW, I think the opt phrases above might be caught by vger's taboo
filter. If your mail doesn't appear on the list, that is likely the
reason.

> > This bit of the code surprised me. I guess you are trying to re-create
> > the index state of the HEAD so that the commit you build on top of it
> > contains _only_ the untracked files as changes, and not whatever
> > intermediate index state you had.  That makes some sense to me, as clean
> > is never touching the index state.
> 
> TBH, I didn't really think this stuff through, I basically just hacked
> on this until I got it to save away superfluous files when the index
> matched HEAD. So this part is more accidental than designed. I'm not
> very familiar with the index-maniuplation code in Git either.
> 
> I *think* the right thing to do would be to save the tree of HEAD
> *plus* those deleted files in this case. That way it only records the
> destruction itself. This does *not* seem to be what currently happens.
> If I have a change staged, that staged change also gets included in
> the commit. That's not ideal, I think.

Ah. Yeah, if you are going to just record the current index state, I do
not see a reason to call unpack_trees at all. You can just add new
entries to the index, and then throw the resulting index away without
writing it back to disk.

But I do think it would make sense to reset it back to HEAD and build
straight on there, in which case you basically want to do "read-tree
HEAD". Or in C code, unpack-trees as a "oneway merge". I thought that's
what was going on here. ;)

All of this is moot if you go in the stash direction, as then you would
be storing something a bit more complicated (and delegating the
complexity to stash anyway).

> > If we were to do that, should it be a separate ref? Or should there be a
> > single backup ref for such "oops, undo that" operations? If the latter,
> > what should that ref look like? I think it would look something like
> > refs/stash, with the index and the working tree state stored as separate
> > commits (even though in the "clean" case, the index state is not likely
> > to be that interesting, it is cheap to store and makes the recovery
> > tools uniform to use).
> 
> Hmm, perhaps. I do like the concept of a "git undo" of sorts, but
> perhaps that'll raise the expectations even further? Or maybe raising
> them a good thing, so people add missing features? :)

Yeah, I think this would just be a first step on the way to "git undo".
It's the safety net for a few commands, but a true undo would need
somebody to build logic to see what the last command is, and then
reverse it (presumably using these safety nets). I don't think there's
any problem with building this first step and leaving the rest for
somebody to do later; it's a strict improvement.

> > And if we are going to store it like that, should we just be using "git
> > stash save --keep-index --include-untracked"? I think we would just need
> > to teach it a "--no-reset" option to leave the tracked files as-is.
> 
> Hm, interesting. But it does leave me with a bit of a bad feeling; git
> stash is currently a shell-script, and I want us to move *away* from
> depending on those rather than towards... Or perhaps I just convinced
> myself to port git-stash to C? I guess the full script won't be
> needed, only the heavy lifting...

Yeah, I wondered if you might say that, knowing how you Windows guys are
hesitant about shell scripts. :)

My feeling is that you should think about the best design, and implement
it that way. If stash as a shell script is a problem, then fix that on
the way. Of course it is very easy for me to tell you that, as I am not
the one volunteering to do the extra work. ;)

> >> +     if (!active_cache_tree)
> >> +             active_cache_tree = cache_tree();
> >> +
> >> +     if (!cache_tree_fully_valid(active_cache_tree)) {
> >> +             if (cache_tree_update(active_cache_tree,
> >> +                 (const struct cache_entry * const *)active_cache,
> >> +                 active_nr, 0) < 0)
> >> +                     die("failed to update cache");
> >> +     }
> >
> > I'd have thought you could use write_cache_as_tree, which backs "git
> > write-tree", but there is currently no way to convince it not to write
> > out the new cache. This is little enough code that it may not be worth
> > refactoring write_cache_as_tree to handle it.
> >
> I think not having to maintain multiple copies might make it worth
> factoring it out. Sure, it's not *that* complicated, but it *is*
> pretty well-contained.

Yeah, I was on the fence when I said that. I think it would depend on
what the refactor looks like.

> >> +     /* create a reflog, if there isn't one */
> >> +     git_snpath(logfile, sizeof(logfile), "logs/%s", ref);
> >> +     if (stat(logfile, &st)) {
> >> +             FILE *fp = fopen(logfile, "w");
> >> +             if (!fp)
> >> +                     warning(_("Can not do reflog for '%s'\n"), ref);
> >> +             else
> >> +                     fclose(fp);
> >> +     }
> >
> > Kind of gross that we have to do this ourselves (and somewhat contrary
> > to efforts elsewhere to make the ref code more abstract), but I see that
> > "git stash" does the same thing.
> 
> Hmm, it seems like log_ref_setup might be able to do the work for us,
> if it wold take a flag to force O_CREAT. Perhaps that's worth the
> effort?

log_ref_setup gets called internally by update_ref.  I guess you'd have
to teach update_ref a new flag for "always create reflog", which would
not be too bad. I suspect that would also make the "new_branch_log" code
in checkout.c cleaner, too.

Alternatively, the logic for "should we create a reflog" is in
log_ref_setup. It knows about core.logAllRefUpdates, and does some magic
for various prefixes and HEAD. That logic could be taught about
"refs/stash" and any other similar refs we add.

-Peff
