From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/16] add NO_EXTERNAL_GREP build option
Date: Wed, 12 Mar 2008 15:30:05 -0700
Message-ID: <7viqzr4lua.fsf@gitster.siamese.dyndns.org>
References: <cover.1205356737.git.peff@peff.net>
 <20080312213916.GK26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZZTV-0004b9-0E
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 23:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbYCLWaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 18:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbYCLWaT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 18:30:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbYCLWaS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 18:30:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B9F8C160C;
	Wed, 12 Mar 2008 18:30:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E797A160B; Wed, 12 Mar 2008 18:30:12 -0400 (EDT)
In-Reply-To: <20080312213916.GK26286@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 12 Mar 2008 17:39:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77013>

Jeff King <peff@peff.net> writes:

> Previously, we just chose whether to allow external grep
> based on the __unix__ define. However, there are systems
> which define this macro but which have an inferior group
> (e.g., one that does not support all options used by t7002).
> This allows users to accept the potential speed penalty to
> get a more consistent grep experience (and to pass the
> testsuite).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This might have fallouts for msysgit (i.e., they need to define
> NO_EXTERNAL_GREP instead of relying on __unix__ not being defined).
> ...
> diff --git a/builtin-grep.c b/builtin-grep.c
> index f4f4ecb..f215b28 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -153,7 +153,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
>  	return i;
>  }
>  
> -#ifdef __unix__
> +#ifndef NO_EXTERNAL_GREP

Perhaps place

    #ifndef NO_EXTERNAL_GREP
    #ifndef __unix__
    #define NO_EXTERNAL_GREP 1
    #else
    #define NO_EXTERNAL_GREP 0
    #endif
    #endif

in git-compat-util.h, and make the in-code reference to

    #if NO_EXTERNAL_GREP
            ... optimization using external grep ...
    #endif
