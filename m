From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: fix an 'different modifiers' sparse warning
Date: Thu, 25 Feb 2016 12:20:12 -0800
Message-ID: <xmqqfuwgo83n.fsf@gitster.mtv.corp.google.com>
References: <56CF576B.4020401@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:20:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2Og-0006li-Bp
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933750AbcBYUUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:20:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933600AbcBYUUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:20:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B8C754778C;
	Thu, 25 Feb 2016 15:20:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LjPyCYYWu/6v1nex0CcKT3O6Nhg=; b=oQQgzN
	XoJ+SZHKPsgAvVp+dFSuUCiszLq3QHA1q4k8IVplYrO2Ju1mb/Il2MTx0Uw7U0ms
	+MKl5NIki/pAEM60YTSzutTO8/1q/fp3O7Hz3urdOaBTUWKNDGRVVatJlDZhoiGR
	KN4mnC87uGm1uafhvqq5sLSB2qgaZWeHpYIdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dgq7moBLxtNg+FPxVqeFAvL/u6n2ythl
	Hm4pI0CiLJgjkAO1YU6uHgeUKizpOYrVyITxgxwGjU+vS/DQvMCXy5G9+4f6dxGG
	/+VELXkoc2xvF1NogDjf0VjXp0/chE9wnuoZcOgYbZYc5u49LBLHtWeBYclIt9Tf
	vc4uMu9kPV8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B05B94778B;
	Thu, 25 Feb 2016 15:20:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2923C47789;
	Thu, 25 Feb 2016 15:20:14 -0500 (EST)
In-Reply-To: <56CF576B.4020401@ramsayjones.plus.com> (Ramsay Jones's message
	of "Thu, 25 Feb 2016 19:35:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D88A232-DBFD-11E5-9E05-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287430>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Jeff,
>
> If you need to re-roll your 'jk/epipe-in-async' branch, could you
> please squash this into the relevant patch. (ie. "write_or_die:
> handle EPIPE in async threads", 24-02-2016).
>
> Thanks!

I actually was planning to merge this to 'next' today, so I'll
squash it in without waiting for a reroll.

By the way, doesn't it bother anybody to give two different types to
the same function depending on NO_PTHREAD?  It is not a new issue
added by this series, but async_exit() that claims to return int
does not (naturally) return anything, and sparse does not seem to
care (neither do we).

>
> ATB,
> Ramsay Jones
>
>  run-command.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index cd861bc..5dec18b 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -625,7 +625,7 @@ int in_async(void)
>  	return !pthread_equal(main_thread, pthread_self());
>  }
>  
> -void async_exit(int code)
> +void NORETURN async_exit(int code)
>  {
>  	pthread_exit((void *)(intptr_t)code);
>  }
> @@ -675,7 +675,7 @@ int in_async(void)
>  	return process_is_async;
>  }
>  
> -int async_exit(int code)
> +int NORETURN async_exit(int code)
>  {
>  	exit(code);
>  }
