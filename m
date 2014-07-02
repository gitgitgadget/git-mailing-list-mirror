From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 7/7] replace: add test for --graft with signed commit
Date: Wed, 02 Jul 2014 14:22:01 -0700
Message-ID: <xmqqlhsbfocm.fsf@gitster.dls.corp.google.com>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
	<20140628181117.5687.83337.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 23:22:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Ryn-0004M5-Sn
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 23:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859AbaGBVWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 17:22:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62642 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626AbaGBVWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 17:22:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD20923C9B;
	Wed,  2 Jul 2014 17:21:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6MxVqhxtCwEvIw+Izze6j6AWpYw=; b=haxc2R
	w3Ynt5/omDNFLF4OO7cUdL8RX3ZumfLTRVTq2d6lj70FzxOllJJTjc440DAkztH+
	u79RtfZLpa3zBudc0jy991HLCuPi9iW2GBYeM1Hy+CJa0Qfk/kfsrKSZLeIZhSms
	MntRUSzklPBVBnbHfpBEK04CPKdcM1jSZ0xQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KWN4XSqc+zSalOxdf5mnDJEnIp3J11CW
	eOD5b5gPp5AmMvw0M4u95Dwrj5k7S6j6uu3eQADe68Ekz/0ny36eA9APZKRYQNC8
	kM+eQt7cOdtCa3Cc9Ghyc9mutwpCt37Tc+toUihCDe56p0i2V5EwYEEwl2bmirhK
	1CTdeq6g3l8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D129223C9A;
	Wed,  2 Jul 2014 17:21:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DE45C23C92;
	Wed,  2 Jul 2014 17:21:51 -0400 (EDT)
In-Reply-To: <20140628181117.5687.83337.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 28 Jun 2014 20:11:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E28177E0-022E-11E4-8CA3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252842>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t6050-replace.sh | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index ca45a84..80b85e3 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -7,6 +7,7 @@ test_description='Tests replace refs functionality'
>  exec </dev/null
>  
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-gpg.sh"
>  
>  add_and_commit_file()
>  {
> @@ -363,4 +364,25 @@ test_expect_success '--graft with and without already replaced object' '
>  	git replace -d $HASH5
>  '
>  
> +test_expect_success GPG 'set up a signed commit' '
> +	echo "line 17" >> hello &&
> +	echo "line 18" >> hello &&

Style?

> +	git add hello &&
> +	test_tick &&
> +	git commit --quiet -S -m "hello: 2 more lines in a signed commit" &&
> +	HASH8=$(git rev-parse --verify HEAD) &&
> +	git verify-commit $HASH8
> +'
> +
> +test_expect_success GPG '--graft with a signed commit' '
> +	git cat-file commit $HASH8 >orig &&
> +	git replace --graft $HASH8 &&
> +	git cat-file commit $HASH8 >repl &&
> +	test_must_fail grep gpgsig repl &&
> +	diff -u orig repl | grep "^-parent $HASH7" &&
> +	diff -u orig repl | grep "^-gpgsig -----BEGIN PGP SIGNATURE-----" &&

Almost the same comment as the one for 2/7 applies here.

> +	test_must_fail git verify-commit $HASH8 &&
> +	git replace -d $HASH8
> +'
> +
>  test_done
