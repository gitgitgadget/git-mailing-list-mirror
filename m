From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v7 6/9] submodule: fix detection of invalid submodule
 URL
Date: Mon, 28 May 2012 21:01:18 +0200
Message-ID: <4FC3CB7E.6000501@kdbg.org>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com> <1338132851-23497-7-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com,
	phil.hord@gmail.com, ramsay@ramsay1.demon.co.uk
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 21:01:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ5CZ-0005Wy-5f
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 21:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab2E1TBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 15:01:20 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:22290 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711Ab2E1TBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 15:01:20 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2A2D4A7EB5;
	Mon, 28 May 2012 21:03:03 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4BC3619F5E3;
	Mon, 28 May 2012 21:01:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <1338132851-23497-7-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198713>

Am 27.05.2012 17:34, schrieb Jon Seymour:
> diff --git a/git-submodule.sh b/git-submodule.sh
> index dbbc905..2550681 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -37,23 +37,42 @@ resolve_relative_url ()
>  	remoteurl=$(git config "remote.$remote.url") ||
>  		remoteurl=$(pwd) # the repository is its own authoritative upstream
>  	url="$1"
> -	remoteurl=${remoteurl%/}
> -	sep=/
> +	remoteurl="${remoteurl%/}"
> +
> +	case "$remoteurl" in
> +		*//*/*)
> +			variant="${remoteurl#*//*/}"
> +		;;
> +		*::*)
> +			variant="${remoteurl#*::}"
> +		;;
> +		*:*)
> +			variant="${remoteurl#*:}"
> +		;;
> +		/*)
> +			variant="${remoteurl#/}"

Without understanding in detail what this series is about, I would guess
that the previous two case arms are not very Windows friendly. Does the
right thing happen when $remoteurl is "c:/path/to/remote"? Would it help
to use is_absolute_path?

	if is_absolute_path "$remoteurl"
	then
		variant="${remoteurl#*/}"
	else
		case "$remoteurl" in
		...other cases go here...
		esac
	fi

-- Hannes
