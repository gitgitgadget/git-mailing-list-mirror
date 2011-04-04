From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http: make curl callbacks match contracts from curl
 header
Date: Mon, 04 Apr 2011 16:34:27 -0700
Message-ID: <7v8vvp7fr0.fsf@alter.siamese.dyndns.org>
References: <1301535531-1244-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 01:34:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6tIA-0006CW-0b
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 01:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab1DDXeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 19:34:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab1DDXeg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 19:34:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7339D5362;
	Mon,  4 Apr 2011 19:36:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NL5eJwNhg5IjvuExm4p33PaP/P0=; b=PjTM9z
	BTwPV9eOEQdwe0zostqN9Kd+7hAUN/ijcHKSelPXCi1UVsJuyt9GuFPtsp3A5zmL
	UP2JjFwLFqY7fND5GuG2fC07zSzFnUJWZNroYYshCOpld9ndtoam7hFIs2sCnlYP
	od/qgEP7jeL/VCi5WIPEE7477l1nM/0nR3E8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P3HYTRDfakjmfILQiCc9M+/XGBTTUWJs
	CH7yQrGLVh2ErxOSHyL7fLkRlDoWNSxlwsCw2RK/F6BEqiTZ7g/Ekwn3kNlyrZpk
	XX031OhUwHGpxVN5+ljTz5uFxqJh5B02BBYuPHx21ky0OOnm84lvTxFw2eIoUU7/
	EOL1pKHsVco=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4F4A35360;
	Mon,  4 Apr 2011 19:36:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5F3DF535E; Mon,  4 Apr 2011
 19:36:22 -0400 (EDT)
In-Reply-To: <1301535531-1244-1-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Wed, 30 Mar 2011 20:38:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B0967C0-5F14-11E0-B7F3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170848>

Dan McGee <dpmcgee@gmail.com> writes:

> diff --git a/http-walker.c b/http-walker.c
> index 9bc8114..c83df1b 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -185,7 +185,7 @@ static void process_alternates_response(void *callback_data)
>  	struct active_request_slot *slot = alt_req->slot;
>  	struct alt_base *tail = cdata->alt;
>  	const char *base = alt_req->base;
> -	static const char null_byte = '\0';
> +	char null_byte = '\0';

I know you needed this change because later call to fwrite_buffer() uses a
pointer to this one byte, and the fwrite_buffer() takes "char *" not
"const char *", but ...

> @@ -1183,7 +1183,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
>  	} while (posn < size);
>  
>  	freq->stream.avail_in = size;
> -	freq->stream.next_in = ptr;
> +	freq->stream.next_in = (void *)ptr;

... if you are willing to cast the type away like this anyway, which is
not a bad thing at all, wouldn't it be better to keep the "static const
char nul_byte = '\0'" as it was, and use it like

	fwrite_buffer((char *)&nul_byte, 1, 1, ...);

for consistency?
