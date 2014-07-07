From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs: Fix valgrind suppression file
Date: Mon, 07 Jul 2014 11:20:41 -0700
Message-ID: <xmqqy4w5c9om.fsf@gitster.dls.corp.google.com>
References: <1404505441-1853-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 20:20:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4DX4-00063r-63
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 20:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbaGGSUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 14:20:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54725 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaGGSUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 14:20:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3089126F45;
	Mon,  7 Jul 2014 14:20:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z/M/+s7oaOz7XaA3tePOd/bH9e0=; b=Y5ZEOj
	SmFtdL4xpTw7AdvcQsi3TtrYm/0J9ZczSzvcMtUs4YpRS5rTdqiLA7spvkfXBB+z
	tdcAdjw8ZRtLRAHgTBBVWFd1UG4PC9nDTVGTy8hy+P27F2unAZHjCv5t/KJXqZyy
	8Yu0qN5CAZzkloXa7vKX4LySWoOlNd1Qn6omU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=varg3TaJpc7Ipb5umA61rUV0ECDGPUE8
	laHZmZACWO5sWUK9jg2zqgnwojbOTwwDzzQn74vujy1g0FS536MXSmj0KUFeNIgN
	cgBPbwmPRA0phWRAPWqu66tz+sPVGWjX2luk8PkkOnd65DewYLvSNEZuZ5mZ8H/c
	mLgLmrXV5y8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 26C4126F44;
	Mon,  7 Jul 2014 14:20:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 76AE726F3F;
	Mon,  7 Jul 2014 14:20:30 -0400 (EDT)
In-Reply-To: <1404505441-1853-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Fri, 4 Jul 2014 13:24:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 60B2C916-0603-11E4-81AB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252979>

David Turner <dturner@twopensource.com> writes:

> Add all of the ways in which check_refname_format violates valgrind's
> expectations to the valgrind suppression file; remove an assumption about
> the call chain of check_refname_format from same.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  t/valgrind/default.supp | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

I'll queue, but it makes me feel more and more disgusted with that
SSE patch, to be honest.

>
> diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
> index 332ab1a..9d51c92 100644
> --- a/t/valgrind/default.supp
> +++ b/t/valgrind/default.supp
> @@ -50,10 +50,17 @@
>  	fun:copy_ref
>  }
>  {
> -	ignore-sse-check_refname_format
> +	ignore-sse-check_refname_format-addr
>  	Memcheck:Addr8
>  	fun:check_refname_format
> -	fun:cmd_check_ref_format
> -	fun:handle_builtin
> -	fun:main
> +}
> +{
> +	ignore-sse-check_refname_format-cond
> +	Memcheck:Cond
> +	fun:check_refname_format
> +}
> +{
> +	ignore-sse-check_refname_format-value
> +	Memcheck:Value8
> +	fun:check_refname_format
>  }
