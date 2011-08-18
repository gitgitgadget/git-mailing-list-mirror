From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] mergetools/meld: Use '--output' when available
Date: Thu, 18 Aug 2011 03:13:10 -0500
Message-ID: <20110818081309.GP31888@elie.gateway.2wire.net>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
 <1313652227-48545-5-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 10:13:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtxj6-0000Kr-KU
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 10:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755288Ab1HRINP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 04:13:15 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49001 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab1HRINO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 04:13:14 -0400
Received: by yxj19 with SMTP id 19so1307992yxj.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 01:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EWOrlxZJd0G/+MraQFqSMGJO/Em0oLFZEK+2D+bY77Q=;
        b=fjOnPPNflYykMDMzBrTb6iySDgfrEwKHX8SRGyY2edIBXrk073UkOrY3y+3hJ7J/WH
         NkeUQ9XByUn64YK52eTbPYS3M6rxyEK2pT+gkEye+f8sbRpIe9QFtSIGRZmW4/yRrIHZ
         gnfS4zam0Cv1cOqsNiPLIbWtbgEzQIDyBFhFU=
Received: by 10.42.202.73 with SMTP id fd9mr500509icb.22.1313655193165;
        Thu, 18 Aug 2011 01:13:13 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-105-3.dsl.chcgil.ameritech.net [68.255.105.3])
        by mx.google.com with ESMTPS id v16sm841500ibe.17.2011.08.18.01.13.11
        (version=SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 01:13:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313652227-48545-5-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179581>

David Aguilar wrote:

> use the '--output' option when available.

Yay. :)

> --- a/mergetools/meld
> +++ b/mergetools/meld
> @@ -4,6 +4,37 @@ diff_cmd () {
>  
>  merge_cmd () {
>  	touch "$BACKUP"
> -	"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> +	if test "$meld_has_output_option" = true
> +	then
> +		"$merge_tool_path" --output "$MERGED" \
> +			"$BASE" "$LOCAL" "$REMOTE"

Shouldn't this be "$LOCAL" "$BASE" "$REMOTE"?

> +	else
> +		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> +	fi
>  	check_unchanged

I wonder if the version test could be made a little simpler (perhaps
to cope better if future versions use a different numbering system):

	if "$merge_tool_path" --output /dev/null --help >/dev/null 2>&1
	then
		"$merge_tool_path" --output ...
	else
		"$merge_tool_path" "$LOCAL" ...
	fi

Forgive my ignorance: is this function likely to be called in a loop?
If so, it makes sense to precompute or cache the result of detection,
like you already do.

	check_meld_for_output_option () {
		if ...
		then
			meld_has_output_option=true
		else
			meld_has_output_option=false
		fi
	}

	merge_cmd () {
		if test -z "${meld_has_output_option:+set}"
		then
			check_meld_for_output_option
		fi

		if test "$meld_has_output_option" = true
		then
			...


[...]
> +	# Filter meld --version to contain numbers and dots only
> +	meld="$(meld --version 2>/dev/null | sed -e 's/[^0-9.]\+//g')"

\+ is not a BRE.  If parsing version numbers seems like the right
thing to do, maybe "tr -cd 0-9."?

> +	meld="${meld:-0.0.0}"
> +
> +	meld_major="$(expr "$meld" : '\([0-9]\{1,\}\)' || echo 0)"
> +	meld_minor="$(expr "$meld" : '[0-9]\{1,\}\.\([0-9]\{1,\}\)' || echo 0)"

I think git avoids \{m,n\} ranges where possible (for portability).
This could be:

	meld_major=${meld%%.*}
	meld_nonmajor=${meld#${meld_major}.}
	meld_minor=${meld_nonmajor%%.*}

or:

	case $meld in
	[2-9].* | [1-9][0-9]* | 1.[5-9]* | 1.[1-9][0-9]*)	# >= 1.5.0
		meld_has_output_option=true ;;
	*)
		meld_has_output_option=false ;;
	esac

It's nice how self-contained this can be now that it's in its own
file.  Thanks.
