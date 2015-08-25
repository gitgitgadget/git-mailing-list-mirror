From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple estimated time remaning
Date: Tue, 25 Aug 2015 11:33:49 -0700
Message-ID: <xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
	<20150825171238.GB9674@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Gabor Bernat <bernat@primeranks.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 20:34:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUJ2h-0004aV-Tb
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 20:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603AbbHYSdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 14:33:51 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35265 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbHYSdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 14:33:51 -0400
Received: by pacdd16 with SMTP id dd16so131968967pac.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Yu5ECWRhZ6xFBo1tyO7fMb0b2JFAKpG6iG8GWKQIm0s=;
        b=yXVtlLLkhENKnQXGkCrlFiMmp0o6Xmwuw8FRhcF23PPrRGdz/EP2YKLQtmf0b8S/ED
         Iym3XubTRAe+mmw+27hwZKGkT19/uFtnSqhb4ZsCWYN48t28jUuCERShIJzEGPAtiDlY
         WBy1V/e1ifTwI4vpXlJ4glV538lBHsyALlfm+kXHw5qJF0oixz2Y7m6yPktdzlH/7Td+
         AOaf1CC39YUbwM9OrDI130wH6IH+VvQxKtsIkhHDiKAyhu8pPK9Pz6OGCpYVIzIS44QE
         4QtpEMhtLlfypQIgWcIeS+rnDPKrN8vOp7yBso6xLYnG3rEuapT1V7dCFDrVcB1YtyBm
         9POw==
X-Received: by 10.68.254.99 with SMTP id ah3mr58722612pbd.15.1440527630628;
        Tue, 25 Aug 2015 11:33:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id iw8sm21840806pbc.21.2015.08.25.11.33.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 11:33:49 -0700 (PDT)
In-Reply-To: <20150825171238.GB9674@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 25 Aug 2015 13:12:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276556>

Jeff King <peff@peff.net> writes:

> +start=$(date +%s)

Is that a GNU extension?

>  git_filter_branch__commit_count=0
>  while read commit parents; do
>  	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
> -	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)"
> +	now=$(date +%s)
> +	elapsed=$(($now - $start))
> +	# work in integer percentages as a sort of fixed-point
> +	pct=$(($git_filter_branch__commit_count * 100 / $commits))
> +	if test $pct -eq 0; then
> +		remain=
> +	else
> +		eta=$(($elapsed * 100 / $pct))
> +		remain="($(($eta - $elapsed)) seconds remaining)   "
> +	fi
> +	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits) $remain"
>  
>  	case "$filter_subdir" in
>  	"")
>
> but the time jumps around early on because of the lack of precision. And
> of course there's no smoothing, and no emphasis on recent history versus
> the whole operation. I'll leave those as an exercise to the reader. :)

;-)

An alternative implementation may be to ask `date` every 1000
commits (or whatever sufficiently large value that we can amortise
the cost) to measure the rate and compute $remain based on that
measurement.  That way, we can afford to use more portable ways to
ask `date` about the current time and compute the "how many seconds"
ourselves.
