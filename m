From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Mon, 14 Sep 2015 12:35:55 -0700
Message-ID: <xmqqzj0ovlno.fsf@gitster.mtv.corp.google.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 21:36:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbZXn-0006d0-0y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 21:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbbINTf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 15:35:58 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33190 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbbINTf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 15:35:57 -0400
Received: by pacex6 with SMTP id ex6so152413883pac.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+3tmHvlfHLMdkqJYT+o1FgPXWed4cQ2spnSbFLvzS18=;
        b=wanilofxuztdEYyFYipIabmTxSLcEjp7+t400hAaZUOJc4sB/5LVb4Z0X160ngPMJH
         cDPlhzWHupbZ5vK3fRsOiVa0Nhr1BD4TK9wVkI9lVkbKUkSN2Kl22+rKff9gBfy1eUma
         3kXJx8XwdGhWb7JFTD4LDcCRmGu57MQzVUwSIUlxKglbPlnGZdgD63U7aUPwrexxk+6T
         RkUYTX9+VrCVPqklC1BMdF0jp7effbXWNRM/qtWKsWTELqAjy0dSPuR1SSBlrsJPaZjN
         W/FRcDb2lkWVOOIpItzQEgkuVGYgxalIQzlfv/20GHyCgtt6EOeAyDti2FZLrTx/sf4J
         nVkw==
X-Received: by 10.68.137.202 with SMTP id qk10mr38154528pbb.30.1442259357263;
        Mon, 14 Sep 2015 12:35:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id de9sm17773083pad.44.2015.09.14.12.35.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 12:35:55 -0700 (PDT)
In-Reply-To: <1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 13 Sep 2015 12:53:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277861>

Karthik Nayak <karthik.188@gmail.com> writes:

> +	/*
> +	 * First we obtain all regular branch refs and if the HEAD is
> +	 * detached then we insert that ref to the end of the ref_fist
> +	 * so that it can be printed and removed first.
> +	 */
>  	for_each_rawref(append_ref, &cb);
> +	if (detached)
> +		head_ref(append_ref, &cb);
> +	index = ref_list.index;
> +
> +	/* Print detached HEAD before sorting and printing the rest */
> +	if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
> +	    !strcmp(ref_list.list[index - 1].name, head)) {
> +		print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
> +			       1, remote_prefix);
> +		index -= 1;
> +	}
>  
> +	qsort(ref_list.list, index, sizeof(struct ref_item), ref_cmp);

This looks somewhat strange.  Wouldn't it be more consistent to
teach ref_cmp that HEAD sorts where in the collection of refs (I
presume that kind is checked first and then name, so if you give
REF_DETACHED_HEAD a low number than others, it would automatically
give you the ordering you want) without all of the above special
casing?
