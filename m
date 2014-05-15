From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 12/29] "guilt header": more robust header selection.
Date: Thu, 15 May 2014 18:46:58 -0400
Message-ID: <20140515224658.GA1334@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-13-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:46:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4QU-0001oh-Lt
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbaEOWqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:46:55 -0400
Received: from josefsipek.net ([64.9.206.49]:1703 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291AbaEOWqy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:46:54 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id E0BC955654;
	Thu, 15 May 2014 18:46:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-13-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249214>

On Tue, May 13, 2014 at 10:30:48PM +0200, Per Cederqvist wrote:
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
>  guilt-header | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/guilt-header b/guilt-header
> index 41e00cc..4701b31 100755
> --- a/guilt-header
> +++ b/guilt-header
> @@ -45,10 +45,32 @@ esac
>  [ -z "$patch" ] && die "No patches applied."
>  
>  # check that patch exists in the series
> -ret=`get_full_series | grep -e "^$patch\$" | wc -l`
> -if [ $ret -eq 0 ]; then
> -	die "Patch $patch is not in the series"
> +full_series=`get_tmp_file series`
> +get_full_series > "$full_series"
> +found_patch=
> +while read x; do
> +	if [ "$x" = "$patch" ]; then
> +		found_patch="$patch"
> +		break
> +	fi
> +done < "$full_series"

We have to use a temp file instead of a 'get_full_series | while read x; do ...'
because that'd create a subshell, correct?

> +if [ -z "$found_patch" ]; then
> +	TMP_MATCHES=`get_tmp_file series`
> +	grep "$patch" < "$full_series" > "$TMP_MATCHES"
> +	nr=`wc -l < $TMP_MATCHES`
> +	if [ $nr -gt 1 ]; then
> +		echo "$patch does not uniquely identify a patch. Did you mean any of these?" >&2
> +		sed 's/^/  /' "$TMP_MATCHES" >&2
> +		rm -f "$TMP_MATCHES"
> +		exit 1
> +	elif [ $nr -eq 0 ]; then
> +		rm -f "$TMP_MATCHES"
> +		die "Patch $patch is not in the series"
> +	fi
> +	found_patch=`cat $TMP_MATCHES`
> +	rm -f "$TMP_MATCHES"
>  fi
> +patch="$found_patch"

Do we not delete $full_series?

>  
>  # FIXME: warn if we're editing an applied patch
>  
> -- 
> 1.8.3.1
> 

-- 
OpenIndiana ibdm: 8 cores, 12 GB RAM
