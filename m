From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] checkout: avoid unnecessary match_pathspec calls
Date: Thu, 28 Mar 2013 15:32:27 -0700
Message-ID: <7vd2ujrw90.fsf@alter.siamese.dyndns.org>
References: <7vr4j3zbrz.fsf@alter.siamese.dyndns.org>
 <1364363901-17815-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 23:32:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULLNS-0002Zz-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 23:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab3C1Wcb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Mar 2013 18:32:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab3C1Wca convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 18:32:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4434E372;
	Thu, 28 Mar 2013 22:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=27P+ALJxWEDxzEDYrVUUD6RQ+
	N0=; b=Tu39Xa1EVQUfSHdEUbV5D6+54eSrIJJ148T04gi99OPWn57q2vQn4bfVB
	m93FrXzRPfow2lD7vtx1TLVG6nudx2ld1GMxMwpnvfvZlZPdo25iNTcomwN0nXd0
	p1ZDjj9Jyge6PimJcz3EoOUzT77tx+fB3+p921+N5+7gAFmNiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=UeN8rNO3EgWCHHmVIs0
	GDb656+EN1jLrPq6s66eCioS6mPlODshQKNRYrlmMiBSE/h5CibbbcNiUx1gM9PA
	iAb8xHD3IVyQFg66/P6nK6CR5tMJLUFtJeLdE8cAa/mgd9Q6aAaEdG9iC0MTCs4e
	X7DQWTUEevdhahe8tCd1G5gw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A40C8E371;
	Thu, 28 Mar 2013 22:32:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B636E36B; Thu, 28 Mar 2013
 22:32:28 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F90A466-97F7-11E2-A6C8-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219472>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
> index 56090d2..5e01d58 100755
> --- a/t/t2022-checkout-paths.sh
> +++ b/t/t2022-checkout-paths.sh
> @@ -39,4 +39,25 @@ test_expect_success 'checking out paths out of a t=
ree does not clobber unrelated
>  	test_cmp expect.next2 dir/next2
>  '
> =20
> +test_expect_success 'do not touch unmerged entries matching $path bu=
t not in $tree' '
> +	git checkout next &&
> +	git reset --hard &&
> +
> +	cat dir/common >expect.common &&
> +	EMPTY_SHA1=3De69de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&

	EMPTY_SHA1=3D$(git hash-object -w --stdin </dev/null)

> +	git rm dir/next0 &&
> +	cat >expect.next0<<EOF &&
> +100644 $EMPTY_SHA1 1	dir/next0
> +100644 $EMPTY_SHA1 2	dir/next0
> +EOF
> +	git update-index --index-info < expect.next0 &&

	cat >expect.next0 <<-EOF &&
        100644 $EMPTY_SHA1 1 dir/next0
        100644 $EMPTY_SHA1 2 dir/next0
	EOF
	git update-index --index-info <expect.next0 &&

> +
> +	git checkout master dir &&
> +
> +	test_cmp expect.common dir/common &&
> +	test_path_is_file dir/master &&
> +	git diff --exit-code master dir/master &&
> +	git ls-files -s dir/next0 >actual.next0
> +'

=2E.. and actual.next0 is checked against what?

Ending this test with

	git ls-files -s dir/next0 >actual.next0 &&
	test_cmp expect.next0 actual.next0

would be sufficient, methinks.

Will replace v2 with the above fixups.  Thanks.

> +
>  test_done
