From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/4] mergetool--lib: Add functions for finding
 available tools
Date: Tue, 29 Jan 2013 19:48:47 +0000
Message-ID: <20130129194846.GD1342@serenity.lan>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
 <1359334346-5879-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 20:49:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0HBF-0005iQ-BD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 20:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302Ab3A2Tsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 14:48:55 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:49309 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab3A2Tsy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 14:48:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id F093660656C;
	Tue, 29 Jan 2013 19:48:53 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yEAEHJ9mb0Vd; Tue, 29 Jan 2013 19:48:53 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 4F449606598;
	Tue, 29 Jan 2013 19:48:48 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1359334346-5879-4-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214964>

On Sun, Jan 27, 2013 at 04:52:25PM -0800, David Aguilar wrote:
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
> +show_tool_names () {
> +	condition=${1:-true} per_line_prefix=${2:-} preamble=${3:-}
> +
> +	( cd "$MERGE_TOOLS_DIR" && ls -1 * ) |

Is the '*' necessary here?  I would expect ls to list the current
directory if given no arguments, but perhaps some platforms behave
differently?

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
> +		fi
> +	done
> +}
> +
>  diff_mode() {
>  	test "$TOOL_MODE" = diff
>  }
> @@ -199,35 +228,21 @@ list_merge_tool_candidates () {
>  }
>  
>  show_tool_help () {
> -	unavailable= available= LF='
> -'
> -	for i in "$MERGE_TOOLS_DIR"/*
> -	do
> -		tool=$(basename "$i")
> -		setup_tool "$tool" 2>/dev/null || continue
> -
> -		merge_tool_path=$(translate_merge_tool_path "$tool")
> -		if type "$merge_tool_path" >/dev/null 2>&1
> -		then
> -			available="$available$tool$LF"
> -		else
> -			unavailable="$unavailable$tool$LF"
> -		fi
> -	done
> -
> -	cmd_name=${TOOL_MODE}tool
> +	tool_opt="'git ${TOOL_MODE}tool --tool-<tool>'"
> +	available=$(show_tool_names 'mode_ok && is_available' '\t\t' \
> +		"$tool_opt may be set to one of the following:")
> +	unavailable=$(show_tool_names 'mode_ok && ! is_available' '\t\t' \
> +		"The following tools are valid, but not currently available:")
>  	if test -n "$available"
>  	then
> -		echo "'git $cmd_name --tool=<tool>' may be set to one of the following:"
> -		echo "$available" | sort | sed -e 's/^/	/'
> +		echo "$available"
>  	else
>  		echo "No suitable tool for 'git $cmd_name --tool=<tool>' found."
>  	fi
>  	if test -n "$unavailable"
>  	then
>  		echo
> -		echo 'The following tools are valid, but not currently available:'
> -		echo "$unavailable" | sort | sed -e 's/^/	/'
> +		echo "$unavailable"
>  	fi
>  	if test -n "$unavailable$available"
>  	then

You haven't taken full advantage of the simplification Junio suggested
in response to v1 here.  We can change the "unavailable" block to be:

    show_tool_names 'mode_ok && ! is_available' "$TAB$TAB" \
        "${LF}The following tools are valid, but not currently available:"

If you also add a "not_found_msg" parameter to show_tool_names then the
"available" case is also simplified:

    show_tool_names 'mode_ok && is_available' "$TAB$TAB" \
        "$tool_opt may be set to one of the following:" \
        "No suitable tool for 'git $cmd_name --tool=<tool>' found."

with this at the end of show_tool_names:

    test -n "$preamble" && test -n "$not_found_msg" && \
        echo "$not_found_msg"


John
