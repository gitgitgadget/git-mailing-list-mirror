From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 3/6] Refactor --dirstat parsing; deprecate --cumulative and
 --dirstat-by-file
Date: Wed, 27 Apr 2011 04:02:10 +0200
Message-ID: <201104270402.10658.johan@herland.net>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-4-git-send-email-johan@herland.net>
 <7vy62xezqy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 04:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEu56-0006Jo-2i
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 04:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab1D0CCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 22:02:14 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39677 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755458Ab1D0CCN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 22:02:13 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA00AAGGBOMS50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:02:12 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 3D28C1EEEDE1_DB77924B	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:02:12 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 7D9251EEED5A_DB77923F	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:02:11 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA002LHGBNY610@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:02:11 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.2; x86_64; ; )
In-reply-to: <7vy62xezqy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172146>

On Tuesday 26 April 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > +--dirstat[=<arg1,arg2,...>]::
> > +	Output the distribution of relative amount of changes for each
> > +	sub-directory. The behavior of `--dirstat` can be customized by
> > +	passing it a comma separated list of arguments. The defaults
> > +	are controlled by the `diff.dirstat` configuration variable (see
> > +	linkgit:git-config[1]). The following arguments are available:
>
> These "arguments" feel more like "options" (or "parameters"), no?  Your
> code in diff.c also calls it "opt".  The second line of the proposed log
> message has the same issue.

I have tried to consistently use "option" for referring to the entire
"--dirstat=whatever" entity, and then use "argument" for referring to
each comma-separated token following "--dirstat=". I based this on the
function naming in diff.c, which uses "diff_opt_parse()" to parse diff
options, "stat_opt()" to parse the '--stat*' options, and "opt_arg()"
to parse arguments to options (i.e. "--option=argument").

To me, "argument" and "parameter" are synonyms, but English is not my
first language. I'll replace "argument" with "parameter" in the re-roll.
I.e. "option" refers to the option name AND the option parameters, while
"parameters" refers to the option parameters only.

> > +--
> > +`changes`;;
> > +	Compute the dirstat numbers by counting the lines that have been
> > +	removed from the source, or added to the destination. This ignores
> > +	the amount of pure code movements within a file.  In other words,
> > +	rearranging lines in a file is not counted as much as other changes.
> > +	This is the default `--dirstat` behavior.
> 
> "default behavior when no option is given"?

"default behavior when no parameter is given"?

> > +`cumulative`;;
> > +	Count changes in a child directory for the parent directory as well.
> > +	Note that when using `cumulative`, the sum of the percentages
> > +	reported may exceed 100%. The default (non-cumulative) behavior can
> > +	be specified with the `noncumulative` argument.
> 
> So the later one wins?  I.e. --dirstat=cumulative,noncumulative from the
> command line (which seems silly), or more importantly with
> 
>     [alias]
>     	dstat = diff --dirstat=cumulative
> 
> and you can say "git dstat --dirstat=noncumulative A..B"?

Indeed. The intention is that dirstat parameters are parsed in order
(first from config, then from command line), and the later parameters
override earlier (conflicting) parameters.

> > diff --git a/diff.c b/diff.c
> > index cfbfa92..08aaa47 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -3144,6 +3144,72 @@ static int stat_opt(struct diff_options
> > *options, const char **av)
> > 
> >  	return argcount;
> >  
> >  }
> 
> /*
>  * Document what the return value from this function means here.
>  */
> > +static int dirstat_opt(struct diff_options *options, const char **av)
> 
> Do you have to pass "const char **av", or just "const char *arg"?

dirstat_opt() was modeled on stat_opt(). dirstat_opt() obviously needs
just "const char *arg". Will fix.

> > +{
> > +	const char *p, *arg = av[0];
> > +	char *mangled = NULL;
> > +	char sep = '=';
> > +
> > +	if (!strcmp(arg, "--cumulative")) /* deprecated */
> > +		/* handle '--cumulative' like '--dirstat=cumulative' */
> > +		p = "=cumulative";
> > +	else if (!strcmp(arg, "--dirstat-by-file") ||
> > +		 !prefixcmp(arg, "--dirstat-by-file=")) { /* deprecated */
> > +		/* handle '--dirstat-by-file=*' like '--dirstat=files,*' */
> > +		mangled = xstrdup(arg + 2);
> > +		memcpy(mangled, "--dirstat=files", 15);
> > +		if (mangled[15]) {
> > +			assert(mangled[15] == '=');
> > +			mangled[15] = ',';
> > +		}
> > +		arg = mangled;
> > +		p = mangled + 9;
> 
> I understand you wanted to reuse the while() loop below, but I do not
> think it is worth it.  Isn't it easier to read if you handled the above
> cases in their if/else body and return?
> 
> 	if (--cumulative) {
> 		options->output_format |= DIFF_FORMAT_DIRSTAT;
>         	DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
>                 return 1;
> 	}
>         if (--dirstat-by-file) {
> 		options->output_format |= DIFF_FORMAT_DIRSTAT;
> 		DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
> 		return 1;
> 	}
> 	...
> 
> Even better, probably they can be left to diff_opt_parse() without
> calling this function, as you are deprecating them and do not have to
> allow them to take the opt1,opt2,... form of parameter.

I understand, but politely disagree: Patch 6/6 complicates the logic
that DIFF_OPT_SET()/CLR() various bits in the diff options. I'd rather
keep that logic in one place, than duplicate it into diff_opt_parse().

> > +	}
> > +	else if (!prefixcmp(arg, "-X"))
> > +		p = arg + 2;
> > +	else if (!prefixcmp(arg, "--dirstat"))
> > +		p = arg + 9;
> > +	else
> > +		return 0;
> > +
> > +	options->output_format |= DIFF_FORMAT_DIRSTAT;
> > +
> > +	while (*p) {
> > +		if (*p != sep)
> 
> What happens to "diff -X3 A..B"?

Oops. Will fix, and add testcases verifying the fix.

> > +			die("Missing argument separator ('%c'), at index %lu of '%s'",
> > +			    sep, p - arg, arg);
> 
> Don't you need to cast (p-arg) for %lu from ptrdiff type here?

Copied PD_FMT from builtin/mktag.c instead.

> It probably is more common to say s/index/char/;

Indeed.

> > +		if (!prefixcmp(p, "changes")) {
> > +			p += 7;
> > +			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
> > +		}
> > +		else if (!prefixcmp(p, "files")) {
> > +			p += 5;
> > +			DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
> > +		}
> > +		else if (!prefixcmp(p, "noncumulative")) {
> > +			p += 13;
> > +			DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
> > +		}
> > +		else if (!prefixcmp(p, "cumulative")) {
> > +			p += 10;
> > +			DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
> > +		}
> > +		else if (isdigit(*p)) {
> > +			char *end;
> > +			options->dirstat_percent = strtoul(p, &end, 10);
> > +			assert(end > p);
> > +			p = end;
> > +		}
> 
> That's a senseless assert(), isn't it?
> 
> You already know the first letter is a digit, so assert(p < end) will
> always be true.  You may want to check that this particular option is all
> digit by checking (*end == '\0' || *end == ',') but that is done at the
> beginning of this loop anyway, so I don't think there is anything to
> check here.

True. I guess I just wanted a sanity check that aborts, rather than
entering an infinite loop in case I got my logic wrong somewhere...
Removed in the re-roll.

> > +		else
> > +			die("Unknown --dirstat argument '%s'", p);
> 
> The function parses dirstat_OPT, but this says argument?

Again, the "option" refers to the option name ("--dirstat") AND its
s/arguments/parameters/ ("changes,noncumulative,3")


Your other comments (that I felt no need to comment on) will also be
incorporated in the re-roll.


Thanks for the feedback!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
