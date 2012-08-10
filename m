From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] connect: learn to parse capabilities with values
Date: Fri, 10 Aug 2012 14:55:07 -0700
Message-ID: <7v393uif9g.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
 <20120810211509.GB888@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:56:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzxBS-0007sE-Qo
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758936Ab2HJVzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 17:55:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51913 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758879Ab2HJVzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 17:55:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7017E9225;
	Fri, 10 Aug 2012 17:55:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I2RhoW6frjjTPKb6f2YbF2njlvo=; b=WVuTZT
	e9aw4urICSes1QLOjVhtwvvjJbblKuA64U9W7PGNhQGf/MB7ljSia2qmP8EHALzY
	FNsvg1cV7YRuHyqZfz48a7wijAidDHF3T2uj3+gQNcctJBZ01GilXI5Kf5YpJdf4
	RpIN+tIy+OizJmbe4n2+Lof/b8GB9Ps5PhNjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HUt67rtQ01G7bAK15Uquc0zQ70jPBxgC
	WtU5OPvRjzY2mwvbwqD85fFiLnNhH75ApffbeMiRzcftlhG/vHVqVM1+DUEs4e5n
	cS/uV8wcRo96HKy5qXxBzhtv7/pk6kGQHhCszvua8xrI3w3NdnHxLpvxISIOxtwb
	5wjYESFLYiw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C2B39223;
	Fri, 10 Aug 2012 17:55:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAA7E9220; Fri, 10 Aug 2012
 17:55:08 -0400 (EDT)
In-Reply-To: <20120810211509.GB888@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 10 Aug 2012 17:15:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D47EA78-E336-11E1-940A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203271>

Jeff King <peff@peff.net> writes:

> I would think the extra memory allocation would dwarf it, anyway.
>> ...
>> and a new caller can do something like
>> 
>> 	agent = server_supports("agent");
>>         if (!agent || !agent[5])
>>         	... no agent ...
>> 	else {
>>         	int span = strcspn(agent + 6, " \t\n");
>>                 printf("I found agent=<%.*s>!\n", span, agent + 6);
>> 	}
>> 
>> which doesn't look too bad.

I forgot to mention it, but the above was done also to make it
"possible but not mandatory" to pay extra allocation penalty.  The
caller can choose to parse the string into an int, for example,
without extra allocation.  Only the ones that want a string value
and keep a copy around do have to do xmemdupz().

> Anyway, do you think this is even worth doing at this point? I'm
> lukewarm on the final two patches due to the existence of
> GIT_TRACE_PACKET, which is much more likely to be useful.

In the longer term, I think giving callers access to the parameter
value given to a capability is necessary.  If we had this facility
in the old days, we wouldn't have done side-band-64k but spelled it
as side-band=64k.

For the agent=<foo>, certainly we don't need it.
