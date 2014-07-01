From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix filter-branch to eliminate duplicate mapped parents
Date: Tue, 01 Jul 2014 08:03:46 -0700
Message-ID: <xmqqmwctxgrx.fsf@gitster.dls.corp.google.com>
References: <1404163227-30962-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 17:04:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1zbF-0007Pr-6t
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 17:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756936AbaGAPD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 11:03:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65167 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbaGAPD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 11:03:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC08F24EA6;
	Tue,  1 Jul 2014 11:03:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FarrfF8x+k4ov1rImhM5OhrgAsE=; b=NGIyXD
	9hgor8DZyexO3uvSG3hFd4YCqLHPWQrdGvtaZuYkER1JkJHnkLYP6Oe2LGn9+Lqx
	Pp+QE5gePoaNbUAv/qirx4vrqIqaFNFazZg6ZIQzrhouaPjZ5CwvX2LHxjAFYvjM
	8IO4LADnobN6cWMR7jjI3XpJrUcO1xzbEB0oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=COa46JMBr9udLP6wYJiYpAubKUCqyuGf
	/Ti6JG80duK2+UDVWJKKPXz+k86Geti0KJxLrJpDjoKZscS2HcEnuQ3RGQ1cgbr9
	dyWe0Q66O89fybFalGWDbM/2WeGmHa1VoeDpP0CWMeARoN/3Ye2eck5jzeUl35Xo
	OU9Gydu4f14=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B2F3924EA5;
	Tue,  1 Jul 2014 11:03:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 95EFF24E9B;
	Tue,  1 Jul 2014 11:03:38 -0400 (EDT)
In-Reply-To: <1404163227-30962-1-git-send-email-charles@hashpling.org>
	(Charles Bailey's message of "Mon, 30 Jun 2014 22:20:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1CD4E36-0130-11E4-9633-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252720>

Charles Bailey <charles@hashpling.org> writes:

> I worked on this after discovering that --prune-empty often left some
> apparently empty commits that I was wasn't expecting it to leave and
> that running filter-branch --prune-empty in a loop would often do many
> passes where it was still pruning empty former merge commits.

Good find.

>
> The test is a simple example of such a case. A non-ff merge of a commit
> that only changes a file that is to be pruned gets squashed into an
> empty non-merge commit that should be pruned.
>
>  git-filter-branch.sh     |  8 +++++++-
>  t/t7003-filter-branch.sh | 11 +++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 86d6994..c5b82a8 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -332,7 +332,13 @@ while read commit parents; do
>  	parentstr=
>  	for parent in $parents; do
>  		for reparent in $(map "$parent"); do
> -			parentstr="$parentstr -p $reparent"
> +			case "$parentstr" in
> +				*" -p $reparent"*)
> +					;;
> +				*)
> +					parentstr="$parentstr -p $reparent"
> +					;;
> +			esac

The case arms seem to be indented one level too deep; I'll fix it up
locally when queuing, so no need to resend.


Thanks.
