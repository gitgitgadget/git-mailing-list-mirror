From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/6] stash: default listing to "--cc
 --simplify-combined-diff"
Date: Wed, 30 Jul 2014 20:09:07 -0400
Message-ID: <20140731000907.GA22297@peff.net>
References: <20140729175300.GA21536@peff.net>
 <20140729175725.GE31181@peff.net>
 <xmqqppgo2dqr.fsf@gitster.dls.corp.google.com>
 <xmqqtx5yy6nm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 02:09:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCdvw-0000s3-7p
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 02:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbaGaAJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 20:09:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:43361 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751605AbaGaAJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 20:09:19 -0400
Received: (qmail 27821 invoked by uid 102); 31 Jul 2014 00:09:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Jul 2014 19:09:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jul 2014 20:09:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtx5yy6nm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254531>

On Wed, Jul 30, 2014 at 12:43:09PM -0700, Junio C Hamano wrote:

> > "git log --cc" is one of the things I wanted for a long time to fix.
> > When the user explicitly asks "--cc", we currently ignore it, but
> > because we know the user wants to view combined diff, we should turn
> > "-p" on automatically.  And the change this patch introduces will be
> > broken when we fix "log --cc" ("stash list" will end up always
> > showing the patch, without a way to disable it).
> >
> > Can you make this conditional?  Do this only when <options> are
> > given to "git stash list" command and that includes "-p" or
> > something?

I'm definitely sympathetic. Using "--cc" with the diff family _does_
imply "-p" already, so it would be nice to do the same for the log
family.

> Perhaps something along this line?
> 
>  git-stash.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/git-stash.sh b/git-stash.sh
> index ae73ba4..0db1b19 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -297,8 +297,15 @@ have_stash () {
>  
>  list_stash () {
>  	have_stash || return 0
> -	git log --format="%gd: %gs" -g --cc --simplify-combined-diff \
> -		"$@" $ref_stash --
> +	case " $* " in
> +	*' --cc '*)
> +		;; # the user knows what she is doing
> +	*' -p '* | *' -U'*)
> +		set x "--cc" "--simplify-combined-diff" "$@"
> +		shift
> +		;;
> +	esac
> +	git log --format="%gd: %gs" -g "$@" $ref_stash --

Ugh. I'd generally like to avoid this sort of ad-hoc command line
parsing, as it is easy to get confused by option arguments or
even non-options. At least we do not have to worry about pathspecs here,
as we already do an explicit "--" (so we might be confused by them, but
they are broken anyway).

Still, I wonder if a cleaner solution is to provide alternate "default
to this" options for the revision.c option parser. We already have
"--default" to pick the default starting point. Could we do something
like "--default-merge-handling=cc" or something?

There's a similar ad-hoc parsing case in "stash show", where we add
"--stat" if no arguments are given, but we have no clue if a diff format
was given (so "git stash show --color" accidentally turns on patch
format!). Something like "--default-diff-format=stat" would be more
robust.

I dunno. Maybe it is over-engineering. I just hate to see solutions that
work most of the time and crumble in weird corner cases, even if people
don't hit those corner cases very often.

-Peff
