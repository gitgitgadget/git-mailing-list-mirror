From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 09 Jul 2013 09:39:20 -0700
Message-ID: <7v38rnwuvb.fsf@alter.siamese.dyndns.org>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 18:39:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwawr-0002tK-E9
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 18:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab3GIQjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 12:39:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197Ab3GIQjY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 12:39:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F5E52F8BA;
	Tue,  9 Jul 2013 16:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+fYrq+nYhlKeJXGEUtHr3qOspoY=; b=i189UT
	KNYRtrrFzpkf5IskptwEh0733pYRMI63hYWWuXAGv3UdLOtHlS37InKCpzowNW3X
	R3+QE0GUTPOGKNLzpy4GixZQU9XVIjd+B7sePzsWvVyJoTheS6vRM9Mw76XoO6hE
	+iaWLjWW1aEUakRTir+9eajhf4cNiEZ53/sAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iWxg9an8QNf/2smIp1wwrE1nLZCDvwsI
	qTUf0WbHY0oFvst4WbDZA3OMfLYB0GWgoJsnvg4qXSI95Mzp21dFVkMGgfBB7WeA
	ADKuU228GsP6tdtQ6NbiRuOfB+kZShbd7A4pZMkDw414X8RTDG6SyqBPrPcJ4RqP
	fA1LJ3voNS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3166E2F8B9;
	Tue,  9 Jul 2013 16:39:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E77F2F8B6;
	Tue,  9 Jul 2013 16:39:21 +0000 (UTC)
In-Reply-To: <CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 9 Jul 2013 11:04:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BAF214A-E8B6-11E2-9F65-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229966>

Eric Sunshine <sunshine@sunshineco.com> writes:

> As implemented by this patch, the behavior of git-blame with multiple
> -L's is consistent with that of git-log with multiple -L's. The
> implemented behavior feels intuitive to me, but I can see how the
> behavior you suggest could feel intuitive to others.
>
> If I re-do the patch to work the way you describe above, how should we
> deal with the inconsistent behaviors between the two commands?

To be extremely honest, I do not care too deeply about what log -L
does today, because it is still in "may have rough edges but is an
interesting toy to play with" state in my mind ;-)

The suggestion to error out was more about "start simple, strict and
obvious to make it easy to explain" and nothing else.  If we start
with a simple and strict version, we can later loosen it without
making an input that was valid earlier invalid.  If we start with
too loose, on the other hand, it would be hard to tighten it later.

But the only two things I care deeply about are, in a file whose
contents is:

	C
        B
        A
        B
        C
        D

 (1) The range "-L /A/,/B/" finds the first A from the beginning,
     and then chooses B that comes _after_ it, making it equivalent
     to -L3,4 (not -L3,2 or -L2,3).

 (2) In the ranges "-L <anything>,/B/ -L /C/,<anything>", the
     beginning of the second range is found by choosing C that comes
     _after_ the end of the previous range (/B/ may choose either
     the second or the 4th line, and the only C that comes after
     either of them is the 5th line and that is where the second
     range should begin, not at the beginning of the file).  The
     same for "-L 1,3 -L /C/" (only C that comes after 3 is eligible
     to be the beginning of the second range).

I view it as a nice addition to coalesce two overlapping ranges
given exactly by numbers, e.g. "-L 100,200 -L 50,102".  I do not
have a strong objection to it, as long as it does not interfere
negatively with ranges specified by patterns.

Thanks.
