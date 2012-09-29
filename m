From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] revision: add --grep-reflog to filter commits by
 reflog messages
Date: Fri, 28 Sep 2012 22:54:29 -0700
Message-ID: <7vpq55idbe.fsf@alter.siamese.dyndns.org>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
 <1348893689-20240-1-git-send-email-pclouds@gmail.com>
 <1348893689-20240-3-git-send-email-pclouds@gmail.com>
 <20120929053013.GB3330@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 29 07:54:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THq0f-0001jQ-Pn
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 07:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376Ab2I2Fyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 01:54:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779Ab2I2Fyb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 01:54:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50C2494AC;
	Sat, 29 Sep 2012 01:54:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9alcXTHvEeJIM8QrRWB2aGbz3ok=; b=N1gG6K
	32VX49vvnBX5jiWXotCIWjEIZATblCE+dA2JwAEjn0OsMb64owAyYMkLFhyiBDZq
	lEdeNnTFeSXCobJRQA8+5q/BL+/dQKJ89cf83HAruF/BYhSOQ/0yuNKUO3dWzsbK
	8eNLE5MwdHYOnSSCJqhkvW6LkEoT9ponzg7+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yS8ntL4m7jDDJL2kNkSAMYgyIbaKd41P
	ThtKmKPuBquvFnMnWEDLU9xkvB+htjWLwx6J15Eq6t2myD6LLk1kXLMB3ngcLyoj
	Sr3CLntaJVeHxu92qRV9puFV6Qa+zU176Vljc420JDlJZsVGzsfXDjCPYF2lplhf
	ybCiUhVc4rc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F3B494AB;
	Sat, 29 Sep 2012 01:54:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BC5594AA; Sat, 29 Sep 2012
 01:54:30 -0400 (EDT)
In-Reply-To: <20120929053013.GB3330@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 29 Sep 2012 01:30:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22E53832-09FA-11E2-BB0E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206631>

Jeff King <peff@peff.net> writes:

>> +	if (opt->reflog_info) {
>> +		strbuf_addstr(&buf, "reflog ");
>> +		get_reflog_message(&buf, opt->reflog_info);
>> +		strbuf_addch(&buf, '\n');
>> +		strbuf_addstr(&buf, commit->buffer);
>> +	}
>> +	if (buf.len)
>> +		retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
>> +	else
>> +		retval = grep_buffer(&opt->grep_filter,
>> +				     commit->buffer, strlen(commit->buffer));
>> +	strbuf_release(&buf);
>> +	return retval;
>
> I like how callers not doing a reflog walk do not have to pay the price
> to do the extra allocating. We could further limit it to only when
> --grep-reflog is in effect, but I guess that would mean wading through
> grep_filter's patterns, since it could be buried amidst ANDs and ORs?
>
> One alternative would be to set a bit in the grep_opt when we call
> append_header_grep_pattern. It feels a bit like a layering violation,
> though. I guess the bit could also go into rev_info. It may not even be
> a measurable slowdown, though. Premature optimization and all that.

I do not think it is a layering violation.  compile_grep_exp()
should be aware of the short-cut possibilities and your "our
expression is interested in reflog so we need to read it" is very
similar in spirit to the existing opt->extended bit.

It will obviously allow us to avoid reading reflog information
unnecessarily here.  I think it makes perfect sense.

We may also want to flag the use of the --grep-reflog option when
the --walk-reflogs option is not in effect in setup_revisions() as
an error, or something.
