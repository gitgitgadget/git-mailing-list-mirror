From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push --force-with-lease: Fix ref status reporting
Date: Thu, 28 Jan 2016 15:13:36 -0800
Message-ID: <xmqqmvrpl2lb.fsf@gitster.mtv.corp.google.com>
References: <1454012898-10138-1-git-send-email-agwheeler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Andrew Wheeler <awheeler@motorola.com>
To: Andrew Wheeler <agwheeler@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:13:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOvl5-000578-DB
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 00:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbcA1XNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 18:13:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750909AbcA1XNj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 18:13:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FBAF3E8A7;
	Thu, 28 Jan 2016 18:13:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mnao0pZrwf4JAke+GkXeicppbLY=; b=UrFJSI
	5vP3jWeqNwjtCDXrmJUOQoN4rwSUg8NVSuHlwhVwYaV8EBX6j/otSYhlijRHozaI
	ezECJHy8CnuOPkQbm+wZViYNySJ1Qh1/q8oqKT8aqBwxXa2wiA5o9XOKCs13ZUA3
	foOsAmkUmuh/3i/jrSE2ZulRHQYj5bIY3ioj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=odu6sVBh9EDccG+36td8XukUVuFlCtyo
	mOM45j7M9UbH+hwhqCIfFHKDxpVENJ66efSGrRxLoPKZeLX1Of0/PenB4OeBopd6
	FWbPahPCRrFBRPhdBMTLbS8ckwl5h5VfLZVF0IxasWjhB9p4AI6i8VeBsqJ4CxFE
	02Psj7tDZ18=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 876E83E89F;
	Thu, 28 Jan 2016 18:13:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0DAE73E899;
	Thu, 28 Jan 2016 18:13:37 -0500 (EST)
In-Reply-To: <1454012898-10138-1-git-send-email-agwheeler@gmail.com> (Andrew
	Wheeler's message of "Thu, 28 Jan 2016 14:28:18 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C32B1F62-C614-11E5-8142-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285043>

Andrew Wheeler <agwheeler@gmail.com> writes:

> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index c402d8d..c65033f 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -101,7 +101,8 @@ test_expect_success 'push to update (allowed, tracking)' '
>  	(
>  		cd dst &&
>  		test_commit D &&
> -		git push --force-with-lease=master origin master
> +		git push --force-with-lease=master origin master 2>err &&
> +		! grep "forced update" err
>  	) &&
>  	git ls-remote dst refs/heads/master >expect &&
>  	git ls-remote src refs/heads/master >actual &&
> @@ -114,7 +115,8 @@ test_expect_success 'push to update (allowed even though no-ff)' '
>  		cd dst &&
>  		git reset --hard HEAD^ &&
>  		test_commit D &&
> -		git push --force-with-lease=master origin master
> +		git push --force-with-lease=master origin master 2>err &&
> +		grep "forced update" err
>  	) &&
>  	git ls-remote dst refs/heads/master >expect &&
>  	git ls-remote src refs/heads/master >actual &&
> @@ -147,7 +149,8 @@ test_expect_success 'push to delete (allowed)' '
>  	setup_srcdst_basic &&
>  	(
>  		cd dst &&
> -		git push --force-with-lease=master origin :master
> +		git push --force-with-lease=master origin :master 2>err &&
> +		grep deleted err
>  	) &&
>  	>expect &&
>  	git ls-remote src refs/heads/master >actual &&

These all look OK (I am not sure about message i18n, though).

Do we not test a case where --force-with-lease push is rejected due
to REF_STATUS_REJECT_STALE?

Thanks.
