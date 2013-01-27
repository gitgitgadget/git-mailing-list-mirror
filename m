From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/4] mergetool--lib: Add functions for finding available
 tools
Date: Sun, 27 Jan 2013 23:26:52 +0100
Message-ID: <5105A9AC.1040808@kdbg.org>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com> <1359321886-80523-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 23:27:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzah2-0000qc-J7
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 23:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739Ab3A0W0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 17:26:55 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:42432 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756580Ab3A0W0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 17:26:54 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 419F813004B;
	Sun, 27 Jan 2013 23:26:53 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C789E19F46B;
	Sun, 27 Jan 2013 23:26:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130105 Thunderbird/17.0.2
In-Reply-To: <1359321886-80523-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214741>

Am 27.01.2013 22:24, schrieb David Aguilar:
> Refactor show_tool_help() so that the tool-finding logic is broken out
> into separate functions.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool--lib.sh | 60 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index cf52423..894b849 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -2,6 +2,33 @@
>  # git-mergetool--lib is a library for common merge tool functions
>  MERGE_TOOLS_DIR=$(git --exec-path)/mergetools
>  
> +mode_ok () {
> +	diff_mode && can_diff ||
> +	merge_mode && can_merge
> +}

&& and || have the same precedence: if diff_mode and can_diff both are
"true", then the result of the function is that of can_merge. I don't
think that is what is intended.

> +filter_tools () {
> +	filter="$1"
> +	prefix="$2"
> +	(
> +		cd "$MERGE_TOOLS_DIR" &&
> +		for i in *
> +		do
> +			echo "$i"
> +		done

		cd "$MERGE_TOOLS_DIR" &&
		printf "%s\n" *

But what's wrong with "ls -1"? It would save the explicit sort.

> +	) | sort | while read tool
> +	do
> +		setup_tool "$tool" 2>/dev/null &&
> +		(eval "$filter" "$tool") &&
> +		printf "$prefix$tool\n"
> +	done
> +}

-- Hannes
