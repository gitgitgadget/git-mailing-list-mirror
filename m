From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Some issues when trying to set up a shallow git mirror server
Date: Fri, 08 Jan 2016 13:37:02 -0800
Message-ID: <xmqqd1tb21oh.fsf@gitster.mtv.corp.google.com>
References: <20160107165417.GB3397@logi.codethink.co.uk>
	<xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Richard Maw <richard.maw@codethink.co.uk>
X-From: git-owner@vger.kernel.org Fri Jan 08 22:37:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHeif-0005YE-EO
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 22:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725AbcAHVhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 16:37:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754560AbcAHVhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 16:37:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06BFE3A60A;
	Fri,  8 Jan 2016 16:37:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jpgTgYtHxE0DV8ti6t3OUqPI8zI=; b=Ns5jCQ
	uZcR27t+HmdxF436UhKwkkG1LqBV8aHZLjxxnHfh34t/+mwrTns6kWJzt/tyBC7S
	ZascG25yzQgqECcgYoFHn5P7XyJqzj6XKtNW1AFrbJ82r97/dunMM8NJCJposff1
	aKfQdeRO+0pjgGCzIxEsUaHgJLaUcEITXVuCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YXHzFufaldiH17TWZbNkvdjJf4f3D24j
	Mxs5KX/kccnVTaoLxTfc0BX4JraLvz4A3Ktk47aMeDGFFEnRSOBONaS5MhTX3Cwp
	YR9m44buYQ/W2enQbnBrHS+voKryhXcU1Bd85tDUf596v7Zp+FQ1D8qdXlGllc6o
	gRN3qxXGymo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F2CF93A604;
	Fri,  8 Jan 2016 16:37:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 608A83A5FF;
	Fri,  8 Jan 2016 16:37:03 -0500 (EST)
In-Reply-To: <xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Jan 2016 10:00:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F504D3B8-B64F-11E5-960B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283582>

Junio C Hamano <gitster@pobox.com> writes:

> Richard Maw <richard.maw@codethink.co.uk> writes:
>
>> This is inconvenient for us,
>> as we were explicitly using refspecs which didn't force the fetch,
>> since we were using the "non fast-forward update" errors
>> to detect whether upstream force pushed important refs
>> which could be a sign of tampering.
>>
>> While the client doesn't have enough information
>> the server has those commits.
>> Would it make sense for the server to be able to tell the client
>> "trust me, that commit is a descendant of the previous one"?
>
> It does not in our security model, as you do not blindly trust the
> other side, whether you are a "client" or a "server".

Thinking about it more, I think my answer was flawed.  

A client may ask the server to give a history, and before it accepts
the result, it must do its own consistency check.  A client may send
its history, and before the server accepts it, the server must do
its own consistency check.  This is the general principle around our
consistency model (it is not limited to "security", but it is more
about "correctness" in general).

While that consistency principle must hold everywhere in our system,
it does not mean a client cannot ask a server to do something whose
result it has to trust, at least to some degree, because there is
fundamentally no way to independenty verify the result.

I think what you were hinting falls into that category.  The client
cannot verify that the new tip is a descendant of the old one
without having the full history between these two points, but
transfering that history would defeat the whole point of using a
shallowed history.

So in that sense I do think that such a protocol extension does make
sense.  But it would involve some extra pieces of information that
need to be sent between the client and the server, not just "I'll
trust you".

In the current "git fetch" protocol, the sender gives the receiver a
list of refs, and for each of these refs, the object name it points
at.  Then the receiver asks the sender to give it the objects that
appear in the history leading to a set of objects (aka "want"), and
tells the sender what objects it completely has already (aka
"have").  The idea is that the sender can exclude objects that are
reachable from "have"s when it enumerates the objects that need to
be sent.  When the receiver is shallow, it also tells the sender
that its current history is truncated at such and such commits,
lacking things before them.  After that exchange, the sender just
gives the receiver a packfile that contains the objects requested.
The receiver verifies that the packfile makes sense, e.g. it has all
the "want" objects it asked for, and the objects that they refer to
(recursively) are available, before updating its refs with (some of)
the "want" objects.

In the simplest case, for example, where you might have a single
refs/heads/master that currently points at O and the other side has
N at its refs/heads/master, the sender would say "I have N at
refs/heads/master" and the receiver would say "I want N, and I have
O".  A shallow receiver may also say "I do not have history behind
O" and "I only want a history 1 commit deep".  And the sender would
send objects that is necessary to satisfy the request, e.g. commit N
itself and the trees and blobs in commit N that are not common with
commit O.

Notice that nowhere in this exchange the receiver tells the sender
what it intends to do with the "want" objects?

Because the receiver does not say "I want N and I intend to replace
O I currently have refs/heads/master", there is no way for the
sender to say "trust me, N is a descendant of O".  It simply does
not know if the receiver _cares_ how N and O are related with each
other.

So if you want to do this, a new protocol extension needs to allow
your updated sender (upload-pack) and receiver (fetch-pack) to work
more like this:

 * The sender would advertise "I support that extension", while
   giving the usual "here are my refs and its current values".

 * The receiver would say "I want to use that extension", and to
   each of its "want" (which usually consists of "want" followed by
   an object name and nothing else), it optionally adds names of the
   objects it wants to verify ancestry relationship with.

   E.g. if you have O at the tip of the master branch and P at the
   tip of the maint branch, the sender has N at both of these two
   branches, and if you are updating your master and maint with
   their master and maint, you would say something like "want N O P"
   to tell the sender that you want history leading to N, and you
   want to see if N is a descendant of O and if N is a descendant of
   P.

 * The receiver and the sender then does the usual "have"/"ack"
   exchange, which does not have to change any behaviour with this
   extension.

 * Finally, when the sender sends out the resulting packfile, it
   also has to tell the receiver which of the object pairs the
   receiver asked it to check the ancestry relationship violate the
   fast-forward rule.  In the earlier example of fast-forwarding O
   and P with N, where the receiver asked "want N O P", the receiver
   asked to check object pairs <N, O> and <N, P>.  If P fast-forwards
   to N but O does not, then the sender would tell the receiver the
   fact that "O does not fast forward to N".

With such an extension, your updated receiver can receive the
necessary objects to update your history to "N", but notice that it
would result in non-ff update to update master (that used to be O)
with the new commit N.
