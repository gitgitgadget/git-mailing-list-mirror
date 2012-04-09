From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Mon, 09 Apr 2012 11:44:59 -0700
Message-ID: <7vbon0wxqs.fsf@alter.siamese.dyndns.org>
References: <1333935414-10389-1-git-send-email-bwalton@artsci.utoronto.ca>
 <m2sjgde7cs.fsf@linux-m68k.org>
 <1333977812-sup-4111@pinkfloyd.chass.utoronto.ca> <m2fwcdc57q.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:45:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJaS-0003nj-M0
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757701Ab2DISpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 14:45:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757689Ab2DISpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 14:45:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B8CB7816;
	Mon,  9 Apr 2012 14:45:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BqSnpFhlFNNyTg+T3uwypurmyU4=; b=qh01aL
	PqxvOa2iGCJ6+h58rAkCWHs/x+eKxBY3ORN8DHmKlgcjK503T4gzLa/XFsr7C6+4
	vMNMpYN07oBmsxD7gNfZeRLQA1qwv4btIORNBiLJ2Qcz407uakfH84EbhVig5a16
	f9s5ZtTalYpSaohvqy4x2HWiepSfUjA0y67pI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B+S8FZX+vCR88URiZIfxWEjqDOWN6rBG
	p5eyTYRZ4R7D+HSi5Q7DuXPPFpUZB6+Cw9OhnzZgRbkgiO3vf3MO0+JhlaoPA0LM
	dfd1xbpXUrfBmumUxUEhPDeV+fE7cHFcKdwrAU8nf4YPGIYPr0BJyV49ca1eNBho
	zSDDRr6cZHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0328F7815;
	Mon,  9 Apr 2012 14:45:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC4427814; Mon,  9 Apr 2012
 14:45:00 -0400 (EDT)
In-Reply-To: <m2fwcdc57q.fsf@igel.home> (Andreas Schwab's message of "Mon, 09
 Apr 2012 17:09:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CC78544-8274-11E1-AF45-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195026>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Ben Walton <bwalton@artsci.utoronto.ca> writes:
>
>> Excerpts from Andreas Schwab's message of Mon Apr 09 02:40:03 -0400 2012:
>>
>>> How about using 's|[^/][^/]*|..|g' instead, which should avoid the bug
>>> as well.
>>
>> I'd be ok with that change if the changed semantics of the regex are
>> ok in this application.  It's essentially the same as s|[^/]+|..|g,
>> which requires at least one character.
>>
>> In the current code, if you do:
>>
>> echo '/' | sed -e 's|[^]*|..|g'
>>
>> you get: ../.. (from a working implementation).
>>
>> Your regex would see the result  be: /
>>
>> I don't think we'd ever be passing a plain /, but we might pass a
>> fully qualified path /path/to/foo, which would see the result change
>> from ../../../.. to /../../.. and that could have unintended impact.
>
> AFAICS the variables at this point never contain a value with a leading
> slash.

Correct.  After $a and $b are initialized to "$(cd somewhere ; pwd)/",
there is a loop:

	while test "${a%%/*}" = "${b%%/*}"
	do
		a=${a#*/}
		b=${b#*/}
	done

The test for the first iteration will see that they both start with '/' so
stripping maximal trailing substring that match "/*" from them will yield
two empty strings, and we always enter the body of the loop.  The body
during the first iteration will strip the leading '/'.

When pwd computed for both $a and $b were at '/', this loop may do
something funky ($b will become empty), but that is covered by an earlier
"is $a inside $b or vice versa?" check, so we should be OK.
