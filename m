From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH v2] tg-create.sh: Support for multiple
	{to,cc,bcc} options
Date: Mon, 11 Aug 2008 22:47:23 +0200
Message-ID: <20080811204723.GF10151@machine.or.cz>
References: <1218307736-24891-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:48:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSeJZ-0002g2-OQ
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 22:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbYHKUr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 16:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbYHKUr1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 16:47:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51882 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbYHKUr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 16:47:26 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id CD731393B320; Mon, 11 Aug 2008 22:47:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218307736-24891-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91999>

  Hi,

On Sat, Aug 09, 2008 at 08:48:56PM +0200, Bert Wesarg wrote:
> Git config supports multiple values for the same config key, so support it
> for these TopGit config options, too.
> 
> New in v2:
> Print a RFC2822 compliant header.
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

  oops, I'm really sorry! I thought I already commented on this while
apparently, I forgot to.

> ---
>  tg-create.sh |   35 ++++++++++++++++++++++++++++++++---
>  1 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/tg-create.sh b/tg-create.sh
> index 6cce7ed..d7ee1d2 100644
> --- a/tg-create.sh
> +++ b/tg-create.sh
> @@ -100,13 +100,42 @@ git checkout -b "$name"
>  echo "$deps" | sed 's/ /\n/g' >"$root_dir/.topdeps"
>  git add "$root_dir/.topdeps"
>  
> +# Print a RFC2822 compliant header ($2) with values from the config option
> +# ($1 without the topgit. prefix)
> +get_multi_config()
> +{
> +	# Do we need to escape it for awk double quotes?
> +	prefix="$2"
> +	prefix_align="$(printf "%*s  " "${#2}" "")"
> +
> +	git config --get-all topgit.$1 |
> +		awk '
> +			BEGIN {
> +				line = ""
> +				prefix = "'"$prefix"': "
> +			}
> +				{
> +					if (line != "") {
> +						print prefix line ","
> +						prefix = "'"$prefix_align"'"
> +					}
> +					line = $0
> +				}
> +			END {
> +				if (line != "") {
> +					print prefix line
> +				}
> +			}
> +		'
> +}
> +

I'm not too happy about this, for several reasons:

	(i) This code is so awfully complicated.

	(ii) It would be simpler to just prefix all the further lines
with a tab; wouldn't something like

		sed '2,$s/^/\t/'

actually work?

	(iii) This is troublesome because now header values can span
multiple lines. Until now, we were just blisfully ignorant about this
possibility. At least tg export needs to be adjusted to account for this
now, and I fear dealing with this will be pretty annoying when
prototyping new features.

>  author="$(git var GIT_AUTHOR_IDENT)"
>  author_addr="${author%> *}>"
>  {
>  	echo "From: $author_addr"
> -	! header="$(git config topgit.to)" || echo "To: $header"
> -	! header="$(git config topgit.cc)" || echo "Cc: $header"
> -	! header="$(git config topgit.bcc)" || echo "Bcc: $header"
> +	get_multi_config to  "To"
> +	get_multi_config cc  "Cc"
> +	get_multi_config bcc "Bcc"
>  	! subject_prefix="$(git config topgit.subjectprefix)" || subject_prefix="$subject_prefix "
>  	echo "Subject: [${subject_prefix}PATCH] $name"
>  	echo
> -- 
> tg: (2e5b885..) t/support-for-multiple-to-cc-bcc-options (depends on: master)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
