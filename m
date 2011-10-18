From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] completion: match ctags symbol names in grep
 patterns
Date: Tue, 18 Oct 2011 00:35:39 -0700
Message-ID: <7v8voiiwfo.fsf@alter.siamese.dyndns.org>
References: <20111018044955.GA8976@sigill.intra.peff.net>
 <20111018050105.GC9008@sigill.intra.peff.net>
 <7vd3duixdg.fsf@alter.siamese.dyndns.org>
 <20111018072655.GA22309@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 09:35:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG4DD-0002TA-Er
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 09:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757312Ab1JRHfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 03:35:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464Ab1JRHfm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 03:35:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA6483B39;
	Tue, 18 Oct 2011 03:35:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ukvz4hdpta16zWyhW335D7DGVfw=; b=CDdV3z
	RG83AQxGjtuEqDwoq3CH4xvskRkRHo/QTW27ldGQttp+JSXi3UwKrWtRcog6RDvs
	Rx1zYZ8uBIaorQM/QB67wnEhg9PpIvyGC+2qbmp+jqIQR+fLzj4uboBITm7DPHah
	LutEC6b5HjycAa6vnkohXuVWTLdF0KhzVvrNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bt0/OVZCSv5zpGYjPhdUSuA5QGG7Mick
	08VU/Rn/s1Hwx1asxmTRnqypfli5yYP9/twRr73GTikNo4oYNsUFkl28npA65uCv
	Pgy1wt4yVWMuO8qv2isIJtyTn25kwxapzOW4BqH+Ornb22jFqmCBpkzbCUhLUKUF
	F1wL8JuiMTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D17BF3B38;
	Tue, 18 Oct 2011 03:35:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E1E43B37; Tue, 18 Oct 2011
 03:35:41 -0400 (EDT)
In-Reply-To: <20111018072655.GA22309@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Tue, 18 Oct 2011 02:26:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C801133C-F95B-11E0-8E4E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183868>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Perhaps something like this is in order?
> [...]
>> +++ b/Makefile
>> @@ -2127,17 +2127,25 @@ po/git.pot: $(LOCALIZED_C)
>>  
>>  pot: po/git.pot
>>  
>> +git_check = $(shell git ls-files >/dev/null 2>&1; echo $$?)
>> +ifeq ($(git_check),0)
>> +FIND_SOURCE_FILES = git ls-files '*.[hcS]'
>> +else
>> +FIND_SOURCE_FILES = $(FIND) . \( -name .git -type d -prune \) \
>> +		-o \( -name '*.[hcS]' -type f -print \)
>> +endif
>
> Neat.  I'd prefer something like
>
> 	FIND_SOURCE_FILES = \
> 		git ls-files '*.[hcS]' 2>/dev/null || \
> 		$(FIND) . -name .git -prune -o -name '*.[hcS]' -type f -print
>
> that avoid punishing people who were using the makefile for some
> purpose unrelated to tags and cscope, though. ;)

Hmm, how would this punish anybody exactly (I just took the structure
from the way how the auto-depend is done)?

Besides, you would need to have the whole thing in a subshell or
something, as this is used as the upstream to "| xargs".
