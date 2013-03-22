From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid false positives in label detection in cpp diff
 hunk header regex.
Date: Fri, 22 Mar 2013 15:32:21 -0700
Message-ID: <7vhak35ami.fsf@alter.siamese.dyndns.org>
References: <loom.20130322T144107-601@post.gmane.org>
 <7vehf78olw.fsf@alter.siamese.dyndns.org> <514CD34F.70107@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vadim Zeitlin <vz-git@zeitlins.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 23:32:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJAW3-0007Da-Ja
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 23:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423408Ab3CVWcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 18:32:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422924Ab3CVWcX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 18:32:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5135DBD0D;
	Fri, 22 Mar 2013 18:32:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Jy5TEaqg2/SUERB9EOvzkxA5XU=; b=BrKXmn
	5Ede9YCaj+HFXpoWxlQq7J0ShZwsRGwrebM6wMPbk7dr/8uINH8cQQmdL6mZBPp7
	oCmLWja16ZB3dD2BbJeae/+RvxmCncs0Lx1jQKjD1OZXLqI5Rrfv/jKKB5aao/6J
	UKxYWMUFwsysNZdkA9EKq6J/SAk0Bw48VdlJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R06Ajt6lLURzk4PQ9aAxSo749cMz2Lpa
	DgbbajeSBIWHFh2EPS7TPJ9oEn/aQvbR3z6Dj8b0H2gpYtLmmQNSp2nP1L9cx8ze
	x3tZHa1RenyVxZ3JScp6Gcgu9V9x6ITR99v0R4a4qNGHyY7VXvLMkJE8Eq++1hm9
	TaAyfWbAKEA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 442E1BD0C;
	Fri, 22 Mar 2013 18:32:23 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D699BD0B; Fri, 22 Mar 2013
 18:32:22 -0400 (EDT)
In-Reply-To: <514CD34F.70107@kdbg.org> (Johannes Sixt's message of "Fri, 22
 Mar 2013 22:55:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D44F9D4-9340-11E2-AFA5-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218860>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 22.03.2013 16:02, schrieb Junio C Hamano:
>> Vadim Zeitlin <vz-git@zeitlins.org> writes:
>> 
>>> A C++ method start such as
>>>
>>>         void
>>>         foo::bar()
>>>
>>> wasn't recognized by cpp diff driver as it mistakenly included "foo::bar" as a
>>> label. However the colon in a label can't be followed by another colon, so
>>> recognize this case specially to correctly detect C++ methods using this style.
>
> Much appreciated!
>
>>>  PATTERNS("cpp",
>>>          /* Jump targets or access declarations */
>>> -        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
>>> +        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:([^:].*$|$)\n"
>> 
>> Hmm.  Wouldn't "find a word (possibly after indentation), colon and
>> then either a non-colon or end of line" be sufficient and simpler?
>> iow, something like...
>> 
>>        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:([^:]|$)"
>
> Yes, indeed. We don't need to match more than necessary in a negative
> pattern. The \n must still remain, though.

... because \n is not for matching against the text, but merely to
separate the regular expressions, right?

I also wonder if 

	label :

should also be caught, or is it too weird format to be worth
supporting?
