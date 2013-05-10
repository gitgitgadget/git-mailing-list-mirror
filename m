From: Junio C Hamano <gitster@pobox.com>
Subject: Re: write() _will_ fail on Mac OS X/XNU if nbytes > INT_MAX
Date: Thu, 09 May 2013 19:28:53 -0700
Message-ID: <7vbo8j600q.fsf@alter.siamese.dyndns.org>
References: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com>
	<7v4nffpbct.fsf@alter.siamese.dyndns.org>
	<CAEDE8504Pa_hRcHBLt4S9CL74noqrX3fWGCSf+x45zCr_43+5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Filipe Cabecinhas <filcab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 04:29:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uad56-00019l-QC
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 04:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013Ab3EJC27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 22:28:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754403Ab3EJC24 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 22:28:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0570B159D3;
	Fri, 10 May 2013 02:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kabzCFsCWNFlHgk6DS3AtJxd7sQ=; b=MyMscS
	qeqv0gtKWQ0ov1bzZCmbgsu3OeHewSWt9ucQaL9tJHGaZdUZedItwMqGW7t22vkm
	ZsoyGXsf33MOr/PbOQ6sD2zMt4ZdelzDSERewTzhv94EyCvp7sUKkEQT9d/tRkfW
	VBVKWMacLVhLtCqBr2kyCuFOGGOnAdhnmRqPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jIY7GQv3GExJwDv9oSbwyWDudEY84GSu
	n1MPnWBoFQ/iYpE/d5O+G+d/zbk24wiPtEJnP0rtPkIuwvGpJAb1NbTOdoM8HOtq
	gQGuVZh5n1wRzr78tz6OKujBUvG+A/qIasd9dqpxT0UzBSpOccz9J8nlo3V5NFeo
	HYjBMnIv4F8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEB7C159D2;
	Fri, 10 May 2013 02:28:55 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B3CF159CF;
	Fri, 10 May 2013 02:28:55 +0000 (UTC)
In-Reply-To: <CAEDE8504Pa_hRcHBLt4S9CL74noqrX3fWGCSf+x45zCr_43+5A@mail.gmail.com>
	(Filipe Cabecinhas's message of "Thu, 9 May 2013 15:58:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C8BD34C-B919-11E2-8C55-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223811>

Filipe Cabecinhas <filcab@gmail.com> writes:

> Sorry for the delay. I've updated the patch to work as you suggested (I think).
> It's attached.

A few comments.

First, the formalities.  Please see Documentation/SubmittingPatches,
notably:

   - Please do not send a patch as an attachment.

   - The attached patch does not seem to have any proposed commit
     log message. For this particular change, I expect it would not
     be more than a paragraph of several lines. Please have one.

   - Please sign-off your patch.

Look at patches from other high-value contributors to learn the
style and the tone of log message.  For instance,

    http://article.gmane.org/gmane.comp.version-control.git/223406

is a good example (taken at random).

> diff --git a/compat/write.c b/compat/write.c
> new file mode 100644
> index 0000000..1e890aa
> --- /dev/null
> +++ b/compat/write.c
> @@ -0,0 +1,11 @@
> +#include <limits.h>
> +#include <unistd.h>
> +
> +/* Version of write that will write at most INT_MAX bytes.
> + * Workaround a xnu bug on Mac OS X */

	/*
         * We format our multi-line comments like this.
         *
         * Nothing other than slash-asterisk/asterisk-slash
         * on the first and the last line of the comment block.
         */

> +ssize_t clipped_write(int fildes, const void *buf, size_t nbyte) {
> +  if (nbyte > INT_MAX)
> +    return write(fildes, buf, INT_MAX);
> +  else
> +    return write(fildes, buf, nbyte);
> +}

Style:

 - opening and closing parentheses of the function body sit on
   lines on their own.

 - one level of indent is 8 places, using a tab.

Perhaps it would look more like this (my MUA may clobber the tabs,
though, before it gets to you):

	ssize_t clipped_write(int fildes, const void *buf, size_t nbyte)
	{
		if (nbyte > INT_MAX)
			nbyte = INT_MAX;
		return write(fildes, buf, nbyte);
	}

I do not want to see this ffile called "write.c"; we will encounter
a platform whose write(2) behaves a way that we do not expect but is
different from this "clipped to INT_MAX" in the future.  The way we
will deal with such a platform is to add a workaround similar to
this patch somewhere in the compat/ directory, but if you squat on
"compat/write.c", it would be a problem for that platform, as it
cannot call its version "compat/write.c".

Perhaps call it "compat/clipped-write.c" or something.

By the way, does your underlying write(2) correctly write INT_MAX
bytes, or did you mean to clip at (INT_MAX-1)? Just double-checking.

Other than that, the patch looks sensible to me.

Thanks.
