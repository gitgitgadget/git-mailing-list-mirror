From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/14] remote.c: refactor setup of branch->merge list
Date: Thu, 21 May 2015 10:47:51 -0700
Message-ID: <xmqqfv6pkek8.fsf@gitster.dls.corp.google.com>
References: <20150521044429.GA5857@peff.net> <20150521044509.GB23409@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 19:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUZa-00059I-Uj
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984AbbEURry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 13:47:54 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38602 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbbEURrx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:47:53 -0400
Received: by igcau1 with SMTP id au1so14576373igc.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Iqvglj3YwrrKiIFb33xwPrU4qXWR/tZ1T6WnNT+FkJA=;
        b=WPD+ImXFKJFPucZUnsnMAiCATP2WRHMY0JC93c93l/k/bpOBLKRx4ovdP9cIjsAT37
         agbAH0tQQQzSEpVFp38kTsJUX+2/niiJ7VvpYkUl9eQK5Zib+VeVbEFicEdvE+rgrfQE
         a8D5AOwFSNBONVsyuxQUDslcwoRMY1CP0HP4Wo8/KPgIfkEqvp9DoVQPpc7xez3HG8hX
         nz8XW4ylaFSwouPL8KgcMtCReCKcchWqr3flFR0JGNg8sZjDIMoSZf3IwXiE5q9GFndp
         KoygW+MGuKYCG7gL0Uwc8dZ95aoHp8ECLyReZxqHFNooG9Ud2jp2acjKjdCk2RrjKbZn
         ovRw==
X-Received: by 10.42.175.198 with SMTP id bb6mr4752891icb.53.1432230473305;
        Thu, 21 May 2015 10:47:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id n9sm1815653igv.13.2015.05.21.10.47.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 10:47:52 -0700 (PDT)
In-Reply-To: <20150521044509.GB23409@peff.net> (Jeff King's message of "Thu,
	21 May 2015 00:45:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269628>

Jeff King <peff@peff.net> writes:

> When we call branch_get() to lookup or create a "struct
> branch", we make sure the "merge" field is filled in so that
> callers can access it. But the conditions under which we do
> so are a little confusing, and can lead to two funny
> situations:
> ...
> In addition to those two fixes, this patch pushes the "do we
> need to setup merge?" logic down into set_merge, where it is
> a bit easier to follow.

Nicely done.  Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index bec8b31..ac17e66 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1636,6 +1636,19 @@ static void set_merge(struct branch *ret)
>  	unsigned char sha1[20];
>  	int i;
>  
> +	if (!ret)
> +		return; /* no branch */
> +	if (ret->merge)
> +		return; /* already run */
> +	if (!ret->remote_name || !ret->merge_nr) {
> +		/*
> +		 * no merge config; let's make sure we don't confuse callers
> +		 * with a non-zero merge_nr but a NULL merge
> +		 */
> +		ret->merge_nr = 0;
> +		return;
> +	}
> +
>  	ret->merge = xcalloc(ret->merge_nr, sizeof(*ret->merge));
>  	for (i = 0; i < ret->merge_nr; i++) {
>  		ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
> @@ -1660,11 +1673,9 @@ struct branch *branch_get(const char *name)
>  		ret = current_branch;
>  	else
>  		ret = make_branch(name, 0);
> -	if (ret && ret->remote_name) {
> +	if (ret && ret->remote_name)
>  		ret->remote = remote_get(ret->remote_name);
> -		if (ret->merge_nr)
> -			set_merge(ret);
> -	}
> +	set_merge(ret);
>  	return ret;
>  }
