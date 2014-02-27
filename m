From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rewrite git-compat-util.h:skip_prefix() as a loop
Date: Thu, 27 Feb 2014 14:16:13 -0800
Message-ID: <xmqq38j4xkuq.fsf@gitster.dls.corp.google.com>
References: <1393503197-29669-1-git-send-email-sunheehnus@gmail.com>
	<xmqqd2i8z6um.fsf@gitster.dls.corp.google.com>
	<87k3cg47o6.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sun He <sunheehnus@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 27 23:16:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ9Fi-00085N-Ki
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 23:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbaB0WQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 17:16:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaB0WQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 17:16:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1150D70180;
	Thu, 27 Feb 2014 17:16:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3KiSZ0mHXcrz6LP0I6pCXRzOPy0=; b=g7w5vq
	STRRU4k3yZZ0CMF48dt0OpdSHc1KsD4mLXQIG4gwKVjk4GYLkOfnLwZCas3WL5+k
	ht59xjiXawuJeltzDaE0HiPeoQ4uv67xCi3IYbD3fDUFXWlPAGNsqaiOOzSZz65d
	U1jvJc+ZUkv3Sdv4xEvT/cX4+v8KA1sOTNgkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CrwR/nboj/IX5uOdms19rzxVBNkA8eVo
	TTE95ziRxRy0lFObaaw1XAC1bzeSQ2MN8NWSzf9mrIXnGpAiMnyabqZXd4gOC3GZ
	1zHyQsn0BR+0pc4G5FL1Q2US3cCn5UN+U7a2naoKSdJn5UJ5CM7h/jK2xcfQ8H4f
	m5GrxXokqQk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB5FF7017E;
	Thu, 27 Feb 2014 17:16:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 133E37017B;
	Thu, 27 Feb 2014 17:16:18 -0500 (EST)
In-Reply-To: <87k3cg47o6.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 27 Feb 2014 21:33:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C837213A-9FFC-11E3-998A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242866>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sun He <sunheehnus@gmail.com> writes:
>>
>>> Signed-off-by: Sun He <sunheehnus@gmail.com>
>>> ---
>>>  git-compat-util.h |    4 ++--
>>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/git-compat-util.h b/git-compat-util.h
>>> index cbd86c3..4daa6cf 100644
>>> --- a/git-compat-util.h
>>> +++ b/git-compat-util.h
>>> @@ -357,8 +357,8 @@ extern int suffixcmp(const char *str, const char *suffix);
>>>  
>>>  static inline const char *skip_prefix(const char *str, const char *prefix)
>>>  {
>>> -	size_t len = strlen(prefix);
>>> -	return strncmp(str, prefix, len) ? NULL : str + len;
>>> +    while( *prefix != '\0' && *str++ == *prefix++ );
>>> +    return *prefix == '\0' ? str : NULL;
>>
>> Documentation/CodingGuidelines?
>
> Mostly relevant for tabification here, not helping much otherwise.

"Imitate existing code" would let you spot that we have SP outside
the () pair, not inside, for controls like while/for/if, and we
usually do not explicitly compare things with 0, NULL or '\0'.

Together with the "empty statement should occupy its own line" you
mentioned, I tend to agree with you that some people may benefit
from them explicitly spelled out.


 
