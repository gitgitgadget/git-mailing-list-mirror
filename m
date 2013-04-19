From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3400 (rebase): add failing test for a peculiar rev spec
Date: Fri, 19 Apr 2013 09:21:24 -0700
Message-ID: <7vvc7i330b.fsf@alter.siamese.dyndns.org>
References: <1366275155-26244-1-git-send-email-artagnon@gmail.com>
	<7vmwsv94jo.fsf@alter.siamese.dyndns.org>
	<CALkWK0=RDCCSxOJ2TU4=tniSRTg9VJohJ8Pf6uN9E=fd3jg=_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 18:21:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTE48-0004ym-L9
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385Ab3DSQVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:21:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59146 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756221Ab3DSQV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 12:21:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8976515003;
	Fri, 19 Apr 2013 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iYVKJR/1wYvzQo065v1e2eTuK90=; b=R4ApoH
	lLRGRdelZdAAy+lBTu26yatx9O/Efk33Jhtoj6zWBx93GA9lb/c6IvLEKoXjC76D
	dN5oGq3tzhk9mI1ehKni2AKC8pHhf6V3z6KMGI3PXURKl8aZwpR6f21Y1F1ejF6z
	tZlGs8+dTfTZmugLkqyaTZJXAUe9PRb+DyHkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dS5GFCF1k0Zhr7kerzNrKgGXfZyTHtBg
	V1XfxxNyfqXxXSGTT9Rni5PC6szrePn4Vib5VQPLrTzeKixqxXce/8+DSZrO1Tyz
	9XzMZXqTG2K0X9p0j/DA81Iyn4JiDRzMaZIO8WlLLZhOXttK68ZU0mlmpiVCwbbL
	5qIoETjt554=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 818AF15002;
	Fri, 19 Apr 2013 16:21:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D622E16FFA;
	Fri, 19 Apr 2013 16:21:26 +0000 (UTC)
In-Reply-To: <CALkWK0=RDCCSxOJ2TU4=tniSRTg9VJohJ8Pf6uN9E=fd3jg=_Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 19 Apr 2013 13:13:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F5D3C1A-A90D-11E2-A6EF-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221767>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I'm more interested in knowing what you think of my first point: is
> :/text fundamentally broken, as it can't be combined with other
> operators like the other rev specs can?  If so, how do you think we
> should fix it?

The question :/string wants to ask is fundamentally ambiguous once
you start wanting to give arbitrary string to it.

Think what this asks:

    git show ":/Fix regression introduced by commit v1.5.1-rc1"~113^2

Is it looking for a commit that fixes v1.5.1-rc1 and then locate the
side branch that waas merged by the 113th-generation parent of that
fix?  Or is it looking for the commit that fixes v1.5.1-rc1~113^2?

When we introduced a postfix $rev^{/string} operator at 32574b68c57f
(get_sha1: support $commit^{/regex} syntax, 2010-12-13) to dig from
a given rev, we designed it so that we can disambiguate between the
two: HEAD^{/Fix v1.5.1~113^2} vs HEAD^{/Fix v1.5.1}~113^2.

But the tradeoff made with 28a4d9404438 (object name: introduce
':/<oneline prefix>' notation, 2007-02-24), which is much older than
the $rev^{/string} syntax, is to help casual interactive use by not
requiring sometimes-hard-to-type line noise characters.

Even back then, I did not want to paint us into a corner we cannot
escape from, and made sure the syntax has an escape hatch built-in.

cf.

  http://thread.gmane.org/gmane.comp.version-control.git/40460/focus=40477

If you cared deeply enough, you could activate it, to take something
like:

    git show ":/!(s=Fix regression by v1.5.1-rc1~113^2)~20"

to say "The 20th-generation parent of the commit whose subject says
it fixed regression at v1.5.1-rc1~113^2".

That would make this

	":/!(a=Ramkumar)(s=move diff.wordRegex)~4"

a way to find the fourth-generation parent of 2ead7a674d7f (t5516
(fetch-push): update test description, 2013-04-02) as a natural
extension, I guess.
