From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: configure: use AC_SEARCH_LIBS instead of
 AC_CHECK_LIB
Date: Sun, 19 Jul 2009 09:13:41 -0700
Message-ID: <7v3a8szm4q.fsf@alter.siamese.dyndns.org>
References: <m34ot9c67t.fsf_-_@localhost.localdomain>
 <a52be8ba36206abc5ff5c91a759036a931e2658c.1248007036.git.nicolas.s.dev@gmx.fr> <20090719131404.GA11546@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	David Syzdek <david@syzdek.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun Jul 19 18:13:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSZ1T-0003vP-9V
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 18:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbZGSQN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 12:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbZGSQNz
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 12:13:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbZGSQNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 12:13:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 04824A9E9;
	Sun, 19 Jul 2009 12:13:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 55387A9E8; Sun, 19 Jul 2009
 12:13:43 -0400 (EDT)
In-Reply-To: <20090719131404.GA11546@vidovic> (Nicolas Sebrecht's message of
 "Sun\, 19 Jul 2009 15\:14\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 277CEA52-747F-11DE-8D34-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123555>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> I wonder if we could have some feedbacks on this patch. The change on
> the whole file may make more bad than good. Works as expected here on
> Linux (glibc 2.9).
>
> Otherwise, the following lines are sufficient to correct the original
> error:
>
>>  test -n "$NEEDS_RESOLV" && LIBS="$LIBS -lresolv"
>>  
>> -AC_CHECK_LIB([gen], [basename],
>> +AC_SEARCH_LIBS([basename], [gen],
>>  [NEEDS_LIBGEN=],
>>  [NEEDS_LIBGEN=YesPlease])
>>  AC_SUBST(NEEDS_LIBGEN)

Thanks.

The autoconf documentation does not give much confidence either way:

	AC_CHECK_LIB requires some care in usage, and should be avoided in
	some common cases.

It is unclear what these "some" are, and is sufficiently unclear for us to
decide if our situation falls into these "some common cases."  The only
problem it cites is that alternative libraries may contain a variant
implementation of the same function found in a more common library, in
which case you may not want to use such an alternative implementation, and
I do not think "basename() in -lgen" falls into that category.

It does say

	These days it is normally better to use AC_SEARCH_LIBS(...)
	instead of AC_CHECK_LIB(...).

but without any further justification, which does not help building
confidence in the suggestion.

It is very tempting to revert the configure.ac part of commit ecc395c
especially in an -rc freeze, but if some autoconf experts can help us
decide by clarifying the situation, and explain why AC_SEARCH_LIBS() is
indeed the better way these days (which I suspect it is), I'd say we can
apply your patch to favor AC_SEARCH_LIBS() over AC_CHECK_LIB() with more
confidence.

If autoconf people say AC_SEARCH_LIBS() should be preferred over
AC_CHECK_LIB(), it probably is the right thing to do.  But I want to have
a warmer-and-fuzzier feeling that we understand why it went wrong, rather
than blindly doing what the documentation says because the documentation
tells us to.
