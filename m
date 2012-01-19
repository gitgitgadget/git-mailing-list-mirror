From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: Fix push status report when all branches
 fail
Date: Thu, 19 Jan 2012 14:57:29 -0800
Message-ID: <7vzkdjgv1i.fsf@alter.siamese.dyndns.org>
References: <1327011899-18883-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 23:57:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro0vK-0003wi-6U
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 23:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325Ab2ASW5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 17:57:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51726 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab2ASW5c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 17:57:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92EBC7630;
	Thu, 19 Jan 2012 17:57:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6N+hgP2gZZuHRUa8Qmj95A3VSBQ=; b=N0/Op2
	9CSJydRK1RYQevedwGGjKtlbL+JIwt5ySjz7qhjXzqB//8UCAuDXH+19edGxmnDd
	sqsts4tVLnvtVY/8kTvKMpL+YO058PGsHaUq+RpXG+JZ0huG9mq31qCvYt5ebmNE
	JowBBFmMda29xNxkzU4el8zjK1Z9mIgo1rccc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XC1XQdKR3OaV6MleqDslwFcfAWiqhEjK
	6TV/HahtZhnZh5f+t/TfvZ6Ta5Cd5iY3DcMDhqGiHvg/iKQO57rwY1ORfqqXSDYt
	UaN/N4LORRf5enjT0ZZljhTbMJJlHfo1MED1tgPVYwBQyN8O7hEzIdn/Ml1Lw2uS
	QlydvP375iw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A56D762F;
	Thu, 19 Jan 2012 17:57:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4D3F762D; Thu, 19 Jan 2012
 17:57:30 -0500 (EST)
In-Reply-To: <1327011899-18883-1-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Thu, 19 Jan 2012 14:24:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F77B88A2-42F0-11E1-8EB6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188845>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Always print a blank line after the send-pack process terminates,
> ensuring the helper status report (if it was output) will be
> correctly parsed by the calling transport-helper.c. This ensures
> the helper doesn't abort before the status report can be shown to
> the user.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---

Anybody wants to add a simple test for this failure mode?

>  remote-curl.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 48c20b8..d6054e2 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -805,7 +805,7 @@ static int push(int nr_spec, char **specs)
>  static void parse_push(struct strbuf *buf)
>  {
>  	char **specs = NULL;
> -	int alloc_spec = 0, nr_spec = 0, i;
> +	int alloc_spec = 0, nr_spec = 0, i, ret;
>  
>  	do {
>  		if (!prefixcmp(buf->buf, "push ")) {
> @@ -822,12 +822,11 @@ static void parse_push(struct strbuf *buf)
>  			break;
>  	} while (1);
>  
> -	if (push(nr_spec, specs))
> +	ret = push(nr_spec, specs);
> +	xwrite(1, "\n", 1);
> +	if (ret)
>  		exit(128); /* error already reported */
>  
> -	printf("\n");
> -	fflush(stdout);
> -

This is not a fault of this patch, but could we fix this ugly mixture of
xwrite() and printf() in the same program?  I can see that the loop in the
main() function carefully tries to call fflush(stdout) to make sure that
nothing is pending after processing a single command so using xwrite() may
not cause any harm here, but the thing is that you do not check the error
return from this xwrite(), so use of it is not giving us any potential
benefit of being able to detect I/O errors in a finer grained manner,
i.e. it is no better than the printf("\n"); fflush(stdout); sequence it
replaces.

Thanks.
