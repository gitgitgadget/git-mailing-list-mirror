From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fallback on getpwuid if envar HOME is unset
Date: Tue, 21 Aug 2012 11:22:32 -0700
Message-ID: <7vzk5ocdg7.fsf@alter.siamese.dyndns.org>
References: <CAFFUb6WiXJ0n4NkhOQ=+mcfs+uaAo2_G6TOs7L=AuPwPVfxyMg@mail.gmail.com>
 <20120821023033.GB20271@sigill.intra.peff.net>
 <CAFFUb6UypNJ-8p8Hs14+QMGeU3KSG+pQX7NJTeh3OtBoTZoO3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Conley Owens <cco3@android.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 20:23:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3t6T-0004KP-2b
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 20:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262Ab2HUSWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 14:22:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932268Ab2HUSWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 14:22:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 604DB8048;
	Tue, 21 Aug 2012 14:22:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G20x8cNJovwF8jlBRvl3796jtZk=; b=gIfdTr
	/bhZSXcgGkBRZorU3jlN9/lNH/bYnksLdRqeKry8pUeQxjrpObZg3gc5BVlxK2mq
	0igYagX4Ra+OpKxWX3vVaCkDDi0DwRPawIs4dmu8BS0izkxEdQOsW58RbzBKeqG0
	3FL8YZwoty356warnx/Cj4It0sbOWtJSWD5mQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rw800lsrB5A3njnSNm8i8+RlF2Na1tSy
	pDe+m8XDwltMIeACoO7B2kHmYRkyWNgkUeuxpJCz30WtjeA0TDkB0jiZhlieLnTY
	erT26V/G2pIo4mskKutavFnTEm4Ak4i5UqvmgnpBNYok/kVGFCQ23BBhdMOCZIE5
	fxHvf2dTrVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 339FC8047;
	Tue, 21 Aug 2012 14:22:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 899238044; Tue, 21 Aug 2012
 14:22:34 -0400 (EDT)
In-Reply-To: <CAFFUb6UypNJ-8p8Hs14+QMGeU3KSG+pQX7NJTeh3OtBoTZoO3g@mail.gmail.com> (Conley
 Owens's message of "Tue, 21 Aug 2012 10:18:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DB08876-EBBD-11E1-973A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203979>

Conley Owens <cco3@android.com> writes:

> On Mon, Aug 20, 2012 at 7:30 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Aug 20, 2012 at 06:28:57PM -0700, Conley Owens wrote:
>>
>>> From f64ba3c908b33a2ea5a5ad1f0e5800af76b82ce9 Mon Sep 17 00:00:00 2001
>>> From: Conley Owens <cco3@android.com>
>>> Date: Mon, 20 Aug 2012 18:23:40 -0700
>>> Subject: [PATCH] Fallback on getpwuid if envar HOME is unset
>>
>> Please drop these lines from the message body; they are redundant with
>> your email's headers.
>>
>> This seems sensible on the surface, but I'm a bit curious: why isn't
>> $HOME set? And are there any reasons that somebody who has unset HOME
>> would not want to fallback?  For example, running under Apache, HOME is
>> often unset when calling CGI programs. Would it make sense for us to
>> look in ~www-data/.gitconfig in that case?
>
> I think it might, but perhaps I'm wrong.  As another example, upstart strips all
> the environment variables, so if you run a job as a particular user, that user's
> .gitconfig will not be read unless HOME is specified.

Do you mean upstart as the "replacement init.d mechanism"?  If that
is the case, the responsibility to set up HOME was moved to the
scripts by upstart if they rely on having a sane value in $HOME; I
do not see it as Git's problem, as it is not the only program that
looks at and acts on the value of $HOME [*1*].

Where do shells (e.g. bash and dash) go when you say "cd" without
parameter when $HOME is unset, for example?  I do not think they
magically read from getpwent() and use the value from there to fill
the $HOME's place.  We should follow suit.


[Footnote]

*1* I further have to suspect that enough scripts would be
inconvenienced by such a (mis)feature in upstart that over time the
environment scrubbing may have to be rethought in upstart, and at
that point, this entire discussion would become moot.
