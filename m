From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] mergetool--lib: Add functions for finding available
 tools
Date: Sun, 27 Jan 2013 15:32:41 -0800
Message-ID: <7v8v7ecicm.fsf@alter.siamese.dyndns.org>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
 <1359321886-80523-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 00:33:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzbir-0003t1-Tu
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 00:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab3A0Xcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 18:32:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044Ab3A0Xco (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 18:32:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92510C53C;
	Sun, 27 Jan 2013 18:32:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/8iQgNQ6JBMh4/cz4lEFyq0AfyY=; b=vT/SkF
	eB3UHl2gkqKOxiz7oUtFl8avl8iN+pgNfh0ISBxGMyPr76ZDiHUIUhg5ep/z2/Qd
	1s7RjhEHYInmTpeqk+RCPW8sVmdknDEdX3KGugKDLWgUHUybVVgQkivB40DwI4+e
	plqZ5vJsl0aR2faoDghbGnP34L8ncV8/17ljQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eNApFHPQZuCpgeWomsf6UiNJbp+t5dwG
	tXsxCpRYH7smbmvCR0Ht2y7HtL0Xh5YCr/C9RvhGsZx8BTAqiQ0X9W09ZGl+Bi9e
	aWIBW3auhuI8Cm2v2ezkijhHT4p/ZfbcD0Eb9kQOQeqbBo0ADYcvyUfbGqWGli5+
	Qkrbq8yUOfY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 851ABC53A;
	Sun, 27 Jan 2013 18:32:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFD33C536; Sun, 27 Jan 2013
 18:32:42 -0500 (EST)
In-Reply-To: <1359321886-80523-4-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 27 Jan 2013 13:24:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8BC837A-68D9-11E2-92FA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214752>

David Aguilar <davvid@gmail.com> writes:

> +filter_tools () {
> +	filter="$1"
> +	prefix="$2"
> +	(
> +		cd "$MERGE_TOOLS_DIR" &&
> +		for i in *
> +		do
> +			echo "$i"
> +		done
> +	) | sort | while read tool
> +	do
> +		setup_tool "$tool" 2>/dev/null &&
> +		(eval "$filter" "$tool") &&
> +		printf "$prefix$tool\n"
> +	done
> +}
> +
>  diff_mode() {
>  	test "$TOOL_MODE" = diff
>  }
> @@ -199,27 +226,13 @@ list_merge_tool_candidates () {
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
>  	cmd_name=${TOOL_MODE}tool
> +	available=$(filter_tools 'mode_ok && is_available' '\t\t')
> +	unavailable=$(filter_tools 'mode_ok && ! is_available' '\t\t')
>  	if test -n "$available"
>  	then
>  		echo "'git $cmd_name --tool=<tool>' may be set to one of the following:"
> -		echo "$available" | sort | sed -e 's/^/	/'
> +		printf "$available"

This may happen to be safe as available will not have anything with
a per-cent % in it, but is not a good discipline in general.

	printf "%s" "$available"

If you are giving filter_tools an optional "prefix-per-line", I do
not think it is too much of a stretch to introduce another optional
"perfix for the whole thing" and let this call site say something
like this:

	cmd_name=${TOOL_MODE}tool
	show_tool_names 'mode_ok && is_available' '\t\t' \
		"'git $cmd_name --tool=<tool>' may be set to one of these:"
	show_tool_names 'mode_ok && !is_available' '\t\t' \
		"These are valid but not available:"

without any of the above logic (and the same for unav).  It may look like this:

show_tool_names () {
	condition=${1?condition} per_line_prefix=${2:-} preamble=${3:-}

        ( cd "$MERGE_TOOLS_DIR && ls -1 * ) |
	while read toolname
	do
		if setup_tool "$toolname" 2>/dev/null && (eval "$condition")
		then
			if test -n "$preamble"
			then
				echo "$preamble"
				preamble=
			fi
                        printf "%s%s\n" "$prefix" "$toolname"
		fi
	done
}
