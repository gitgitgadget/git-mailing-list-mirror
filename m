From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/2] daemon: allow more than one host address given via
 --listen
Date: Mon, 30 Aug 2010 00:28:48 -0700
Message-ID: <7vwrr8ftjj.fsf@alter.siamese.dyndns.org>
References: <1283094462-5184-1-git-send-email-alexander@sulfrian.net>
 <1283094796-27984-3-git-send-email-alexander@sulfrian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Sulfrian <alexander@sulfrian.net>
X-From: git-owner@vger.kernel.org Mon Aug 30 09:29:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opyo3-0004j0-GR
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 09:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716Ab0H3H3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 03:29:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab0H3H27 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 03:28:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F1BAD1795;
	Mon, 30 Aug 2010 03:28:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H9KV+4vZPTCV3enOXrxpg9hLkAM=; b=ShSdKn
	lhAc1T7gDqhn6V4M5FpVkrNUhK8nOa1p3mwpyBoRRmk5Q4iRWuZgCkvu1WlmpQna
	d1B1vqj+WT+ibhQD7HnFN/T3VeLMerGCQbR+iSOHR49YgERkbTN4PZe5i4QoO4mC
	1k6jrk8X0C+LJbSUosW/sprGFNeaSYQ6m438Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X2muF4tOA+coTCSamlFREY4H7P7/Gh3G
	3DMpSpgybMyGutQGIG8YQtRQa+YdR5miq7ApkNCESHY8ZbCw3DU7vsB+rv2SZpzh
	RUtSV+pxcsrjo6KkrnChIYEeocxQYUUYXhQ1weJrxtCDeLI1unSDyUfI8BzeMFXs
	ApsknQP4nhQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32C9CD1794;
	Mon, 30 Aug 2010 03:28:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38FBFD1792; Mon, 30 Aug
 2010 03:28:50 -0400 (EDT)
In-Reply-To: <1283094796-27984-3-git-send-email-alexander@sulfrian.net>
 (Alexander Sulfrian's message of "Sun\, 29 Aug 2010 17\:13\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3DAA3900-B408-11DF-9EF6-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154772>

Alexander Sulfrian <alexander@sulfrian.net> writes:

> @@ -861,11 +862,20 @@ static int setup_named_sock(char *listen_addr, int listen_port, int **socklist_p
>  
>  #endif
>  
> -static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
> +static int socksetup(struct string_list *listen_addr, int listen_port, int **socklist_p)
>  {
>  	int socknum = 0, *socklist = NULL;
>  
> -	socknum = setup_named_sock(listen_addr, listen_port, &socklist, socknum);
> +	if (!listen_addr->nr)
> +		socknum = setup_named_sock(NULL, listen_port, &socklist,
> +					   socknum);
> +	else {
> +		int i;
> +		for (i = 0; i < listen_addr->nr; i++)
> +			socknum = setup_named_sock(listen_addr->items[i].string,
> +						   listen_port, &socklist,
> +						   socknum);
> +	}
>  
>  	*socklist_p = socklist;
>  	return socknum;

Giving an old number and returning a new number feels a bit awkward as an
API.  If you create a structure that consists of a <pointer, nr, alloc>
tuple that is suitable for ALLOC_GROW() API and pass that around instead
of <&socklist, socknum> pair, then the helper can return how many sockets
it prepared, and signal a failure with a negative value, no?

> +static int serve(struct string_list *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
>  {
>  	int socknum, *socklist;
>  
>  	socknum = socksetup(listen_addr, listen_port, &socklist);
>  	if (socknum == 0)
> -		die("unable to allocate any listen sockets on host %s port %u",
> -		    listen_addr, listen_port);
> +		die("unable to allocate any listen sockets on port %u",
> +		    listen_port);

The old code accepted only one --listen, so it was clear when no socket
can be prepared for a given name (which may expand to multiple addresses),
it is clear what failed (i.e. the failing input could have been only _one_
from the user's point of view).  This check diagnoses the case where
socket preparation failed for all names.  Don't we want to have a new
check inside the iteration over names in socksetup() to warn when socket
preparation for all addresses for a name fails?

Also doesn't setup_named_sock() as refactored die() when one of the names
given to --listen results no socket under ipv6 build but keeps going under
noipv6 build?  Without multi-listen, the distinction did not matter
exactly because it took only one name, but your multi-listen addition
exposes this inconsistency.  I think the helper should be modified not to
die but just return "I didn't prepare any socket for the given name", to
allow the outer loop to continue on to the next name (perhaps while
issuing a warning e.g. "No listening socket resulted for '%s'".
