From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing git pull error message
Date: Mon, 05 Oct 2009 12:08:38 -0700
Message-ID: <7vljjpacax.fsf@alter.siamese.dyndns.org>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org> <4AC9D952.3050108@viscovery.net>
 <20091005115308.GA2122@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 21:11:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Musxf-0004vg-Qe
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 21:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbZJETJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 15:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752967AbZJETJa
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 15:09:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbZJETJa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 15:09:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 91DE14D8FA;
	Mon,  5 Oct 2009 15:08:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZWEqo2yShyweRXYe1xWAvkTCLAo=; b=ClQgmNrrF4o7FLFjBDxGeoM
	ug+mH7FuZ34ZLEw04Zjl6RsCxv3/Zr8oQ5exSm1j6Nr0LhiSzYnLSl/g4Nn4OMoX
	EzQkJBNH/tRcDKH7jxDwVf0aODFwP2g6a68HBCDXnCeoadJxTa6MEIhPvoDralQb
	sLxZfuIdcrqndA4W/HgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=qEFPFez9Lbj3OoIu7ScoggYUO0lt9+tH21v56djdLkeFJLifY
	Vdr4zvePZf2hTB50XlMqZ12oh7odawwzbV/Dj2Sozxsi8TtASKyYJruzwkvJ92O5
	XlPddCd1bDCmMc3lu3EtE25ajzETGAKxjN5dixJSHyrcsQh94Evo4qq3W4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 547CA4D8F9;
	Mon,  5 Oct 2009 15:08:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 783C24D8F4; Mon,  5 Oct
 2009 15:08:39 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 806F4EDE-B1E2-11DE-B85A-92E639D9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129578>

Jeff King <peff@peff.net> writes:

> So I think we need something like this. I wasn't able to figure out a
> test case to trigger the first code path below, though. It may not be
> possible; if we give a refspec on the command line, either it will be a
> candidate for merging or, if it does not exist, fetch will barf. So it
> may be that we can just collapse it down to a single case.

I think you are right.

By the way, I think the other case arms in the case statement that has the
sole caller of this function are never reached, no?

Back when you added the check in a74b170 (git-pull: disallow implicit
merging to detached HEAD, 2007-01-15), $? referred to the error status of
reading HEAD as a symbolic-ref so the check did make sense, but cd67e4d
(Teach 'git pull' about --rebase, 2007-11-28) made a stupid mistake that
nobody noticed.

> diff --git a/git-pull.sh b/git-pull.sh
> index edf3ce3..a831db5 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -97,6 +97,18 @@ error_on_no_merge_candidates () {
>  		echo "Please specify which branch you want to merge on the command"
>  		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
>  		echo "See git-pull(1) for details."
> +	elif [ -n "$1" ]; then
> +		if [ $# -gt 1 ]; then
> +			echo "You asked to pull from the remote '$1', but none"
> +			echo "of the things you asked to fetch were candidates"
> +			echo "for merging."
> +		else
> +			echo "You asked to pull from the remote '$1', but did"
> +			echo "not specify a branch to merge. Because this is"
> +			echo "not the default configured remote for your current"
> +			echo "branch, you must specify a branch on the command"
> +			echo "line."
> +		fi
>  	elif [ -z "$upstream" ]; then
>  		echo "You asked me to pull without telling me which branch you"
>  		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
>
