From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Tue, 7 Feb 2012 12:30:25 -0500
Message-ID: <20120207173025.GA22225@sigill.intra.peff.net>
References: <20120206062713.GA9699@sigill.intra.peff.net>
 <CAJDDKr6A2UvB3D-Dapw7WCEzWfzLoLd0E8MSDjT0RtdxFeWZAQ@mail.gmail.com>
 <20120207051719.GA11598@sigill.intra.peff.net>
 <CAJDDKr5yiKvNnpVV29jFK1Z1yuUnA-=dn0yMB8iW9y53vRGDHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 18:30:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuosC-0002GZ-Ii
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 18:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab2BGRa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 12:30:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59321
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755748Ab2BGRa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 12:30:27 -0500
Received: (qmail 9090 invoked by uid 107); 7 Feb 2012 17:37:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 12:37:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 12:30:25 -0500
Content-Disposition: inline
In-Reply-To: <CAJDDKr5yiKvNnpVV29jFK1Z1yuUnA-=dn0yMB8iW9y53vRGDHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190187>

On Tue, Feb 07, 2012 at 02:05:34AM -0800, David Aguilar wrote:

> I won't claim it's the best solution, but this has worked extremely
> well in practice:
> 
> https://github.com/git-cola/git-cola/blob/master/cola/gitcfg.py
> 
> Here's the problem.  I need to know which config items are "user"
> config (~/.gitconfig), which are "repo" config (.git/config), and
> which are "system" config (/etc/gitconfig).

I'm not a git cola user. But from peeking at that code and a brief
"apt-get install git-cola && git cola", it looks like the point is to
show a dialog with per-repo and per-user settings, let the user tweak
them, and save them back to the appropriate spot.

But how does that interact with includes? Let's imagine I do this:

  git config --global include.path .gitidentity
  git config -f ~/.gitidentity user.name "Jeff King"

Without having git-cola expand includes, your call to "git config
--global --list" will not show the user.name variable, and it will
appear blank. Which is not great.

If git-cola does expand includes, then the name will appear. But what
will happen when I modify that field and try to save it? It will save it
using "git config --global", putting it into ~/.gitconfig. So now you'll
have two names in your config, one in .gitconfig and one in
.gitidentity.

And which one will take precedence?  That depends on what was in your
config file before. If there was a [user] section before the include
already in your .gitconfig, then the newly written value will go in that
section _before_ the include, and the include will still take
precedence. Otherwise, a new section will be written _after_ the
include, and that will take precedence.

So...yuck. It's kind of a complex and messy situation. But the important
thing is that when you are looking at a bidirectional editing situation
like this, blindly expanding includes is not going to solve the problem.
It's just going to paper over the complexity. In the long term,
something like git-cola that is trying to present and edit config to the
user would need to learn about includes, track the sources of each
variable, and then edit appropriately.

You can do that with my current patch by manually following include.path
directives. However, that's a pain.  Git-config could potentially help
with that (and even simplify the current code) by allowing something
like:

  $ git config --list-with-sources
  /home/peff/.gitconfig user.name=Jeff King
  /home/peff/.gitconfig user.email=peff@peff.net
  .git/config core.repositoryformatversion=0
  .git/config core.bare=false
  [etc]

(you would use the "-z" form, of course, and the filenames would be
NUL-separated, but I made up a human-readable output format above for
illustration purposes).

And then it would be natural to mention included files there, and you
could actually modify the file that contains the value in question. Of
course, you might not have _access_ to the file in question. You could
be pulling in options from a shared config file, and the right thing to
do is not to edit the shared file, but to override it. And that raises
the question of where, and how to tell git-config to make sure that the
option goes _after_ the include.

So fundamentally, includes make the idea of "overwrite this value" much
more complex. It's possible that git-config should learn all of this
complexity, and that git cola could rely on git-config being smart.  But
I was rather hoping that most of the automated tools could remain simple
and stupid, and that people who wanted to do complex things with
includes would be left to their own devices (i.e., using $EDITOR, or
smartly using "git config -f" on their individual files).

> Figuring out the repo config is tricky.  You can't just say "git
> config --list" because that includes the user config stuff in
> ~/.gitconfig.
> 
> Figuring out the user config is easy because you can say "git config
> --global --list".  This is inconsistent with the behavior for "git
> config --list" because it does not include the --system config, which
> one would expect given the overlay semantics.

I think you are mistaking a lack of source options for "look at the repo
config". But without providing a source, the request is "look everywhere
that git knows about". With "--global", it's about "look at this one
file" (just as "--system" is about "look at this other file"). So I
think what you are really lamenting is the lack of "git config --repo",
which would basically be:

  git config --list --file="$(git rev-parse --git-dir)/config"

That might be something we could improve in the documentation.

> The generic interface for getting a concise listing of values from
> these sources is to use "git config -f" on ~/.gitconfig, .git/config,
> and $(prefix)/etc/gitconfig.

Right. And --global and --system are basically just synonyms for the
prior two.

> git config --global and git config --system are both consistent in
> that they return just the information relevant to them.  Is --global
> just a shortcut for "-f ~/.gitconfig"?  If yes, then does that mean
> "git config --global" will not honor includes?  If it is not a
> shortcut, does that mean that "git config --global" and "git config -f
> ~/.gitconfig" are not really the same thing?  The documentation does
> lead one to believe that they should be equivalent...

Yes, it is a shortcut, and it follows the same code path (i.e., we
expand "--global" into "-f ~/.gitconfig" early on).

> > Yes, that's a general problem of adding new command-line options to turn
> > features off or on. We could add an environment variable to control this
> > feature. But I'd really like to hear the compelling use case first
> > (i.e., both why it cannot simply be spelled "git config -z --list", and
> > why not following includes is not OK).
> 
> Hopefully my explanation conveys why "git config -z --list" is insufficient.

Yes, I agree it's insufficient in the face of includes. Unfortunately, I
don't think simply expanding includes by default is sufficient, either.

Probably the simplest solution for this case would be something like:

  1. Always expand includes on listing.

  2. When editing, always override items in includes. So do _not_ reuse
     sections, but always put the values at the end of the file (or at
     least after any includes).

That's not as nice as doing it "right" (you'll end up with duplicated
values in included files and their parents, and sections may appear
multiple times). But it's simple and should have the desired semantics.

> From a naive user's POV --
> I am asking "git config" to evaluate this file.  I don't care what's
> inside of it; it's a black box to me.  All I know is that I get config
> values out the other side.  Sometimes git respects the included files.
> Sometimes it does not (when using -f).
> ^^^^^^^^^
> I think this subtle difference in behavior is best avoided.

It is not "sometimes when I ask git config to evaluate this file". It is
"git never expands includes when you ask it to evaluate a file".
Includes are expanded only when you ask git "search all files you know
about" (i.e., when you do not provide a file argument).

There is also a more complex issue with "-f", which is that git-config
is used not just to parse git configuration, but also to parse other
config-like files that should not respect includes (e.g.,
".gitmodules"). So to remain backwards-compatible, we need the default
for "-f" to not respect includes, and that is not really negotiable.

We could convert "--global" and "--system" to respect includes by
default (since we at least know these are actual git config files). But
that is introducing a subtle difference, which you complained about
above.

But if scripted uses like "git cola" are the ones that need it, I'd
rather provide a backwards-compatible way of tweaking the behavior (if a
command line option is not sufficient, then I'd rather provide an
environment variable).

> Here's another.  The naive user will do: `git config --list -f file`.
> They will then edit that file to add an include statement.  They will
> then run `git config --list -f file` again and be confused as to why
> their included configuration is not honored.

As I mentioned above, that one is not really negotiable. But it seems
like it is a mismatch of expectations to behavior, and that is something
we can at least address with documentation.

> Right now these two are synonymous: "git config --system --list" and
> "git config -f $(prefix)/etc/gitconfig --list".  Having one form honor
> includes and not the other is inconsistent.

With my patch, they are consistent, and neither should honor includes
(that being said, there is a bug in my patch which makes --list honor
includes in all cases; however, you are responding correctly to the
intended and advertised behavior of my patch, and that is what we should
be discussing).

> What if we frame this the other way around -- when would we not want
> it to follow includes?  I can imagine someone writing a "git config"
> editing program, but I think that use case is rare (and they haven't
> spoken up, either ;-).

But isn't "git cola" a git-config editing program?

> Well.. okay. My use case is rare too!  The dumb "cache the values
> behind a stat() call" thing has worked really well in practice so I've
> been happy with it so far.  It's dumb, and it won't notice when
> included files change, but I really don't care because it solves the
> 99% case.

I don't get the caching. How often would you need to call "git config"?
Isn't is only when the edit-config dialog appears? Is it really that
expensive to call when opening a user-editable dialog?

> Rewriting it (for me) would mean using --global and --system and
> probably not caring so much about the distinction of repo vs. user
> configuration (or rather, deal with the fact that `git config --list`
> returns both the user config and the repo config). At that point I
> might as well just write (reuse) a proper .gitconfig parser, but
> what's the fun in that when "git config" is so nice and easy to parse?

I definitely feel your pain. I don't want you to have to rewrite yet
another .gitconfig parser. Let's see if we can figure out reasonable
editing semantics that can go into git-config.

-Peff
