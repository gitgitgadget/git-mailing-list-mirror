From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] split_ident: parse timestamp from end of line
Date: Mon, 14 Oct 2013 15:25:29 -0700
Message-ID: <xmqqwqlfebhi.fsf@gitster.dls.corp.google.com>
References: <20131014202734.GA7007@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 00:25:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqa0-0000fm-Pz
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757590Ab3JNWZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:25:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756459Ab3JNWZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:25:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA2CE4A291;
	Mon, 14 Oct 2013 22:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BS/OTMW0C6FIXVf3lpphhHMdDfY=; b=HGp7RP
	siR/PBklPUkz1h1019MSdze9UXQ5rQ4GIIux5KeMp6+jG/UCDzgL/1xmyYDQIYx2
	51tlYTIiUaGjEQ6SLwwPh8hgLNuzz4xAJD3YFprx01I52M/Mv/68ocMXBYnIgkn/
	rOFbae9JJrrpEEBa7WzqUzFvlmXOgC9C2iXLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MrnRBFsx/Kc4c2Iug77X+jkujHtMlnM9
	xVUa/gMarpA/JMZJSgDK/SiA5wKm8dOr0dUnJFcqZCAb7OSg1fBvoTyTpaYDHpTR
	QVCZzH/t7IT7XsyShPvSK/iOENQCmwpz81wMyPpOWGxJHFLrM5xDCQaNmNOtp/DL
	824039uUC48=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FB2F4A290;
	Mon, 14 Oct 2013 22:25:31 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24DAF4A28F;
	Mon, 14 Oct 2013 22:25:31 +0000 (UTC)
In-Reply-To: <20131014202734.GA7007@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 14 Oct 2013 16:27:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 891892CE-351F-11E3-9BB5-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236124>

Jeff King <peff@peff.net> writes:

> You could take this concept further and try to do something clever with
> the email when we notice the extra ">". But I think that is where this
> crosses from "easily and simply covers a class of errors" into "losing
> proposition trying to tweak heuristics around various breakages".

True.

> The only thing that gives me pause here is that parsing from the right
> would close the door to ever adding any new information on the end of an
> ident line. I'd be surprised if that door wasn't already closed by the
> existing parsers, but I feel like the topic might have come up sometime
> in the past year or two (but I can't seem to find anything in the
> archive).

I do not recall any, either.

The approach to parse from the right-end feels like the simplest and
the clearest one to get the piece of information that matters in the
presence of breakages like the ones you mentioned.

> +	/*
> +	 * Look from the end-of-line to find the trailing ">" of the mail
> +	 * address, even though we should already know it as split->mail_end.
> +	 * This can help in cases of broken idents with an extra ">" somewhere
> +	 * in the email address.  Note that we are assuming the timestamp will
> +	 * never have a ">" in it.
> +	 *
> +	 * Note also that this memchr can never return NULL, as we would
> +	 * always find at least the split->mail_end closing bracket.
> +	 */
> +	cp = memrchr(split->mail_end, '>', len - (split->mail_end - line));
> +	for (cp = cp + 1; cp < line + len && isspace(*cp); cp++)
>  		;

"git grep" tells me this is the first use of memrchr(), which,
unlike memchr(), is _GNU_SOURCE-only if I am not mistaken, so we may
need a fallback definition in the compat/ and NEEDS_MEMRCHR in the
Makefile, I think.
