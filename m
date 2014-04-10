From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/2] Add xpread() and xpwrite()
Date: Thu, 10 Apr 2014 11:35:42 -0700
Message-ID: <xmqq7g6xxcap.fsf@gitster.dls.corp.google.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yiannis Marangos <yiannis.marangos@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 20:35:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYJpK-0005pd-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 20:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbaDJSfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 14:35:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758999AbaDJSfr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 14:35:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF0C57B792;
	Thu, 10 Apr 2014 14:35:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J/wJJIZDf5ASJ/iBcumN7y7xXnQ=; b=IaqJzw
	B2ZlO2ZUxzLuNQ1NrLUytl9XlQcDyA/OF0pBuyp447txGkayNb+AZKYjWbJsx3oY
	GhB9zAhd99x4s4Qb6a+6Z6SDQ7V5fHZP6AYvTCzUKaZPt4c/bxfrLNMZ/JEbUMLE
	yDvs0lZkjB13vbwkZrHxNzJPitetFshdZlNKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W8xQZ8/gMd5qmc6KCR8rd2iNjfzIY6mL
	wfkjgPknn5Cg3N59tfOMvvrAUsmWU+lhtBmKY/75MepSgx4nUmDSWm12Euj9m7P0
	CdbIJytbH15RsYjVDuyPNcmunoRyW2XJcgnDU+tUC2yteFh2NJtIv3IDiXr2b5nZ
	OgVT1yseKwM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC6437B791;
	Thu, 10 Apr 2014 14:35:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 921327B790;
	Thu, 10 Apr 2014 14:35:44 -0400 (EDT)
In-Reply-To: <1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
	(Yiannis Marangos's message of "Thu, 10 Apr 2014 21:31:20 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED336900-C0DE-11E3-8716-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246028>

Yiannis Marangos <yiannis.marangos@gmail.com> writes:

> xpread() and xpwrite() pay attention to EAGAIN/EINTR, so they will resume
> automatically on interrupted call.

We do not even use pwrite(); please don't add anything unnecessary
and unexercised, like xpwrite(), as potential bugs in it will go
unnoticed long after its introduction until it first gets used.

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index b9f6e12..1bac0f5 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -542,7 +542,7 @@ static void *unpack_data(struct object_entry *obj,
>  
>  	do {
>  		ssize_t n = (len < 64*1024) ? len : 64*1024;
> -		n = pread(pack_fd, inbuf, n, from);
> +		n = xpread(pack_fd, inbuf, n, from);
>  		if (n < 0)
>  			die_errno(_("cannot pread pack file"));
>  		if (!n)

OK.

> diff --git a/compat/mmap.c b/compat/mmap.c
> index c9d46d1..7f662fe 100644
> --- a/compat/mmap.c
> +++ b/compat/mmap.c
> @@ -14,7 +14,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
>  	}
>  
>  	while (n < length) {
> -		ssize_t count = pread(fd, (char *)start + n, length - n, offset + n);
> +		ssize_t count = xpread(fd, (char *)start + n, length - n, offset + n);
>  
>  		if (count == 0) {
>  			memset((char *)start+n, 0, length-n);
> @@ -22,8 +22,6 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
>  		}
>  
>  		if (count < 0) {
> -			if (errno == EAGAIN || errno == EINTR)
> -				continue;
>  			free(start);
>  			errno = EACCES;
>  			return MAP_FAILED;

OK.

> diff --git a/wrapper.c b/wrapper.c
> index 0cc5636..25b7419 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -174,6 +174,42 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
>  	}
>  }
>  
> +/*
> + * xpread() is the same as pread(), but it automatically restarts pread()
> + * operations with a recoverable error (EAGAIN and EINTR). xpread() DOES
> + * NOT GUARANTEE that "len" bytes is read even if the data is available.
> + */
> +ssize_t xpread(int fd, void *buf, size_t len, off_t offset)
> +{
> +	ssize_t nr;
> +	if (len > MAX_IO_SIZE)
> +	    len = MAX_IO_SIZE;
> +	while (1) {
> +		nr = pread(fd, buf, len, offset);
> +		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
> +			continue;
> +		return nr;
> +	}
> +}

OK.

Thanks.
