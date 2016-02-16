From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] pager: factor out a helper to prepare a child process to run the pager
Date: Tue, 16 Feb 2016 15:49:55 -0800
Message-ID: <xmqqk2m4kyfw.fsf@gitster.mtv.corp.google.com>
References: <1455664017-27588-1-git-send-email-gitster@pobox.com>
	<1455664017-27588-3-git-send-email-gitster@pobox.com>
	<20160216232657.GB18634@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:50:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVpNb-0005ol-BL
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933378AbcBPXt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 18:49:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933313AbcBPXt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:49:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D46745D75;
	Tue, 16 Feb 2016 18:49:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q33ktWep8eaDft2RTYzq7YUqKsM=; b=ZOs6hS
	NkcCdRJU/eXXrn729cWwBM4a74INYXr7l+YRrgbdpfbslva4SnAr6u1HhAGucK06
	gYvhYcU6Wwg+F/EcAF/3CKBpDUXrFN2LJ7wuaHz7ergr0U9NXoxc9NhYildd/v+G
	yl1AVyLfWKug/5ol4IA20vkEW2qyvj6ubNDuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dMR8+kWJlRdAJoMYzvbMuk6o1GWcoZ8m
	xSj49bRBU/A7xJ0h4AYQgvGT4ikuYHldCWT4zXWKj2lv7vPkctoJ/oX8h50WqMHj
	hsECsBrO5x7ixBpObi5qXGysdBzfIH8RR+klPAqiNm0pKOXw8fVsQoQbvukBukjO
	LuN5KbVAJg8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6576145D74;
	Tue, 16 Feb 2016 18:49:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D7DC445D73;
	Tue, 16 Feb 2016 18:49:56 -0500 (EST)
In-Reply-To: <20160216232657.GB18634@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 16 Feb 2016 18:26:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FBB35636-D507-11E5-84BC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286461>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 16, 2016 at 03:06:56PM -0800, Junio C Hamano wrote:
>
>> diff --git a/pager.c b/pager.c
>> index 5dbcc5a..1406370 100644
>> --- a/pager.c
>> +++ b/pager.c
>> @@ -53,6 +53,23 @@ const char *git_pager(int stdout_is_tty)
>>  	return pager;
>>  }
>>  
>> +void prepare_pager_args(struct child_process *pager_process, ...)
>> +{
>> +	va_list ap;
>> +	const char *arg;
>> +
>> +	va_start(ap, pager_process);
>> +	while ((arg = va_arg(ap, const char *)))
>> +		argv_array_push(&pager_process->args, arg);
>> +	va_end(ap);
>> +
>> +	pager_process->use_shell = 1;
>> +	if (!getenv("LESS"))
>> +		argv_array_push(&pager_process->env_array, "LESS=FRX");
>> +	if (!getenv("LV"))
>> +		argv_array_push(&pager_process->env_array, "LV=-c");
>> +}
>
> When reading this, I had to wonder what the "..." args were supposed to
> be. I figured it out when I read the caller, but I wonder if a comment
> would help. Also, we are expecting the pager here as the first argument,
> so maybe:
>
>   void prepare_pager_args(struct child_process *pager_process,
>                           const char *pager, ...);
>
> would be a better signature.

;-)

I had that originally, and then incorrectly fed pager to va_start()
which broke the whole thing.

> That also made me wonder if we could simply
> get away with:
>
>   void prepare_pager_args(struct child_process *pager_process,
>                           const char *pager);
>
> and have callers argv_array_push() themselves afterwards.

After all that may be a nicer way to structure.

> And if you put the git_pager() call inside prepare_pager_args (which I
> agree would be cleaner), we just have:
>
>   void prepare_pager_args(struct child_process *pager_process);
>
> which is pretty self-explanatory (though it might need a new name; I'd
> be tempted to call it init_pager_process() or something, and actually
> have it do the child_process_init() to make sure it is working with a
> sane clean slate).

Conceptually I am on the same page, but I am not sure how well that
interacts with what "git am -i" codepath wants to do, though.

One big difference between the "we'll feed our output to pager"
codepath and "we'll spawn a pager to let a file on the filesystem be
read" codepath is that the former needs to call git_pager() and
check the NULL-ness of the return value to decide that it does not
want to spawn a pager and let the standard output just go straight
to the outside world.  The latter, on the other hand, does want to
spawn something to cause the file to be presented to the end user
even git_pager() returns NULL.

And that is why I didn't make this helper call git_pager() itself.
