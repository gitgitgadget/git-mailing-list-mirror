From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] make config --add behave correctly for empty and NULL values
Date: Fri, 12 Sep 2014 10:29:25 -0700
Message-ID: <xmqqa964bvd6.fsf@gitster.dls.corp.google.com>
References: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>
	<xmqqvbppwtir.fsf@gitster.dls.corp.google.com>
	<20140819051732.GA13765@peff.net>
	<xmqqmwb1vwvs.fsf@gitster.dls.corp.google.com>
	<20140819062000.GA7805@peff.net>
	<xmqqy4tpbuii.fsf@gitster.dls.corp.google.com>
	<54129F66.9080905@gmail.com> <54129FE1.6020303@gmail.com>
	<vpqegvhfe5p.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 12 19:29:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSUf7-0000sY-Ht
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 19:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbaILR33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 13:29:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64149 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbaILR32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 13:29:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE84837874;
	Fri, 12 Sep 2014 13:29:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PLiLas/zo0Wq7mFWt6pG2s8Xwho=; b=F5AOV5
	fA6/zC1O1CNf+935sdzMEi8EEYT48mplfddd+5TlwJQWEyRUexiDuq7ibRvWTZUq
	ypEVHGB29qTq/N5ELgqdfKOkEQ4olBTLzO8FA/2UGdhRURxf8kK7o346Uh3UojUZ
	5exOdVh1psw57i3ue+TIllLCOL1bUD8rbkJy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJXjuThP0xk3DY20mG+OvDpJYkieHBOW
	mbQITfv4jU4k9P3ResbIYDb9YtVCcZY99hg0Vl0E+S10iZWGyaJAmkaXUMAbtjbd
	xOsG8k5CyNx4BjGNlIvRmkj58LhnYGbYDAkaHKySaQU1SiI5+IiK6lW5fw1n5VXH
	4P4CZ9HtVLw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D450837873;
	Fri, 12 Sep 2014 13:29:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E75D3786D;
	Fri, 12 Sep 2014 13:29:27 -0400 (EDT)
In-Reply-To: <vpqegvhfe5p.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	12 Sep 2014 10:15:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 58966A7A-3AA2-11E4-86B2-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256929>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> +const char CONFIG_REGEX_NONE[] = "a^";
>
> I have a slight preference for this version (no magic (void *)1 value,
> and belts-and-suspenders solution since someone actually using the regex
> should still get a correct behavior.
>
> But I'm fine with both Junio/Peff's version or this one.

I do not care too deeply either way, to be honest.

But if we were to redo this in the right way, I suspect that the
best solution may be to correct the root cause, which is the design
mistake in the git_config_set_multivar_in_file API.  The function
takes a regexp (possibly NULL) and a multi_replace bit, and with
that expresses these three combinations:

    - a non-NULL regexp means only the existing ones that match are
      subject to replacement;

    - NULL regexp means all of the existing ones that match are
      subject to replacement;

    - multi-replace bit controls which ones among the replacement
      candidates are replaced (either the first one or all).

But we actually want to express three, not two, different handling
for the existing entries.  Either (1) use the regexp to decide which
ones are subject to replacement, (2) declare all of them are subject
to replacement, or (3) declare none of them are to be replaced.  The
last one cannot be expressed without coming up with a trick to say
"I am giving a regexp that hopefully will not match anything as a
workaround because otherwise you will replace all of them but what I
really want to say is I do not want you to replace anything", and
this thread discusses a fix to the bug in the implementation that
failed to come up with a "hopefully will not match anything"
pattern.  And we are still discussing to fix a better workaround.

Instead of polishing the workaround, wouldn't it be better to make
it unnecessary to work it around?  For exaple, we could turn the
last parameter to the function into an "unsigned flag" with two
bits, CONFIG_SET_USE_REGEXP_TO_FILTER (if set, use the regexp to
filter which of the existing entries to be replaced) and
CONFIG_SET_REPLACE_MULTI (if set, replace all the eligible ones),
and the result would be conceptually a lot cleaner, no?

Some notes:

 - Because most callers expect "replace" behaviour, instead of
   adding CONFIG_SET_USE_REGEXP_TO_FILTER to the majority of
   existing callers, a new flag CONFIG_SET_JUST_APPEND (which is
   exactly the negation of the USE_REGEXP_TO_FILTER) would be a more
   practical thing to introduce.

 - We can keep using value_regexp==NULL (under !JUST_APPEND) to mean
   value_regexp=".*", i.e. matches anything, as a short-hand.

Hmm?
