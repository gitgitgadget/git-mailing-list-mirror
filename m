From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-compat-util.h: implement a different ARRAY_SIZE macro for for safely deriving the size of array
Date: Thu, 30 Apr 2015 10:20:11 -0700
Message-ID: <xmqqk2wt1qk4.fsf@gitster.dls.corp.google.com>
References: <1430397854-28908-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 19:20:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yns8M-0007Yn-3U
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 19:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbbD3RUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 13:20:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751923AbbD3RUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 13:20:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B50BA4C88A;
	Thu, 30 Apr 2015 13:20:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j+RyO91bJGKWYiEnXsQ97CoHhH8=; b=iS6Kez
	cXBcRf1mgq3Qjv4/XIMgOhEm5cPkotnZO1vkHnDnjtjbVPaPokA6f760dGc0wHk2
	qztn+AWsAhxwkHvHc1Y19nJWUGbFMfLV3FPVh8AaYwIJnpzkqBZ2cWPtvT5pu1qO
	gYgVx5swwPYMlKd6juDcpoREmoz4nIBCy/0O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uCyh77Vh6Nl77OIMY2we48KC+1uNPhuf
	CFzUAruAbPAPzAF3Wfpj9qMzITD3ffHB79b0qfO1ZhsRgEdHA3j6pRyb+IvbxU63
	CrE2bgicDvDr+ojxYHp3LYomiv8gvFx6gfnGl1wWbdGVcIuT0dGeU4n9fAFn54oO
	uBslhlaqLbU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE6D64C888;
	Thu, 30 Apr 2015 13:20:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2735F4C887;
	Thu, 30 Apr 2015 13:20:13 -0400 (EDT)
In-Reply-To: <1430397854-28908-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Thu, 30 Apr 2015 14:44:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 294B0CEC-EF5D-11E4-BDCA-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268079>

Elia Pinto <gitter.spiros@gmail.com> writes:

> To get number of elements in an array git use the ARRAY_SIZE macro
> defined as:
>
>        #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
>
> The problem with it is a possibility of mistakenly passing to it a
> pointer instead an array. The ARRAY_SIZE macro as conventionally
> defined does not provide good type-safety and the open-coded
> approach is more fragile, more verbose and provides no improvement in
> type-safety.
>
> Use instead a different but compatible ARRAY_SIZE() macro,
> which will also break compile if you try to
> use it on a pointer. This implemention revert to the original code
> if the compiler doesn't know the typeof and __builtin_types_compatible_p
> GCC extensions.
>
> This can ensure our code is robust to changes, without
> needing a gratuitous macro or constant. A similar
> ARRAY_SIZE implementation also exists in the linux kernel.
>
> Credits to Rusty Russell and his ccan library.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  git-compat-util.h | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
>
> This is the third version of the patch.
>
> Compared to the second version:
>
> - Eliminated the autoconf use. I use instead the GCC (and compatible compilers) macros
>   for checking if the not portable builtin is supported or not ("Jeff suggestion")
> - Changed the name of the macro from _array_size_chk to BARF_IF_IS_NOT_AN_ARRAY i
>  ("Junio suggestion. In ALL_CAPS for the Jeff comment )"

Thanks.  Allow me to s/BARF_IF_IS_NOT_AN_ARRAY/BARF_UNLESS_AN_ARRAY/
everywhere for brevity while applying.
