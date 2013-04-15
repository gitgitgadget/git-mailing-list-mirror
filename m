From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] commit-slab: introduce a macro to define a slab for
 new type
Date: Sun, 14 Apr 2013 18:32:42 -0700
Message-ID: <7vppxw4lz9.fsf@alter.siamese.dyndns.org>
References: <1365919489-17553-1-git-send-email-gitster@pobox.com>
 <1365919489-17553-4-git-send-email-gitster@pobox.com>
 <20130414184121.GA1621@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 15 03:32:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URYHp-0006wi-FE
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 03:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162Ab3DOBcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 21:32:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56895 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932109Ab3DOBco (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 21:32:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 845F911BBD;
	Mon, 15 Apr 2013 01:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t980rKBYHph80K24QyFWT8VfI0w=; b=w4Hwgd
	L+i2hkE8aBe1EGU9NJiqjTfU/5SCv/+UPY+TX6QB6QgI7d0SCxSY9qQ3mfD3wmcr
	lKTSYhZwchX+SM35ZQPcMUfnHId/K/gu/To+ANwJHlje5gUvY0fz/5gVE0rtn1ng
	PpdTsqLM5ZCUcQPVY4NmLmwFf0FddHhgdPds4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i2mZYp71Mun7Q6GS2iUzor8Ql+7Wcps3
	YFf+SfAKsWwefIdv9m9UCc4G/6fM7QHxtcbDt6AR88Yx+N4FAJPXfX/c8ESEynZ3
	r8ia1GPbBxygTPc98NgSjLOdgTYf6wY4Xg+UkFrrc/dYi3H1wEwEl27bnRU3JXQn
	xfWbTopD0S4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CB7611BBC;
	Mon, 15 Apr 2013 01:32:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAD6411BBB; Mon, 15 Apr
 2013 01:32:43 +0000 (UTC)
In-Reply-To: <20130414184121.GA1621@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 14 Apr 2013 14:41:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EB30EDA-A56C-11E2-BFD9-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221177>

Jeff King <peff@peff.net> writes:

> On Sat, Apr 13, 2013 at 11:04:49PM -0700, Junio C Hamano wrote:
>
>> Suppose you want to give one bit per existing ref and paint commits
>> down to find which refs are descendants of each commit. You find
>> that you have 320 refs only at runtime.
>> 
>> The code can declare a commit slab "struct flagbits"
>> 
>> 	define_commit_slab(flagbits, unsigned char);
>> 	struct flagbits flags;
>> 
>> and initialize it by:
>> 
>> 	nrefs = ... count number of refs that returns say 320 ...
>> 	init_flagbits_with_stride(&flags, (nrefs + 7) / 8);
>> 
>> so that
>> 
>> 	unsigned char *fp = flagbits_at(&flags, commit);
>> 
>> will return a pointer pointing at an array of 40 "unsigned char"s
>> associated with the commit.
>
> Thanks, I was thinking originally that we would want to break it down
> into "unsigned long" or something, but there is probably no real
> performance advantage to doing that over bytes.

The 320 came from writing "an array of 5 unsigned long long" in the
first draft ;-)

> I'd probably further wrap it with a flagbit_set and flagbit_tst to wrap
> the "figure out which byte, then which bit of that byte" logic, but that
> would be a wrapper around flagbits_at, anyway. It can come later.

Exactly. At that point, it is not about "what you could use commit
slab for" but is about "how you would implement unbounded set of
flag bits".

> We'd probably want the hot path of this (returning the actual pointer)
> to be inline, but not necessarily the parts about growing,...

Yeah, this was just a technology demonstration as your original.
