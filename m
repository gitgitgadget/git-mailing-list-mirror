From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] remote-curl: send the refs to fetch-pack on stdin
Date: Mon, 02 Apr 2012 11:50:58 -0700
Message-ID: <7vfwcmezn1.fsf@alter.siamese.dyndns.org>
References: <4F79C195.6090905@gmx.net> <4F79C264.1060508@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ivan Todoroski <grnch@gmx.net>
X-From: git-owner@vger.kernel.org Mon Apr 02 20:51:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEmLM-0002Ib-0y
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 20:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab2DBSvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 14:51:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab2DBSvB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 14:51:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B96B977D2;
	Mon,  2 Apr 2012 14:51:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SiZSJSBRoaDqBG/Dcq+dtqK1cqA=; b=KTvVVy
	60qzezArcBOLTyoIA1PV8pm8izBgIm2RjaCf3PIMcdvKPUO0JX+JIaytVNPIuR5i
	RB74D/hI8hr2lj7mjEs6Ctm0uKtBY2kPB266JS5sxKTIjcrLwrXgbQDOZdZufwq7
	7AaRRwUE2W/5sGKSUqYbqMfLgzyf9RhtLYER4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WCZbhNvKOqlFlr4dInzUhK94ippFerCf
	BNjNerk39zGYV0WAO37xcTxKoZRdBpgUBQwELI/9AU5QbKq5JDLNYA/F8AUSnl+Z
	MWhbYSpyXFMdrSvDrkRKLZ48SjZbfoOt1lgtrlwJ84rK4CO9haK8ti0iyswIs6cB
	kcP5BolsXRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0D1577D1;
	Mon,  2 Apr 2012 14:51:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 141A477CF; Mon,  2 Apr 2012
 14:50:59 -0400 (EDT)
In-Reply-To: <4F79C264.1060508@gmx.net> (Ivan Todoroski's message of "Mon, 02
 Apr 2012 17:14:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA03C3C4-7CF4-11E1-9B0D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194549>

Ivan Todoroski <grnch@gmx.net> writes:

> Now that we can throw an arbitrary number of refs at fetch-pack using
> its --stdin option, we use it in the remote-curl helper to bypass the
> OS command line length limit.
>
> Signed-off-by: Ivan Todoroski <grnch@gmx.net>
> ---
>  remote-curl.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index d159fe7f34..a728edfa7f 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -633,6 +638,7 @@ static int fetch_git(struct discovery *heads,
>  	argv = xmalloc((15 + nr_heads) * sizeof(char*));

You no longer need an argv array whose size is proportional to nr_heads.
I'll queue the patch without "+ nr_heads" part, but we should probably
switch this to use argv_array API after this series settles.

>  	argv[argc++] = "fetch-pack";
>  	argv[argc++] = "--stateless-rpc";
> +	argv[argc++] = "--stdin";
>  	argv[argc++] = "--lock-pack";
>  	if (options.followtags)
>  		argv[argc++] = "--include-tag";
> @@ -651,23 +657,27 @@ static int fetch_git(struct discovery *heads,
>  		argv[argc++] = depth_arg;
>  	}
>  	argv[argc++] = url;
> +	argv[argc++] = NULL;
> +
>  	for (i = 0; i < nr_heads; i++) {
>  		struct ref *ref = to_fetch[i];
>  		if (!ref->name || !*ref->name)
>  			die("cannot fetch by sha1 over smart http");
> -		argv[argc++] = ref->name;
> +		packet_buf_write(&preamble, "%s\n", ref->name);
>  	}
> -	argv[argc++] = NULL;
> +	packet_buf_flush(&preamble);
