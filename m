From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere forget: grok files containing NUL
Date: Tue, 02 Apr 2013 12:18:57 -0700
Message-ID: <7vmwtgd9lq.fsf@alter.siamese.dyndns.org>
References: <5159FDE4.2090409@kdbg.org>
 <7vhajpj294.fsf@alter.siamese.dyndns.org> <515B2B6D.4050801@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:19:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6jy-0000T4-K7
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762103Ab3DBTTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:19:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48287 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353Ab3DBTTA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:19:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D11D312350;
	Tue,  2 Apr 2013 19:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NxJqDfqFBE9mN4cMKmCovWiLzl0=; b=ADdXRm
	20enhIvBy+aKXfJfn+Bhi9v4TPw8rBXTvCZQ6DaKY+Mnxu7iWk+w0zvaLj/KcJFl
	5qhqctX7tEe5sAjFeXMsE6kPoknN/3PyFVHHhsVT2msnIVZzSR1JRt8kHMnIX3dy
	MS6eDw3ZWYHeRBcq6UxpSW8AkoE4UtqXei0Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QewSjhfzCEGVLI5hhRG0kAiZSyOnoXjW
	xf1Lt1lzT72VHpEvBL6YqOD3Gg0aJvO6wKyu/72odkkhj2zXDMnxrVSKlcGbOJ+1
	oewPmA+E2pdeJu/IADQFVZ9lQ5/fa5PKCITrfjqzpbAd/tncHA/kXa/68KETwNd2
	Vm14ZyfmRJ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6C1D1234F;
	Tue,  2 Apr 2013 19:18:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B9E11234E; Tue,  2 Apr
 2013 19:18:59 +0000 (UTC)
In-Reply-To: <515B2B6D.4050801@kdbg.org> (Johannes Sixt's message of "Tue, 02
 Apr 2013 21:03:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B9BE162-9BCA-11E2-9BFA-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219855>

Johannes Sixt <j6t@kdbg.org> writes:

>> Does the three-way merge machinery replay recorded resolution for
>> such a binary file correctly (after your fix, that is)?
>
> Yes, it does. It recognizes the binary-ness and picks 'our' side. Only
> then comes rerere_mem_getline into play.

Surely getline() needs to be fixed not to loop forever regardless of
the binary-ness, but I was more worried about our additions of lines
that satisfy is_cmarker(), counting of them in the callchain from
handle_file() to handle_path() to decide if a path has already been
resolved by the user, and recording of an resolution based on the
return value of that callchain, all of which relies on the merged
contents being textual and marked with the conflict marker.

>>> diff --git a/rerere.c b/rerere.c
>>> index a6a5cd5..4d940cd 100644
>>> --- a/rerere.c
>>> +++ b/rerere.c
>>> @@ -284,8 +284,10 @@ static int rerere_mem_getline(struct strbuf *sb, struct rerere_io *io_)
>>>  	strbuf_release(sb);
>>>  	if (!io->input.len)
>>>  		return -1;
>>> -	ep = strchrnul(io->input.buf, '\n');
>>> -	if (*ep == '\n')
>>> +	ep = memchr(io->input.buf, '\n', io->input.len);
>>> +	if (!ep)
>>> +		ep = io->input.buf + io->input.len;
>>> +	else if (*ep == '\n')
>>>  		ep++;
>>>  	len = ep - io->input.buf;
>>>  	strbuf_add(sb, io->input.buf, len);
