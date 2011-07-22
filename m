From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REGRESSION, BISECTED] `git checkout <branch>` started to be
 memory hog
Date: Fri, 22 Jul 2011 10:33:31 -0700
Message-ID: <7vipquz0d0.fsf@alter.siamese.dyndns.org>
References: <20110722130518.GA9873@tugrik.mns.mnsspb.ru>
 <20110722170001.GB20700@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@mns.spb.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 22 19:33:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkJbX-0006R4-PH
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 19:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830Ab1GVRdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 13:33:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611Ab1GVRde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 13:33:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69A364FD9;
	Fri, 22 Jul 2011 13:33:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rf/tDFfnkzP10BmaC6AM3EqoOLQ=; b=TBUWc6
	Yv5a2GiprbPFAklaEuMUiaAqFdBNhKA0Zz+yfqWEJadUFKe4+BnC3bAO8Lra625W
	GlZLAKY9uIxNsrMTotgMnMqmRWRKaaKweykY0guUN2zZKg6ZrdaupT9vL4cm3iV+
	jhrLstPW3KJBk+OnQ94PTwbxxTD9hACx5MZ4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CR8lsOymLw5JUFcBBXgwyRDJa9BZebER
	UX3ySgq693vq9GZqJu8Iph54uFfLMGNOPCRN3KY3BCnH8IM6KoYB9klz2hr8pu4J
	c1Jf+6ZK9aBkuprTCQZJ0zPwcKf9GQHb6q5G87hGrS2Zm/LcePmsaexVK1e4eHq6
	Sr8xesrCZtE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 612A34FD8;
	Fri, 22 Jul 2011 13:33:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C85F84FD6; Fri, 22 Jul 2011
 13:33:32 -0400 (EDT)
In-Reply-To: <20110722170001.GB20700@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Jul 2011 11:00:03 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8B1989C-B488-11E0-A86A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177649>

Jeff King <peff@peff.net> writes:

> From my quick look, I came up with the fix below. It removes the leak
> and doesn't trigger any memory errors according to valgrind. So it
> _must_ be right. :)
>
> -Peff
>
> ---
> diff --git a/streaming.c b/streaming.c
> index 565f000..f3acc5d 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -93,7 +93,9 @@ struct git_istream {
>  
>  int close_istream(struct git_istream *st)
>  {
> -	return st->vtbl->close(st);
> +	int r = st->vtbl->close(st);
> +	free(st);
> +	return r;
>  }

I do not think of a reason any future callers would want to close the
stream first and then inspect some attribute of the stream afterwards (if
this were an output stream, there might be things like output stats that
may want such an interface, but even in such a case, the caller should say
"flush" first to drain whatever is pending, grab stats and then close), so
freeing the resource at close time seems sensible to me.

Both the external caller in entry.c and the internal caller (a filtered
istream reads from its underlying istream, and when it is getting closed,
closes the underlying istream) were leaking the istream exactly the same
way, so this fix should plug both of them.

Thanks.
