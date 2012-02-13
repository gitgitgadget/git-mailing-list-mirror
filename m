From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] push/fetch/clone --no-progress suppresses progress
 output
Date: Mon, 13 Feb 2012 13:13:43 -0800
Message-ID: <7vlio6cu7s.fsf@alter.siamese.dyndns.org>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
 <1329164235-29955-6-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 13 22:13:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx3Db-0008TT-DA
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 22:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222Ab2BMVNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 16:13:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755901Ab2BMVNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 16:13:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3241875A7;
	Mon, 13 Feb 2012 16:13:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=BognOUAzy31DvG6RbzghYv7PvIo=; b=f/0s/MlKITfM/wWIld5S
	s8diknYWvU7eFv0ZrgSCUMDV7ITk4VLd9TSp9jfzX8Rs7UTVLJOjzdIzyl3XhgDR
	25wCJwhhVRBCvIKK5DAH1rcRqvZk8meTon1ldo+Kf00BXeN8FOPDhS+O5z/qhQF0
	94HLE8mTVF/+lKyGy2zPlOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=BXA1l/DydcLbxw9JL2nhrATM36tEw8TaGX5bnYNdHYdnkc
	HicyN9trsWvKIAGLYgSZGll3ZtFz00mnwutycGRF7goghuatge/Ou6MMOkfPTR/k
	D6+yFHcYUja2JNwikqNXB6iLfHj20iSUsaYILb4yn6ZdMLdVL/qBGd/OTipbg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2368D75A6;
	Mon, 13 Feb 2012 16:13:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A725E75A5; Mon, 13 Feb 2012
 16:13:44 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CAC8890-5687-11E1-AFF6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190672>

Clemens Buchacher <drizzd@aon.at> writes:

> diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
> index 9ee52cf..3683df1 100755
> --- a/t/t5523-push-upstream.sh
> +++ b/t/t5523-push-upstream.sh
> @@ -101,10 +101,11 @@ test_expect_success TTY 'push -q suppresses progress' '
>  	! grep "Writing objects" err
>  '
>  
> -test_expect_failure TTY 'push --no-progress suppresses progress' '
> +test_expect_success TTY 'push --no-progress suppresses progress' '
>  	ensure_fresh_upstream &&
>  
>  	test_terminal git push -u --no-progress upstream master >out 2>err &&
> +	! grep "Unpacking objects" err &&
>  	! grep "Writing objects" err
>  '

Very nice to see an old expect-failure turned into expect-success.

> diff --git a/transport.c b/transport.c
> index cac0c06..6074ee9 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -994,10 +994,14 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
>  	 * when a rule is satisfied):
>  	 *
>  	 *   1. Report progress, if force_progress is 1 (ie. --progress).
> +	 *   2. Don't report progress, if force_progress is 0 (ie. --no-progress).
>  	 *   2. Don't report progress, if verbosity < 0 (ie. -q/--quiet ).
>  	 *   3. Report progress if isatty(2) is 1.
>  	 **/

I'll turn this into an unnumbered bulletted list, while I tease it apart
to remove textual dependency on the 'verify-refs' extension, which this
fix shouldn't depend on and taken hostage to.

Thanks.
