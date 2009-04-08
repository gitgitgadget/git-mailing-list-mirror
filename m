From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v4 14/14] difftool/mergetool: refactor commands to use git-mergetool--lib
Date: Wed, 8 Apr 2009 07:33:00 +0200
Message-ID: <200904080733.01030.markus.heidelberg@web.de>
References: <1239145213-76701-1-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, charles@hashpling.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 07:34:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrQQi-00089Z-Hq
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 07:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399AbZDHFco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 01:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754293AbZDHFcn
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 01:32:43 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35400 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbZDHFcn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 01:32:43 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4F045FCA4A1F;
	Wed,  8 Apr 2009 07:32:41 +0200 (CEST)
Received: from [89.59.73.185] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LrQOv-0006eQ-00; Wed, 08 Apr 2009 07:32:41 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1239145213-76701-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18THnnvLeMOJm5zjm/TjWRjp1Yc28clHR1Kel7J
	faKMVe0XagJ1uxhM7rDbzw2pbxiynOdvTpYDUDxLIeFTw2PHg0
	YsYQRIyctNwH02z9vmPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116037>

David Aguilar, 08.04.2009:
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh

> +guess_merge_tool () {
> +	tools="ecmerge"
> +	if merge_mode; then
> +		tools="$tools tortoisemerge"

ecmerge can now go to the block after "test -n $DISPLAY", so that in
this if-then-else really only merge-only and diff-only tools are
handled.
Then here it is
+		tools="tortoisemerge"

> +	else
> +		kompare="kompare"

and here
+		tools="kompare"

> +	fi
> +	if test -n "$DISPLAY"; then
> +		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
> +			tools="meld opendiff kdiff3 $kompare tkdiff $tools"
> +			tools="$tools xxdiff gvimdiff diffuse"
> +		else
> +			tools="opendiff kdiff3 $kompare tkdiff xxdiff $tools"
> +			tools="$tools meld gvimdiff diffuse"
> +		fi

And above ecmerge
And now that we remove the duplicated spaces afterwards anyway, we can
get rid of the double tools= and continue the line with \
if we adjust the sed command below...

> +	fi
> +	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
> +		# $EDITOR is emacs so add emerge as a candidate
> +		tools="$tools emerge vimdiff"
> +	elif echo "${VISUAL:-$EDITOR}" | grep vim > /dev/null 2>&1; then
> +		# $EDITOR is vim so add vimdiff as a candidate
> +		tools="$tools vimdiff emerge"
> +	else
> +		tools="$tools emerge vimdiff"
> +	fi
> +	tools="$(echo "$tools" | sed -e 's/ +/ /g')"

Doesn't work for me. For me 's/ \+/ /g' works.

...like this: 's/[ 	]\+/ /g' (space and tab)

OK, for clarification now:
	if merge_mode; then
		tools="tortoisemerge"
	else
		tools="kompare"
	fi
	if test -n "$DISPLAY"; then
		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
			tools="meld opendiff kdiff3 tkdiff xxdiff $tools \
				gvimdiff diffuse ecmerge"
		else
			tools="opendiff kdiff3 tkdiff xxdiff meld $tools \
				gvimdiff diffuse ecmerge"
		fi
	fi
	[...]
	tools="$(echo "$tools" | sed -e 's/[ 	]\+/ /g')"

> +	echo >&2 "merge tool candidates: $tools"
> +
> +	# Loop over each candidate and stop when a valid merge tool is found.
> +	for i in $tools
> +	do
> +		merge_tool_path="$(translate_merge_tool_path "$i")"
> +		if type "$merge_tool_path" > /dev/null 2>&1; then
> +			merge_tool="$i"
> +			break
> +		fi
> +	done
> +
> +	if test -z "$merge_tool" ; then
> +		echo >&2 "No known merge resolution program available."
> +		return 1
> +	fi
> +	echo "$merge_tool"
> +}

Looks good to me, after these last 2 issues are adjusted.
Maybe resend the whole series then, so that Junio can apply them easily?

Markus
