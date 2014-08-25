From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header dependencies
Date: Mon, 25 Aug 2014 12:30:51 -0700
Message-ID: <xmqqvbpgl638.fsf@gitster.dls.corp.google.com>
References: <20140822042716.GE27992@peff.net>
	<20140822043303.GB18192@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:31:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLzzC-0002kq-Qf
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 21:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933302AbaHYTbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 15:31:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54419 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933108AbaHYTbW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 15:31:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF48233308;
	Mon, 25 Aug 2014 15:31:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bs8Nf/SrNS4B6fmzMcZG6xCdCuI=; b=bl3ziw
	UBE6xUNViIRFh92HPKk3Ct8pSQHOHBnZ/WULlML9OUaESa9NhysTgDWMpzGris2X
	MPVrpq4jAjqtGfO5ZTsJNJzh6G711ihXlRCPAA9QEFnW+Fo2E23TjOX6GsaLPxE6
	GxMHaxmrmOrZ9YhlyyBi37K4OVpMrGD2PDNW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FOdNP8wtd6s6hTPtrTC1Kpu6Cg2s/rlI
	VXNH0FhU7yfkF8SMvXwJEymKDSF082ZPCF6vf4AaoADh30Ot30bVpRU9SJPrhKdd
	BE9RFhXfxS9OngECVnhTUI6DokmkX2kwMIpdq/X1vdOQI0iOA68nZ5uGDiIqA2vY
	AArJuYiCXD4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B589F33307;
	Mon, 25 Aug 2014 15:31:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 70D96332CD;
	Mon, 25 Aug 2014 15:30:53 -0400 (EDT)
In-Reply-To: <20140822043303.GB18192@peff.net> (Jeff King's message of "Fri,
	22 Aug 2014 00:33:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 540834B0-2C8E-11E4-9EC5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255855>

Jeff King <peff@peff.net> writes:

> Since we do not use the value $(LIB_H) unless either
> COMPUTE_HEADER_DEPENDENCIES is turned on or the user is
> building "po/git.pot" (where it comes in via $(LOCALIZED_C),
> make is smart enough to not even run this "find" in most
> cases. However, we do need to stop using the "immediate"
> variable assignment ":=" for $(LOCALIZED_C). That's OK,
> because it was not otherwise useful here.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I cannot see any reason for the ":=", but maybe I am missing something.

If the right-hand-side were something like $(shell find ...) that
was heavy-weight then it might have made sense, but I do not think
it is that.  It has stayed to be := ever since it was introduced by
cd5513a7 (i18n: Makefile: "pot" target to extract messages marked
for translation, 2011-02-22).

And now you use LIB_H only once ;-).

Also interestingly, I notice that it is very clear that it is not
"LIB_H" but "ANY_H" ;-)

>
>  Makefile | 140 ++++-----------------------------------------------------------
>  1 file changed, 8 insertions(+), 132 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index cf0ccdf..f2b85c9 100644
> --- a/Makefile
> +++ b/Makefile
> ...
> @@ -2128,9 +2004,9 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
>  XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
>  	--keyword=gettextln --keyword=eval_gettextln
>  XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
> -LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
> -LOCALIZED_SH := $(SCRIPT_SH)
> -LOCALIZED_PERL := $(SCRIPT_PERL)
> +LOCALIZED_C = $(C_OBJ:o=c) $(GENERATED_H)
> +LOCALIZED_SH = $(SCRIPT_SH)
> +LOCALIZED_PERL = $(SCRIPT_PERL)
>  
>  ifdef XGETTEXT_INCLUDE_TESTS
>  LOCALIZED_C += t/t0200/test.c
