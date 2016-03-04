From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdiff/xprepare: fix a memory leak
Date: Fri, 04 Mar 2016 15:50:31 -0800
Message-ID: <xmqqegbpyf94.fsf@gitster.mtv.corp.google.com>
References: <56DA15FA.1090601@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 00:50:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abzUV-0002At-I0
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 00:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760579AbcCDXuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 18:50:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760368AbcCDXuf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 18:50:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 712804ACD1;
	Fri,  4 Mar 2016 18:50:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=70woBwRIfcmQwUrkGoKoi0iYtAw=; b=cMRzd0
	km6nyX1R2hh8VJN8prvs2pNf5XEK4crWx044jJHGUCJrSr/KgXW6v+IiCN4ekbTg
	VNUPcgSYuSNOJGYPUcAR2tu9PCAX0rmmFRypUjZ7xq141Q7SUXUOLlCE2iyFf27l
	N6ZILKUZWPnBCzXnpM4bGgBCuQ7U2c8f7BIMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ltULNMsgzt+wm2y2a5UkKz4kNW+7bv2S
	ZqVCp7Utm/W7D+02tCAoMB8Wc3BFUpQpCARkoBLN+9RxentL1wXR3KOcGCF/zye3
	T+mLfXRKWqzhrkoW8BqcZZMQCzKjYovoIQIbqv1ajrV7ygWusj+oqUNq10i9JE3L
	q6CAHlEQvqE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 68DFA4ACD0;
	Fri,  4 Mar 2016 18:50:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E14E54ACCF;
	Fri,  4 Mar 2016 18:50:32 -0500 (EST)
In-Reply-To: <56DA15FA.1090601@ramsayjones.plus.com> (Ramsay Jones's message
	of "Fri, 4 Mar 2016 23:10:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E2340E76-E263-11E5-8E9F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288282>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> The xdl_prepare_env() function may initialise an xdlclassifier_t
> data structure via xdl_init_classifier(), which allocates memory
> to several fields, for example 'rchash', 'rcrecs' and 'ncha'.
> If this function later exits due to the failure of xdl_optimize_ctxs(),
> then this xdlclassifier_t structure, and the memory allocated to it,
> is not cleaned up.
>
> In order to fix the memory leak, insert a call to xdl_free_classifier()
> before returning.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  xdiff/xprepare.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 5ffcf99..13b55ab 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -301,6 +301,7 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>  
>  		xdl_free_ctx(&xe->xdf2);
>  		xdl_free_ctx(&xe->xdf1);
> +		xdl_free_classifier(&cf);
>  		return -1;
>  	}

This looks obviously correct from the pattern of prepare's and
free's in the code that this part follows.  This potential leak has
been that way since 3443546f (Use a *real* built-in diff generator,
2006-03-24), i.e. the very beginning.

I find it somewhat strange that the call to xdl_free_classifier() at
the end of this function is made conditional to XDF_HISTOGRAM_DIFF,
though.  I can half-buy the argument "that is because we do not call
init-classifier for XDF_HISTOGRAM_DIFF", but in the error path we
call free-classifier unconditionally, so the code clearly knows that
it is safe to call free-classifier on a classifier that is cleared
with the initial memset(&cf, 0, sizeof cf).

I think the latter funkiness came from 9f37c275.
