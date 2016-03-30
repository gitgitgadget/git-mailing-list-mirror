From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/6] submodule foreach: correct path display in recursive submodules
Date: Wed, 30 Mar 2016 13:05:25 -0700
Message-ID: <xmqqy48zspdm.fsf@gitster.mtv.corp.google.com>
References: <1459301266-12403-1-git-send-email-sbeller@google.com>
	<1459301266-12403-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 22:13:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alMUe-0002rP-D5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 22:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283AbcC3UFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 16:05:33 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60689 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755260AbcC3UF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 16:05:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2EFF45191D;
	Wed, 30 Mar 2016 16:05:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wgyxBA7QSho17OXYJ6NI/4MhpOA=; b=AItmWn
	E46h2o0VH78E03iHf59wAB9xqYkwPmxKrCJfGwlXjuCDbrrEPfBOf4w3vOZNj7Ox
	APxnOClzw4VwrvXMcidlHKjsAXztYLjA/KDvsZtv381+AmEz+73tUYe/uQjT/V5F
	Ka3obmIzTVHumvz6Qj7Zz9fVS0+hGot2SzUMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VEWnsp3vMlXoDPOJQu+0PNXl4xxwj0Kv
	aq/46KiND6KzlNzBZraQqFB0EBdCvm5yfcShbI41vlwuRO9OIFgrc74xrw83DzuI
	LZodGolhOfbAc1WK8KlLsy4l5rwMeP2ywtPWmB5j/EGCig10zUK31yr1txIvU/YF
	73xMRFUnE/I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1CAFA5191C;
	Wed, 30 Mar 2016 16:05:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 788FA5191B;
	Wed, 30 Mar 2016 16:05:26 -0400 (EDT)
In-Reply-To: <1459301266-12403-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 29 Mar 2016 18:27:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE7C11DC-F6B2-11E5-99B4-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290343>

Stefan Beller <sbeller@google.com> writes:

> The `prefix` was put in front of the display path unconditionally.
> This is wrong as any relative path computation would need to be at
> the front, so include the prefix into the display path.
>
> The new test replicates the previous test with the difference of executing
> from a sub directory. By executing from a sub directory all we would
> expect all displayed paths to be prefixed by '../'.
>
> Prior to this patch the test would report
>     Entering 'nested1/nested2/../nested3'
> instead of the expected
>     Entering '../nested1/nested2/nested3'
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Definitely easier to read and helps understand what is going on in
the changed codepath much better.  Very well done.

Thanks.

> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 7ca10b8..776b349 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -178,6 +178,26 @@ test_expect_success 'test messages from "foreach --recursive"' '
>  '
>  
>  cat > expect <<EOF
> +Entering '../nested1'
> +Entering '../nested1/nested2'
> +Entering '../nested1/nested2/nested3'
> +Entering '../nested1/nested2/nested3/submodule'
> +Entering '../sub1'
> +Entering '../sub2'
> +Entering '../sub3'
> +EOF
> +
> +test_expect_success 'test messages from "foreach --recursive" from subdirectory' '
> +	(
> +		cd clone2 &&
> +		mkdir untracked &&
> +		cd untracked &&
> +		git submodule foreach --recursive >../../actual
> +	) &&
> +	test_i18ncmp expect actual
> +'
> +
> +cat > expect <<EOF
>  nested1-nested1
>  nested2-nested2
>  nested3-nested3
