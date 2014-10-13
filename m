From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] test-lib.sh: support -x option for shell-tracing
Date: Mon, 13 Oct 2014 15:38:53 -0700
Message-ID: <xmqq8ukj1toi.fsf@gitster.dls.corp.google.com>
References: <20141010062722.GB17481@peff.net>
	<20141010064727.GC17481@peff.net>
	<xmqqh9z71uf9.fsf@gitster.dls.corp.google.com>
	<20141013223303.GA17045@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 14 00:39:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdoGa-0007qK-Db
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 00:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbaJMWi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 18:38:56 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752554AbaJMWi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 18:38:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87AFB15667;
	Mon, 13 Oct 2014 18:38:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GVhFT3nQhcDE351S8fu9ADlIbdI=; b=jAcGVO
	GJFkZ8OK3jZ7yazq0uSIk0ZyTOyFVUNAqOcjAUiBPr5PB+ALRGKrwhBdp3dAgxlk
	I0FgHOTOYswOEOhkgTsviugTXDGRWWWV/MXEZqJxW5064LdY/qbc68qNZGpjWFQT
	sqsWkC5xk36Zzklo3whCLEiS5bluUwu4V1ECw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t6OZnjawb6H8rKW9OAq2mD9U2OMZTlg0
	QRMd6ceupOfW4ZrsnWo9PM+LprdwX0X46romI70VC/zM+zQ14uOpVCYdboVZ8FeX
	naiV2NNIT7l+B88YE0S/j+bPHgMVzpKlFRwuenYj49O2O+0NApPOaHjV8ZhgMZZQ
	mCrAHTLrpwk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F5C015666;
	Mon, 13 Oct 2014 18:38:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 053C915662;
	Mon, 13 Oct 2014 18:38:54 -0400 (EDT)
In-Reply-To: <20141013223303.GA17045@peff.net> (Jeff King's message of "Mon,
	13 Oct 2014 18:33:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B69A74DC-5329-11E4-97DA-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This fixes it:
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 4dab575..059bb25 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -528,8 +528,7 @@ maybe_setup_valgrind () {
>  test_eval_inner_ () {
>  	eval "
>  		test \"$trace\" = t && set -x
> -		$*
> -	"
> +		$*"
>  }
>  
>  test_eval_ () {
>
>
> My patch definitely expands the snippet with an extra trailing newline.
> But what I really don't understand is why that would impact the
> _contents_ of the config file.

Ahh, OK.  The inside of eval begins with

	cat >.git/config <<\EOF
        ...

and ends with "<HT>EOF", which is _ignored_ because it is not "EOF"
alone on a line, so the shell takes everything, i.e. including the
additional LF your dq.  No wonder we got one extra line.

And with that additional LF fixed, even if we do not fix t1308, it
should work (with some definition of "work") as before.

Thanks, that clears it up.
