From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 6/6] entry.c: fix a memleak
Date: Mon, 30 Mar 2015 22:41:53 -0700
Message-ID: <xmqqoan9soym.fsf@gitster.dls.corp.google.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
	<1427764931-27745-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:42:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcowH-0003tF-RB
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 07:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbbCaFmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 01:42:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751095AbbCaFl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 01:41:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EC0E38AC4;
	Tue, 31 Mar 2015 01:41:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BGtknRXbVLKZCrMcZsmYfK9vkMA=; b=n/flXO
	3KHUphm4OAlzIHjPySpBV3pRw3bnRDTXuN3I2wMhomhQu/mpFmqiB7dWik0dlm4z
	fv3YNQt1Ff7JJ+oZgndxv10mDlZ51w3QwAUeVkwoilHS2rUfz8fUhwLIlESEdlsN
	UhhLyJhnbYc45zxgDYK56JdcvBzAPHv5ucbR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rXJVgN3iQQz7KpW1QAYJNWdcquoJkxKD
	eLWuQadXxKE6X7YGufGf0Ci+Lk3m2A9UFvWB6tmOs+dH/J6Ay3xi8SfYZkC7kITF
	VS9sa9ZEGIFbW61niLHYoCe7UFfSZK7XGXnPe8fJ2BcVLxcdBdvcGz2S4lwD7zTx
	20Z29mnQRfs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1537A38AC3;
	Tue, 31 Mar 2015 01:41:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C24B38AC0;
	Tue, 31 Mar 2015 01:41:54 -0400 (EDT)
In-Reply-To: <1427764931-27745-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 30 Mar 2015 18:22:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3AE4F1A-D768-11E4-9259-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266515>

Stefan Beller <sbeller@google.com> writes:

> From: John Keeping <john@keeping.me.uk>
>
> stream_blob_to_fd() always frees the filter now, so there is no memory
> leak in entry.c:152 just before the `goto finish`.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  
>  I added Johns signoff here tentatively, John can you confirm the sign off?
>  
>  streaming.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/streaming.c b/streaming.c
> index 2ff036a..811fcc2 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -507,8 +507,11 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
>  	int result = -1;
>  
>  	st = open_istream(sha1, &type, &sz, filter);
> -	if (!st)
> +	if (!st) {
> +		if (filter)
> +			free_stream_filter(filter);
>  		return result;
> +	}

I think this one is fine. I see you moved the callsite to free this
thing from entry.c down to streaming (stream_blob_to_fd()), which
means you would need to adjust the title of the change, too.

It somewhat feels dirty that we free what the caller gave us, but
given that closing a filtered stream frees the filter at the end,
I think this is the right place to discard the filter.  In essence,
the overall use of the API in this code is equivalent to

	filter = ... prepare a filter ...
        if (open_istream(... filter) == OK) {
		... use filter ...
                close_istream(); /* which frees the filter */
	} else {
           	/* we failed to free filter here without the patch */
		free_stream_filter(filter);
	}

so the patch makes sense.

We may want to teach free_stream_filter() that a request to free a
NULL filter is OK, though. That would be a separate clean-up topic.


>  	if (type != OBJ_BLOB)
>  		goto close_and_exit;
>  	for (;;) {
