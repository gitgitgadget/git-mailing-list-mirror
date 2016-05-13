From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t3404 static check of bad SHA-1 failure
Date: Fri, 13 May 2016 13:03:41 -0700
Message-ID: <xmqqshxl9142.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEiH6oxq=KXfz1pqOue9VKnkp=S8zNqC4OFmbuhRFFxoMw@mail.gmail.com>
	<20160513182325.GB30700@sigill.intra.peff.net>
	<xmqqwpmx91mb.fsf@gitster.mtv.corp.google.com>
	<20160513195911.GE9890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 13 22:03:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1JJN-0001w3-7l
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbcEMUDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:03:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932211AbcEMUDo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:03:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68476195D8;
	Fri, 13 May 2016 16:03:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VTOpFIhoFau01jEsHbrWeaaCxHI=; b=Wo7cPl
	emJIYPpOTN5JU7A0Zlf+ZPZTkM5gC03rAwzpA2AdanVAbPnaYDU7feLd4KfkUAS5
	DcIWV8GWDRSCL2aR7KqLQlKHqqTmffdEz9F2MC9h7TvzGH9HwdSb+uFk8MQyI5TT
	3yTmNpFuZaFuCRxXMvcf5NCzcQp0WCeg+qA1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=acCpLEyc5FJ8WIDCOkJHedxuvZ2MfEon
	N03+urUXvKApmWwmrt5OT9RjZpfhz9LmwPFbuNkUKhog6CA30jjL+PvTXpYF8cpd
	ruL7yz9chuw1372rE9M+pjHsPg61qnUd6WubiZnlUZatPvDpw8Q9HPDqUHxJ6LNP
	2qofbNmZWBY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F0C0195D7;
	Fri, 13 May 2016 16:03:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9742195D6;
	Fri, 13 May 2016 16:03:42 -0400 (EDT)
In-Reply-To: <20160513195911.GE9890@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 May 2016 15:59:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CAE8C428-1945-11E6-BC09-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294570>

Jeff King <peff@peff.net> writes:

> On Fri, May 13, 2016 at 12:52:44PM -0700, Junio C Hamano wrote:
>
>> I _think_ "test -z" should succeed according to POSIX, because
>> 
>>  (1) it is not "test -z string" because it lacks string,
>> 
>>  (2) it is not any of the other "test -<option> thing" because -z,
>>     and
>> 
>>  (3) the only thing it matches in the supported form of "test" is
>>      "test <string>" that tests if the <string> is not the null
>>      string, and "-z" indeed is not the null string.
>> 
>> For the same reason, "test -n" succeeds.
>
> Yeah, I think you're right; POSIX is pretty clear that this falls under
> case 3. So that means "test -z" quietly does what we want. But it means
> that "test -n" does the _opposite_ of what we want.

;-)

> And sadly,
>
>   git grep 'test -n [^"]'
>
> is not empty.

Are you doing an audit?  Otherwise I'm interested in taking a brief
look.

>> But working around older/broken shells is easy and the resulting
>> script it more readable, so let's take this.  It makes the resulting
>> code easier to understand even when we know we run it under POSIX
>> shell.
>
> Yep. The POSIX-explanation of what is going on might be worth putting in
> the commit message for the "-z" case (i.e., it should work, but the
> "why" is subtle).

Perhaps.

A small consolation for ksh fans around is that ksh93 seems to get
this case right ;-)
