From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t/t7004-tag: test handling of rfc1991 signatures
Date: Tue, 09 Nov 2010 09:17:24 -0800
Message-ID: <7vwrommn6j.fsf@alter.siamese.dyndns.org>
References: <4CAB90EC.1080302@drmicha.warpmail.net>
 <cover.1289041051.git.git@drmicha.warpmail.net>
 <c20fb62cefcd42533e47f6f1bf5817712e5ebf9a.1289041051.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 18:17:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFrpI-000409-NH
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 18:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab0KIRRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 12:17:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab0KIRRh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 12:17:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 735CF2414;
	Tue,  9 Nov 2010 12:17:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V029imxiKmM0f/WAD2PYzybZCMU=; b=rvin8k
	1yl5O89J3zSBU/x9m9/6OtT/5os/oNtTzTi+E3tuzKHbXvkxhRxsza8BGOki+IWS
	tXnYqkRHjlxXN2Cdgytdg/XgoTPYER138XACuq00M5KdPPGZu0vLNDDmRmsabHIZ
	uiHGQly/mFdIUbejHi3nQnZU5gCumlFIlFwG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AwyeE8aqaVeJK8KvQcnLDwajJneHJ5Fr
	KqY30rlY5sOXI++eu/bW958FgJJ4no5kpgJwcTSHvx5NY5hbxUjDh0hmNY/AvSU/
	N3UfjAh90T1pndSKUjrPP1DTd139IvcUgXK/FX6PCLjL8pDw3RLeJ+bM1VcwtCWG
	DHid1K60Qwg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4380F2413;
	Tue,  9 Nov 2010 12:17:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7FB552410; Tue,  9 Nov 2010
 12:17:31 -0500 (EST)
In-Reply-To: <c20fb62cefcd42533e47f6f1bf5817712e5ebf9a.1289041051.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Sat\,  6 Nov 2010 12\:04\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3FC73404-EC25-11DF-B465-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161061>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, git expects "-----BEGIN PGP SIGNATURE-----" at the beginning of a
> signature. But gpg uses "MESSAGE" instead of "SIGNATURE" when used with
> the "rfc1991" option. This leads to git's failing to verify it's own
> signed tags, among other problems.
>
> Add tests for all code paths (tag -v, tag -l -n largenumber, tag -f
> without -m) where signature detection matters.
>
> Reported-by: Stephan Hugel <urschrei@gmail.com>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  t/t7004-tag.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 43 insertions(+), 0 deletions(-)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index ac943f5..22dcc45 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1030,6 +1030,49 @@ test_expect_success GPG \
>  	test_cmp expect actual
>  '
>  
> +# usage with rfc1991 signatures
> +echo "rfc1991" > gpghome/gpg.conf
> +get_tag_header rfc1991-signed-tag $commit commit $time >expect
> +echo "RFC1991 signed tag" >>expect
> +echo '-----BEGIN PGP MESSAGE-----' >>expect
> +test_expect_success GPG \
> +	'creating a signed tag with rfc1991' '
> +	git tag -s -m "RFC1991 signed tag" rfc1991-signed-tag $commit &&
> +	get_tag_msg rfc1991-signed-tag >actual &&
> +	test_cmp expect actual
> +'
> +
> +cat >fakeeditor <<'EOF'
> +#!/bin/sh
> +cp "$1" actual
> +EOF
> +chmod +x fakeeditor
> +
> +test_expect_failure GPG \
> +...
> +'
> +
> +rm -f gpghome/gpg.conf

Shouldn't this line be placed much earlier in the sequence, to make sure
that people without --rfc1991 can grok new style signatures?  Better yet,
shouldn't the script test rfc1991-signed tags both with and without the
rfc1991 configuration?
