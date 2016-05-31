From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RCF/PATCH] Makefile: move 'ifdef DEVELOPER' after config.mak* inclusion
Date: Tue, 31 May 2016 10:00:29 -0700
Message-ID: <xmqqpos25fiq.fsf@gitster.mtv.corp.google.com>
References: <20160531132443.5033-1-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue May 31 19:00:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7n1z-0007jP-2R
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 19:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbcEaRAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 13:00:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755204AbcEaRAd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 13:00:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35E241EC8A;
	Tue, 31 May 2016 13:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2psrV8Bt4zgXb4ONhjKkIj+T3F0=; b=I4n6Bg
	AvlVrhTVVGI6VjcA/yxyzrSTHRniWNq2pK+kTmMWnTimUp3bAofjwSzwbuo/kaiT
	retVbSIwEQ8qhJEzUNxE/qb6mxqZbvx/oPA5j3jolQXAQePgRZL8oTThfaUAHCxf
	IGZzOZEi+Oot3eS6Ci1YDtXxXjiFLJTqgEGcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BTOAb8Ui8R8I+7OfQzz2TH7Lc60RyI/v
	nmTdmv83Kv1oe1E6djolmJoi/aYLUtVmpxvDGdA1Tpla5xEACOUBSnF+NH+X0+TQ
	8IeBu6w9zF7SnukFMr4q0YXS0tjjjTHQH9XGINPZWAilt2S1CMk7pQnPXuUrpuy+
	6zLluKXarYQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E9FD1EC89;
	Tue, 31 May 2016 13:00:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3EF01EC87;
	Tue, 31 May 2016 13:00:30 -0400 (EDT)
In-Reply-To: <20160531132443.5033-1-Matthieu.Moy@imag.fr> (Matthieu Moy's
	message of "Tue, 31 May 2016 15:24:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E8BC458-2751-11E6-B7FB-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295996>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The DEVELOPER knob was introduced in 658df95 (add DEVELOPER makefile
> knob to check for acknowledged warnings, 2016-02-25), and works well
> when used as "make DEVELOPER=1", and when the configure script was not
> used.
>
> However, the advice given in CodingGuidelines to add DEVELOPER=1 to
> config.mak does not: config.mak is included after testing for
> DEVELOPER in the Makefile, and at least GNU Make's manual specifies
> "Conditional directives are parsed immediately", hence the config.mak
> declaration is not visible at the time the conditional is evaluated.
>
> Also, when using the configure script to generate a
> config.mak.autogen, the later file contained a "CFLAGS = <flags>"
> initialization, which overrode the "CFLAGS += -W..." triggered by
> DEVELOPER.
>
> This patch fixes both issues.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> I'm surprised that no one noticed the issue. Probably because the
> Makefile is silent by default. Did I miss anything obvious?

Probably because the overlap of the population that use DEVELOPER=1
and config.mak is miniscule?  

When you work in multiple "git worktrees" (or its equivalent), it is
far more convenient to have a single "make" wrapper that you use
everywhere than to make sure that you copy (or symlink) a config.mak
into each and every one of them.

In any case, this change is a right thing to do.  Thanks for
noticing.

>  Makefile | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 15fcd57..2226319 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -380,18 +380,6 @@ ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
>  STRIP ?= strip
>  
> -ifdef DEVELOPER
> -CFLAGS += -Werror \
> -	-Wdeclaration-after-statement \
> -	-Wno-format-zero-length \
> -	-Wold-style-definition \
> -	-Woverflow \
> -	-Wpointer-arith \
> -	-Wstrict-prototypes \
> -	-Wunused \
> -	-Wvla
> -endif
> -
>  # Create as necessary, replace existing, make ranlib unneeded.
>  ARFLAGS = rcs
>  
> @@ -952,6 +940,18 @@ include config.mak.uname
>  -include config.mak.autogen
>  -include config.mak
>  
> +ifdef DEVELOPER
> +CFLAGS += -Werror \
> +	-Wdeclaration-after-statement \
> +	-Wno-format-zero-length \
> +	-Wold-style-definition \
> +	-Woverflow \
> +	-Wpointer-arith \
> +	-Wstrict-prototypes \
> +	-Wunused \
> +	-Wvla
> +endif
> +
>  ifndef sysconfdir
>  ifeq ($(prefix),/usr)
>  sysconfdir = /etc
