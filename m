From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 07/29] Added test cases for "guilt fold".
Date: Tue, 13 May 2014 17:30:24 -0400
Message-ID: <20140513213024.GF4791@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-8-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:30:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkKHH-0001cc-8m
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbaEMVaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:30:20 -0400
Received: from josefsipek.net ([64.9.206.49]:1724 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753463AbaEMVaS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:30:18 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 76B1A55654;
	Tue, 13 May 2014 17:30:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-8-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248860>

On Tue, May 13, 2014 at 10:30:43PM +0200, Per Cederqvist wrote:
> Test that we can combine any combination of patches with empty and
> non-empty messages, both with and without guilt.diffstat.  (All
> patches are empty.)
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/t-035.out | 467 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  regression/t-035.sh  |  62 +++++++
>  2 files changed, 529 insertions(+)
>  create mode 100644 regression/t-035.out
>  create mode 100755 regression/t-035.sh
>
...
> diff --git a/regression/t-035.sh b/regression/t-035.sh
> new file mode 100755
> index 0000000..e914b32
> --- /dev/null
> +++ b/regression/t-035.sh
> @@ -0,0 +1,62 @@
> +#!/bin/bash
> +#
> +# Test the fold code
> +#
> +
> +source "$REG_DIR/scaffold"
> +
> +cmd setup_repo
> +
> +function fixup_time_info
> +{
> +	cmd guilt pop
> +	touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
> +	cmd guilt push
> +}
> +
> +function empty_patch
> +{
> +	cmd guilt new "empty$1"
> +	fixup_time_info "empty$1"
> +}
> +
> +function nonempty_patch
> +{
> +	if [ "$1" = -2 ]; then
> +		msg="Another commit message."
> +	else
> +		msg="A commit message."
> +	fi
> +
> +	cmd guilt new -f -s -m "$msg" "nonempty$1"
> +	fixup_time_info "nonempty$1"
> +}
> +
> +for using_diffstat in true false; do
> +	cmd git config guilt.diffstat $using_diffstat
> +	for patcha in empty nonempty; do
> +		for patchb in empty nonempty; do
> +
> +			if [ $patcha = $patchb ]
> +			then

I know that this is before patch 29, but ... style? ;)

Otherwise, looks good.  I like this way better than the unrolled loop in v1
of this patch.

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>


> +				suffixa=-1
> +				suffixb=-2
> +			else
> +				suffixa=
> +				suffixb=
> +			fi
> +
> +			echo "%% $patcha + $patchb (diffstat=$using_diffstat)"
> +			${patcha}_patch $suffixa
> +			${patchb}_patch $suffixb
> +			cmd guilt pop
> +			cmd guilt fold $patchb$suffixb
> +			fixup_time_info $patcha$suffixa
> +			cmd list_files
> +			cmd guilt pop
> +			cmd guilt delete -f $patcha$suffixa
> +			cmd list_files
> +
> +		done
> +	done
> +done
> -- 
> 1.8.3.1
> 

-- 
*NOTE: This message is ROT-13 encrypted twice for extra protection*
