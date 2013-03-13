From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] git-merge-one-file: revise merge error reporting
Date: Wed, 13 Mar 2013 10:57:26 -0700
Message-ID: <7vehfj2neh.fsf@alter.siamese.dyndns.org>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
 <1363137142-18606-1-git-send-email-kevin@bracey.fi>
 <1363137142-18606-3-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Wed Mar 13 18:57:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFpw3-0006Jg-OY
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 18:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933872Ab3CMR53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 13:57:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933043Ab3CMR52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 13:57:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7362BB85B;
	Wed, 13 Mar 2013 13:57:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lnoQRv7N63eSPrNcCLdZGEilTec=; b=yFuDzI
	81xca0lgRk+gU6pSmw8fRRY6vqP6Xb5l1EWjJR9qA14JUndT1DDUiZE+WM/ctNvE
	4L4W9NH7KaRo8bews58MGRyftV2rvt0M8j7CykkH240fuDRxOrryTaDAgLL4FZLd
	zThaIz04jrXqiU6vUM8jC0Ftuw99j6wi8OFWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XiG+8egRZeb6JmjtOhbSYfOnRgb7rq2E
	SLuLdBSfd1oigwmPkjm5edWvUq0yNBmfkfSmzs0ZNSWZTxXnH4l3memUD3Pr0vbJ
	h+CtIeYHBVN3oIK0ZeGyn6Z0VWrsEf9D5JaaxD+JwUZBNROnk7C2gYTXld+xzhEr
	pwHy+dyF4rs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6735FB85A;
	Wed, 13 Mar 2013 13:57:28 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C51A5B858; Wed, 13 Mar 2013
 13:57:27 -0400 (EDT)
In-Reply-To: <1363137142-18606-3-git-send-email-kevin@bracey.fi> (Kevin
 Bracey's message of "Wed, 13 Mar 2013 03:12:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77DCE4F4-8C07-11E2-B833-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218079>

Kevin Bracey <kevin@bracey.fi> writes:

> Commit 718135e improved the merge error reporting for the resolve
> strategy's merge conflict and permission conflict cases, but led to a
> malformed "ERROR:  in myfile.c" message in the case of a file added
> differently.
>
> This commit reverts that change, and uses an alternative approach without
> this flaw.
>
> Signed-off-by: Kevin Bracey <kevin@bracey.fi>
> ---
>  git-merge-one-file.sh | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> index 0f164e5..78b07a8 100755
> --- a/git-merge-one-file.sh
> +++ b/git-merge-one-file.sh
> @@ -104,11 +104,13 @@ case "${1:-.}${2:-.}${3:-.}" in
>  		;;
>  	esac
>  
> +	ret=0
>  	src1=$(git-unpack-file $2)
>  	src2=$(git-unpack-file $3)
>  	case "$1" in
>  	'')
> -		echo "Added $4 in both, but differently."
> +		echo "ERROR: Added $4 in both, but differently."
> +		ret=1

The problem you identified may be worth fixing, but I do not think
this change is correct.

This message is at the same severity level as the message on the
other arm of this case that says "Auto-merging $4".  In that other
case arm, we are attempting a true three-way merge, and in this case
arm, we are attempting a similar three-way merge using your "virtual
base".

Neither has found any error in this case arm yet.  The messages are
both "informational", not an error.  I do not think you would want
to set ret=1 until you see content conflict.
