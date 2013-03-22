From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/4] submodule: clarify logic in show_submodule_summary
Date: Fri, 22 Mar 2013 14:10:42 -0700
Message-ID: <7v620j6sz1.fsf@alter.siamese.dyndns.org>
References: <20130322161837.GG3083@sigill.intra.peff.net>
 <20130322161955.GA25857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 22 22:11:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ9F3-0004HN-Li
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 22:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423072Ab3CVVKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 17:10:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52241 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422967Ab3CVVKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 17:10:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4F6FBBD2;
	Fri, 22 Mar 2013 17:10:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lZWhLo2/1+YiOzhMiDPHxEoZo40=; b=rhXqWP
	Z4WsjgHiNfznjcwDR+S9Ojh5SCQ2mjqLq46iNdGpmCaOJ1MQhQDnThUp/5H/zZkH
	R3qfkWGv3La9jGtCawo0QMpWmIdwhEu+btvonyVYFJffn94P/qtWwiQR1G5Iwt3T
	31Lto1jZe0BANZCSbXrKJvfVs/6ShoYMlJblw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B6bigNuwhVH+/xjLNAVMlWN0lF2cBCk2
	G98nk8Bc192Tgwx1IVR8KzDO6n4IF1YPY4fMEdIekrdUUpqz39TlyMMWUTWS9nGo
	7tImxyzC+Za0IyXy/6sBlSLIUg9TFTUU5Q5g69awqdWKxqb3zHJWmghX6ZZUYSju
	h3vSI3skZC8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9EE5BBD1;
	Fri, 22 Mar 2013 17:10:44 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 392F3BBCA; Fri, 22 Mar 2013
 17:10:44 -0400 (EDT)
In-Reply-To: <20130322161955.GA25857@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Mar 2013 12:19:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F596CF20-9334-11E2-98AC-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218846>

Jeff King <peff@peff.net> writes:

> There are two uses of the "left" and "right" commit
> variables that make it hard to be sure what values they
> have (both for the reader, and for gcc, which wrongly
> complains that they might be used uninitialized).
>
> The functions starts with a cascading if statement, checking
> that the input sha1s exist, and finally working up to
> preparing a revision walk. We only prepare the walk if the
> cascading conditional did not find any problems, which we
> check by seeing whether it set the "message" variable or
> not. It's simpler and more obvious to just add a condition
> to the end of the cascade.
>
> Later, we check the same "message" variable when deciding
> whether to clear commit marks on the left/right commits; if
> it is set, we presumably never started the walk. This is
> wrong, though; we might have started the walk and munged
> commit flags, only to encounter an error afterwards. We
> should always clear the flags on left/right if they exist,
> whether the walk was successful or not.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Looks good.  Thanks.

>  submodule.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 9ba1496..975bc87 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -261,7 +261,7 @@ void show_submodule_summary(FILE *f, const char *path,
>  		const char *del, const char *add, const char *reset)
>  {
>  	struct rev_info rev;
> -	struct commit *left = left, *right = right;
> +	struct commit *left = NULL, *right = NULL;
>  	const char *message = NULL;
>  	struct strbuf sb = STRBUF_INIT;
>  	int fast_forward = 0, fast_backward = 0;
> @@ -275,10 +275,8 @@ void show_submodule_summary(FILE *f, const char *path,
>  	else if (!(left = lookup_commit_reference(one)) ||
>  		 !(right = lookup_commit_reference(two)))
>  		message = "(commits not present)";
> -
> -	if (!message &&
> -	    prepare_submodule_summary(&rev, path, left, right,
> -					&fast_forward, &fast_backward))
> +	else if (prepare_submodule_summary(&rev, path, left, right,
> +					   &fast_forward, &fast_backward))
>  		message = "(revision walker failed)";
>  
>  	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> @@ -302,11 +300,12 @@ void show_submodule_summary(FILE *f, const char *path,
>  		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
>  	fwrite(sb.buf, sb.len, 1, f);
>  
> -	if (!message) {
> +	if (!message) /* only NULL if we succeeded in setting up the walk */
>  		print_submodule_summary(&rev, f, del, add, reset);
> +	if (left)
>  		clear_commit_marks(left, ~0);
> +	if (right)
>  		clear_commit_marks(right, ~0);
> -	}
>  
>  	strbuf_release(&sb);
>  }
