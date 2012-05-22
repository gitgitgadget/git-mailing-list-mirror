From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] fetch-pack: sort incoming heads
Date: Tue, 22 May 2012 13:08:42 -0700
Message-ID: <7v7gw43rn9.fsf@alter.siamese.dyndns.org>
References: <20120521221417.GA22664@sigill.intra.peff.net>
 <20120521221702.GA22914@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 22:08:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvO0-0002J3-5h
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760345Ab2EVUIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 16:08:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64295 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928Ab2EVUIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:08:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D16F78246;
	Tue, 22 May 2012 16:08:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Ry/f5WS6Mfu7Z3Mx1aI25dKpEQ=; b=adu5h4
	0xovgSU4/a/IQNuXvH1UGY5pzCqPi4WhtL7pQWe8OsHkolL2MGA/7vB/FE7rNzAg
	0t5QE9jfVKGzzUPbNXx1jRH6AjYDqOcDueARLmLgu6iPjnHj6lYC14Df1zzPljP2
	18h1O5eKMsqAMZVfqYqyg88JZiAPnI7setnUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u9yrev423cb2hlh/9mxK7ra0Un41iM3H
	mkhBwZt5VssfgHrI/5/qc0RiiCQBbPF3q0rDrI+Ypr28mWS2aEyX8Zcwyutcvqab
	WkEfl1srO+5FKCU9z8Ps9BIYiEoxfwprVcuMqR/mxrxHzKcn1krcL06io/SVtZWA
	6Zw7M2Ez1x0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7C3D8245;
	Tue, 22 May 2012 16:08:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F09C8244; Tue, 22 May 2012
 16:08:44 -0400 (EDT)
In-Reply-To: <20120521221702.GA22914@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 21 May 2012 18:17:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEC0DEB4-A449-11E1-AC75-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198236>

Jeff King <peff@peff.net> writes:

> There's no reason to preserve the incoming order of the
> heads we're requested to fetch. By having them sorted, we
> can replace some of the quadratic algorithms with linear
> ones.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I actually wouldn't be surprised if these were typically sorted already,
> as they frequently come from the ref-mapping functions, which in turn
> process the lists we get from the remote. But we also might get random
> junk on the command-line of fetch-pack, so we need to be careful.
>
>  builtin/fetch-pack.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 10db15b..380743e 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -1057,6 +1057,11 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> +static int compare_heads(const void *a, const void *b)
> +{
> +	return strcmp(*(const char **)a, *(const char **)b);
> +}
> +
>  struct ref *fetch_pack(struct fetch_pack_args *my_args,
>  		       int fd[], struct child_process *conn,
>  		       const struct ref *ref,
> @@ -1076,6 +1081,8 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
>  			st.st_mtime = 0;
>  	}
>  
> +	qsort(heads, nr_heads, sizeof(*heads), compare_heads);
> +
>  	if (heads && nr_heads)
>  		nr_heads = remove_duplicates(nr_heads, heads);

Hrm, could heads and/or nr_heads be NULL/0 here when we try to run qsort()
in this codepath?

>  	if (!ref) {
