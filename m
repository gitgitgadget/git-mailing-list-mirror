From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Fri, 6 Feb 2009 11:19:54 -0500
Message-ID: <20090206161954.GA18956@coredump.intra.peff.net>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Fri Feb 06 17:21:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVTSH-0001YG-92
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbZBFQT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbZBFQT5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:19:57 -0500
Received: from peff.net ([208.65.91.99]:36174 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbZBFQT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 11:19:56 -0500
Received: (qmail 23240 invoked by uid 107); 6 Feb 2009 16:20:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 11:20:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 11:19:54 -0500
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108758>

On Tue, Feb 03, 2009 at 09:55:08AM -0800, Keith Cascio wrote:

> First of all, thanks for the tips!

Of course. Thank you for spending time to refine your patch.

> > > +diff.primer::
> > > +	Whitespace-separated list of options to pass to 'git-diff'
> > > +	on every invocation, including internal invocations from
> > > +	linkgit:git-gui[1] and linkgit:gitk[1],
> > > +	e.g. `"--patience --color --ignore-space-at-eol --exit-code"`.
> > > +	See linkgit:git-diff[1]. You can suppress these at run time with
> > > +	option `--no-primer`.  Supports a subset of
> > > +	'git-diff'\'s many options, at least:
> > > +	`-b --binary --color --color-words --cumulative --dirstat-by-file
> > > +--exit-code --ext-diff --find-copies-harder --follow --full-index
> > > +--ignore-all-space --ignore-space-at-eol --ignore-space-change
> > > +--ignore-submodules --no-color --no-ext-diff --no-textconv --patience -q
> > > +--quiet -R -r --relative -t --text --textconv -w`
> > 
> > Funny indentation?
> 
> The last part is a backtick-quoted list, I think it either must occur on one 
> line or as is.

Ah, yes, I see. I wonder if that is a sign that we can use some kind of
list construct instead. I also wonder if we need the exact list. It
seems like a poor user interface to have to enumerate each option. As a
user, should I be saying "I would like to put --foobar into my primer
variable. Let me check whether it is supported"? Or should there be some
sane and succint rule by which to say "I know whether --foobar is
supported or not, because it falls into categroy X"?

I think the latter is much nicer to users. And then the help text
describes that rule (and I think the rule should be "everything that
tweaks what diffs _look_ like is included" or something like that).

But more on that:

> > This seems really clunky to list all of the options here. I thought
> > the point was to respect _all_ of them, but do it from porcelain so
> > that it is up to the user what they want to put in.
> > 
> > How was this list chosen?
> 
> The current version does not try to support all diff options.  It only
> supports those that are recorded in struct diff_options.flags and
> .xdl_opts - that is the present list.

That is a very unsatisfying list, as it bears no relation to what users
actually want to put in diff.primer, or what even makes sense there. For
example:

  - "-u" is not supported, but that is something I would expect people
    to want to use (in fact, it is the _only_ thing supported by
    GIT_DIFF_OPTS)

  - "--follow" is supported, but it makes no sense to say "my diffs
    should always use --follow" (and yes, this is a result of it
    confusingly being part of diff opts, when it is really about
    revision processing).

  - "--exit-code" and "--quiet" are supported, but why would you want to
    have them on all the time as defaults?

  - "--relative" is supported, but "--relative=" is not.

So I think the behavior is quite confusing for potential users. I don't
mind as much that some options don't make sense (like --exit-code and
--follow), because people who put them in diff.primer get what they
deserve. But not supporting some options that people do want to use is
going to look like a bug.

> > This doesn't appear to have any quoting mechanism. Is it impossible
> > to have an option with spaces (e.g., --relative='foo bar')? I guess
> > that is probably uncommon, but I would expect normal shell quoting
> > rules to apply.
> 
> The current version only supports the flags listed above in
> Documentation/config.txt.

Right, but you can see that I think that should change. :) I think there
are some quote-parsing routines that we use for config and for aliases
that may work for re-use, but I haven't checked.

> >   /*
> >    * Our desired flags are:
> >    *
> >    *   1. Anything the master hasn't explicitly set, we can take from
> >    *      the slave.
> >    *   2. Anything the slave didn't explicitly, we can take whether or
> >    *      not the master set it explicitly.
> >    *   3. Anything the master explicitly set, we take.
> >    */
> >   master->flags =
> >      /* (1) */ (~master->flags & slave->flags & slave->mask) |
> >      /* (2) */ (master->flags & ~slave->mask) |
> >      /* (3) */ (master->flags & master->mask);
> 
> Your version is much better.

Except I think in (1) it should be "~master->mask". Oops. :)

> The point of --primer was for scripts like gitk and git-gui.  I

Right, I am calling into question whether we want "--primer" at all.
That is, if you think of it as just "prepend these command line options"
we can get the same thing with something like:

  git diff-tree `git config diff.primer` $other_options

if the caller wants to be totally promiscuous, and

  git diff-tree `git config diff.primer | filter_options` $other_options

if it wants to be paranoid (and obviously in tcl the code would be
different, but I think you can see the point).

> wouldn't say "respect --primer" so much as "pass --primer" (which
> causes diff-tree to respect diff.primer, which it normally wouldn't).
> Reviewing the options that diff.primer currently supports, except for
> --color which I specifically guarded against, I don't see a scenario
> that would break gitk as is.

Well, "--quiet" and "--exit-code" certainly would produce confusing
results. Though I can't imagine anyone putting those into their
diff.primer variable.

> I think we could call that simple scheme the linear walk, and it was
> my first impulse as well.  We walk through all the places where diff
> options live, in order from lowest precedence to highest precedence,
> accumulating/overriding options as we go along.  When we're done, we
> know the user's intention.
> 
> But as you say, we need that extra pass.  Once I noticed we need that
> extra pass, the software engineer in me saw the concept of linear walk
> as too weak for this feature.  These options occur in precedence
> layers and we need to combine those layers the right way.  The right
> way means: honor the intuitive semantics the user expects.  Hence the
> function name flatten_diff_options().

Hrm. Do we really need the multiple passes, though? Let's assume for a
minute that we don't want "--primer". The rule is: "if you are a
porcelain, you respect diff.primer; if you're not, you don't". And
because diff.primer is, by definition, a set of command line options, it
is trivial for a caller who wants to selectively apply them to a
plumbing to do so. Similarly, if somebody really wants to call a
porcelain and _disable_ options, I don't think "--no-primer" is
necessarily the right interface. Instead, the actual command line
options given override what's in diff.primer, so you can selectively
disable whatever you like.

And of course all of this extends naturally to a "primer.*" set of
config, rather than just "diff.primer".

> A multi-pass walk is one possible implementation of such semantics,
> but in my opinion not the best.  My implementation is much more
> explicit, meaningful, and declarative.  It's not at all hard to
> understand looking at the code.  In fact, it positively declares

I do think declarative interfaces can be nice, but I really have two
complaints with your approach:

  1. It is somewhat fragile, because it is easy to bypass the
     declarative nature in C. That is, there is an ordering constraint
     with the flattening that we may not be fulfilling everywhere in
     git. For example, let's say some code checks option A and then does
     something with option B as a result. If this code runs before the
     flattening, then it may fail to correctly pick up option A, since
     it is in the slave spot. But if it runs after, the flattening may
     logic may miss the option setting.

     I think the "after" case above is not a problem in practice,
     because we are only flattening two cases, and post-flattening we
     always just operate directly on the master case. So I think we
     really want to flatten at the last minute. So rather than
     flattening everything and storing it, I think a nicer approach is
     to put it in the accessor:

       /* If master set it, take that. If not, and slave set it,
          take that. If nobody set it, take the master as default. */
       #define DIFF_OPT_TST(opts, flag) \
         ((opts)->master_mask & DIFF_OPT_##flag ?  \
           (opts)->master_flag & DIFF_OPT_##flag : \
           (opts)->slave_mask & DIFF_OPT_##flag ? \
             (opts)->slave_flag & DIFF_OPT_##flag : \
             (opts)->master_flag & DIFF_OPT_##flag;

  2. The current flattening code deals only with the flags field, which
     is fairly easy to handle using a mask and some macros. But what
     about fields that have a more complex implementation? I think the
     amount of work to do flattening is going to be linear with the
     number of options. Which means that now there is new work to be
     done every time a new non-flag option is added, and a chance for
     the developer to forget to do that work. Which hurts
     maintainability in the long run.

So yes, I think a declarative solution can be nice, but there is really
very little language support in C for doing it in a safe way. I think
you can get by on the flags with some macros, but I don't think there is
really a nice general solution for all of the options that won't make
per-option work. If you really think it is possible, I invite you to try
to make a nice set of macros that cover all cases.

-Peff

PS I am behind on git mail and catching up slowly; I see there are some
other messages in this thread, but I don't have time to read them right
at this second. So don't think I am ignoring issues raised there -- I
just haven't gotten to them yet.
