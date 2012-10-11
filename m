From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] quote: let caller reset buffer for
 quote_path_relative()
Date: Thu, 11 Oct 2012 09:42:57 -0700
Message-ID: <7v8vbd7yem.fsf@alter.siamese.dyndns.org>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org>
 <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349868894-3579-2-git-send-email-pclouds@gmail.com>
 <7vd30qav4m.fsf@alter.siamese.dyndns.org>
 <CACsJy8CTGpDW46-37oX14+JxLxWmoz2f4mawr4QPkqCSunF7dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 18:43:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMLqs-0001uX-I9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 18:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758871Ab2JKQnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 12:43:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39388 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758614Ab2JKQnC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 12:43:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78CD791C7;
	Thu, 11 Oct 2012 12:42:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TCcsLt+1HjBWvrpLMJUirYkN/0Y=; b=JNsc4E
	BI9xNGJwfW3bcKa8KCgbBk8z/WM7XlH46NnRWw6tfMiEq0QQik5OR7Yt3L1fFQFd
	bvTrB0W9U6q8NItnztAoS5NZ3+9M7zOx5SQ3ZZadLzAsyFM5Afu6vzgPUU8OHVyk
	Uc494G6JzjkVoQn9Qgw6C6vErKoup1qAz6xl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n9YeyA3/bENa+8YtqySFUSAByrJZVzgR
	qsGPHpSHc44U0sRwMEsfOxMe6nKHuoy05QhIhUMO6vSjYwwSEmRZTFBNVxvMpyks
	HI3xp2Bv5T9fYKG7F+nFaSgcKAfpOGOy60WsznWpDfqT9V0QrCSm22hS+xspDSyQ
	TEMX5LkHlcg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 679C991C6;
	Thu, 11 Oct 2012 12:42:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E3FD91C4; Thu, 11 Oct 2012
 12:42:58 -0400 (EDT)
In-Reply-To: <CACsJy8CTGpDW46-37oX14+JxLxWmoz2f4mawr4QPkqCSunF7dQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 11 Oct 2012 20:04:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6D57C06-13C2-11E2-811B-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207485>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Oct 11, 2012 at 4:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> This sounds a lot stronger than "let" to me.  All existing callers
>> that assumed that buf to be emptied by the function now has to clear
>> it.  "quote: stop resetting output buffer of quote_path_relative()"
>> may better describe what this really does.
>>
>> How should this interact with the logic in the called function that
>> used to say "if we ended up returning an empty string because the
>> path is the same as the base, we should give ./ back", and what
>> should the return value of this function be?
>> ...
>> So what does it mean to have an existing string in the output buffer
>> when calling the function?  Is it supposed to be a path to a
>> directory, or just a general uninterpreted string (e.g. a message)?
>
> I prefer the KISS principle in this case: do not interpret existing string.

Sorry, I do not quite understand what you mean.

The original function is about turning one path into a path that is
relative to the other path (e.g. make the result usable for chdir()
when your cwd() is the other path to name that path), and because
you do not want to end up with an empty path, it adds "./" to the
result when the two paths are equal.

That is simple and stupid, in the sense that you can explain in
simple terms what it does even to a stupid person and make him
understand.

If a patch changes one aspect of the implementation of the function,
but keeps other parts intact without thinking the ramifications of
doing so through, and ends up giving the end result unnecessarily
complex semantics, the _patch_ might be simple and stupid, but the
end result is no longer simple.

That is why I asked what it means to "append" and asked you to write
it down for people who may need to decide if this function is an
appropriate thing to call for their new code in the future.

You didn't answer that question, so I have to ask again.  What is
the existing string this function appends its result to?

 - If it is a leading path (in other words, you are transplanting a
   hierarchy to somewhere else --- see and (re)read "But if the
   caller did this instead" part from the message you are responding
   to), "because you do not want to end up with an empty path, it
   adds "./" to the result when the two paths are equal" does not
   make sense at all.

 - If it is a message that describes the resulting relative path
   (the use case above that "transplant" example in the same
   message), it needs to add "./" to the result, but the logic to
   determine it now needs to take the length of what was in the
   buffer when the function was called into account.

 - Is there a third possibility?

Whatever your answer is, please make sure the next person who wants
to call this function from his code does not have to ask "Why does
it append "./" when out->len is zero?  Shouldn't the condition be
when *rel is an empty string?"

Thanks.
