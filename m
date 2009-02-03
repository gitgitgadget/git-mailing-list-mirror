From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Tue, 3 Feb 2009 09:55:08 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:57:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPW8-0006ef-3f
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326AbZBCRzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756103AbZBCRza
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:55:30 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:41428 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197AbZBCRz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:55:28 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n13Ht9fI008860;
	Tue, 3 Feb 2009 09:55:09 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n13Ht8Fb008857;
	Tue, 3 Feb 2009 09:55:08 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <20090203071516.GC21367@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108230>

Peff,
First of all, thanks for the tips!

On Tue, 3 Feb 2009, Jeff King wrote:

> You don't need to repeat the subject in the body.

OK.

> Paragraph breaks might have made this a bit easier to read.

How about:

Improve porcelain diff's accommodation of user preference by allowing
some settings to (a) persist over all invocations and (b) stay consistent
over multiple tools (e.g. command-line and gui).  The approach taken here
is good because it delivers the consistency a user expects without breaking
any plumbing.  It works by allowing the user, via git-config, to specify
arbitrary options to pass to porcelain diff on every invocation, including
internal invocations from other programs, e.g. git-gui.

Introduce diff command-line options --primer and --no-primer.

Affect only porcelain diff: we suppress primer options for plumbing 
diff-{files,index,tree}, format-patch, and all other commands unless explicitly 
requested using --primer (opt-in).

Teach gitk to use --primer, but protect it from inapplicable options like 
--color.

> > +diff.primer::
> > +	Whitespace-separated list of options to pass to 'git-diff'
> > +	on every invocation, including internal invocations from
> > +	linkgit:git-gui[1] and linkgit:gitk[1],
> > +	e.g. `"--patience --color --ignore-space-at-eol --exit-code"`.
> > +	See linkgit:git-diff[1]. You can suppress these at run time with
> > +	option `--no-primer`.  Supports a subset of
> > +	'git-diff'\'s many options, at least:
> > +	`-b --binary --color --color-words --cumulative --dirstat-by-file
> > +--exit-code --ext-diff --find-copies-harder --follow --full-index
> > +--ignore-all-space --ignore-space-at-eol --ignore-space-change
> > +--ignore-submodules --no-color --no-ext-diff --no-textconv --patience -q
> > +--quiet -R -r --relative -t --text --textconv -w`
> 
> Funny indentation?

The last part is a backtick-quoted list, I think it either must occur on one 
line or as is.

> This seems really clunky to list all of the options here. I thought the
> point was to respect _all_ of them, but do it from porcelain so that it
> is up to the user what they want to put in.
> 
> How was this list chosen?

The current version does not try to support all diff options.  It only supports 
those that are recorded in struct diff_options.flags and .xdl_opts - that is the 
present list.

> Some of the manpages use a more terse form for negatable options, like:
> 
>   --[no-]primer::
> 
> which often helps focus the text a bit. Something like:
> 
>   --[no-]primer::
>     Respect (or ignore) options specifed in the diff.primer
>     configuration variable. By default, porcelain commands (such as `git
>     diff` and `git log`) respect this variable, but plumbing commands
>     (such as `git diff-{files,index,tree}`) do not.

Agree.

> Also, don't mention ".git/config" by name: configuration can come from
> ~/.gitconfig, a system-wide gitconfig, or .git/config.

OK.

> > @@ -284,6 +284,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
> > [...]
> > +	DIFF_OPT_SET(&rev.diffopt, PRIMER);
> 
> Probably ALLOW_PRIMER is a more sensible name, to match ALLOW_EXTERNAL
> and ALLOW_TEXTCONV.

Agree.

> > +static const char blank[] = " \t\r\n";
> > +
> > +void parse_diff_primer(struct diff_options *options)
> > +{
> > +	char *str1, *token, *saveptr;
> > +	int len;
> > +
> > +	if ((! diff_primer) || ((len = (strlen(diff_primer)+1)) < 3))
> > +		return;
> > +
> > +	token = str1 = strncpy((char*) malloc(len), diff_primer, len);
> > +	if ((saveptr = strpbrk(token += strspn(token, blank), blank)))
> > +		*(saveptr++) = '\0';
> > +	while (token) {
> > +		if (*token == '-')
> > +			diff_opt_parse(options, (const char **) &token, -1);
> > +		if ((token = saveptr))
> > +			if ((saveptr = strpbrk(token += strspn(token, blank), blank)))
> > +				*(saveptr++) = '\0';
> > +	}
> > +
> > +	free( str1 );
> > +}
> 
> This doesn't appear to have any quoting mechanism. Is it impossible to have an 
> option with spaces (e.g., --relative='foo bar')? I guess that is probably 
> uncommon, but I would expect normal shell quoting rules to apply.

The current version only supports the flags listed above in 
Documentation/config.txt.

> Style: long lines.

OK.

> Style: no C99/C++ comments.

OK.

> > +	master->flags = (~x1&x2&x3)|(x0&~x3)|(x0&x1);
> 
> Style: whitespace between operands and operators.
> 
> I have to admit that this particular line is pretty dense to read. You have 
> eliminated any meaning from the variable names (like the fact that you have a 
> master/slave pair of flag/mask pairs). Yes, you point to the Quine-McCluskey 
> algorithm in the comment above, but I think something like this would be 
> easier to see what is going on:
> 
>   /*
>    * Our desired flags are:
>    *
>    *   1. Anything the master hasn't explicitly set, we can take from
>    *      the slave.
>    *   2. Anything the slave didn't explicitly, we can take whether or
>    *      not the master set it explicitly.
>    *   3. Anything the master explicitly set, we take.
>    */
>   master->flags =
>      /* (1) */ (~master->flags & slave->flags & slave->mask) |
>      /* (2) */ (master->flags & ~slave->mask) |
>      /* (3) */ (master->flags & master->mask);

Your version is much better.

> > @@ -2326,14 +2369,15 @@ void diff_setup(struct diff_options *options)
> >  	options->break_opt = -1;
> >  	options->rename_limit = -1;
> >  	options->dirstat_percent = 3;
> > -	DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
> > +	if (DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE))
> > +		DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
> 
> Hmm. I haven't gotten to any changes to DIFF_OPT_{SET,CLR} yet. But it is a 
> little worrisome that this patch is so invasive as to require a change like 
> this.

My proposal is to make DIFF_OPT_{SET,CLR} more meaningful.  Instead of just 
flipping a bit, they mean "{un}set this bit and honor my intention in the 
future".

> I wouldn't be surprised to find other spots outside of diff.c where the 
> options are munged by various programs. Did you audit for all such spots?

Yes I believe I did.  The only danger zones are spots that use struct 
diff_options member "flags" or "xdl_opts" along with assignment and bitwise 
operators.  The following recursive grep call (output included) satisfies me 
that no such spots exist after my patch.

grep -EHnr '--include=*.[ch]' '(flags|xdl_opts).*=.*(DIFF_OPT_|\b)(RECURSIVE|TREE_IN_RECURSIVE|BINARY|TEXT|FULL_INDEX|SILENT_ON_REMOVE|FIND_COPIES_HARDER|FOLLOW_RENAMES|COLOR_DIFF|COLOR_DIFF_WORDS|HAS_CHANGES|QUIET|NO_INDEX|ALLOW_EXTERNAL|EXIT_WITH_STATUS|REVERSE_DIFF|CHECK_FAILED|RELATIVE_NAME|IGNORE_SUBMODULES|DIRSTAT_CUMULATIVE|DIRSTAT_BY_FILE|ALLOW_TEXTCONV|PRIMER|XDF_NEED_MINIMAL|XDF_IGNORE_WHITESPACE|XDF_IGNORE_WHITESPACE_CHANGE|XDF_IGNORE_WHITESPACE_AT_EOL|XDF_PATIENCE_DIFF|XDF_WHITESPACE_FLAGS)\b' . | grep -Ev TST | less -S

merge-tree.c:109:     xpp.flags = XDF_NEED_MINIMAL;
merge-file.c:65:      xpp.flags = XDF_NEED_MINIMAL;
xdiff/xpatience.c:308:        xpp.flags = map->xpp->flags & ~XDF_PATIENCE_DIFF;
builtin-blame.c:41:static int xdl_opts = XDF_NEED_MINIMAL;
combine-diff.c:217:   xpp.flags = XDF_NEED_MINIMAL;
builtin-rerere.c:101: xpp.flags = XDF_NEED_MINIMAL;
diff.c:517:   xpp.flags = XDF_NEED_MINIMAL;
diff.c:1570:          xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
diff.c:1658:          xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
diff.c:1706:          xpp.flags = XDF_NEED_MINIMAL;
diff.c:3238:          xpp.flags = XDF_NEED_MINIMAL;

> > +	if (DIFF_OPT_TST(options, PRIMER)) {
> > +		if (! primer) {
> > +			diff_setup(primer = (struct diff_options *) malloc(sizeof(struct diff_options)));
> 
> First, don't use malloc. Use the xmalloc wrapper that will try to free pack 
> memory and/or die if it fails.

OK.

> Secondly, don't cast the result of malloc. At best it is pointless and 
> verbose, and at worst it can hide errors caused by a missing function 
> declaration.

OK.

> >  	/* xdiff options */
> >  	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
> > -		options->xdl_opts |= XDF_IGNORE_WHITESPACE;
> > +		DIFF_XDL_SET(options, IGNORE_WHITESPACE);
> 
> It often makes the patch easier to review if you split changes like this
> out into a separate patch. Then your series is
> 
>   1/2: use DIFF_XDL_SET instead of raw bit-masking
> 
>        This is a cleanup in preparation for option-setting doing
>        something more complex than just setting a bit-mask. The code
>        should behave exactly the same.
> 
>   2/2: primer patch
> 
>        ... DIFF_XDL_SET tracks not only the set options, but which ones
>        were set explicitly via a mask ...
> 
> Then we can all see pretty easily that patch 1/2 doesn't change the behavior, 
> and each patch is a much smaller, succint chunk to review.

Agree.

> Ditto here with DIFF_OPT_SET.

OK.

> > +#define DIFF_OPT_TST(opts, flag)    ((opts)->flags &   DIFF_OPT_##flag)
> > +#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |=  DIFF_OPT_##flag), ((opts)->mask |= DIFF_OPT_##flag)
> > +#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag), ((opts)->mask |= DIFF_OPT_##flag)
> > +#define DIFF_OPT_DRT(opts, flag)    ((opts)->mask  &   DIFF_OPT_##flag)
> 
> OK, I see what it is supposed to do, but what does DRT stand for? Also,
> what practical use does it have? I don't see anybody _calling_ it.

DRT means "dirty".  The masks here are dirty bits.  You're right, I never called 
it.  But it seemed so meaningful to me, I felt it was right to include it while 
introducing the concept of dirty bits.

> > --- a/gitk-git/gitk
> > +++ b/gitk-git/gitk
> > @@ -4259,7 +4259,7 @@ proc do_file_hl {serial} {
> >  	# must be "containing:", i.e. we're searching commit info
> >  	return
> >      }
> > -    set cmd [concat | git diff-tree -r -s --stdin $gdtargs]
> > +    set cmd [concat | git diff-tree --primer --no-color -r -s --stdin $gdtargs]
> 
> Does gitk really want to respect --primer? Might it not make more sense for 
> it, as a porcelain, to respect the diff.primer variable itself, and prepend it 
> to the list of diff args? Then it has the power to veto any options which it 
> doesn't handle.

The point of --primer was for scripts like gitk and git-gui.  I wouldn't say 
"respect --primer" so much as "pass --primer" (which causes diff-tree to respect 
diff.primer, which it normally wouldn't).  Reviewing the options that 
diff.primer currently supports, except for --color which I specifically guarded 
against, I don't see a scenario that would break gitk as is.

> Also, any gitk changes should almost certainly be split into a different
> patch.

OK.

> All in all, this was a lot more complicated than I was expecting. Why isn't 
> the behavior of "diff.primer" simply "pretend as if the options in diff.primer 
> were prepended to the command line"? That is easy to explain, and easy to 
> implement (the only trick is that you have to do an extra pass to find 
> --[no-]primer). Is there some drawback to such a simple scheme that I am 
> missing?

I think we could call that simple scheme the linear walk, and it was my first 
impulse as well.  We walk through all the places where diff options live, in 
order from lowest precedence to highest precedence, accumulating/overriding 
options as we go along.  When we're done, we know the user's intention.

But as you say, we need that extra pass.  Once I noticed we need that extra 
pass, the software engineer in me saw the concept of linear walk as too weak for 
this feature.  These options occur in precedence layers and we need to combine 
those layers the right way.  The right way means: honor the intuitive semantics 
the user expects.  Hence the function name flatten_diff_options().

A multi-pass walk is one possible implementation of such semantics, but in my 
opinion not the best.  My implementation is much more explicit, meaningful, and 
declarative.  It's not at all hard to understand looking at the code.  In fact, 
it positively declares itself to you and annouces exactly what it is doing.  It 
"underlines the intent" and also "eases further extensions" in Samuel Tardieu's 
words:
http://article.gmane.org/gmane.comp.version-control.git/105654

That's a desirability I believe you agree with :)
http://article.gmane.org/gmane.comp.version-control.git/105657

I think introducing explicit dirty masks and explicit layer flattening is the 
right way to go forward, but I agree it would be better to split this up into 
smaller patches.  My design would require a lot more lines of code if we wanted 
to support more diff options than are represented by struct diff_options.flags 
and .xdl_opts.  That would mean introducing more masks and more CPP macros.  
But I have faith in declarative programming.  100 lines of clear-as-day 
meaningful code don't scare me nearly as much as 10 lines of secret obfuscation.  
Also, I'm not convinced it is necessary for diff.primer to support all diff 
options under the sun.  Thoughts?

                                   -- Keith
