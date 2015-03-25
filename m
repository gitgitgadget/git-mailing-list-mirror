From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] t: simplify loop exit-code status variables
Date: Wed, 25 Mar 2015 10:27:49 -0700
Message-ID: <xmqqfv8t2dii.fsf@gitster.dls.corp.google.com>
References: <20150325052456.GA19394@peff.net>
	<20150325053017.GF31924@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 18:28:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yap5y-0000jh-0f
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 18:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbbCYR1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 13:27:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752013AbbCYR1w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 13:27:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA928427C1;
	Wed, 25 Mar 2015 13:27:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qzHRt/TDTYKVsKlZTVL85nUoTLs=; b=qxkWmt
	1fXUUu3YF1jN9/35n01Uk+umfnRGUou/lf8iHuzMfLc/I9joFJwkbk6AdVhp6STD
	nTU2gGXEeNqrwQ4zjh9fUWQO3362ZQmXZVV9oACQD2vtBm/AV2crONM0xKKqGw6z
	pu6R3tiorR6S1IpQ4cOQ3rLTmBCb8XAuMZmn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LaGbF8OBEIVUhgxCOo+ZTIEHPg9hpD6U
	LIqafpTfNXs2ww0keLZWpDRSmdXQ/Sum3oWQFvkC3iCX8pUGX2vhyWqKGZ6aA+ae
	p6CXmTzmpovRIFloUlUbeOpMvQTAKhzYuGiwgXeWmixuVMAKJ61gffJ+rdWsnE8i
	eey9o9loLwU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3DAD427C0;
	Wed, 25 Mar 2015 13:27:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13D02427BE;
	Wed, 25 Mar 2015 13:27:51 -0400 (EDT)
In-Reply-To: <20150325053017.GF31924@peff.net> (Jeff King's message of "Wed,
	25 Mar 2015 01:30:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 435D4A6A-D314-11E4-8621-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266285>

Jeff King <peff@peff.net> writes:

> Since shell loops may drop the exit code of failed commands
> inside the loop, some tests try to keep track of the status
> by setting a variable. This can end up cumbersome and hard
> to read; it is much simpler to just exit directly from the
> loop using "return 1" (since each case is either in a helper
> function or inside a test snippet).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t3060-ls-files-with-tree.sh | 13 ++++---------
>  t/t3901-i18n-patch.sh         |  8 ++------
>  2 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
> index 61c1f53..36b10f7 100755
> --- a/t/t3060-ls-files-with-tree.sh
> +++ b/t/t3060-ls-files-with-tree.sh
> @@ -25,15 +25,10 @@ test_expect_success setup '
>  		do
>  			num=00$n$m &&
>  			>sub/file-$num &&
> -			echo file-$num >>expected || {
> -				bad=t
> -				break
> -			}
> -		done && test -z "$bad" || {
> -			bad=t
> -			break
> -		}
> -	done && test -z "$bad" &&
> +			echo file-$num >>expected ||
> +			return 1
> +		done
> +	done &&
>  	git add . &&
>  	git commit -m "add a bunch of files" &&

The empty initialization for $bad can also go for this one, right?
