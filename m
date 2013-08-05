From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/11] t8001/t8002: blame: demonstrate -L bounds checking bug
Date: Mon, 05 Aug 2013 12:29:45 -0700
Message-ID: <7v4nb4j5qu.fsf@alter.siamese.dyndns.org>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
	<1375258545-42240-3-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 21:29:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6QTa-0007aw-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 21:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591Ab3HET3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 15:29:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab3HET3t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 15:29:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BAB236061;
	Mon,  5 Aug 2013 19:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Olvb4sYLFquE4zEJwg8n7IA1TO8=; b=lgjFCD
	OTHbvSSjthNXd6m3UCBDHtRhzVM+5t/TCAmXNrE73ck6nQq1smFkk0+oanrOUjRP
	yYBINYH3UqHe55jP2lVsRIII0uW3v+gR1L7zP0GI32tx6QVuMnoiqQJjaORglTrI
	edvnncP9mQWBODp7Yc5BMOPY1VpO1eD8dJWn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bzpttJHByb6P1VgqsQxgbfH8V0LN84PW
	5OhRAx782mHtA5K9u+HSqwCTQiwdBzud7Lh2Kt5Oqp+ARN4pEnq4Pd69sPgLWeKa
	dgLdHbGOoLW3gs3dI0QOs8HLhgJQt1Cmdg5jsROYh1lMSoklR94R5RpTVLaB2jNx
	+jnP/OMB1Xw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CE0F36060;
	Mon,  5 Aug 2013 19:29:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50AEB3605E;
	Mon,  5 Aug 2013 19:29:47 +0000 (UTC)
In-Reply-To: <1375258545-42240-3-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Wed, 31 Jul 2013 04:15:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63934FD6-FE05-11E2-B825-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231693>

Eric Sunshine <sunshine@sunshineco.com> writes:

> A bounds checking bug allows the X in -LX to extend one line past the
> end of file. For example, given a file with 5 lines, -L6 is accepted as
> valid. Demonstrate this problem.
>
> While here, also add tests to check that the remaining cases of X and Y
> in -LX,Y are handled correctly at and in the vicinity of end-of-file.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/annotate-tests.sh | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index 3524eaf..02fbbf1 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -225,10 +225,32 @@ test_expect_success 'blame -L /RE/,-N' '
>  	check_count -L/99/,-3 B 1 B2 1 D 1
>  '
>  
> +# 'file' ends with an incomplete line, so 'wc' reports one fewer lines than
> +# git-blame sees, hence the last line is actually $(wc...)+1.
> +test_expect_success 'blame -L X (X == nlines)' '
> +	n=$(expr $(wc -l <file) + 1) &&
> +	check_count -L$n C 1
> +'
> +
> +test_expect_failure 'blame -L X (X == nlines + 1)' '
> +	n=$(expr $(wc -l <file) + 2) &&
> +	test_must_fail $PROG -L$n file
> +'
> +
>  test_expect_success 'blame -L X (X > nlines)' '
>  	test_must_fail $PROG -L12345 file
>  '
> +test_expect_success 'blame -L ,Y (Y == nlines)' '
> +	n=$(expr $(wc -l <file) + 1) &&
> +	check_count -L,$n A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1 E 1
> +'
> +
> +test_expect_success 'blame -L ,Y (Y == nlines + 1)' '
> +	n=$(expr $(wc -l <file) + 2) &&
> +	test_must_fail $PROG -L,$n file
> +'
> +

This is somewhat curious.

Does the problem triggers only on a file that ends with an
incomplete line, or the test was inserted at this location only
because it was convenient and the problem exists with or without the
incomplete final line?

I am guessing that it is the latter.

Thanks.

>  test_expect_success 'blame -L ,Y (Y > nlines)' '
>  	test_must_fail $PROG -L,12345 file
>  '
