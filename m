From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't tried Negotiate
Date: Fri, 05 Feb 2016 09:54:50 -0800
Message-ID: <xmqq60y3dout.fsf@gitster.mtv.corp.google.com>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
	<xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
	<20160202232952.GA6503@vauxhall.crustytoothpaste.net>
	<CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, daniel@haxx.se
To: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 18:55:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRkax-0003SU-Jj
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 18:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbcBERyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 12:54:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751762AbcBERyx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 12:54:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D974407C7;
	Fri,  5 Feb 2016 12:54:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FS6DpxK7tskybbsRJfTP+WqiiRU=; b=Oc+NVW
	l5PECbzLHXhxADyp9yqIsfg49k6qM1N9lAB2F+2CKlmviNm80aOp8NCctTDUOlT7
	DVgrVhi+qKgoYiUtfHPEshQiYD6sUgLGdNIsrirRQViu2asGfVIczny47nLP1hRW
	5ZYprvE+7GNaKqhHKPz9Z1A2svA8GDpchLkW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JtSW9BkLLUvgYikpSbcQXUTU6lUkmiBm
	UnspQ2OBvKsjWsIFCZMu+i0LwbI6Ny1jB8uGz7RCDybW1LN4kGkULRR65AdH+ao3
	lx7HIGzZFBNdgfSmzNiKUETohYhqkxENhLdU2UYM/y3+5TYbKJVcOM/PiAE4CGGl
	o3vF80JSSXM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5441E407C6;
	Fri,  5 Feb 2016 12:54:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B344A407C5;
	Fri,  5 Feb 2016 12:54:51 -0500 (EST)
In-Reply-To: <CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
	(Dmitry Vilkov's message of "Fri, 5 Feb 2016 12:18:22 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E586722-CC31-11E5-8F7B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285591>

Dmitry Vilkov <dmitry.a.vilkov@gmail.com> writes:

> 2016-02-03 2:29 GMT+03:00 brian m. carlson <sandals@crustytoothpaste.net>:
>> I'm unclear in what case you'd need to have a username and password
>> combination with GSS-Negotiate.  Kerberos doesn't use your password,
>> although you need some indication of a username (valid or not) to get
>> libcurl to do authentication.
>>
>> Are you basically using a bare URL (without a username component) and
>> waiting for git to prompt you for the username, so that it will then
>> enable authentication?  If so, this patch looks fine for that, although
>> I'd expand on the commit message.  If not, could you provide an example
>> of what you're trying to do?
>
> You are right, we are using a bare URL (without a username component).
> With username encoded in URL everything works just fine. But it's
> generally wrong to pass creds in URL (in my opinion) and security
> policy of my employer prohibits doing such thing.
>
> Anyway, as you said libcurl needs valid (not NULL) username/password
> to do GSS-Negotiate, so there is nothing wrong if I set empty
> username/password combination when git prompts for creds. 

OK, as Brian said, that use case would need to be in the log
message, at least.  I am curious, though, if you can give just a
random string to username, or at least that must match what the
underlying authentication mechanism uses.

Brian, I can see how this would work in that use case, but I haven't
convinced myself that the change would not affect other existing use
cases that are supported--do you think of any that would negatively
affect the user expeerience?

> Even more,
> there is no other way to let libcurl to use GSS-Negotiate without
> username in URL.

Asking lubcurl expert about that might not be a bad idea; Cc'ed
Daniel Stenberg.
