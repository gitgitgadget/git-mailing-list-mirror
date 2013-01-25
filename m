From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 7/7] mergetool--lib: Improve show_tool_help() output
Date: Fri, 25 Jan 2013 19:54:46 +0000
Message-ID: <20130125195446.GA7498@serenity.lan>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-8-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 20:55:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TypMt-0000LJ-4t
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 20:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab3AYTy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 14:54:57 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:46269 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab3AYTy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 14:54:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 82A2322FAF;
	Fri, 25 Jan 2013 19:54:55 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11mLScW9ZulE; Fri, 25 Jan 2013 19:54:54 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id EA91922FC4;
	Fri, 25 Jan 2013 19:54:53 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id BFE9F161E4E3;
	Fri, 25 Jan 2013 19:54:53 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Ol-2ht49wrn; Fri, 25 Jan 2013 19:54:53 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 50FBF161E279;
	Fri, 25 Jan 2013 19:54:48 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1359107034-14606-8-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214573>

On Fri, Jan 25, 2013 at 01:43:54AM -0800, David Aguilar wrote:
> Check the can_diff and can_merge functions before deciding whether to
> add the tool to the available/unavailable lists.  This makes --tool-help context-
> sensitive so that "git mergetool --tool-help" displays merge tools only
> and "git difftool --tool-help" displays diff tools only.

This log message is misleading - the existing code in
list_merge_tool_candidates already filters the tools like this, so the
change is more:

    mergetool--lib: don't use a hardcoded list for "--tool-help"

    Instead of using a list of tools in list_merge_tool_candidates, list
    the available scriptlets and query each of those to know whether it
    applies to diff mode and/or merge mode.

    guess_merge_tool still relies on list_merge_tool_candidates so we
    can't remove that function now.


The patch seems to do the right thing, although I have a couple of minor
nits...

> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool--lib.sh | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index db8218a..c547c59 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -168,17 +168,33 @@ list_merge_tool_candidates () {
>  }
>  
>  show_tool_help () {
> -	list_merge_tool_candidates
>  	unavailable= available= LF='
>  '
> -	for i in $tools
> +
> +	scriptlets="$(git --exec-path)"/mergetools
> +	for i in "$scriptlets"/*
>  	do
> -		merge_tool_path=$(translate_merge_tool_path "$i")
> +		. "$scriptlets"/defaults
> +		. "$i"
> +
> +		tool="$(basename "$i")"

Quotes are unnecessary here.

> +		if test "$tool" = "defaults"
> +		then
> +			continue
> +		elif merge_mode && ! can_merge
> +		then
> +			continue
> +		elif diff_mode && ! can_diff
> +		then
> +			continue
> +		fi

Would this be better as:

    test "$tool" = "defaults" && continue

    can_merge || ! merge_mode || continue
    can_diff || ! diff_mode || continue

or is that a bit too concise?

I'd prefer to see two separate if statements either way since the "test
$tool = defaults" case is different from the "does it apply to the
current mode?" case.  The "$tool = defaults" case could even move to the
top of the loop.

> +		merge_tool_path=$(translate_merge_tool_path "$tool")
>  		if type "$merge_tool_path" >/dev/null 2>&1
>  		then
> -			available="$available$i$LF"
> +			available="$available$tool$LF"
>  		else
> -			unavailable="$unavailable$i$LF"
> +			unavailable="$unavailable$tool$LF"
>  		fi
>  	done
