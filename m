From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pass transport verbosity down to git_connect
Date: Thu, 28 Jan 2016 15:45:50 -0800
Message-ID: <xmqqegd1l13l.fsf@gitster.mtv.corp.google.com>
References: <20160128225123.GA20045@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:45:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOwGD-0004Da-NI
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 00:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbcA1Xpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 18:45:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750920AbcA1Xpx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 18:45:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9187F3F1A9;
	Thu, 28 Jan 2016 18:45:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HVENmv2n86MU8Hj3n8vD+vcHloQ=; b=i9XB7d
	VghKPlKaXeqDJO8/iHjSKoBpA4vr9swhso9/BvGEcv2sw43GEJ751puiyZLzDB4g
	irABU/J/8gCw98glpFJl/AomH4KtEGL3+gt+BVIwqeINlxLHwgkAjUZIV/jIp0dF
	XjPrsOeYEQ5mR6h398aaJVMWyNqMk4uYgHiNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MTQBsIQcfiaaZ/FSSwdyV5av3ia1DcQ0
	2vSolaoxd7gJoPBr+4taLeh44za8h5UkksCRF9Y7d/xlGJD7lTvgf7CQfPoCbONJ
	nQUoN8lznaHiYsTR2OXsoF1EshFeNxzd7Boo8hITySad37MPz+vWSzgqbkuh9xWr
	bneEKRGoQAc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 781473F1A8;
	Thu, 28 Jan 2016 18:45:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D7E913F1A7;
	Thu, 28 Jan 2016 18:45:51 -0500 (EST)
In-Reply-To: <20160128225123.GA20045@dcvr.yhbt.net> (Eric Wong's message of
	"Thu, 28 Jan 2016 22:51:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 43D194A8-C619-11E5-ACC0-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285046>

Eric Wong <normalperson@yhbt.net> writes:

> While working in connect.c to perform non-blocking connections,
> I noticed calling "git fetch -v" was not causing the progress
> messages inside git_tcp_connect_sock to be emitted as I
> expected.

Nice.  Can we demonstrate and protect this fix with simple tests?

Thanks.  Will queue.

>  transport.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index 67f3666..9ae7184 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -481,9 +481,10 @@ static int set_git_option(struct git_transport_options *opts,
>  	return 1;
>  }
>  
> -static int connect_setup(struct transport *transport, int for_push, int verbose)
> +static int connect_setup(struct transport *transport, int for_push)
>  {
>  	struct git_transport_data *data = transport->data;
> +	int flags = transport->verbose > 0 ? CONNECT_VERBOSE : 0;
>  
>  	if (data->conn)
>  		return 0;
> @@ -491,7 +492,7 @@ static int connect_setup(struct transport *transport, int for_push, int verbose)
>  	data->conn = git_connect(data->fd, transport->url,
>  				 for_push ? data->options.receivepack :
>  				 data->options.uploadpack,
> -				 verbose ? CONNECT_VERBOSE : 0);
> +				 flags);
>  
>  	return 0;
>  }
> @@ -501,7 +502,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
>  	struct git_transport_data *data = transport->data;
>  	struct ref *refs;
>  
> -	connect_setup(transport, for_push, 0);
> +	connect_setup(transport, for_push);
>  	get_remote_heads(data->fd[0], NULL, 0, &refs,
>  			 for_push ? REF_NORMAL : 0,
>  			 &data->extra_have,
> @@ -536,7 +537,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	args.update_shallow = data->options.update_shallow;
>  
>  	if (!data->got_remote_heads) {
> -		connect_setup(transport, 0, 0);
> +		connect_setup(transport, 0);
>  		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
>  				 NULL, &data->shallow);
>  		data->got_remote_heads = 1;
> @@ -812,7 +813,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>  
>  	if (!data->got_remote_heads) {
>  		struct ref *tmp_refs;
> -		connect_setup(transport, 1, 0);
> +		connect_setup(transport, 1);
>  
>  		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
>  				 NULL, &data->shallow);
