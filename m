From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Wed, 12 Mar 2014 21:52:02 +0100
Message-ID: <87ob1bi1hp.fsf@fencepost.gnu.org>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
	<20140312175624.GA7982@sigill.intra.peff.net>
	<xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Quint Guvernator <quintus.public@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:52:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNq8M-0001Jo-BV
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbaCLUwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:52:06 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:40984 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaCLUwD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:52:03 -0400
Received: from localhost ([127.0.0.1]:40024 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WNq8A-00050O-TN; Wed, 12 Mar 2014 16:52:03 -0400
Received: by lola (Postfix, from userid 1000)
	id 63BD5E05D9; Wed, 12 Mar 2014 21:52:02 +0100 (CET)
In-Reply-To: <xmqqiorjky0a.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 12 Mar 2014 12:39:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243990>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>>  static inline int standard_header_field(const char *field, size_t len)
>>>  {
>>> -	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
>>> -		(len == 6 && !memcmp(field, "parent ", 7)) ||
>>> -		(len == 6 && !memcmp(field, "author ", 7)) ||
>>> -		(len == 9 && !memcmp(field, "committer ", 10)) ||
>>> -		(len == 8 && !memcmp(field, "encoding ", 9)));
>>> +	return ((len == 4 && starts_with(field, "tree ")) ||
>>> +		(len == 6 && starts_with(field, "parent ")) ||
>>> +		(len == 6 && starts_with(field, "author ")) ||
>>> +		(len == 9 && starts_with(field, "committer ")) ||
>>> +		(len == 8 && starts_with(field, "encoding ")));
>>
>> These extra "len" checks are interesting.  They look like an attempt to
>> optimize lookup, since the caller will already have scanned forward to
>> the space.
>
> If one really wants to remove the magic constants from this, then
> one must take advantage of the pattern
>
> 	len == strlen(S) - 1 && !memcmp(field, S, strlen(S))

If the caller has already scanned forward to the space, then there is no
actual need to let the comparison compare the space again after checking
len, is there?  That makes for a more consistent look in the memcmp
case.

One could do this in a switch on len instead.  Not that it seems
terribly more efficient.

> that appears here, and come up with a simple abstraction to express
> that we are only using the string S (e.g. "tree "), length len and
> location field of the counted string.
>
> Blindly replacing starts_with() with !memcmp() in the above part is
> a readability regression otherwise.

Don't really think so: if the len at the front and the back is the same
and the space is not explicitly compared any more, both look pretty much
the same to me.

>> ... I think with a few more helpers we could really further clean up
>> some of these callsites.
>
> Yes.

Possibly.  But it does seem like overkill.

-- 
David Kastrup
