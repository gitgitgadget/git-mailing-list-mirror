From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] test-terminal: give the child an empty stdin TTY
Date: Mon, 12 Dec 2011 12:38:24 -0800
Message-ID: <7v7h2134qn.fsf@alter.siamese.dyndns.org>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch> <7vfwgp4niu.fsf@alter.siamese.dyndns.org> <20111212191602.GA14061@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 21:38:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaCe2-0002i4-HV
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 21:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab1LLUi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 15:38:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870Ab1LLUi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 15:38:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3CE16DCB;
	Mon, 12 Dec 2011 15:38:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HIAIpaQHkiUx73kKDLJC+Ot8w0k=; b=lsYGjj
	SJgdJbE76Rmn54DfluzbIw1EE0v9zXWnwvYN8YmEVpbwP3TCYEoLuwZd8qUaHGwj
	rgC5/61YCMgGF6J6ZXooh3GZxc09yIawk/wHo/MJtpRbJfvQ0N7tehofFfT2Kz/9
	q6nB4xspNUZuwjWhGYvtuUeVQgO6hgMQ2gRio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W/Hjbf7ADq2lz6K0DE0whaAKNKM18kvD
	kJc0CmiaEE++zz4sHkzJtggNTabMrFDkXBrhnhEN+ZjFD58JQoJrihxkpYDuFvM+
	DnjRekqoacLLpY8lAHVg9g/iygzA6yTBz/eCRrRNW55NQ7zDLn9uhbA0rxFr4qQY
	N+NM1TgFf4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA15E6DCA;
	Mon, 12 Dec 2011 15:38:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5060D6DC8; Mon, 12 Dec 2011
 15:38:26 -0500 (EST)
In-Reply-To: <20111212191602.GA14061@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Dec 2011 14:16:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E0311FE-2501-11E1-89D5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186945>

Jeff King <peff@peff.net> writes:

> Is this right place to do it?
>
> It doesn't catch "cd t && make"....

That's just an illustration. I know my audiences who will give us real
tested patches are intelligent ;-).

And I tend to agree that at the test-lib.sh level might be a bit too low
for convenience of debugging, but it is probably a good start. An obvious
alternative would be a patch similar to the illustration patch applied to
t/Makefile.

As I said in a separate post, I think this is orthogonal to the
test-terminal patch under discussion. Being able to give the tested
programs an environment that mimics an interactive tty session better is a
good thing to do regardless of the "test should not read from make's stdin"
issue.

> happen in t/Makefile. But I actually wonder if it should be in
> test-lib.sh, as it is as much about cleaning up the test script's
> environment as it is about protecting people running "make test" in a
> loop. I.e., something like:
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index bdd9513..5a38505 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -198,6 +198,9 @@ else
>  	exec 4>/dev/null 3>/dev/null
>  fi
>  
> +exec 6<&0
> +exec 0</dev/null
> +
>  test_failure=0
>  test_count=0
>  test_fixed=0
>
> One downside of that approach is that it makes it harder to insert
> questionable debugging statements into test scripts. E.g., sometimes I
> will temporarily throw a "gdb" or even a "bash" invocation into a test
> script to investigate a failure. But that would still be possible by
> redirecting from "<6".
>
> -Peff
