From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] test-terminal: give the child an empty stdin TTY
Date: Mon, 12 Dec 2011 11:07:21 -0800
Message-ID: <7vfwgp4niu.fsf@alter.siamese.dyndns.org>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:07:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaBDl-0005Ax-NR
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab1LLTHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:07:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461Ab1LLTHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:07:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9F725006;
	Mon, 12 Dec 2011 14:07:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bN4exBdANUYHas7gZjZ3T7lztpw=; b=CBN2E7
	tvTJsH/reGeHAYVb8QgE71zx1bS8/zR84/IiC7ftJ6OahQxoEs9KDvixWNQBzWqL
	thBTksYqRaRvD/W4R/4GvOF2RUToWngqbsMsNjvx7ojRPSdqP8BeBGlZnJqjwjhL
	IRnnme8v/npNNe9knaWDdhFX95DpI/Mp2ZcLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SHfZ+LfAnW5LZfeS0Y+3JaWixMlRo0r4
	cgsbZqeaj/ASH7n+a5KG6mZDdR/iYydN2ZV3VuOJWdlBf4PC8Ql2yMqAQfmvI09x
	5Bi74LceyeNW2QfSrUrlA53q2qaDorTwycw5KGua16Sbl6L8WrPVd/esYOQwtmVp
	fDda64taPBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0DFA5005;
	Mon, 12 Dec 2011 14:07:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44CEE5002; Mon, 12 Dec 2011
 14:07:23 -0500 (EST)
In-Reply-To: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon, 12 Dec 2011 19:09:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85C840DE-24F4-11E1-B20E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186933>

Thomas Rast <trast@student.ethz.ch> writes:

> So far, test-terminal.perl did not care at all about the stdin (that
> is, leave it as-is).  This mostly works well, but git-shortlog is a
> problem:
>
> * It takes decisions based on isatty(0).  (No test checks this, but
>   compare 'git shortlog </dev/null' with 'git shortlog' in a
>   terminal.)
>
> * It reads all of stdin if !isatty(0) and no arguments were passed.
>
> Because of the latter, t7006.58ff cause unexpected results if you do:
>
>   git rev-list <range> |
>   while read sha; do
>     git checkout sha
>     make test
>   done

In the above, lack of dollar-sign in "git checkout $sha" is obvious ;-)
but I think it is a bug that you are not running make with its stdin
redirected from /dev/null in the first place.

Perhaps "make test" should do that for all tests, not just this terminal
related one? Doing it this way we do not have to worry about other tests
reading from the standard input by mistake.

-- >8 --
Subject: Do not let the tests read from standard input stream

Consider running a loop like this:

   git rev-list <range> |
   while read commit
   do
	git checkout $commit && make test || break
   done

If any of the test reads from the standard input, we may end up running a
test for just one commit (and while running the test for that commit, the
remainder of the rev-list output is consumed by the test). A workaround
would be to redirect like this:

    git checkout $commit && make test </dev/null || break

but the Makefile should be doing that for us instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ed82320..7a85237 100644
--- a/Makefile
+++ b/Makefile
@@ -2239,7 +2239,7 @@ export NO_SVN_TESTS
 ### Testing rules
 
 test: all
-	$(MAKE) -C t/ all
+	$(MAKE) -C t/ all </dev/null
 
 test-ctype$X: ctype.o
 
