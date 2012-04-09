From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] xdiff: load full words in the inner loop of
 xdl_hash_record
Date: Mon, 09 Apr 2012 16:03:38 -0700
Message-ID: <7viph8tsmt.fsf@alter.siamese.dyndns.org>
References: <e0f938e9b849108e958da2e45e177f6f33d1118d.1333745883.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:03:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHNcj-0000ag-Pq
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 01:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024Ab2DIXDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 19:03:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673Ab2DIXDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 19:03:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F17D574A5;
	Mon,  9 Apr 2012 19:03:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IuDysPzHMzIcw8AclVIN9DmB8s0=; b=wuDY65
	Jal1EfyiJoqgF3U1sUBCpE1p6QEJgppWqg8IJXsogEBIUpwP6q1EWNKaD6y66mj5
	zknCcgdAZeG/v+6PqVObUBmJy3u71WeHy1QIzwFK5ft3+mt4THPKU774IfKMIs2H
	9In0uWRxVgpPxhFirxeUqkft3jttqXooJ9rhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HHUfrMwcRiEG6bY745y1wf0hzszPyK53
	Tcj/EJCK1W4dhxdJeTVo5sS8fIOAuVTvq4dH6jqRPxLos9VYu0Ig33wLz8xuGOqm
	KR2W5vGYC/I4PQsK7lVQh0CiJt6uEHZqUSOEczMIqZn1wlmd4q+1DaIbrDAEmufG
	nCBRZAoizNE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7F6774A4;
	Mon,  9 Apr 2012 19:03:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CEB574A3; Mon,  9 Apr 2012
 19:03:39 -0400 (EDT)
In-Reply-To: <e0f938e9b849108e958da2e45e177f6f33d1118d.1333745883.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri, 6 Apr 2012 23:01:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EA166F2-8298-11E1-8B43-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195045>

Thomas Rast <trast@student.ethz.ch> writes:

> +unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
> +	unsigned long hash = 5381;
> +	unsigned long a = 0, mask = 0;
> +	char const *ptr = *data;
> +	char const *end = top-sizeof(unsigned long)+1;
> +
> +	if (flags & XDF_WHITESPACE_FLAGS)
> +		return xdl_hash_record_with_whitespace(data, top, flags);
> +
> +	ptr -= sizeof(unsigned long);
> +	do {
> +		hash += hash << 5;
> +		hash ^= a;
> +		ptr += sizeof(unsigned long);
> +		if (ptr >= end)
> +			break;
> +		a = *(unsigned long *)ptr;
> +		/* Do we have any '\n' bytes in this word? */
> +		mask = has_zero(a ^ NEWLINEBYTES);
> +	} while (!mask);
> +
> +	if (ptr >= end) {
> +		/*
> +		 * There is only a partial word left at the end of the
> +		 * buffer. Because we may work with a memory mapping,
> +		 * we have to grab the rest byte by byte instead of
> +		 * blindly reading it.

Ok, because end is sufficiently below "top" and because you know "top-1"
should be a mapped byte, the "ptr >= end" check in the above loop ensures
that reading ul at ptr will stay within the range of mapped pages.

Cute but ugly ;-)
