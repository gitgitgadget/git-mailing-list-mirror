From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v3 12/31] "guilt header": more robust header selection.
Date: Fri, 16 May 2014 11:22:40 -0400
Message-ID: <20140516152240.GE1770@meili.valhalla.31bits.net>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
 <1400251578-17221-13-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri May 16 17:22:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJy6-0000Uh-QF
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 17:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbaEPPWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 11:22:33 -0400
Received: from josefsipek.net ([64.9.206.49]:1590 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932760AbaEPPWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 11:22:32 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 1AC3855654;
	Fri, 16 May 2014 11:22:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400251578-17221-13-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249346>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, May 16, 2014 at 04:45:59PM +0200, Per Cederqvist wrote:
> If you run something like "guilt header '.*'" the command would crash,
> because the grep comand that tries to ensure that the patch exist
> would detect a match, but the later code expected the match to be
> exact.
> 
> Fixed by comparing exact strings.
> 
> And as a creeping feature "guilt header" will now try to use the
> supplied patch name as an unachored regexp if no exact match was
> found.  If the regexp yields a unique match, it is used; if more than
> one patch matches, the names of all patches are listed and the command
> fails.  (Exercise left to the reader: generalized this so that "guilt
> push" also accepts a unique regular expression.)
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-header | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/guilt-header b/guilt-header
> index 41e00cc..c3d24f9 100755
> --- a/guilt-header
> +++ b/guilt-header
> @@ -45,10 +45,33 @@ esac
>  [ -z "$patch" ] && die "No patches applied."
>  
>  # check that patch exists in the series
> -ret=`get_full_series | grep -e "^$patch\$" | wc -l`
> -if [ $ret -eq 0 ]; then
> -	die "Patch $patch is not in the series"
> +TMP_FULL_SERIES=`get_tmp_file series`
> +get_full_series > "$TMP_FULL_SERIES"
> +found_patch=
> +while read x; do
> +	if [ "$x" = "$patch" ]; then
> +		found_patch="$patch"
> +		break
> +	fi
> +done < "$TMP_FULL_SERIES"
> +if [ -z "$found_patch" ]; then
> +	TMP_MATCHES=`get_tmp_file series`
> +	grep "$patch" < "$TMP_FULL_SERIES" > "$TMP_MATCHES"
> +	nr=`wc -l < $TMP_MATCHES`
> +	if [ $nr -gt 1 ]; then
> +		echo "$patch does not uniquely identify a patch. Did you mean any of these?" >&2
> +		sed 's/^/  /' "$TMP_MATCHES" >&2
> +		rm -f "$TMP_MATCHES" "$TMP_FULL_SERIES"
> +		exit 1
> +	elif [ $nr -eq 0 ]; then
> +		rm -f "$TMP_MATCHES" "$TMP_FULL_SERIES"
> +		die "Patch $patch is not in the series"
> +	fi
> +	found_patch=`cat $TMP_MATCHES`
> +	rm -f "$TMP_MATCHES"
>  fi
> +rm -f "$TMP_FULL_SERIES"
> +patch="$found_patch"
>  
>  # FIXME: warn if we're editing an applied patch
>  
> -- 
> 1.8.3.1
> 

-- 
Failure is not an option,
It comes bundled with your Microsoft product.
