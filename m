From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?"] Implement better chunk heuristics.
Date: Thu, 14 Apr 2016 19:09:06 -0700
Message-ID: <xmqqbn5bei7x.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
	<20160415000730.26446-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: unlisted-recipients:; (no To-header on input) peff@peff.net,
	davidel@xmailserver.org, jacob.keller@gmail.com,
	git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:10:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqtD5-0002ST-3P
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 04:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbcDOCKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 22:10:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751535AbcDOCKI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 22:10:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C348B14D3F;
	Thu, 14 Apr 2016 22:10:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rMAKkEjkQUeJWxEfiILs9DSZV7Q=; b=ZJCDC4
	7OKTuc4aoIZC4APKed3d77tc3QGdZ4cWuq4FwLhO6n7OLVB6bbtDL55dTzRTEC7c
	AKUWRkueK00x/SOsSNh19tDfvsmsMlprRKJMT9bhizZqdvsX2b4Xo4wHqyj8Yc45
	Wr62O5Z2Nm6YHdQo+W2UQg0PhujowgBx/Qvmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cCmzQzse/feJYjlGawIHR8vfNfihmMCN
	F0waQfGrN9a0dqQMykAW7h2GVj/tie+yUkVnwGZEbpa/XJq2PsDcqmbTScRr0vBT
	7yf6CbF39/kPM2fzBxazlN8A5/j4UuWgqohYNYuHA4eZZBwedqXoDJ45TnPKqfdB
	RXnwPQdbgDM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB0E914D3E;
	Thu, 14 Apr 2016 22:10:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 637EE14D01;
	Thu, 14 Apr 2016 22:09:07 -0400 (EDT)
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)peff@peff.net
								     ^-missing end of address
In-Reply-To: <20160415000730.26446-1-sbeller@google.com> (Stefan Beller's
	message of "Thu, 14 Apr 2016 17:07:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 08FF2200-02AF-11E6-B6D2-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291592>

Stefan Beller <sbeller@google.com> writes:

>  
> +static int starts_with_emptyline(const char *recs)
> +{
> +	return recs[0] == '\n'; /* CRLF not covered here */
> +}
> +
> +

That's "is-empty-line", not "starts-with" ;-)

> +
> +		/*
> +		 * If a group can be moved back and forth, see if there is an
> +		 * empty line in the moving space. If there is an empty line,
> +		 * make sure the last empty line is the end of the group.
> +		 *
> +		 * As we shifted the group forward as far as possible, we only
> +		 * need to shift it back if at all.
> +		 */

Sounds sensible.

> +		if (has_emptyline) {
> +			while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
> +			       xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags) &&
> +			       !starts_with_emptyline(recs[ix - 1]->ptr)) {

You probably want to wrap the "hash compares equal and recmatch does
say they are the same" into a helper function (to be automatically
inlined by the compiler) to make it more readable here.  I think
is-empty is a lot cheaper than the recmatch so that should probably
be done earlier in the && chain.

> +				rchg[--ixs] = 1;
> +				rchg[--ix] = 0;
> +
> +				/*
> +				 * This change did not join two change groups,
> +				 * as we did that before already, so there is no

Sorry, cannot quite parse the part before "already".

> +				 * need to adapt the other-file, i.e.
> +				 * running
> +				 *     for (; rchg[ixs - 1]; ixs--);
> +				 *     while (rchgo[--ixo]);
> +				 */
> +			}
> +		}
>  	}
>  
>  	return 0;
