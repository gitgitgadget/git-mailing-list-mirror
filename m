From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add extra logic required to detect endianness on Solaris
Date: Thu, 01 May 2014 11:58:26 -0700
Message-ID: <xmqqa9b1coml.fsf@gitster.dls.corp.google.com>
References: <1398930197-12851-1-git-send-email-cbailey32@bloomberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <cbailey32@bloomberg.net>
X-From: git-owner@vger.kernel.org Thu May 01 20:58:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfwBn-0006wF-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 20:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbaEAS6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 14:58:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61534 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbaEAS6b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 14:58:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6930A11EFA;
	Thu,  1 May 2014 14:58:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pgLRH4/bxKgPUlfkFiBgl4idWE0=; b=r3yGSD
	irOrWl5Bt+pcKaO7Q6XtfyyJQWIhNXa4u5KUQVfQae/6PVWQWEFhq71u34MaSrys
	P37jbfM1Dq7ZYejuAYQsV7lsp23gEiXD1NsN7AdMWOIXz47/bhfJryRPrwrxk96d
	HkHAtpyXfNJOrORMm1l/j12rgOibLU5QzsZmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5xvmdR+DEsI3HujYDLIjf45SkqhjvJ6
	+qlYKNqSi9eruUQWnF/SMPK03jUgazTeDuS2eyMgZsdUfpMFPRJA4NPMZOjTR14D
	u6IbY16KmDtFMfZzceQqEy+5nt3Vb14/GRAo2T6NG2VTfvmdAmVIQfMrS73LrdD9
	JzBtStQeAEY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D17511EF9;
	Thu,  1 May 2014 14:58:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2948211EF8;
	Thu,  1 May 2014 14:58:28 -0400 (EDT)
In-Reply-To: <1398930197-12851-1-git-send-email-cbailey32@bloomberg.net>
	(Charles Bailey's message of "Thu, 1 May 2014 08:43:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 94A0A5E8-D162-11E3-84F4-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247826>

Charles Bailey <cbailey32@bloomberg.net> writes:

>  #if !defined(__BYTE_ORDER)
> +/* Known to be needed on Solaris but designed to potentially more portable */
> +
> +#if !defined(__BIG_ENDIAN)
> +#define __BIG_ENDIAN 4321
> +#endif
> +
> +#if !defined(__LITTLE_ENDIAN)
> +#define __LITTLE_ENDIAN 1234
> +#endif
> +
> +#if defined(_BIG_ENDIAN)
> +#define __BYTE_ORDER __BIG_ENDIAN
> +#endif
> +#if defined(_LITTLE_ENDIAN)
> +#define __BYTE_ORDER __LITTLE_ENDIAN
> +#endif

The existing support is only for platforms where all three macros
(BYTE_ORDER, LITTLE_ENDIAN and BIG_ENDIAN) are defined, and the
convention used on such platforms where BYTE_ORDER is set to either
one of the *_ENDIAN macros to tell the code which byte order we
have.  This mimics the convention where __BYTE_ORDER and other two
macros are already defined with two leading underscores, and in such
a case we do not have to do anything.  We make the final decision to
use or bypass bswap64() in our ntohll() implementation based on the
variables with double leading underscores.

This patch seems to address two unrelated issues in that.

 (1) The existing support does not help a platform where the
     convention is to define either _BIG_ENDIAN (with one leading
     underscore) or _LITTLE_ENDIAN and not both, which is Solaris
     but there may be others.

 (2) There may be __LITTLE_ENDIAN and __BIG_ENDIAN macros already
     defined on the platform.  Or these may not have been defined at
     all.  You avoid unconditionally redefing these.

I find the latter iffy.

What is the reason for avoiding redefinition?  Is it because you
know the original values they have are precious?  And if so in what
way they are precious?  If the reason of avoiding redefinition is
because you do not even know what their values are (so that you are
trying to be safe by preserving), what other things can you say
about their values you are preserving?

Specifically, do you know that these two are defined differently, so
that defining __BYTE_ORDER to one of them and comparing it to
__BIG_ENDIAN is a good way to tell if the platform is big endian?

I would understand it if (2) were "we undefine if these are defined
and then define them as 4321 and 1234 respectively, in order to
avoid a compiler warning against redefinition of a macro", but that
is not what I am seeing, so I am not sure what you meant to achieve
by that "if !defined()" constructs.

Thanks.
