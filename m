From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/16] index-helper: use watchman to avoid refreshing index with lstat()
Date: Thu, 07 Apr 2016 15:47:26 -0700
Message-ID: <xmqqh9fdxcht.fsf@gitster.mtv.corp.google.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	<1459980722-4836-10-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 00:47:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoIi6-0001jO-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 00:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbcDGWra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 18:47:30 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752898AbcDGWr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 18:47:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A62E53EC4;
	Thu,  7 Apr 2016 18:47:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KLJoqJv85WhU1biTAnGIIYKSDbU=; b=qe2Z6H
	v+g84Fll0sT/GYdGlXCxTI9S5YpUWalVeX1mxF6kz6Iwr3AQL5O8S3YKrMQ1t1EN
	ZgCu9RTRxKP/JNZig6H+l6OO1gIykqW0Y2OyZm4ofzqtMFjcuQBV/tqX4o5/d/Km
	AxLKDtCqP9Bdo5vGVC388GSwSE8PPhjPoCkq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PnAfRJqRLXYGF9R7Qt1khu6czUf+DmIc
	pfFLNYgR/djzoeUlrSZJQp1rqdxChzpkLYHDM36Qkcjnz2ZSCWgAom7Es4LaSe/S
	jmM4qYWsZr0+kASIqN3dAM7EXtaLE6SK7LKWVzRUTHC5NksCnopZDKfFHJ3WvZQF
	TzdnBJi+lFY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 61EAC53EC3;
	Thu,  7 Apr 2016 18:47:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B90F753EC2;
	Thu,  7 Apr 2016 18:47:27 -0400 (EDT)
In-Reply-To: <1459980722-4836-10-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 6 Apr 2016 18:11:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B41D09B0-FD12-11E5-BA83-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290993>

David Turner <dturner@twopensource.com> writes:

> diff --git a/read-cache.c b/read-cache.c
> index 59d892e..b6e9244 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1407,10 +1472,24 @@ static int read_watchman_ext(struct index_state *istate, const void *data,
>  	ewah_each_bit(bitmap, mark_no_watchman, istate);
>  	ewah_free(bitmap);
>  
> -	/*
> -	 * TODO: update the untracked cache from the untracked data in this
> -	 * extension.
> -	 */
> +	if (istate->untracked && istate->untracked->root) {
> +		int i;
> +		const char *untracked;
> +
> +		untracked = data + len + 8 + bitmap_size;

This breaks compilation as data here is of type (void *).

There may be similar breakages in this patch.
