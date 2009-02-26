From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 12:30:27 -0800
Message-ID: <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:32:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcmtp-0002s8-FL
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 21:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbZBZUai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 15:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbZBZUah
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 15:30:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbZBZUah (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 15:30:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7B4D99DE40;
	Thu, 26 Feb 2009 15:30:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 51CD49DE3F; Thu,
 26 Feb 2009 15:30:29 -0500 (EST)
In-Reply-To: <1235677745-939-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Thu, 26 Feb 2009 14:49:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51D33DF2-0444-11DE-8089-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111594>

Jay Soffian <jaysoffian@gmail.com> writes:

> OS X's GNU grep does not support -P/--perl-regexp; use egrep instead,
> avoiding non-portable braces ({}) as well.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
>  t/t5540-http-push.sh |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
> index 11b3432..6a255a6 100755
> --- a/t/t5540-http-push.sh
> +++ b/t/t5540-http-push.sh
> @@ -94,9 +94,15 @@ test_expect_success 'MKCOL sends directory names with trailing slashes' '
>  
>  '
>  
> +x1="[a-z0-9]"

Why [a-z0-9] not [0-9a-f]?

> +x2="$x1$x1"
> +x5="$x1$x1$x1$x1$x1"
> +x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
> +x40="$x38$x2"
> +
>  test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
>  
> -	grep -P "\"(?:PUT|MOVE) .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+\" 20\d" \
> +	egrep "\"(PUT|MOVE) .+objects/$x2/${x38}_$x40 HTTP/[0-9.]+\" 20[0-9]" \
>  		< "$HTTPD_ROOT_PATH"/access.log

I'd rather see the basic BRE grep used if you are shooting for
portability.

There are some oddballs in the source (git-submodule.sh is a notable
offender) but none of the core-ish scripts uses egrep nor "grep -E".
