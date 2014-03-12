From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Wed, 12 Mar 2014 12:39:01 -0700
Message-ID: <xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
	<20140312175624.GA7982@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:39:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNozi-0000ZM-00
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 20:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbaCLTjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 15:39:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32905 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbaCLTjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 15:39:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E70A71D53;
	Wed, 12 Mar 2014 15:39:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vPe7f+jRqU7WqpFzsFBYlseOZx8=; b=ivq3Er
	d++yn6hAAo+EOkEnyGeynZ6p91avO7rrYMVjrzzaTejY6WH7fn9eVJvwS4u9OIw4
	d07CUnU37I5tku+4VJ8Nwd2lTIHbpasMbO7GYqiCpLefnFlkHRrdfQP6pixXRQV6
	pceThZ867ABjWTBJ1l5QAh47B5YOOGbTCSZtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pc0L9UOy2bv3RBAzB9RfPZDwhWQZj9sB
	9Fa5tWqbwq5ui7lK9KcxmsPVLUH4GL0U+MBLKZMkt+vK2lH4NUqFWSrfOLDl3UjH
	k5YhdqEqzOaZpTZynPVaTMS6Mg3D+ENiO/mCIUjw50Px2Y8Wh2pG7i7dPTvwku1z
	1fDl7jLPvi4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A2F171D52;
	Wed, 12 Mar 2014 15:39:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8572071D51;
	Wed, 12 Mar 2014 15:39:05 -0400 (EDT)
In-Reply-To: <20140312175624.GA7982@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 12 Mar 2014 13:56:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F8C2F92A-AA1D-11E3-AFC6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243971>

Jeff King <peff@peff.net> writes:

>>  static inline int standard_header_field(const char *field, size_t len)
>>  {
>> -	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
>> -		(len == 6 && !memcmp(field, "parent ", 7)) ||
>> -		(len == 6 && !memcmp(field, "author ", 7)) ||
>> -		(len == 9 && !memcmp(field, "committer ", 10)) ||
>> -		(len == 8 && !memcmp(field, "encoding ", 9)));
>> +	return ((len == 4 && starts_with(field, "tree ")) ||
>> +		(len == 6 && starts_with(field, "parent ")) ||
>> +		(len == 6 && starts_with(field, "author ")) ||
>> +		(len == 9 && starts_with(field, "committer ")) ||
>> +		(len == 8 && starts_with(field, "encoding ")));
>
> These extra "len" checks are interesting.  They look like an attempt to
> optimize lookup, since the caller will already have scanned forward to
> the space.

If one really wants to remove the magic constants from this, then
one must take advantage of the pattern

	len == strlen(S) - 1 && !memcmp(field, S, strlen(S))

that appears here, and come up with a simple abstraction to express
that we are only using the string S (e.g. "tree "), length len and
location field of the counted string.

Blindly replacing starts_with() with !memcmp() in the above part is
a readability regression otherwise.

> ... I
> think with a few more helpers we could really further clean up some of
> these callsites.

Yes.
