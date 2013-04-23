From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/7] t7008: demonstrate behavior of grep with textconv
Date: Tue, 23 Apr 2013 08:16:29 -0700
Message-ID: <7v1ua1l1ki.fsf@alter.siamese.dyndns.org>
References: <517298D4.3030802@drmicha.warpmail.net>
	<5137a5a48ae6c70ad716d985a22d53ec311ee05a.1366718624.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 23 17:16:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUexQ-0001ol-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675Ab3DWPQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 11:16:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756432Ab3DWPQc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 11:16:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D2B1193F0;
	Tue, 23 Apr 2013 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qLBvjDXv0Tr8lzFCgP7lzhfIavA=; b=bkbGJA
	Ge8hyhzcuJSP8y12S4jUlsHxOlH6q0jHAxKvtPI+xSUf4RDVm02OkEXsHs1UfdMa
	Y1fXzt6PGOPVyRqH7hC1AzPyUNbGvu5znZAWBu9HgyXSRv8d+RKyImtAnQ0T/0Wr
	sam8s1KUsCbL4Bbb0KA8S4yvjP6zjUlh22myM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KjL5n6Dgqs24IC5yF79d4FnmP/vITOpr
	Xa9Rlg/JfCtZBYU7WKk4p1XTp54Bc3+ZABQD9Qt9fn21JkUHyQKvH7NfMrEJXbLN
	KFX2mIqcoymPUcpmseqH5pYQ1WrVFtTEzk0FHVX3pNuW2qM9dOqXvjr0QpZpkZJF
	wDFYh0DXKgo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80F42193EF;
	Tue, 23 Apr 2013 15:16:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF7E2193EC;
	Tue, 23 Apr 2013 15:16:30 +0000 (UTC)
In-Reply-To: <5137a5a48ae6c70ad716d985a22d53ec311ee05a.1366718624.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 23 Apr 2013 14:11:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6E1D000-AC28-11E2-8B6D-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222176>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, "git grep" does not honor any textconv filters. Demonstrate
> this in the tests.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  t/t7008-grep-binary.sh | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
> index 26f8319..126fe4c 100755
> --- a/t/t7008-grep-binary.sh
> +++ b/t/t7008-grep-binary.sh
> @@ -145,4 +145,27 @@ test_expect_success 'grep respects not-binary diff attribute' '
>  	test_cmp expect actual
>  '
>  
> +cat >nul_to_q_textconv <<'EOF'
> +#!/bin/sh
> +"$PERL_PATH" -pe 'y/\000/Q/' < "$1"
> +EOF
> +chmod +x nul_to_q_textconv
> +
> +test_expect_success 'setup textconv filters' '
> +	echo a diff=foo >.gitattributes &&
> +	git config diff.foo.textconv "\"$(pwd)\""/nul_to_q_textconv
> +'
> +
> +test_expect_failure 'grep does not honor textconv' '
> +	echo "a:binaryQfile" >expect &&
> +	git grep Qfile >actual &&

This should pass --textconv to "git grep".

> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'grep blob does not honor textconv' '
> +	echo "HEAD:a:binaryQfile" >expect &&
> +	git grep Qfile HEAD:a >actual &&

Likewise.

> +	test_cmp expect actual
> +'
> +
>  test_done
