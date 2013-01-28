From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/4] mergetool--lib: Add functions for finding
 available tools
Date: Mon, 28 Jan 2013 19:37:00 +0000
Message-ID: <20130128193700.GB7498@serenity.lan>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
 <1359334346-5879-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 20:37:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzuWJ-0004ID-Iq
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 20:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551Ab3A1ThK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 14:37:10 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:42822 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab3A1ThI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 14:37:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 4FB9F22F7B;
	Mon, 28 Jan 2013 19:37:08 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id htWccrPzbOS8; Mon, 28 Jan 2013 19:37:07 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id BFE201FC46;
	Mon, 28 Jan 2013 19:37:07 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id B6587161E34E;
	Mon, 28 Jan 2013 19:37:07 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cOMosSQUu6Hr; Mon, 28 Jan 2013 19:37:07 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4E1E2161E3A4;
	Mon, 28 Jan 2013 19:37:02 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1359334346-5879-4-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214859>

On Sun, Jan 27, 2013 at 04:52:25PM -0800, David Aguilar wrote:
> Refactor show_tool_help() so that the tool-finding logic is broken out
> into a separate show_tool_names() function.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> filter_tools renamed to show_tool_names() and simplfied
> to use ls -1.  show_tool_names() now has a preamble as discussed.
> 
>  git-mergetool--lib.sh | 68 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index db3eb58..fe068f6 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -2,6 +2,35 @@
>  # git-mergetool--lib is a library for common merge tool functions
>  MERGE_TOOLS_DIR=$(git --exec-path)/mergetools
>  
> +mode_ok () {
> +	diff_mode && can_diff ||
> +	merge_mode && can_merge
> +}
> +
> +is_available () {
> +	merge_tool_path=$(translate_merge_tool_path "$1") &&
> +	type "$merge_tool_path" >/dev/null 2>&1
> +}
> +

Can we move show_tool_names() to be above show_tool_help()?  It's a
very minor nit but I prefer having related functionality grouped
together.

> +show_tool_names () {
> +	condition=${1:-true} per_line_prefix=${2:-} preamble=${3:-}

Would this be better with one value on each line?  Also perhaps
per_line_prefix -> line_prefix.

> +
> +	( cd "$MERGE_TOOLS_DIR" && ls -1 * ) |
> +	while read toolname
> +	do
> +		if setup_tool "$toolname" 2>/dev/null &&
> +			(eval "$condition" "$toolname")
> +		then
> +			if test -n "$preamble"
> +			then
> +				echo "$preamble"
> +				preamble=
> +			fi
> +			printf "%s%s\n" "$per_line_prefix" "$tool"

This needs to be:

    printf "$per_line_prefix%s\n" "$tool"

since $per_line_prefix is usually '\t\t' which isn't expanded if we
format it with %s - an alternative would be to change the value passed
in to '$TAB$TAB' with literal tabs.

> +		fi
> +	done
> +}
> +
>  diff_mode() {
>  	test "$TOOL_MODE" = diff
>  }
