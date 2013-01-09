From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/10] mailmap: remove email copy and length
 limitation
Date: Wed, 09 Jan 2013 09:56:24 -0800
Message-ID: <7vbocy6y0n.fsf@alter.siamese.dyndns.org>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
 <1357603821-8647-4-git-send-email-gitster@pobox.com>
 <CALWbr2wp7rV7Vh0=gwmWaZE5hLHQNL+UciDsL+z-1GyhS9pTkQ@mail.gmail.com>
 <7vfw2a6yh5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 18:56:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsztP-0004AN-8O
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 18:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292Ab3AIR41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 12:56:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758057Ab3AIR41 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 12:56:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA8DAB1B9;
	Wed,  9 Jan 2013 12:56:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nV+biU2s5hYbUdgit6P1UykigME=; b=trndEr
	3EhMqgU0YyG+AMWDTRevBNroZVBQ6nfB9sjnv04+MnNUEk+6BuUkppQxzOeKTame
	BFdymrNiiaj/qlqvR1nHBqQL90bKqqQw4tkajJWbmPmKSbwcVM0oG3rl88De2mxe
	6JzhttTyDA+/jpus/RnnjaiS1bC9SRSqFosXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/BfCgYVMNXWtSBWbYjWdgqsZEMEjdjb
	Ic0TLLtDaz0OUEK4cmYLxms7AjiAurkdvJe//GJkAM4f0gy1SDLd5G353/deG6Ud
	vHCeQTeFq4TM35v8gmEqhyzZof4ZK0FdbDwpUQsMrr6lCnDwFtx0hp9fDQq4dBMu
	EgSa21EK4vc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADF2CB1B8;
	Wed,  9 Jan 2013 12:56:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 103BAB1B6; Wed,  9 Jan 2013
 12:56:25 -0500 (EST)
In-Reply-To: <7vfw2a6yh5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 09 Jan 2013 09:46:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3099488-5A85-11E2-944F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213075>

Junio C Hamano <gitster@pobox.com> writes:

> Antoine Pelisse <apelisse@gmail.com> writes:
>
>>> +static struct string_list_item *lookup_prefix(struct string_list *map,
>>> +                                             const char *string, size_t len)
>>> +{
>>> +       int i = string_list_find_insert_index(map, string, 1);
>>> +       if (i < 0) {
>>> +               /* exact match */
>>> +               i = -1 - i;
>>> +               /* does it match exactly? */
>>> +               if (!map->items[i].string[len])
>>> +                       return &map->items[i];
>>
>> I'm not sure the condition above is necessary, as I don't see why an
>> exact match would not be an exact match.
>
> You have a overlong string "ABCDEFG", but you only want to look for
> "ABCDEF", i.e. len=6.  The string_list happens to have an existing
> string "ABCDEFG".  The insert-index function will report an exact
> match, but that does not mean you found what you are looking for. 

To put it another way, we can further clarify the situation by
rewording the comment "Does it match exactly?", perhaps like this

	if (i < 0) {
                /* exact match */
                i = -1 - i;
                if (!string[len])
                        return &map->items[i];
                /*
                 * It matched exactly even to the cruft at the end
                 * of the string, so it is not really a match.
                 */
	}
