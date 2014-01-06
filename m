From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report: stash in upstream caused remote fetch to fail
Date: Mon, 06 Jan 2014 12:17:21 -0800
Message-ID: <xmqq61pwj25q.fsf@gitster.dls.corp.google.com>
References: <CAECVvXYD69Xrp85bVJg6XogvctUTwrFDae+3tawFgoCAUGhwGg@mail.gmail.com>
	<20140106152742.GA26221@sigill.intra.peff.net>
	<xmqqbnzpkrvk.fsf@gitster.dls.corp.google.com>
	<20140106193625.GA27062@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Burke <spraints@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 21:17:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0GcL-0000Bk-V6
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 21:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036AbaAFURa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 15:17:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254AbaAFUR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 15:17:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA987610D6;
	Mon,  6 Jan 2014 15:17:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JtQuoJsMLpQ3RnXWXgPEQQTLINc=; b=f/iyQ8
	AAdKglwULTw/CtxWQ1mT786ifGrxInBKDJh3FiDsKqEVA7ZZWEAzlLglLvB12Xio
	IzdKmfvZwSX0QB2UUXVofshTwQvNwL2wndcXREox0nl3kb/KfPN1kLDwxTK+njCn
	T1U5ayyXIV1j0doDgCfPIWRTk9Hi+Dq5AWmYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pqNCLCMoOmsySl1QImt/Iv+XJnmN96qS
	PukdQ2dQmqihDVxxOF/6xcuZs3dEKJVMoDXztyC+SgixoZklv1V81EqXz2DQLfsj
	S5wEqDF4XP99Ne7UBhpxA6PQMgXUWwjFXZRwUBTUP/pUZ7wxsZgKygKrhrB4/WHn
	um1rA/GIkIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2C2A610D1;
	Mon,  6 Jan 2014 15:17:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BD85610C7;
	Mon,  6 Jan 2014 15:17:23 -0500 (EST)
In-Reply-To: <20140106193625.GA27062@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 Jan 2014 14:36:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8DF74B78-770F-11E3-8BCD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240056>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 06, 2014 at 08:16:31AM -0800, Junio C Hamano wrote:
>
>> > I was going to ask you to send your repository, but I can easily
>> > reproduce here. I guess people don't run into it because it's uncommon
>> > to fetch the whole refs/ namespace from a non-bare repo (and bare repos
>> > do not tend to have stashes). Here's a minimal reproduction recipe:
>> >
>> >   git init repo &&
>> >   cd repo &&
>> >   echo content >foo &&
>> >   git add . &&
>> >   git commit -m foo &&
>> >   echo more >>foo &&
>> >   git stash &&
>> >   git init --bare sub &&
>> >   cd sub &&
>> >   git fetch .. 'refs/*:refs/*'
>> >
>> > It looks like we are not feeding refs/stash properly to pack-objects.
>> > I'll try to take a closer look later today.
>> 
>> I looked at this in the past and I vaguely recall that we reject it
>> in the for-each-ref loop with check-ref-format saying "eh, that is a
>> single-level name".
>> 
>> At that point I stopped digging, thinking it was a feature ;-)
>> based on your exact observation about stash vs bare/non-bare.
>
> I am fine with rejecting it with a warning, but we should not then
> complain that the other side did not send us the object, since we should
> not be asking for it at all. I also do not see us complaining about the
> funny ref anywhere.  So there is definitely _a_ bug here. :)

Oh, no question about that.  I was just pointing somebody who
already has volunteered to take a look in a direction I recall was
where the issue was ;-)

Thanks.

>
> I think somebody else mentioned recently that we do not handle malformed
> refs consistently. I think it was:
>
>   http://article.gmane.org/gmane.comp.version-control.git/239381
>
> which might or might not be related.
>
> -Peff
