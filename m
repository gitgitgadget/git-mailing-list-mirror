From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Fri, 17 Jan 2014 11:17:01 -0800
Message-ID: <xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
References: <20140117041430.GB19551@sigill.intra.peff.net>
	<20140117042153.GB23443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Yuri <yuri@rawbw.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 20:17:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4Eul-0001Ut-Mr
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 20:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbaAQTRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 14:17:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbaAQTRG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 14:17:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69B86629B5;
	Fri, 17 Jan 2014 14:17:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3AKFsVyV1aD+HszC4nua6jSmhoE=; b=NUvYpt
	94+q8q1nDGRatwKNRrOUPNK0+QD/Wu5G0yVa/AAjcZm7AX1IfRXNaqgom7ByUJSD
	6zf4iYC4lKk3ofjHoAGaN4zhxFx4aBtzVtalh1xwcMVupI4czZZ1vdfS9wuXZA02
	RNq1sU3iXO73O88PyzSuPoq8QwGRSK2KU/djA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mTRoYkXQflKElnF/uzbMxlTnA8aO94cD
	jCQA8TUwooN0uyqsc6wMlfMjk3qrowwPmBZy/wTDOaWu8uAcjXM29qcGoF0dvcBy
	7if5othej0i2szyc3iMyHamZN+y6oo5EsOVV7MY+AoWB0RKVo2Ezudyz5mYUOiPt
	S2iSrZbvP9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AB7A629B4;
	Fri, 17 Jan 2014 14:17:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6273629B2;
	Fri, 17 Jan 2014 14:17:04 -0500 (EST)
In-Reply-To: <20140117042153.GB23443@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jan 2014 23:21:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3324D18-7FAB-11E3-8B50-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240612>

Jeff King <peff@peff.net> writes:

> diff --git a/pager.c b/pager.c
> index 90d237e..2303164 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -87,6 +87,10 @@ void setup_pager(void)
>  		argv_array_push(&env, "LESS=FRSX");
>  	if (!getenv("LV"))
>  		argv_array_push(&env, "LV=-c");
> +#ifdef PAGER_MORE_UNDERSTANDS_R
> +	if (!getenv("MORE"))
> +		argv_array_push(&env, "MORE=R");
> +#endif
>  	pager_process.env = argv_array_detach(&env, NULL);
>  
>  	if (start_command(&pager_process))

Let me repeat from $gmane/240110:

 - Can we generalize this a bit so that a builder can pass a list
   of var=val pairs and demote the existing LESS=FRSX to just a
   canned setting of such a mechanism?

As we need to maintain this "set these environments when unset" here
and also in git-sh-setup.sh, I think it is about time to do that
clean-up.  Duplicating two settings was borderline OK, but seeing
the third added fairly soon after the second was added tells me that
the clean-up must come before adding the third.
