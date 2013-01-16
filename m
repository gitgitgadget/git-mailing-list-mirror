From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fix clang -Wconstant-conversion with bit fields
Date: Wed, 16 Jan 2013 15:46:18 -0800
Message-ID: <7vlibsvghh.fsf@alter.siamese.dyndns.org>
References: <20130116182449.GA4881@sigill.intra.peff.net>
 <1358376443-7404-1-git-send-email-apelisse@gmail.com>
 <7vpq14vglu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, Max Horn <max@quendi.de>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:46:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvcgs-00069m-8n
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 00:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab3APXqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 18:46:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757477Ab3APXqV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 18:46:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97512AD5D;
	Wed, 16 Jan 2013 18:46:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQtL55EeXpq0SXdjm5j1VuIq+04=; b=vYOuU5
	BIQ9W3bdPyNh5epqiL/19BCkylDX2H+NrzhSy7D5IZh2+ATq/FFhU9hoctgLDAsu
	ZG9NoYRvf3qgIG8tefwvbntUfjr7VCN8u5QbdYwESQPBDpmHYlCRLhJAqLIWHtIl
	PMRXTbVk/6F1t2Z1RFjaZqGsv/nOZLft42U7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=faOJwSzSQ7aaAZJE7XSY9lYaHoSQgL40
	vmy5xvfutrCwBGDNYrrBEhgFuzMPSEuXUGtRBRJPmlaZHBPH62/ueIC0DEcrzI83
	N8g2e5XIcTCR2APbHp67I3OzN1ox1NCc10ad3IvaAO/R5yORqffx/b1jzCJ1cqC3
	0OH0CRjhxdY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87068AD5B;
	Wed, 16 Jan 2013 18:46:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4AA8AD49; Wed, 16 Jan 2013
 18:46:19 -0500 (EST)
In-Reply-To: <7vpq14vglu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 16 Jan 2013 15:43:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED411C80-6036-11E2-9A9E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213827>

Junio C Hamano <gitster@pobox.com> writes:

> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> clang incorrectly reports a constant conversion warning (implicit
>> truncation to bit field) when using the "flag &= ~FLAG" form, because
>> ~FLAG needs to be truncated.
>>
>> Convert this form to "flag = flag & ~FLAG" fixes the issue as
>> the right operand now fits into the bit field.
>
> If the "clang incorrectly reports" is already recognised by clang
> folks as a bug to be fixed in clang, I'd rather not to take this
> patch.
>
> I do not think it is reasonable to expect people to remember that
> they have to write "flags &= ~TO_DROP" in a longhand whenever they
> are adding new code that needs to do bit-fields, so even if this
> patch makes clang silent for the _current_ code, it will not stay
> that way.  Something like
>
> #define FLIP_BIT_CLR(fld,bit) do { \
> 	typeof(fld) *x = &(fld); \
>         *x = *x & (~(bit)); \
> } while (0)
>
> may be more palapable but not by a large margin.
>
> Yuck.

Double yuck.  I meant palatable.

In any case, I see somebody reports that more recent clang does not
have this bug in the near-by message, so let's forget about this
issue.

Thanks.
