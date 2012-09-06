From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: Append -x line on separate paragraph
Date: Wed, 05 Sep 2012 20:47:43 -0700
Message-ID: <7vmx136cdc.fsf@alter.siamese.dyndns.org>
References: <1410595949.1269.1346877367487.JavaMail.root@bazinga.schuettel.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Stocker <robin@nibor.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 05:47:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9T4O-0005kb-RQ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 05:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab2IFDrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 23:47:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313Ab2IFDrq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 23:47:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 170C29350;
	Wed,  5 Sep 2012 23:47:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JHal4+zPjNaYyX2hGX6ysQM2Hao=; b=uovc7x
	DrDYkhTh5xyaT3qvm5Osttcb453ZitndDPbjQsx+L8WPi06BD58O8L85cDYsBIJN
	rhpBGv204Zsrz5wshIIiDooP+Yk87gEe30yWkhi0RzqM+APFopaD48OAkx8WJ0D6
	N5U9gUMPo4Ysf2fEbdtQHr7kD7rwxVGIPlOKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wfeh7kcXooXgGoPZKfWMb8vDJs0GsXG3
	6aaSGILiz1GlWlfKVSlUfZd84FU/dzzKoz3kRl/2c3fu1Ci47GfaH11FktWPA+EM
	o0RA+QvjFMBwT2Y0+YUEJ3Hz4u8kLH3cHXm9/NWJIfUaGuJThVVXMXfTcWmnS6SS
	xLIAzC5hu+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0129D934F;
	Wed,  5 Sep 2012 23:47:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49767934E; Wed,  5 Sep 2012
 23:47:45 -0400 (EDT)
In-Reply-To: <1410595949.1269.1346877367487.JavaMail.root@bazinga.schuettel.ch> (Robin
 Stocker's message of "Wed, 5 Sep 2012 22:36:07 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E428C32-F7D5-11E1-9FE5-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204858>

Robin Stocker <robin@nibor.org> writes:

> Junio C Hamano writes:
>> Robin Stocker <robin@nibor.org> writes:
>> 
>> >  		if (opts->record_origin) {
>> > + /* Some implementations don't terminate message with final \n, so
>> > add it */
>> > + if (msg.message[strlen(msg.message)-1] != '\n')
>> > + strbuf_addch(&msgbuf, '\n');
>> 
>> I can agree that this is a good change.
>> 
>> > + strbuf_addch(&msgbuf, '\n');
>> 
>> But this is somewhat dubious. Even if what we are adding is merely
>> an extra LF, that changes the mechanically generated output format
>> and can break existing hooks that read from these generated commit
>> log template.
>
> Hm, for a script to break because of an extra LF it would have to be
> very badly written. If it looks for "\n(cherry picked ...", it would
> still work. But I see the point.

If you approach this change from the "information left by -x is
somehow useful" point of view, it wouldn't make any difference.
Scripts can match "(cherry picked from ..." and glean useful
information out of it, with or without an empty line around it.

But if you look at it from the other perspective [*1*], it makes a
big difference.  A script that wants to excise these lines used to
be able to just delete such a line.  With the proposed change, it
also has to be aware of an empty line next to it.

>> Is there a reason better than "having an empty line there look
>> better to _me_" to justify this change?
>
> Yes:

Then please have them in the proposed commit log message to justify
the change.  I think the following analysis I quoted from your
message summarizes the motivation well.

> * If the original commit message consisted just of a summary line,
>   the commit message after -x would then not have a blank second
>   line, which is bad style, e.g.:
>
> The title of the original commit
> (cherry picked ...)

This is very true.  So we at least want an empty line added when the
original is one-liner.

> * If the original message did not have any trailers, the appended
>   text would stick to the last paragraph, even though it is a
>   separate thing.

The other side of this argument is if there are trailers, we would
not want an extra blank line.  We need to look at the last paragraph
of the log message and if it does not end with a trailer, we want an
additional empty line.

> Maybe the solution is to detect if the original commit message
> ends with a trailer and in that case keep the existing behavior
> of not inserting a blank line?

Yeah, that sounds like a good change from "this makes the result
look better" point of view.

> Oh, I like that proposal. I'd lean towards a new --trailer option I
> think.
>
> It would have the same problem of having to append it on a separate
> paragraph if the original commit message does not already have a
> trailer though.

Yes.  The logic would be the same.  First terminate the incomplete
last line, if any, and then look at the last paragraph of the commit
log message (one liner is a natural degenerate case of this; its
single-line title is the last paragraph) and if and only if it does
not end with a trailer, add a blank line before adding the marker.

The only difference between the two would be how the "cherry-picked
from" line is formatted.


[Footnote]

*1* Originally, we added "(cherry picked from ..." by default, and
had a switch to disable it; later we made it off by default and made
it optional (and discouraged) with "-x" and this was for a reason.
Unless the original commit object is also available to the reader of
the history, the line is a useless noise, and many people are found
to cherry-pick from their private branches; by definition, the line
is useless in the resulting commit of such a cherry-pick.
