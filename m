From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCHv3 1/4] am: avoid re-directing stdin twice
Date: Fri, 05 Sep 2014 22:26:35 +0200
Message-ID: <540A1C7B.80109@kdbg.org>
References: <1409911611-20370-1-git-send-email-judge.packham@gmail.com> <1409911611-20370-2-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 22:26:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ05m-0001mS-4S
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbaIEU0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:26:40 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:30707 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbaIEU0j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:26:39 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7D97E10011;
	Fri,  5 Sep 2014 22:26:36 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B9A7D19F459;
	Fri,  5 Sep 2014 22:26:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <1409911611-20370-2-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256517>

Am 05.09.2014 12:06, schrieb Chris Packham:
> In check_patch_format we feed $1 to a block that attempts to determine
> the patch format. Since we've already redirected $1 to stdin there is no
> need to redirect it again when we invoke tr. This prevents the following
> errors when invoking git am
> 
>   $ git am patch.patch
>   tr: write error: Broken pipe
>   tr: write error
>   Patch format detection failed.
> 
> Cc: Stephen Boyd <bebarino@gmail.com>
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> Nothing new since http://article.gmane.org/gmane.comp.version-control.git/256425
> 
>  git-am.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-am.sh b/git-am.sh
> index ee61a77..fade7f8 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -250,7 +250,7 @@ check_patch_format () {
>  			# discarding the indented remainder of folded lines,
>  			# and see if it looks like that they all begin with the
>  			# header field names...
> -			tr -d '\015' <"$1" |
> +			tr -d '\015' |
>  			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p |
>  			sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
>  			patch_format=mbox
> 

I think this change is wrong. This pipeline checks whether one of the
lines at the top of the file contains something that looks like an email
header. With your change, the first three lines would not be looked at
because they were already consumed earlier.

I wonder why tr (assuming it is *this* instance of tr) dies with a write
error instead of from a SIGPIPE. Is SIGPIPE ignored somewhere and then
the tr invocation inherits this "ignore SIGPIPE" setting?

The only thing your version changes is that tr writes a bit less text
into the pipe. Perhaps its just sufficient that the output fits into the
pipe buffer, and no error occurs anymore? Then the new version is not a
real fix: make the patch text a bit longer, and the error is back.

-- Hannes
