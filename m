From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 14/14] difftool/mergetool: refactor commands to use
 git-mergetool--lib
Date: Wed, 08 Apr 2009 00:05:05 -0700
Message-ID: <7vr603pqvy.fsf@gitster.siamese.dyndns.org>
References: <1239172085-23389-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 09:08:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrRtR-0005RA-Lk
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 09:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761893AbZDHHFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 03:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761735AbZDHHFQ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 03:05:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761724AbZDHHFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 03:05:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EADC1D136;
	Wed,  8 Apr 2009 03:05:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F0886D135; Wed, 
 8 Apr 2009 03:05:06 -0400 (EDT)
In-Reply-To: <1239172085-23389-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Tue, 7 Apr 2009 23:28:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9AE35842-240B-11DE-B6A6-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116053>

David Aguilar <davvid@gmail.com> writes:

> This consolidates the common functionality from git-mergetool and
> git-difftool--helper into a single git-mergetool--lib scriptlet.
>
> +guess_merge_tool () {
> +	tools="ecmerge"
> +	if merge_mode; then
> +		tools="tortoisemerge"
> +	else
> +		tools="kompare"
> +	fi

The first assignment of ecmerge seems a no-op.

> +	if test -n "$DISPLAY"; then
> +		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
> +			tools="meld opendiff kdiff3 tkdiff xxdiff $tools \
> +				gvimdiff diffuse ecmerge"
> +		else
> +			tools="opendiff kdiff3 tkdiff xxdiff meld $tools \
> +				gvimdiff diffuse ecmerge"
> +		fi
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
> +	tools="$(echo "$tools" | sed -e 's/ 	*/ /g')"
> +	echo >&2 "merge tool candidates: $tools"

Sorry, but I am not sure what this is doing.  Replace a SP followed by
zero or more HT with a single SP?  

Ahh, you are removing the HT in the indentation part?

I'd rather see the above written like this if that is the case:

> +	if test -n "$DISPLAY"; then
> +		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
> +			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
> +		else
> +			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
> +		fi
> + 		tools="$tools gvimdiff diffuse ecmerge"
> +	fi

then you can lose the "echo | sed", no?
