From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: don't convert off_t to size_t too early to avoid potential die()
Date: Mon, 22 Sep 2014 12:41:32 -0700
Message-ID: <xmqqvbofjvdf.fsf@gitster.dls.corp.google.com>
References: <1411293806-3087-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Sep 22 21:41:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW9UQ-0006GQ-Rh
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 21:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbaIVTlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 15:41:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51939 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754768AbaIVTle (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 15:41:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F16CA3CD57;
	Mon, 22 Sep 2014 15:41:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e6agmhEkBThxdtxdxS303Ziz5GA=; b=G4j49T
	Xq9n2lX/p3IhDv1PD79I9SzGBqPx8n4E802bu6fECZAe1nO1kXNClbkUQWKksY9I
	AC/ajJ46BOnkhM3+FN5+PeZ8Rw+656MZhtlqR2p+QpVbzY8HCx7oI4Mp+JnOo2kx
	284xMGCw6psYWe6gistU1+y6UqOBMudwQ6b2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j8tVDbnjJZ2kZ6xXmShoCLw5xiuLpBrw
	1Q7rVhOH99h0wYgQBHULt4NJlXB0sZaO8y7MNp5/3hXHeAYtGOJsZvP4WNTFpjrH
	bvt9t8REFX5/uCrt0oYYH77umZVwjiWdRaTbZky80OuPm+EA51HRdxKg967uQ+gu
	HKG82zEUErU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8D953CD56;
	Mon, 22 Sep 2014 15:41:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 726083CD55;
	Mon, 22 Sep 2014 15:41:33 -0400 (EDT)
In-Reply-To: <1411293806-3087-1-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Sun, 21 Sep 2014 12:03:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7511E800-4290-11E4-B325-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257379>

Steffen Prohaska <prohaska@zib.de> writes:

> This patch should be applied on top of sp/stream-clean-filter.

... or it can be squashed in as a fix, as the topic is not yet in
'next'.

> index_stream() might internally also be able to handle large files to
> some extent.  But it uses size_t for its third argument, and we must
> already die() when calling it.  It might be a good idea to convert its
> interface to use off_t and push the size checks further down the stack.
> In general, it might be good idea to carefully consider whether to use
> off_t or size_t when passing file-related sizes around.  To me it looks
> like a separate issue for a separate patch series (I have no specific
> plans to prepare one).
>
>  sha1_file.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 5b0e67a..6f18c22 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3180,17 +3180,22 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
>  	     enum object_type type, const char *path, unsigned flags)
>  {
>  	int ret;
> -	size_t size = xsize_t(st->st_size);
>  
> +	/*
> +	 * Call xsize_t() only when needed to avoid potentially unnecessary
> +	 * die() for large files.
> +	 */
>  	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(path))
>  		ret = index_stream_convert_blob(sha1, fd, path, flags);
>  	else if (!S_ISREG(st->st_mode))
>  		ret = index_pipe(sha1, fd, type, path, flags);
> -	else if (size <= big_file_threshold || type != OBJ_BLOB ||
> +	else if (st->st_size <= big_file_threshold || type != OBJ_BLOB ||
>  		 (path && would_convert_to_git(path)))
> -		ret = index_core(sha1, fd, size, type, path, flags);
> +		ret = index_core(sha1, fd, xsize_t(st->st_size), type, path,
> +				 flags);
>  	else
> -		ret = index_stream(sha1, fd, size, type, path, flags);
> +		ret = index_stream(sha1, fd, xsize_t(st->st_size), type, path,
> +				   flags);
>  	close(fd);
>  	return ret;
>  }
