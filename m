From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv17 05/11] run_processes_parallel: treat output of children as byte array
Date: Thu, 25 Feb 2016 10:16:34 -0800
Message-ID: <xmqqsi0godtp.fsf@gitster.mtv.corp.google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
	<1456369618-18127-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	sunshine@sunshineco.com, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 19:16:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ0Sw-0006Ic-B8
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 19:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140AbcBYSQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 13:16:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933114AbcBYSQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 13:16:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AAEE2464F8;
	Thu, 25 Feb 2016 13:16:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T6R/xesx7jUSqUKheckPKuRU3LY=; b=BnButW
	X4bccK2eBVkYSFpb8Qta8Y6qjs50IEyv9YyhecMWUtBx0C6RvykVeS8yX9NaOy06
	xH96l9M+hkNCBDRrm6tcErhP0nLzbavz3lcdFJQMwWjziwHcwipFUA2hQMBblMtA
	useb5hpmBYckWV+QVA5OSbuQqUxkCIYfYM0ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oR9dNDV6aF8GdaaS35B4q3js8RirSJMn
	Ej/jl+S8Ca+oegGtRTfHz2vaazChC121zDVoA0jaOW/CD6ilZSJrpa/oRE+tFz9n
	Ww+VR+yQXRMQykpKKsHm8do5hI/zO2w+VajI5aelDS1xBmdbfxH0AQLEiGR2hey4
	y9wpxkGI/v4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A29FE464F7;
	Thu, 25 Feb 2016 13:16:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 107D5464F6;
	Thu, 25 Feb 2016 13:16:36 -0500 (EST)
In-Reply-To: <1456369618-18127-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 24 Feb 2016 19:06:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E80AF5AE-DBEB-11E5-B860-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287411>

Stefan Beller <sbeller@google.com> writes:

> @@ -1135,11 +1135,11 @@ static int pp_collect_finished(struct parallel_processes *pp)
>  			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
>  			strbuf_reset(&pp->children[i].err);
>  		} else {
> -			fputs(pp->children[i].err.buf, stderr);
> +			strbuf_write(&pp->children[i].err, stderr);
>  			strbuf_reset(&pp->children[i].err);
>  
>  			/* Output all other finished child processes */
> -			fputs(pp->buffered_output.buf, stderr);
> +			strbuf_write(&pp->buffered_output, stderr);
>  			strbuf_reset(&pp->buffered_output);
>  
>  			/*
> diff --git a/strbuf.c b/strbuf.c
> index 38686ff..71345cd 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -395,6 +395,12 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
>  	return cnt;
>  }
>  
> +ssize_t strbuf_write(struct strbuf *sb, FILE *f)
> +{
> +	return fwrite(sb->buf, 1, sb->len, f);
> +}

Whenever I see a call to a function that takes size and nmemb
separately, I get worried about the case where nmemb is zero.
Hopefully everybody implements such a fwrite() as a no-op?

This may not matter in this patch as no caller checks the return
value from this function, but shouldn't the callers be a bit more
careful checking errors in the first place?
