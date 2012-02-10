From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH] mergetools/meld: Use --help output to detect --output
 support
Date: Fri, 10 Feb 2012 16:23:12 -0600
Message-ID: <20120210222311.GB20703@unpythonic.net>
References: <20120209191742.GA20703@unpythonic.net>
 <CAJDDKr58LV9EDJZP+3S0YfyTOXFgJWD6nm=AiA19MkyBF-wb_g@mail.gmail.com>
 <20120210082106.GA7871@burratino>
 <7vwr7unzs8.fsf@alter.siamese.dyndns.org>
 <20120210215755.GL19216@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 23:23:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvysE-0002hT-D3
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 23:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760296Ab2BJWXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 17:23:16 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:32783 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753187Ab2BJWXP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 17:23:15 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id 7117420000F; Fri, 10 Feb 2012 16:23:12 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20120210215755.GL19216@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190469>

I appreciate the interest you've all taken in my report, but I really
don't think there's any need to do anything about this "problem" besides
let people find this thread, in which they can learn to try upgrading
their meld to one that's only 5 1/2 years old.

That said, another possibility is to test whether
    meld --commandline-option-that-cannot-possibly-exist --help
exits with status 0; if it does, then exit-status based probing of
meld's capabilities won't work.  In this case, assume --output is not
available.

Jeff

On Fri, Feb 10, 2012 at 03:57:55PM -0600, Jonathan Nieder wrote:
> In v1.7.7-rc0~3^2 (2011-08-19), git mergetool's "meld" support learned
> to use the --output option when calling versions of meld that are
> detected to support it (1.5.0 and newer, hopefully).
> 
> Alas, it misdetects old versions (before 1.1.5, 2006-06-11) of meld as
> supporting the option, so on systems with such meld, instead of
> getting a nice merge helper, the operator gets a dialog box with the
> text "Wrong number of arguments (Got 5)".  (Version 1.1.5 is when meld
> switched to using optparse.  One consequence of that change was that
> errors in usage are detected and signalled through the exit status
> even when --help was passed.)
> 
> Luckily there is a simpler check that is more reliable: the usage
> string printed by "meld --help" reliably reflects whether --output is
> supported in a given version.  Use it.
> 
> Reported-by: Jeff Epler <jepler@unpythonic.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Junio C Hamano wrote:
> 
> > When an older meld fails when given --output for real (not with the dry
> > run current code tries with --help), can we sanely detect that particular
> > failure?
> 
> Unfortunately it just pops up a GUI with a modal dialog box like this:
> 	 ___________________________________
> 	|                                   |
> 	| Wrong number of arguments (Got 5) |
> 	|                                   |
> 	|                     [Quit] [OK]   |
> 	|___________________________________|
> 
> If I choose "Quit", the exit status is 0.
> 
> But how about this?  "meld --help | grep -e --output" seems to detect
> support for the option reliably.  With 2>&1 on the upstream of the
> pipe, this even seems futureproof. ;-)
> 
>  mergetools/meld |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/mergetools/meld b/mergetools/meld
> index eaa115cc..cb672a55 100644
> --- a/mergetools/meld
> +++ b/mergetools/meld
> @@ -23,7 +23,7 @@ check_meld_for_output_version () {
>  	meld_path="$(git config mergetool.meld.path)"
>  	meld_path="${meld_path:-meld}"
>  
> -	if "$meld_path" --output /dev/null --help >/dev/null 2>&1
> +	if "$meld_path" --help 2>&1 | grep -e --output >/dev/null
>  	then
>  		meld_has_output_option=true
>  	else
> -- 
> 1.7.9
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
