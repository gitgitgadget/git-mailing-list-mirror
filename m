From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv15 2/5] run_processes_parallel: add LF when caller is sloppy
Date: Wed, 24 Feb 2016 18:56:33 -0800
Message-ID: <xmqqziuppkf2.fsf@gitster.mtv.corp.google.com>
References: <1456284017-26141-1-git-send-email-sbeller@google.com>
	<1456284017-26141-3-git-send-email-sbeller@google.com>
	<20160224211947.GO28749@google.com>
	<CAGZ79kZvD4zFA61XvSLa8fe1PzH91+4ii5vSeH-P+ER2wbQy2g@mail.gmail.com>
	<20160225005513.GP28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 03:56:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYm6b-0001Gj-MV
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 03:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390AbcBYC4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 21:56:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753051AbcBYC4g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 21:56:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63D4047D09;
	Wed, 24 Feb 2016 21:56:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oKFG1jFQsMKdEAaWdn6CdT6BaPk=; b=a3DBC0
	45BhBtebTKI4P+ZL+WdD04mK6mRVq2sLQ8KSpIdu4obC4kbgGbEaeppunAmtaOAT
	aD5pfp6sNkNA8sb55O4xyx4qd5rwqq8zjq02uE/3UYDeVA7PDMsYbOuigsePJyyi
	iYN82c+XKdJvXkGgD7YHXmwsFUD2sTODuPTcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C2Ra7SP1EoHOX0y36zcoKMft/jluOCDP
	AATCSDPQHh6wDzWgP3Zs7j3UQMSaq9dTTAE2ZzFknbvd/3knG3G0T3C7frFdotax
	mR9NSSsjAKQqyVsI+FxeP6KawFEfYkn2kx/AAv0JyouFK7zt9CB0xYyCp+g7fr1n
	q23BLZ3ZgUY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 59A3047D08;
	Wed, 24 Feb 2016 21:56:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C4AA247D07;
	Wed, 24 Feb 2016 21:56:34 -0500 (EST)
In-Reply-To: <20160225005513.GP28749@google.com> (Jonathan Nieder's message of
	"Wed, 24 Feb 2016 16:55:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6188499E-DB6B-11E5-99B4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287315>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>> On Wed, Feb 24, 2016 at 1:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> > Stefan Beller wrote:
>
>>>> When the callers of parallel processing machine are sloppy with their
>>>> messages, make sure the output is terminated with LF after one child
>>>> process is handled.
>>>
>>> Why not always add \n here?
>>
>> So you propose to always add a \n if the output length was > 0 ?
>
> Ah, now I see where I was confused.
> ...
> get_next_task_fn et al looked similar to that pattern, but they are
> doing something different.
> ...
> The functions default_start_failure and default_task_finished are
> buggy under that API, since they do not include newlines in their
> output.
>
> Once they're fixed, there wouldn't be any need to add \n, unless we
> are worried about a child process that writes output that doesn't end
> with a newline.  It can be convenient for child processes to do things
> like
>
> 	printf '%s\t' "some information"
>
> so I am not convinced this patch is helping.
>
> Does that make sense?

Sounds very sensible analysis.  Thanks.
