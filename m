From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2] Let submodule command exit with error status if
	path does not exist
Date: Mon, 13 Aug 2012 18:39:17 +0200
Message-ID: <20120813163911.GA6418@book.hvoigt.net>
References: <1340872080.2103.92.camel@athena.dnet> <20120809200302.GA93203@book.hvoigt.net> <7vboijol03.fsf@alter.siamese.dyndns.org> <20120811064912.GA83365@book.hvoigt.net> <7vy5lkfyx1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Milde <daniel@milde.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 18:40:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0xgw-0004NZ-25
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 18:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab2HMQk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 12:40:28 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:36214 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab2HMQk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 12:40:28 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1T0xfi-0005G5-91; Mon, 13 Aug 2012 18:39:18 +0200
Content-Disposition: inline
In-Reply-To: <7vy5lkfyx1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203342>

Hi Junio,

thanks for such a thorough review.

On Sat, Aug 11, 2012 at 10:43:22PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > I did not know that you prefer a space after the function name. I simply
> > imitated the style from C and there we do not have spaces. It makes the
> > style rules a bit more complicated. Wouldn't it be nicer to have the
> > same as in C so we have less rules?
> 
> I do not think so, as they are different languages.  The call site
> of C functions have name and opening parenthesis without a SP in
> between.  The call site of shell functions do not even have
> parentheses.
> 
> In any case, personal preferences (including mine) do not matter
> much, as there is no "this is scientificly superiour" in styles.

How about I update CodingGuidelines according to the rules you
suggested? Then other people know how we prefer bash functions and if
statements to look like.

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index aac575e..48014f2 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -109,7 +109,8 @@ resolve_relative_url ()
> >  #
> >  module_list()
> >  {
> > -	git ls-files --error-unmatch --stage -- "$@" |
> > +	(git ls-files --error-unmatch --stage -- "$@" ||
> > +		echo '160000 0000000000000000000000000000000000000000 0	') |
> 
> Is there a reason why the sentinel has to have the same mode pattern
> as a GITLINK entry, NULL SHA-1, stage #0?  Or is the "path" being
> empty all that matters?
> 
> Ah, OK, you did not want to touch the perl script downstream.  I
> would have preferred a comment to document that, i.e.

I only described it in the commit message, sorry. Next time I will add a
comment.

> > @@ -385,6 +386,10 @@ cmd_foreach()
> >  	module_list |
> >  	while read mode sha1 stage sm_path
> >  	do
> > +		if test -z "$sm_path"; then
> > +			exit 1
> 
> Style:
> 
> 	if test -z "$sm_path"
> 	then
> 		exit 1

See above. If you agree I would add this style to the guidelines.

> I know module_list would have said "error: pathspec 'no-such' did
> not match any file(s) known to git.  Did you forget to git add"
> already, but because that comes at the very end of the input to the
> filter written in perl (and with the way the filter is coded, it
> will stay at the end), I am not sure if the user would notice it if
> we exit like this.  By the time we hit this exit, we would have seen
> "Entering $sm_path..." followed by whatever message given while in
> the submodule for all the submodules that comes out of module_list,
> no?
> 
> How about doing it this way to avoid that issue, to make sure we die
> immediately after the typo is diagnosed without touching anything?

I like it, your approach combines the atomicity of my first patch with
the efficiency of not calling ls-files twice. I was hesitant to change
to much code just to get the exit code right, but your approach looks
good to me.

Should I send an updated patch? Or do you just want to squash this in.
Since now only the tests are from me what should we do with the
ownership?

>  git-submodule.sh | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
[...]

Cheers Heiko
