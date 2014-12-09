From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] doc: document error handling functions and conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf)
Date: Tue, 09 Dec 2014 10:43:52 -0800
Message-ID: <xmqqk320mzo7.fsf@gitster.dls.corp.google.com>
References: <20141203050217.GJ6527@google.com>
	<20141203051344.GM6527@google.com>
	<xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
	<20141204030133.GA16345@google.com>
	<xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
	<20141204234147.GF16345@google.com> <20141204234432.GA29953@peff.net>
	<CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>
	<20141205000128.GA30048@peff.net>
	<xmqqfvcuq8nu.fsf@gitster.dls.corp.google.com>
	<20141207100755.GB22230@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 19:44:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyPlQ-0001Qy-Lm
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 19:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbaLISn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 13:43:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751268AbaLISnz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 13:43:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F44B235D6;
	Tue,  9 Dec 2014 13:43:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jo8UmmnBrsQJrWwS+FkkmPzM/jA=; b=iVefVP
	PLfitARHlvinM2lZWfFfbHXsudGnJSGsFpiczTpmCkp1JwSKibLfOTncvUSGNn0k
	p5iaKBaVadkDlvufcubN7lRGKNWk2r+Sj7Ag8b61WoeN/5YqBRIHjtWr1fsr9C7s
	42nwEX+XT8ASWJzafPprlCKnFTz6VybjeCabk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RuC4tGFU4XKdN2NVyZSL5iFa5JWplCii
	i3SDnEH9LuBgmgOf/NsZBJ7jXqJSorLYaizA5/P6ZfCtfclOlC09CS4mNtQD2eM6
	ubpWNXOUIh99sJOAiIm5+RoHmSUwGVHfJj+MH1fRhi9U+cq4lxMac4jR0tGoRETm
	MsThMaAlms8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36162235D5;
	Tue,  9 Dec 2014 13:43:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95BC1235D4;
	Tue,  9 Dec 2014 13:43:54 -0500 (EST)
In-Reply-To: <20141207100755.GB22230@peff.net> (Jeff King's message of "Sun, 7
	Dec 2014 05:07:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 53B403DE-7FD3-11E4-B0D8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261137>

Jeff King <peff@peff.net> writes:

> On Fri, Dec 05, 2014 at 10:00:05AM -0800, Junio C Hamano wrote:
>
>> I am more worried about variable length part pushing the information
>> that is given later out to the right, e.g. "error: missing file '%s'
>> prevents us from doing X".  Chomping to [1024] is not a good
>> strategy for that kind of message; abbreviating %s to /path/name/...
>> (again, with literally "...") would be.
>
> True. Unfortunately I do not think there is an easy way to truncate the
> expanded strings used by placeholders...
> ...
> Unless we can do something clever with a set of global error strbufs or
> something (i.e., that expand as needed, but the caller does not have to
> free themselves, as they will get recycled eventually). That has its own
> corner cases, though.

I do share your concern that "strbuf"-approach calls for more
boilerplate leading to unmaintainable code, but I offhand do not
have a magic silver bullet for it.  globals are indeed tempting, but
I'd have to say that what Jonathan has may probably be the least bad
of the possibilities.

Chomping also has complications when we have to deal with user
payload (e.g. pathname in UTF-8), which we may want avoid having to
worry about.
