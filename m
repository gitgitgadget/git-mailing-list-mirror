From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] checkout -m: attempt merge when deletion of path was staged
Date: Wed, 13 Aug 2014 13:02:27 -0700
Message-ID: <xmqqr40k2m5o.fsf@gitster.dls.corp.google.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
	<1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
	<20140812235731.GD24621@google.com>
	<20140813000317.GG24621@google.com>
	<xmqqzjf82sc7.fsf@gitster.dls.corp.google.com>
	<xmqqvbpw2p2x.fsf@gitster.dls.corp.google.com>
	<53EBBCC3.4060309@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Johannes.Schindelin@gmx.de, barkalow@iabervon.org,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:02:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHeks-0002yC-Dq
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbaHMUCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:02:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53738 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550AbaHMUCh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:02:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D08D43151E;
	Wed, 13 Aug 2014 16:02:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R3aykFt+HQrC1oT8rweEsJcHsZo=; b=wHiugz
	XFyw5Y2JMvjGMgN+LV93mlo6V2aBGtP3g0ebt2C9/VO/RLdNHCFDGK+bkQmzAWrB
	2f4MJJ4WVXVBrD3lXg16veoNkrbq6nvYtHwM/EPWweF2Tt2myR6M7sOIIMxxtaHf
	ohf3tbmp2ZkPwtteoV5dmGDGltSNdkRbIZa9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IlSblth6fcq6PXkRc8L/IEiHrssOVPgz
	fQUVgc3s8rFcj6yTM3xPHdp4ZG667WIYMpniKzG/CU4jryEpf7zNRMEfFZBTqcLh
	daWUZgUgq4dI0DzUbGGQ+2hP1aCOiUrcbNlE7Je0jL2nIGoQe81rN95Lg3Tgk0FF
	sV3SSXSlJho=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C540F3151D;
	Wed, 13 Aug 2014 16:02:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 64A9D3150B;
	Wed, 13 Aug 2014 16:02:29 -0400 (EDT)
In-Reply-To: <53EBBCC3.4060309@kdbg.org> (Johannes Sixt's message of "Wed, 13
	Aug 2014 21:30:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C1304B40-2324-11E4-85D0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255228>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 13.08.2014 20:59, schrieb Junio C Hamano:
>> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
>> index 0c9ec0a..cedbb6a 100755
>> --- a/t/t7201-co.sh
>> +++ b/t/t7201-co.sh
>> @@ -223,6 +223,23 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
>>  	test_cmp two expect
>>  '
>>  
>> +test_expect_success 'switch to another branch while carrying a deletion' '
>> +
>> +	git checkout -f master && git reset --hard && git clean -f &&
>> +	git rm two &&
>> +
>> +	test_must_fail git checkout simple 2>errs &&
>> +	test_i18ngrep overwritten errs &&
>> +
>> +	git checkout --merge simple 2>errs &&
>> +	! test_i18ngrep overwritten errs &&
>
> This must be written as
>
> 	test_i18ngrep ! overwritten errs &&

Oops. Thanks for spotting.

> I see a few wrong usages in the current code base. Here's a fix.

Will apply; thanks.

> --- >8 ---
> Subject: [PATCH] tests: fix negated test_i18ngrep calls
>
> The helper function test_i18ngrep pretends that it found the expected
> results when it is running under GETTEXT_POISON. For this reason, it must
> not be used negated like so
>
>    ! test_i18ngrep foo bar
>
> because the test case would fail under GETTEXT_POISON. The function offers
> a special syntax to test that a pattern is *not* found:
>
>    test_i18ngrep ! foo bar
>
> Convert incorrect uses to this syntax.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t4018-diff-funcname.sh | 8 ++++----
>  t/t9800-git-p4-basic.sh  | 2 +-
>  t/t9807-git-p4-submit.sh | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 34591c2..1dbaa38 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -52,15 +52,15 @@ do
>  		echo "*.java diff=$p" >.gitattributes &&
>  		test_expect_code 1 git diff --no-index \
>  			A.java B.java 2>msg &&
> -		! test_i18ngrep fatal msg &&
> -		! test_i18ngrep error msg
> +		test_i18ngrep ! fatal msg &&
> +		test_i18ngrep ! error msg
>  	'
>  	test_expect_success "builtin $p wordRegex pattern compiles" '
>  		echo "*.java diff=$p" >.gitattributes &&
>  		test_expect_code 1 git diff --no-index --word-diff \
>  			A.java B.java 2>msg &&
> -		! test_i18ngrep fatal msg &&
> -		! test_i18ngrep error msg
> +		test_i18ngrep ! fatal msg &&
> +		test_i18ngrep ! error msg
>  	'
>  done
>  
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 665607c..5b56212 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -145,7 +145,7 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
>  		test_expect_code 1 git p4 clone --dest="$git" //depot >errs 2>&1
>  	) &&
>  	cat errs &&
> -	! test_i18ngrep Traceback errs
> +	test_i18ngrep ! Traceback errs
>  '
>  
>  # Hide a file from p4d, make sure we catch its complaint.  This won't fail in
> diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
> index 7fab2ed..1f74a88 100755
> --- a/t/t9807-git-p4-submit.sh
> +++ b/t/t9807-git-p4-submit.sh
> @@ -404,7 +404,7 @@ test_expect_success 'submit --prepare-p4-only' '
>  		git p4 submit --prepare-p4-only >out &&
>  		test_i18ngrep "prepared for submission" out &&
>  		test_i18ngrep "must be deleted" out &&
> -		! test_i18ngrep "everything below this line is just the diff" out
> +		test_i18ngrep ! "everything below this line is just the diff" out
>  	) &&
>  	(
>  		cd "$cli" &&
