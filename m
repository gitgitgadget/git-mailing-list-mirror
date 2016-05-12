From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/3] bisect: rewrite `check_term_format` shell function in C
Date: Thu, 12 May 2016 15:36:55 -0700
Message-ID: <xmqq37pmdhtk.fsf@gitster.mtv.corp.google.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-3-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	Johannes.Schindelin@gmx.de, sunshine@sunshineco.com
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 00:37:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0zED-00063h-60
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 00:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbcELWhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 18:37:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751121AbcELWg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 18:36:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 385CA1B4B9;
	Thu, 12 May 2016 18:36:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZFAkV1WnOJ312ogkZDh2jsAmqyI=; b=A/mz2C
	h0/9Jut78zRuV+U/ye+mPjmbI82VQMEdQIKevj2QchQGEJdxLfheQxomfzfJCO75
	/Od8UqohpEgWTbY64IqgID2NhPw7SIZIGTFdCl04rRTNIl8ZDsGdGmYsyeC0Nf6M
	jjhBy/I1jB/rmyWf+Zakxe/7HnN+blqYmaIN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pxuSSsb3C7zICwYovZo0m8/qB0x3LFwG
	aOiibddQmpKSO4QttSpPHKy7jt5G4gqk++g/wFHVLuUlgrXU5JvBom2jqSNjO55J
	CukptiWZ7VScnd5MRIUDbaEc+sq5JRhO84a9TYM7IenUNr175zXMXVqCnTZZem6o
	3yGzxoNVliM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30FC01B4B8;
	Thu, 12 May 2016 18:36:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A77221B4B7;
	Thu, 12 May 2016 18:36:57 -0400 (EDT)
In-Reply-To: <1463031127-17718-3-git-send-email-pranit.bauva@gmail.com>
	(Pranit Bauva's message of "Thu, 12 May 2016 11:02:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 090F2F08-1892-11E6-9DC4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294486>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +	/*
> +	 * In theory, nothing prevents swapping completely good and bad,
> +	 * but this situation could be confusing and hasn't been tested
> +	 * enough. Forbid it for now.
> +	 */
> +
> +	if ((strcmp(orig_term, "bad") && one_of(term, "bad", "new", NULL)) ||
> +		 (strcmp(orig_term, "good") && one_of(term, "good", "old", NULL)))
> +		return error(_("can't change the meaning of the term '%s'"), term);

The above comes from below

> -	bad|new)
> -		if test "$2" != bad
> -		then
> -			die "$(eval_gettext "can't change the meaning ...

So it is not your fault, but it is quite hard to understand.

The original says "You are trying to use 'bad' (or 'new') for
something that is not 'bad'--which is confusing; do not do it".

I _think_ the reason I find C version harder to read is the use of
strcmp(orig_term, "bad") to say "orig_term is not BAD".  The shell
version visually tells with "!=" that the meaning of the new term is
*NOT* "bad", and does not ahve such a problem.

Perhaps if we rewrote it to

	if ((!strcmp(orig_term, "good") &&
             one_of(term, "bad", "new", NULL)) ||
             (!strcmp(orig_term, "bad") &&
             one_of(term, "good", "old", NULL)))

i.e. "If you are using "bad" or "new" to mean "good", that is not a
good idea", as a follow-up change after the dust settles, the result
might be easier to read.

But this is just commenting for future reference, not suggesting to
update this patch at all.  If we were to do the change, that must
come as a separate step.

Thanks.
