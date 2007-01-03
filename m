From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] git-reset --hard: tell the user what the HEAD was reset
 to
Date: Wed, 03 Jan 2007 13:17:21 +0000
Message-ID: <459BACE1.5020406@shadowen.org>
References: <emcf17$esj$1@sea.gmane.org> <Pine.LNX.4.63.0612211525070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 14:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H25zn-00064C-BS
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 14:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbXACNR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 08:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbXACNR1
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 08:17:27 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4311 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbXACNR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 08:17:26 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H25ym-0002ge-UP; Wed, 03 Jan 2007 13:16:29 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612211525070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35865>

Johannes Schindelin wrote:
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> 
> 	On Wed, 20 Dec 2006, Han-Wen Nienhuys wrote:
> 
> 	> It would be nice if git-reset printed 
> 	> 
> 	>  HEAD is now <sha1> - <excerpt of commit message>
> 
> 	This patch does that, but only for --reset.
> 
> 	Without reset, HEAD is _not_ changed, just the contents of the
> 	working directory and/or the index.
> 
>  git-reset.sh |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/git-reset.sh b/git-reset.sh
> index 8d95e37..2379db0 100755
> --- a/git-reset.sh
> +++ b/git-reset.sh
> @@ -86,7 +86,12 @@ update_ref_status=$?
>  
>  case "$reset_type" in
>  --hard )
> -	;; # Nothing else to do
> +	test $update_ref_status = 0 && {
> +		echo -n "HEAD is now at "
> +		GIT_PAGER= git log --max-count=1 --pretty=oneline \
> +			--abbrev-commit HEAD
> +	}
> +	;;
>  --soft )
>  	;; # Nothing else to do
>  --mixed )

Ok, this sounds like a good change in principle, but the output format
it introduces seems likely to cause confusion.  For sure the first
couple of times I saw it I though there was a bug and I was seeing an
error from the plumbing.  See below for an example where you would swear
something bad had occured.

  apw@pinky$ git checkout -b bar master
  apw@pinky$ git reset --hard ac9c1108d8915f0937795e354ad72c4ae6890a3f
  HEAD is now at ac9c110... git-fetch: remove .keep file at the end.

Huh, fetch?  Remove what .keep file?  Did I do a fetch?  What?

I think we need to delimit the name better, probabally we need to quote
it.  Perhaps something like:

  HEAD is now at ac9c110: "git-fetch: remove .keep file at the end".

-apw
