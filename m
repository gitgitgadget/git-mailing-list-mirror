From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/2] git-p4: suppress non test relevant output
Date: Mon, 21 Dec 2015 12:38:37 -0800
Message-ID: <xmqqd1tzfsfm.fsf@gitster.mtv.corp.google.com>
References: <1450629869-49522-1-git-send-email-larsxschneider@gmail.com>
	<1450629869-49522-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, sunshine@sunshineco.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Dec 21 21:38:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB7EC-00073F-5L
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 21:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbbLUUik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 15:38:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751273AbbLUUik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 15:38:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F4163414C;
	Mon, 21 Dec 2015 15:38:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ULk83R3oJtNKA5PjfvuYN7wdtzk=; b=PE+GCD
	l4F6h5vRThxHLdUxEo+FabrHP9nqP7CRRI78xGbj0GBkDPt/atP/fN3nvtyoWE69
	1T9a13GiQgGnPl/wG0d4ggY2ofS7zzRfukc0hmH1hZ4DOGmXooKwDqbF3XIBYw9f
	QwdwXNDCkkgIU8wZu3BnPY7nE0ADKnEc0NoWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rZdAgc99doe+jj6VKlzre9sw18REb3Wp
	QJT1nxs25SPrWo13scETQuXjJUSxTHxnveLt3GB/+wNuANP84OAobj9lhzMOtJkM
	8n46jeB4mxhL5Ojcq9nwp68xRC63genrjvYmqyMUwBTzYrgxgQ1OwT+KVQcTC6u2
	htZg9tAzjag=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55E7234148;
	Mon, 21 Dec 2015 15:38:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B34DE34147;
	Mon, 21 Dec 2015 15:38:38 -0500 (EST)
In-Reply-To: <1450629869-49522-3-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 20 Dec 2015 17:44:29
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D0AF1BB2-A822-11E5-84C6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282816>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> If tests are executed in verbose mode then the retry logic clutters the
> test output. Suppress that clutter.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  t/lib-git-p4.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 30bf7ae..03f29c1 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -174,7 +174,7 @@ retry_until_fail() {
>  	until ! "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
>  	do
>  		sleep 1
> -	done
> +	done >/dev/null 2>&1

Eh, what does this squelch?  The sleep in the body of the loop is
silent, "test A -gt B" on the loop condition would be silent too, so
you are squelching the invocation of "$@" whose standard error
stream is already sent to 2>/dev/null?

If so, why not do it there instead?  You seem to run only "kill" to
send some signal to a process using this helper function, and it
would be silent on its standard output stream (even though it may
say "no such process" etc. on its standard error), so it is not
clear to me what you are doing with this change here...
