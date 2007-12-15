From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace the cryptic messages from "git stash show".
Date: Fri, 14 Dec 2007 22:12:32 -0800
Message-ID: <7v63z0o59r.fsf@gitster.siamese.dyndns.org>
References: <20071214012838.GA8914@fawkes>
	<7vir32xdn3.fsf@gitster.siamese.dyndns.org>
	<20071215051425.GA9118@fawkes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 07:13:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3QGo-0007M1-Or
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 07:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbXLOGMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 01:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbXLOGMo
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 01:12:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbXLOGMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 01:12:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ACBD27A1C;
	Sat, 15 Dec 2007 01:12:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1174F7A1A;
	Sat, 15 Dec 2007 01:12:33 -0500 (EST)
In-Reply-To: <20071215051425.GA9118@fawkes> (Jing Xue's message of "Sat, 15
	Dec 2007 00:14:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68377>

Jing Xue <jingxue@digizenstudio.com> writes:

> On Thu, Dec 13, 2007 at 05:34:40PM -0800, Junio C Hamano wrote:
>> 
>> I agree "git stash show" should not give cryptic error message, but I
>> think you should do this only when the user did not explicitly say which
>> stash to show (that is, we should still give error message if the user
>> said "git stash show garbage").
>
> Good point. Actually I found out that if there _are_ some stashes and an
> invalid name is given, the current behavior is still printing
> refs/stash, which I think is not quite right. So I also try to fix that
> while I'm at it.
>
> Now "git stash show" will keep quiet and just exit if there are no
> stashes at all. "git stash show some-non-existent-stash" will always
> print a clear message indicating the case.
>
> ---
>  git-stash.sh |   23 ++++++++++++++++++++---
>  1 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index f16fd9c..40e93dd 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -116,13 +116,30 @@ show_stash () {
>  	flags=$(git rev-parse --no-revs --flags "$@")
>  	if test -z "$flags"
>  	then
> -		flags=--stat
> +		diff_flags=--stat
> +	else
> +		diff_flags=$flags
> +	fi
> +	s=$(git rev-parse --revs-only --no-flags "$@")
> +	if test -z "$s"
> +	then
> +		arguments=$@
> +		if test "${flags}" = "${arguments}"
> +		then
> +			s=$(git rev-parse --revs-only --no-flags $ref_stash)
> +			if test -z "$s"
> +			then
> +				return 0
> +			fi
> +		else
> +			eval stash_name=\$$#
> +			die "Can't find any stash with name $stash_name"
> +		fi
>  	fi

Is it just me who feels that the added code is much worse than the
disease?
