From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Mon, 28 May 2007 17:46:30 +0200
Message-ID: <20070528154630.GA9176@fiberbit.xs4all.nl>
References: <87bqg724gp.fsf@rho.meyering.net> <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org> <87odk6y6cd.fsf@rho.meyering.net> <alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org> <87sl9hw0o0.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon May 28 18:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsi52-0005Z1-IY
	for gcvg-git@gmane.org; Mon, 28 May 2007 18:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbXE1Q2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 12:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbXE1Q2R
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 12:28:17 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:47405 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbXE1Q2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 12:28:16 -0400
X-Greylist: delayed 2502 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 May 2007 12:28:15 EDT
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1HshQU-0002QD-OA; Mon, 28 May 2007 17:46:30 +0200
Content-Disposition: inline
In-Reply-To: <87sl9hw0o0.fsf@rho.meyering.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48621>

On monday May 28th 2007 at 15:14 Jim Meyering wrote:

> > I don't know how many people remember all the _stupid_ problems we had
> > exactly because many versions of bash are crap, crap, crap, and people
> > (including you) don't realize that EPIPE is _different_ from other write
> > errors.
> >
> > Just do a google search for
> >
> > 	"broken pipe" bash
> >
> > and not only will you see a lot of complaints, but the #5 entry is a
> > complaint for a git issue that we had tons of problems with. See for
> > example
> >
> > 	http://www.gelato.unsw.edu.au/archives/git/0504/2602.html
> 
> Whether bash should print a diagnostic when it kills a process with
> SIGPIPE is _different_ from whether the writing process should diagnose
> its own write failure arising from a handled SIGPIPE.
> 
> I suspect that git's special treatment of EPIPE was a shoot-the-messenger
> reaction to the work-around (trap '' PIPE) required to avoid diagnostics
> from porcelain being interpreted by what would now be a 2-year-old
> version of bash.  It is time to remove that work-around, because it
> can obscure real errors, and removing it will be largely unnoticed.

Good point. But also notice that when you are stuck with a shell that
does complain about SIGPIPE it is _really_ annoying!

On current Debian 'sid' with your patch this does not seem to be the
case.

The second chunk of your patch (to git.c) contains a small copy-paste
accident methinks:

> @@ -321,7 +322,15 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
>  			die("%s must be run in a work tree", cmd);
>  		trace_argv_printf(argv, argc, "trace: built-in: git");
> 
> -		exit(p->fn(argc, argv, prefix));
> +		status = p->fn(argc, argv, prefix);
> +
> +		/* Close stdout if necessary, and diagnose any failure.  */
> +		if (fcntl(fileno (stdout), F_GETFD) >= 0)
> +		    && (ferror(stdout) || fclose(stdout)))
> +			die("write failure on standard output: %s",
> +			    strerror(errno));
> +
> +		exit(status);

The if statement with 'fcntl' is missing a brace, it should be:

+		if ((fcntl(fileno (stdout), F_GETFD) >= 0)
+		    && (ferror(stdout) || fclose(stdout)))

-- 
Marco Roeland
