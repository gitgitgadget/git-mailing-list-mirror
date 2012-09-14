From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
 test suite for detecting heap corruption
Date: Fri, 14 Sep 2012 10:51:33 -0700
Message-ID: <7v392k5w7u.fsf@alter.siamese.dyndns.org>
References: <1347641662-3596-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:51:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCa3N-0003re-N9
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 19:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759710Ab2INRvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 13:51:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49375 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758624Ab2INRvg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 13:51:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAE369763;
	Fri, 14 Sep 2012 13:51:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZJVi/kp6mSNRf2YdJVKjiid0OJo=; b=wAd6eN
	WrSAPMo/Hq6dsCv58MDEBMc94y2q2fFXv4uRq+VfadltDNskNHvaGfe5RIpQNjhv
	eWcaV6pjehQ9UcFMvgRdepsk1p3xgR0Yiz0FsmXrsjRECK3PUvCHtveFG3qwbS6z
	vq7s5qrsiicHGqcxW7X3Duo5qnFnGnnLA5JKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DrPB3s7eRGFzlsTY7B05qxKDC4eL4vDq
	eZXjODoZtZp6lQrsCEnYFVf6qJZcYgyl7JAd/5Ht/u1gRrbttMw7PGO/TwfHjiNf
	QzetxZcp6R4+pPRwU3ym8502pwAGfyVqRJqTFBuNSeBGFFzxdG0mcXWvQjGZxVTA
	wgeQ6trgsLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A927A9762;
	Fri, 14 Sep 2012 13:51:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 101669761; Fri, 14 Sep 2012
 13:51:34 -0400 (EDT)
In-Reply-To: <1347641662-3596-1-git-send-email-gitter.spiros@gmail.com> (Elia
 Pinto's message of "Fri, 14 Sep 2012 09:54:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D341A2FE-FE94-11E1-BB6C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205517>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Recent versions of Linux libc (later than 5.4.23) and glibc (2.x)
> include a malloc() implementation which is tunable via environment
> variables. When MALLOC_CHECK_ is set, a special (less efficient)
> implementation is used which is designed to be tolerant against
> simple errors, such as double calls of free() with the same argument,
> or overruns of a single byte (off-by-one bugs). When MALLOC_CHECK_
> is set to 3, a diagnostic message is printed on stderr
> and the program is aborted.
> ...
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This the third reroll of the original patch.

Well written.  I have one suggestion and a question, though.

>  t/test-lib.sh |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 78c4286..f34b861 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -93,6 +93,15 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
>  export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
>  export EDITOR
>  
> +# Add libc MALLOC and MALLOC_PERTURB test 
> +# only if we are not executing the test with valgrind
> +expr "$GIT_TEST_OPTS" : ".*\(--valgrind\)" >/dev/null || {

I would write this like

	if ! expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null
	then
		...
	fi

> +	MALLOC_CHECK_=3
> +	export MALLOC_CHECK_
> +	MALLOC_PERTURB_="$( expr \( $$ % 255 \) + 1)"

How was this expression chosen?  The only effect I can think of to
use a randomly picked value here is to make it impossible to make
the test repeatable and reproducible, so you must have had some
benefit that outweighs the downside, but I cannot think of any.
Wouldn't MALLOC_PERTURB_=165 (i.e. 0xA5, half of the bits in the
byte is set, including the MSB, and is an odd number) be equally a
good choice without repeatability downside, for example?

Also, doesn't the above give 256 sometimes, which would not fit in a
byte?

> +	export MALLOC_PERTURB_
> +}
> +
>  # Protect ourselves from common misconfiguration to export
>  # CDPATH into the environment
>  unset CDPATH
