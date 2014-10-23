From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/15] copy.c: make copy_fd preserve meaningful errno
Date: Thu, 23 Oct 2014 10:51:11 -0700
Message-ID: <xmqqlho6smi8.fsf@gitster.dls.corp.google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-7-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 19:51:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhMXf-00079T-0I
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 19:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbaJWRvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 13:51:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752293AbaJWRvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 13:51:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7122A16E8E;
	Thu, 23 Oct 2014 13:51:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RQtiPpV1N6dV3pHs4Pk7bvPUjK8=; b=HDVXXp
	Ug8k07GDYJo7lk9iuvnG8mhArNsvytfxeKFX81HaTiMpIclBBgsSwBKOsOhJr4ax
	Iy6QKE31K2QcscJhl1ogQYSkK0j6FMsIm0OFOASc5RyjIhEwsHhl1uSUVxuCgZWB
	n1tF4qdRUZgoA4/7IrZ020+ea4JjA3rd3QmJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BbJz1kvvdIZLw5jZzX9kMHk6BkscIz0g
	FZghWW97y4udmqPadu7QTPlQp0ZQkYkJ9vI5dRu17VOjYisfWjno91qpFxxPusfw
	oxihQ4C7fObhqsiv0v7aRGfU1RTEeuCeFkNXlM+kwNScI/Hp3YXIuVcLGnCgQW4Y
	4nhcE+QuukY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6788D16E8C;
	Thu, 23 Oct 2014 13:51:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D780116E8B;
	Thu, 23 Oct 2014 13:51:12 -0400 (EDT)
In-Reply-To: <1413919462-3458-7-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 12:24:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2DB2C3B6-5ADD-11E4-8FF4-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> commit 306805ccd147bfdf160b288a8d51fdf9b77ae0fa upstream.
>
> Update copy_fd to return a meaningful errno on failure.

These two are good changes, but makes me wonder if more places
benefit from having error_errno() that does the "save away errno,
use strerror(errno) to give an error message and restore errno"
for us.

Not meant as a suggestion for further changes in this series, but as
a future discussion item.

>
> Change-Id: I771f9703acc816902affcf35ff2a56d9426315ac
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
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
