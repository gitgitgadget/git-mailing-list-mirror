From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Mon, 17 Nov 2014 15:08:24 -0800
Message-ID: <xmqq4mtxxw5z.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 00:08:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqVPN-0007cK-Oz
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 00:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbaKQXI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 18:08:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753485AbaKQXI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 18:08:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F80C1FBF4;
	Mon, 17 Nov 2014 18:08:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z2PzBDajRoYztTQqCN1jSbyt5F8=; b=CCNRJR
	BaKaMUvWZAClSmz1H4twW9cn6ItIQ7LQNF4z01wkpAMYpl6zZTOpI9JAzkge7831
	Y4rCkCy0VICzWK/6wr2rn44STMgBNp2p3UXBbUyIOW6pSoRYT+75OOR3zB5TRGHw
	cSmoajS71QRzn8x0c2Xl++Q6T41Q51Qfg3Bh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k9002h8FtIKxoQ3gge6gxhU5FXF/eWiE
	jao8rmClGq95oKTqcxuuADfutbox52YojZVfPLf/+QNPKCissTskda47/5vXqG/P
	cXBsUNuv7nXSCY9ihtc32+afOdROOE75YB5I8ShGqG2AIQNLow8haprvDPZ4ix2g
	yEg70XHGaVQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04B391FBF3;
	Mon, 17 Nov 2014 18:08:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 764AF1FBF0;
	Mon, 17 Nov 2014 18:08:27 -0500 (EST)
In-Reply-To: <1416262453-30349-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 17 Nov 2014 14:14:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A388B39A-6EAE-11E4-B99F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This patch was sent previously to the list as part of
> that series[2], but it seems to be unrelated to me.

I am fine to queue obvious and trivial bits first before the larger
main course.  For now I'll queue this one and also the series that
has been queued for a while, but at some point I suspect we would
have to drop the latter.

Thanks.


> [1] http://www.mail-archive.com/git@vger.kernel.org/msg61051.html
> [2] http://www.spinics.net/lists/git/msg240784.html
>  copy.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/copy.c b/copy.c
> index f2970ec..a8d366e 100644
> --- a/copy.c
> +++ b/copy.c
> @@ -8,12 +8,17 @@ int copy_fd(int ifd, int ofd)
>  		if (!len)
>  			break;
>  		if (len < 0) {
> -			return error("copy-fd: read returned %s",
> -				     strerror(errno));
> +			int save_errno = errno;
> +			error("copy-fd: read returned %s", strerror(errno));
> +			errno = save_errno;
> +			return -1;
> +		}
> +		if (write_in_full(ofd, buffer, len) < 0) {
> +			int save_errno = errno;
> +			error("copy-fd: write returned %s", strerror(errno));
> +			errno = save_errno;
> +			return -1;
>  		}
> -		if (write_in_full(ofd, buffer, len) < 0)
> -			return error("copy-fd: write returned %s",
> -				     strerror(errno));
>  	}
>  	return 0;
>  }
