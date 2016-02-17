From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] config: add 'type' to config_source struct that identifies config type
Date: Wed, 17 Feb 2016 10:59:50 -0800
Message-ID: <xmqqa8mzjh7d.fsf@gitster.mtv.corp.google.com>
References: <1455699468-45443-1-git-send-email-larsxschneider@gmail.com>
	<1455699468-45443-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, ramsay@ramsayjones.plus.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 17 19:59:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW7KO-0006Hh-W4
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbcBQS7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:59:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030250AbcBQS7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:59:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D9FEE43F93;
	Wed, 17 Feb 2016 13:59:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T4pwQoWTjqdC+q446sVHAFXdpA8=; b=gsqJA6
	fGFfAab3SrMO8buxOmDOF79QOwCBzP64K3Hl29oIsaZIo/VHhyRmteY/uH9G1xnE
	fJD4nzR7Lo2ChbwSkNJlRG7VWZDPW3bfW8ltz/ZLplft4bBkC7Hxcrk4GOY7agpa
	X3XHlrsMyYA5ZSPfpbQ1Sw6k0EGOoVb9iR+oE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vc+fYvAMlfvTs0tqbde93vfTRaFbIyze
	hRMBcu4OoQ6JVLRAWAmIyglv70U/3XxFXlp8s7MZh12u4oPpqf+RJ/WaTfUOUhKC
	z46Pe5siXmfWa5xbgOG4x3SpVdtObYGfZAf5KDCVFA5N5EiU128I28qYWgzeSxhH
	Q31FHEnwXIg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D1C6443F92;
	Wed, 17 Feb 2016 13:59:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2BC4A43F90;
	Wed, 17 Feb 2016 13:59:51 -0500 (EST)
In-Reply-To: <1455699468-45443-3-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Wed, 17 Feb 2016 09:57:47
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F814CDC-D5A8-11E5-9CE9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286534>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Use the config type to print more detailed error messages that inform
> the user about the origin of a config error (file, stdin, blob).

"type" is too broad a word in the context of configuration file, and
does not help readers as a variable or a field name in a structure.
You are not talking about "this is a binary typed variable", for
example.

If showing the origin is useful to the user, that origin should be
called origin, not type, I would think.

> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 91235b7..82f82a1 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -195,14 +195,14 @@ test_expect_success 'proper error on error in default config files' '
>  	cp .git/config .git/config.old &&
>  	test_when_finished "mv .git/config.old .git/config" &&
>  	echo "[" >>.git/config &&
> -	echo "fatal: bad config file line 34 in .git/config" >expect &&
> +	echo "fatal: bad config line 34 in file .git/config" >expect &&

This definitely is a great improvement ;-)

>  	test_expect_code 128 test-config get_value foo.bar 2>actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success 'proper error on error in custom config files' '
>  	echo "[" >>syntax-error &&
> -	echo "fatal: bad config file line 1 in syntax-error" >expect &&
> +	echo "fatal: bad config line 1 in file syntax-error" >expect &&
>  	test_expect_code 128 test-config configset_get_value foo.bar syntax-error 2>actual &&
>  	test_cmp expect actual
>  '
