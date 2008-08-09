From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH] tg-create.sh: Support for multiple {to,cc,bcc}
	options
Date: Sat, 9 Aug 2008 02:33:57 +0200
Message-ID: <20080809003357.GQ10151@machine.or.cz>
References: <1218141086-16063-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 02:35:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRcQA-00069Y-37
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 02:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbYHIAd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 20:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbYHIAd7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 20:33:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57119 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbYHIAd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 20:33:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id BBCAF2C4C02B; Sat,  9 Aug 2008 02:33:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218141086-16063-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91733>

  Hi,

On Thu, Aug 07, 2008 at 10:31:26PM +0200, Bert Wesarg wrote:
> Git config supports multiple values for the same config key, so support it
> for these TopGit config options, too.
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> 
> ---
>  tg-create.sh |   17 ++++++++++++++---
>  1 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tg-create.sh b/tg-create.sh
> index 6cce7ed..d47959b 100644
> --- a/tg-create.sh
> +++ b/tg-create.sh
> @@ -100,13 +100,24 @@ git checkout -b "$name"
>  echo "$deps" | sed 's/ /\n/g' >"$root_dir/.topdeps"
>  git add "$root_dir/.topdeps"
>  
> +# Print each config value for a key ($1, without "topgit." prefix)
> +# with the given prefix ($2)
> +get_multi_config()
> +{
> +	# escape any / in prefix for sed
> +	prefix="$(echo "$2" | sed -e 's/\//\\\\\//g')"

Maybe use s### ? ;-)

> +
> +	git config --get-all topgit.$1 2>/dev/null |
> +		sed -e "s/^/$prefix /g"
> +}

Won't this return an error code and terminate the script in case no
option is defined? And why the stderr redirect?

>  author="$(git var GIT_AUTHOR_IDENT)"
>  author_addr="${author%> *}>"
>  {
>  	echo "From: $author_addr"
> -	! header="$(git config topgit.to)" || echo "To: $header"
> -	! header="$(git config topgit.cc)" || echo "Cc: $header"
> -	! header="$(git config topgit.bcc)" || echo "Bcc: $header"
> +	get_multi_config to  "To:"
> +	get_multi_config cc  "Cc:"
> +	get_multi_config bcc "Bcc:"
>  	! subject_prefix="$(git config topgit.subjectprefix)" || subject_prefix="$subject_prefix "
>  	echo "Subject: [${subject_prefix}PATCH] $name"
>  	echo

One trouble here is that I've seen mailers mess up when there is
multiple occurences of these headers, so it would be probably safer to
concatenate them all to single line, comma-separated.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
