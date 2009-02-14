From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 12:40:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>  <7vab8pweod.fsf@gitster.siamese.dyndns.org> <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 12:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYItE-0001VL-97
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 12:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbZBNLj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 06:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbZBNLj2
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 06:39:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:54981 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751351AbZBNLj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 06:39:27 -0500
Received: (qmail invoked by alias); 14 Feb 2009 11:39:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 14 Feb 2009 12:39:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18h2N9U8NEhhOJHsqsvoy8kRaX9f34s15grEV8BoG
	aaSJrSjF+Rgcgp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109860>

Hi,

On Sat, 14 Feb 2009, Felipe Contreras wrote:

> Then why are you asking?

Out of curiosity, I guess, as it would happen to answer my curiosity as 
well.

> This is more a "I would like to increase the chances of my patches
> being accepted so I'd do some chores to gain the trust of some
> developers", and Johannes Schindelin was pushing me to do this.

Heh, I'll gladly take the blame for that!

Note that in contrast to Junio, I think "git config" is a chimera between 
plumbing and porcelain, and would benefit tremendously from a nice help.

> >> +static int type_int, type_bool, type_bool_or_int;
> >
> > You can have either (no type specified, int, bool, bool-or-int) at the
> > end.  Using three independent variables does not feel right.
> >
> > Hint: OPTION_SET_INT.
> 
> That definitely makes things easier, it would have been nice to see an
> example of this; I didn't knew it was there.
> 
> The only problem is that --bool and --int would be possible in the
> same command and there would be no way to output an error, but I guess
> that's not a big problem.

I think that is okay.

> >> +     else if (do_add) {
> >> +             if (argc > 2)
> >> +                     die("Too many arguments.");
> >> +             if (argc != 2)
> >> +                     die("Need name value.");
> >> +             value = normalize_value(argv[0], argv[1]);
> >> +             return git_config_set_multivar(argv[0], value, "^$", 0);
> >
> > This part did not lose argc error checking, but...
> >
> >> +     }
> >> +     else if (do_replace_all) {
> >> +             value = normalize_value(argv[0], argv[1]);
> >> +             return git_config_set_multivar(argv[0], value, (argc == 3 ? argv[2] : NULL), 1);
> >
> > You do not check argc here (nor in many "else if" below) to make sure you
> > have sufficient number of arguments.  "git config --unset" is now allowed
> > to segfault, and "git config --unset a b c d e f" can silently ignore
> > excess arguments for example?
> 
> Yes the arguments check need to be revised.
> 
> My hope was somebody would review this and suggest a clever and
> generic way of doing this. Perhaps a util function check_min_args, or
> maybe something in parseopt that receives the number of args?

Maybe a helper, yes.  Something like:

	static void check_argc(int argc, int min, int max) {
		if (argc >= min && argc <= max)
			return;
		fprintf(stderr, "Wrong number of arguments: %d\n", argc);
		usage_with_options(config_usage, config_options);
	}

Of course, this assumes that config_usage and config_options are global...

> Also, I think the code would be easier to maintain with parseopt.

I agree.

Thanks,
Dscho
