From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] do_one_ref(): save and restore value of current_ref
Date: Wed, 17 Jul 2013 21:03:23 -0700
Message-ID: <7voba04ir8.fsf@alter.siamese.dyndns.org>
References: <CAPWNY8Ua=3t4jeDvkj3Aw2Ouvv+0r1kWrET5GNq9uS8PasGudQ@mail.gmail.com>
	<1373901857-28431-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 18 06:03:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzfRC-0000dC-Vn
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 06:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868Ab3GRED1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jul 2013 00:03:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab3GRED0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jul 2013 00:03:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 703B32A2F2;
	Thu, 18 Jul 2013 04:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=J1JdIukQ4fdc
	vyblyW2qIWJu3U0=; b=Yyc+X7Jm9hmR60gwhbrl6m9kG8MiqREqSvp/iIs40DSQ
	3pgYiqELzHst/YA5On6Th+N07ZSEjoIkTXGHRY0+ipWuEF/lUuqB2BRIwb5diCyP
	FEFkM4p2VbO2ufER9uqTl+9kLGKkDa2cHoAo2GshIAZacuwq3aputqybLTnnrdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=htd/R5
	StZzNplx1qO1AbVPIIbLD6rg4G2B+itvEHxuwrUJXEBXAe27h+cPMk3NVQCZLb5S
	tDFZaw1i0f97KrmCBdC5RBob5a/hLhWzTcDT1e1pqz5y5dmlAfkCKkzVBPvS0yEm
	NJqPvLVxU8MuCPIxmeJSgbiKTKbNc6C6qeh2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 673C32A2F1;
	Thu, 18 Jul 2013 04:03:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3A962A2ED;
	Thu, 18 Jul 2013 04:03:24 +0000 (UTC)
In-Reply-To: <1373901857-28431-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 15 Jul 2013 17:24:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE54436E-EF5E-11E2-9464-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230675>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If do_one_ref() is called recursively, then the inner call should not
> permanently overwrite the value stored in current_ref by the outer
> call.  Aside from the tiny optimization loss, peel_ref() expects the
> value of current_ref not to change across a call to peel_entry().  Bu=
t
> in the presence of replace references that assumption could be
> violated by a recursive call to do_one_ref:
>
> do_for_each_entry()
>   do_one_ref()
>     builtin/describe.c:get_name()
>       peel_ref()
>         peel_entry()
>           peel_object ()
>             deref_tag_noverify()
>               parse_object()
>                 lookup_replace_object()
>                   do_lookup_replace_object()
>                     prepare_replace_object()
>                       do_for_each_ref()
>                         do_for_each_entry()
>                           do_for_each_entry_in_dir()
>                             do_one_ref()
>
> The inner call to do_one_ref() was unconditionally setting current_re=
f
> to NULL when it was done, causing peel_ref() to perform an invalid
> memory access.
>
> So change do_one_ref() to save the old value of current_ref before
> overwriting it, and restore the old value afterward rather than
> setting it to NULL.
>
> Reported by: Mantas Mikul=C4=97nas <grawity@gmail.com>
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Thanks.

s/Reported by:/Reported-by:/ and lose the extra blank line after it?

I wonder if we can have an easy reproduction recipe in our tests.
