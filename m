From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/6] log/pretty-options: Document --[no-]notes and
 deprecate old notes options
Date: Tue, 29 Mar 2011 20:22:06 -0400
Message-ID: <20110330002206.GB1161@sigill.intra.peff.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
 <20110329205307.GA30959@sigill.intra.peff.net>
 <201103292344.26249.johan@herland.net>
 <201103300018.55371.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 02:22:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4jAu-00057E-5T
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 02:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab1C3AWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 20:22:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47727
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab1C3AWI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 20:22:08 -0400
Received: (qmail 3246 invoked by uid 107); 30 Mar 2011 00:22:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 20:22:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 20:22:06 -0400
Content-Disposition: inline
In-Reply-To: <201103300018.55371.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170342>

On Wed, Mar 30, 2011 at 12:18:55AM +0200, Johan Herland wrote:

> > On Tuesday 29 March 2011, Jeff King wrote:
> > > Here's the series I ended up with. Getting the refactoring just right
> > > turned out to be non-trivial, but between several attempts and some
> > > tests, I think the end result is correct. Hopefully the breakdown of
> > > the changes into small patches helps make it easy to review.
> > > 
> > >   [1/6]: notes: make expand_notes_ref globally accessible
> > >   [2/6]: revision.c: refactor notes ref expansion
> > >   [3/6]: notes: refactor display notes extra refs field
> > >   [4/6]: notes: refactor display notes default handling
> > >   [5/6]: revision.c: support --notes command-line option
> > >   [6/6]: revision.c: make --no-notes reset --notes list
> 
> And here's some documentation to go on top.

Thanks. I meant to document at the end, but somehow after the fifteenth
"rebase -i" I forgot. :)

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index ff41784..0c1c10e 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -177,9 +177,9 @@ May be an unabbreviated ref name or a glob and may be specified
>  multiple times.  A warning will be issued for refs that do not exist,
>  but a glob that does not match any refs is silently ignored.
>  +
> -This setting can be disabled by the `--no-standard-notes` option,
> +This setting can be disabled by the `--no-notes` option,
>  overridden by the 'GIT_NOTES_DISPLAY_REF' environment variable,
> -and supplemented by the `--show-notes` option.
> +and supplemented by the `--notes=<ref>` option.

This is not really "supplemented" any more, but rather "overridden", I
think.

> ---no-notes::
> ---show-notes[=<ref>]::
> +--notes[=<ref>]::
>  	Show the notes (see linkgit:git-notes[1]) that annotate the
>  	commit, when showing the commit log message.  This is the default
>  	for `git log`, `git show` and `git whatchanged` commands when
> -	there is no `--pretty`, `--format` nor `--oneline` option is
> -	given on the command line.
> +	there is no `--pretty`, `--format` nor `--oneline` option given
> +	on the command line.
> ++
> +By default, the notes shown are from the notes refs listed in the
> +'core.notesRef' and 'notes.displayRef' variables (or corresponding
> +environment overrides). See linkgit:git-config[1] for more details.
>  +
> -With an optional argument, add this ref to the list of notes.  The ref
> -is taken to be in `refs/notes/` if it is not qualified.
> +With an optional '<ref>' argument, add this notes ref to the list of
> +notes refs to be shown. The ref is taken to be in `refs/notes/` if it
> +is not qualified.

This is somewhat vague about the interaction, in particular that
"--notes=<ref>" will disable default notes from being shown unless
"--notes" is also given.

> +--no-notes::
> +	Do not show notes. This negates the above `--notes` option, by
> +	resetting the list of notes refs from which notes are shown.
> +	This can be combined with the above `--notes` option to control
> +	exactly which notes refs are shown. E.g. "--notes=foo" will show
> +	notes, both from the default notes ref, and from "refs/notes/foo",
> +	while "--no-notes --notes=foo" will only show notes from
> +	"refs/notes/foo".

This example is wrong. "--notes=foo" will show _only_ foo. A few
examples:

  --notes=foo ;# only foo
  --notes --notes=foo ;# foo and default
  --notes=foo --notes=bar --notes --no-notes --notes=foo ;# only foo

Make sense?

-Peff
