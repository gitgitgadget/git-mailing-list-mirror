From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] Add sample pre-push hook script
Date: Mon, 14 Jan 2013 09:42:13 -0800
Message-ID: <7vobgrek5m.fsf@alter.siamese.dyndns.org>
References: <1358054224-7710-1-git-send-email-aaron@schrab.com>
 <1356735452-21667-1-git-send-email-aaron@schrab.com>
 <1358054224-7710-4-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 18:42:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuo3R-0008E3-LT
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 18:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757639Ab3ANRmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 12:42:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756798Ab3ANRmP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 12:42:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74D82CACA;
	Mon, 14 Jan 2013 12:42:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nalilnCIhojB1FdeZPLZFMotwVA=; b=dFaVSa
	K4c3OqcN9GH+koj2k95pT8TDmV6czOQsYlP4e+9UxBo4cF0j4ohc7Y4f2eambJxE
	3y/GZXMqMXZF+OFUxmArgfhtpptirpsUhb+CpNT6p2bsA3P+25hjrg60L7y4bCrT
	uqWKIYFUB4YnrMA3zUFe1rnC9KYQtTYdV7+j0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eISAsFjNcrcAehpUbql2murNyD+1kePk
	2WQyiGtmrIBqAmY5/aU1SMyP52AJUGE56yw53ufSFGhTHrVTkR6hfaG1WPRrzJNV
	FPPWl3Z7ZhzzqZ+wYyItEWtVAgtVvnVpYexFbIV9fw01Ytd78oj1X4bF4A5VlRy0
	/Jgw1FywQ1s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69025CAC8;
	Mon, 14 Jan 2013 12:42:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1404CAC6; Mon, 14 Jan 2013
 12:42:14 -0500 (EST)
In-Reply-To: <1358054224-7710-4-git-send-email-aaron@schrab.com> (Aaron
 Schrab's message of "Sun, 13 Jan 2013 00:17:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBB3F474-5E71-11E2-8049-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213505>

Aaron Schrab <aaron@schrab.com> writes:

> Create a sample of a script for a pre-push hook.  The main purpose is to
> illustrate how a script may parse the information which is supplied to
> such a hook.  The script may also be useful to some people as-is for
> avoiding to push commits which are marked as a work in progress.
>
> Signed-off-by: Aaron Schrab <aaron@schrab.com>
> ---
>  templates/hooks--pre-push.sample | 53 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 templates/hooks--pre-push.sample
>
> diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
> new file mode 100644
> index 0000000..15ab6d8
> --- /dev/null
> +++ b/templates/hooks--pre-push.sample
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +
> +# An example hook script to verify what is about to be pushed.  Called by "git
> +# push" after it has checked the remote status, but before anything has been
> +# pushed.  If this script exits with a non-zero status nothing will be pushed.
> +#
> +# This hook is called with the following parameters:
> +#
> +# $1 -- Name of the remote to which the push is being done
> +# $2 -- URL to which the push is being done
> +#
> +# If pushing without using a named remote those arguments will be equal.
> +#
> +# Information about the commits which are being pushed is supplied as lines to
> +# the standard input in the form:
> +#
> +#   <local ref> <local sha1> <remote ref> <remote sha1>
> +#
> +# This sample shows how to prevent push of commits where the log message starts
> +# with "WIP" (work in progress).

An example for a plausible use case is nice to have.  I would prefer
to see any new shell script to follow the Git style, though.

> +remote="$1"
> +url="$2"
> +
> +z40=0000000000000000000000000000000000000000
> +
> +IFS=' '
> +while read local_ref local_sha remote_ref remote_sha
> +do
> +	if [ "$local_sha" = $z40 ]
> +	then
> +		# Handle delete

    ... by doing what?

> +	else
> +		if [ "$remote_sha" = $z40 ]
> +		then
> +			# New branch, examine all commits
> +			range="$local_sha"
> +		else
> +			# Update to existing branch, examine new commits
> +			range="$remote_sha..$local_sha"
> +		fi
> +
> +		# Check for WIP commit
> +		commit=`git rev-list -n 1 --grep '^WIP' "$range"`
> +		if [ -n "$commit" ]
> +		then
> +			echo "Found WIP commit in $local_ref, not pushing"
> +			exit 1
> +		fi
> +	fi
> +done
> +
> +exit 0
