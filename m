From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Some issues when trying to set up a shallow git mirror server
Date: Tue, 12 Jan 2016 10:29:27 -0800
Message-ID: <xmqqy4butzw8.fsf@gitster.mtv.corp.google.com>
References: <20160107165417.GB3397@logi.codethink.co.uk>
	<xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com>
	<xmqqd1tb21oh.fsf@gitster.mtv.corp.google.com>
	<20160111155153.GE3397@logi.codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Richard Maw <richard.maw@codethink.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:29:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ3hG-0000At-Nw
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 19:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbcALS3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 13:29:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752740AbcALS3a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 13:29:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 491373996C;
	Tue, 12 Jan 2016 13:29:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5+xpwySs/PpHxgB3yqmylGSIFaI=; b=WIaxd/
	wab3s6r1GGqKBU7gF5CGuqGqnA4IvGcIBLzPOouqnhQFNs7Xbi9Kru+weESMDiew
	ynyzptbfq78TW8qCDpP2jZeBotOqEsJ2B4maiO/c9/TnzZDYq0cj3X/usciPPVB3
	o3WBgzY+e5iwc55jl9WP2dJ2AUqszGFFYimBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hecG3QMa2feS5OrNUeUILMA5/KJlfcdW
	ONrpfZ3ANQVfdY8tGge5SlQlAiSI9gboF9hWEPNbHj2wGyz0xnNPOA8FFwvsBljD
	K7tyQr9jE2KMqfw3Y7baWo5HSz9jYnorunLuB5kVTBZ10QkWV0YJNZlfLZV5NuaN
	jOEfLiZD9xg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D7B43996B;
	Tue, 12 Jan 2016 13:29:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9F1703996A;
	Tue, 12 Jan 2016 13:29:28 -0500 (EST)
In-Reply-To: <20160111155153.GE3397@logi.codethink.co.uk> (Richard Maw's
	message of "Mon, 11 Jan 2016 15:51:53 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A5252C8-B95A-11E5-9DD5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283834>

Richard Maw <richard.maw@codethink.co.uk> writes:

> On Fri, Jan 08, 2016 at 01:37:02PM -0800, Junio C Hamano wrote:
> ...
>> So if you want to do this, a new protocol extension needs to allow
>> your updated sender (upload-pack) and receiver (fetch-pack) to work
>> more like this:
>> ...
>>  * Finally, when the sender sends out the resulting packfile, it
>>    also has to tell the receiver which of the object pairs the
>>    receiver asked it to check the ancestry relationship violate the
>>    fast-forward rule.  In the earlier example of fast-forwarding O
>>    and P with N, where the receiver asked "want N O P", the receiver
>>    asked to check object pairs <N, O> and <N, P>.  If P fast-forwards
>>    to N but O does not, then the sender would tell the receiver the
>>    fact that "O does not fast forward to N".
>
> So this would be another step after the receiver communicates "done",
> but before the pack file itself gets sent,
> so the sender can determine that it doesn't need to tell the reciever
> the relationship between two commits,
> since it knows you can work it out yourself?
>
> Otherwise if it can probably communicate the relationships before the have list
> is sent, and extend the shallow-update part of the protocol instead, which
> might be simpler.

I left the detail as vague ;-).

The new request does not have to piggyback on existing "want"
message.  And thinking about it again, it probably is cleaner if it
didn't.  After the use of the protocol extension "ancestry-check" is
negotiated the usual way between the sender and the receiver, the
receiver would send "check-ff N O" and "check-ff N P" after it sends
all of its "want" messages but before it sends the "flush" to go
into the "have"/"ack" common ancestry discovery.

I do not have a strong opinion on where the sender should reply with
"not-ff N O" in the protocol.  Immediately after the receiver says
"I've done with my 'want's (and now 'check-ff's)" by flushing may be
a good place to do so.

>> With such an extension, your updated receiver can receive the
>> necessary objects to update your history to "N", but notice that it
>> would result in non-ff update to update master (that used to be O)
>> with the new commit N.
>
> Code-wise, does the following make sense?
>
> 1.  Add a field to `struct ref` to flag a "trusted fast-forward".
> 2.  Change `find_common()` in `fetch-pack.c`
>     and `receive_needs()` in `upload-pack.c`
>     to communicate the relationships we're interested in as above,
>     and set the "trusted fast-forward" flag.
> 3.  Change `update_local_ref()` in `builtin/fetch.c`
>     to check `ref->trusted_fast_forward || in_merge_bases(current, updated)`.
