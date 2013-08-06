From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/16] blame: accept multiple -L ranges
Date: Tue, 06 Aug 2013 14:33:36 -0700
Message-ID: <7v1u66fqrz.fsf@alter.siamese.dyndns.org>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
	<1375797589-65308-6-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 23:33:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6osy-0001Qq-2G
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 23:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011Ab3HFVdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 17:33:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787Ab3HFVdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 17:33:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59A0D3736B;
	Tue,  6 Aug 2013 21:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9sq4bFPuPUMM/kyPo7EQ0fwDkW0=; b=PN2gaH
	cwHVVfdV05LVE1knpcHnJqM7cByr2jr6U1/XJzXCO3HubThGKyPqoZBqsViKPWrF
	q6saR5BCiaDYrZh6QbV1hJ+aQd2fviv+g88kRW0EZpf2fRfZmAFaUeAH5VPb5OMO
	htEWrT3W3jG50ToG5VU4AnTUHibXGcFIZmlQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=De7U6ax7EbIgZi36ytw8NayXG0NYlHJz
	e8Xdr5yAyTifXkaJqvtPUcDcGvWcvLYPdoy/VleQT/1EyyU5eZ4oHiYgRpJG//dt
	6iniBAwArXD6+UucEbimGq7O11EnzXiQ8rw5F2RP9a6PiArIAl772hpevrqrR25+
	KAZmxL/+OyU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C4E33736A;
	Tue,  6 Aug 2013 21:33:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A11C737365;
	Tue,  6 Aug 2013 21:33:37 +0000 (UTC)
In-Reply-To: <1375797589-65308-6-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Tue, 6 Aug 2013 09:59:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DADC7B28-FEDF-11E2-BEDF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231787>

> +	for (range_i = ranges.nr; range_i > 0; --range_i) {
> +		const struct range *r = &ranges.ranges[range_i - 1];
> +		long bottom = r->start;
> +		long top = r->end;
> +		struct blame_entry *next = ent;
> +		ent = xcalloc(1, sizeof(*ent));
> +		ent->lno = bottom;
> +		ent->num_lines = top - bottom;
> +		ent->suspect = o;
> +		ent->s_lno = bottom;
> +		ent->next = next;
> +		if (next)
> +			next->prev = ent;
> +		origin_incref(o);
> +	}
> +	origin_decref(o);

Hmph, I do not see where the need for this decref is coming from.
Did we incref once too many somewhere?

> +	range_set_release(&ranges);
> +	string_list_clear(&range_list, 0);
>  
>  	sb.ent = ent;
>  	sb.path = path;
