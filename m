From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] trailer: reuse ignore_non_trailer() to ignore conflict lines
Date: Sun, 09 Nov 2014 10:24:20 -0800
Message-ID: <xmqqlhnkb5bf.fsf@gitster.dls.corp.google.com>
References: <20141107184148.16854.63825.chriscool@tuxfamily.org>
	<20141107185053.16854.5660.chriscool@tuxfamily.org>
	<xmqqzjc2eoyw.fsf@gitster.dls.corp.google.com>
	<20141109.113509.1363113947439404678.chriscool@tuxfamily.org>
	<xmqqfvdse308.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com,
	marcnarc@xiplink.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 19:24:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnXA4-00068Q-GL
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 19:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbaKISYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 13:24:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751416AbaKISYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 13:24:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6646619560;
	Sun,  9 Nov 2014 13:24:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z/+wGMN26oA82ijHetRfAZ9qyGk=; b=NVvlQx
	t7QIWJJI3xdp7NnBV0JLzRn5tCZahl7w+ePEgzJWcfwu8FnUlzPz/W28GTJt8Esp
	IKvFeanPV0+VadmEWhH9EMlVuLGlo8RZ820671c2LPfa4ym3buqOnYpgHF9gAH+/
	5D3I1t4rno2bekHITpAwQsV4t968C+mWHsDCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hqbHhOmC5oBYUnclrB/Bm4v6FZecOOUj
	ysqfMg9y6Rj4BZE572gmI6L+BpCwdWy6gTEjY+ZpdOPDJ4HYPribVVgNX4eIk088
	J/K3xUL18Lg28ECYcmYpbdDJpi9SYUJeVzCjU8Aj+yiGtKyUPAS2J2YPxj0iu82z
	2v6zNFKtsOE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BBBD1955F;
	Sun,  9 Nov 2014 13:24:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE66F1955E;
	Sun,  9 Nov 2014 13:24:21 -0500 (EST)
In-Reply-To: <xmqqfvdse308.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 09 Nov 2014 08:45:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A046C1B2-683D-11E4-BCD4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> Yeah, it won't be as efficient as using only one strbuf and only byte
>> oriented functions, and it looks much less manly too :-) But over time in
>> Git we have developed a number of less efficient but quite clean
>> abstractions like strbuf, argv_array, sha1_array and so on, that we
>> are quite happy with.
>
> Actually, all these examples you gave are fairly efficient and clean
> abstractions.  I find it insulting to pretend that the "one line per
> strbuf" is in the same league.  It isn't.
>
> And it is not about manliness.

By the way, I do not mean to say that all of strbuf (which is a
rather full API) is uniformly efficient and cleanly abstracted.

For example, I see strbuf_split() is a handy but a lousy invitation
to stupid programmers to do stupid things and needs to be used
carefully (rather, you need to carefully consider if a possible
solution that uses it is really a good solution).  If you start with
a single strbuf (e.g. perhaps read from a file or a blob in bulk in
an I/O efficient way), pass it around and then have to manipulate
each and every line in it to massage the information on each line
into other useful form (e.g. perhaps each line is a [+]src:dst
refspec element and you are parsing it into an array of "struct
refspec"), it may be tempting to write a parser from a single strbuf
into a single refspec, use strbuf_split() to break the single strbuf
input into multiple and feed each of them to your parser.

But it does not have to be the only way to create such a caller.
Unless the final "other useful form" is an array of strbuf, and you
have to remember that the whole point of using strbuf is because it
is easy to edit its contents efficiently in place, that needs to
further be modified in various ways, the splitting of N lines into N
strbuf, only to parse each line one by one, is a huge waste.  A
right approach may involve introducing a foreach_strbuf_line
iterator function that takes a callback, or a macro of the same name
that puts a control structure.

Going back to the trailer processing, if you are likely to be
editing each and every line in the input before producing the final
result, an array of strbuf would be a perfectly sensible data
structure to use.  I just didn't get the impression that that is
what is being done.  You would be presented a single text with
multiple lines (whose natural representation would be a <ptr,len>
that fits in a single strbuf), you would be asked to inspect and
manipulate one single section in the middle (namely, the runs of
lines that begin with some "keyword: "), and return the
concatenation of the part before that one section (intact), the
section you have manipulated (i.e. the trailer) and possibly the
remainder (intact).  Outside that single section you will be
touching, I do not see a good reason for each of their lines to be
first stored in a strbuf (while moving bunch of pointers in the
array using ARRAY_GROW() and friends), only to be later concatenated
back into a single string.
