From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 07/12] notes: implement helpers needed for note
 copying during rewrite
Date: Sat, 20 Feb 2010 19:34:51 -0800
Message-ID: <7v3a0v45yc.fsf@alter.siamese.dyndns.org>
References: <cover.1266703765.git.trast@student.ethz.ch>
 <9f4cb8a577e853378c1d3136b54a5e73ac29dc22.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 21 05:26:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2bC-00060v-5A
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208Ab0BUDfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:35:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206Ab0BUDfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:35:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EFE109BE2C;
	Sat, 20 Feb 2010 22:35:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yQ5UyS3npXvH22r891Hm8zJxZGI=; b=yUu2Gc
	Wp1k7buq0pFIWTEJpoSZQLojP3QxtpMJDKw+kBc+cczaIa/FrNP6Rk99ROwE5SKW
	HmaBBDZyo7ryNhMJ1OOBcpJm26jYJYUDsNp6FVQrbpY26eBUyD5/rZFYWNypsWQu
	j6lOLQD1P1gy5dgZZzwKLLjFg5Vt5Olcnzu9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=amWMOUox6DtwIKdcDbuD1f5xEYfWTNGg
	HCis13FJuTqEcGm+SGXW+cuk99Mhj6Wn8YiUuW1JA4l06/u27mQRtAWWyX/NqTg/
	WSJGLP8kSOWz5SykDPg76ijBiwWwLnJqScfomLIYH4xyWcLSrWdBuY/E/TDW53xj
	7zQMnSnj33Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63B0C9BE2B;
	Sat, 20 Feb 2010 22:35:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B13C09BE29; Sat, 20 Feb
 2010 22:34:53 -0500 (EST)
In-Reply-To: <9f4cb8a577e853378c1d3136b54a5e73ac29dc22.1266703765.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat\, 20 Feb 2010 23\:16\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16E70E32-1E9A-11DF-B5BE-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140593>

Thomas Rast <trast@student.ethz.ch> writes:

> +combine_notes_fn *parse_combine_notes_fn(const char *v)
> +{
> +	if (!strcasecmp(v, "overwrite"))
> +		return combine_notes_overwrite;
> +	else if (!strcasecmp(v, "ignore"))
> +		return combine_notes_ignore;
> +	else if (!strcasecmp(v, "concatenate"))
> +		return combine_notes_concatenate;
> +	else
> +		return NULL;
> +}

Somebody in the call chain should have made sure v != NULL and called
config_error_nonbool() if v is NULL.

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 634d213..5a0dccd 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -684,6 +684,7 @@ test_expect_success 'cannot copy note from object without notes' '
>  '
>  
>  cat > expect << EOF
> +commit e5d4fb5698d564ab8c73551538ecaf2b0c666185
>  Author: A U Thor <author@example.com>
>  Date:   Thu Apr 7 15:25:13 2005 -0700
>  
> @@ -694,6 +695,7 @@ Notes from notes/other:
>  $whitespace
>      yet another note
>  
> +commit 7038787dfe22a14c3867ce816dbba39845359719
>  Author: A U Thor <author@example.com>
>  Date:   Thu Apr 7 15:24:13 2005 -0700
>  
> @@ -710,9 +712,123 @@ test_expect_success 'git notes copy --stdin' '
>  	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
>  	git notes copy --stdin &&
>  	git log -2 > output &&
> -	strip_then_cmp expect output &&
> +	test_cmp expect output &&
>  	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)" &&
>  	test "$(git notes list HEAD^)" = "$(git notes list HEAD~3)"
>  '

I think the above piece should have been squashed to the previous patch.
