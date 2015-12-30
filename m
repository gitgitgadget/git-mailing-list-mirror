From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] avoid shifting signed integers 31 bits
Date: Tue, 29 Dec 2015 16:09:21 -0800
Message-ID: <xmqq4mf0g5la.fsf@gitster.mtv.corp.google.com>
References: <20151229063449.GA28755@sigill.intra.peff.net>
	<20151229063545.GA30340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 01:09:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE4KW-0008S5-NX
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 01:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbbL3AJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 19:09:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753493AbbL3AJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 19:09:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8BFBE387A1;
	Tue, 29 Dec 2015 19:09:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rP3oKbzbE98JOwn5Bcuf4Hepun4=; b=k0LT5h
	pS8AY6GuOHqKIYkpxT2tKwJMxIH8DI6/NsltVbxQPLw2ci/9Rgpg1jPsSlkvJ547
	tIs315aVcMc3Xw00whFx4OKPPUchxnSmQQZG0gunk4EJwDB0aqlMKScfqGzRdf38
	n5a7jOHOFceHFtnJOPZsh50CPxwe7LrRFP6Jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eCHvpz+Z8ila+M7G+DiYKOVLJcCMkmsz
	0tzwmFK9HeHHx9MY1+JoO4kH6dvoeABzge0M+zeSxa/YFQwvOxumV4eRCq4/m141
	CIJBheIbPseBvAzWqcEi+gQBZ1D18yHuyhY9Uf/pr3xEhuJb/mT3HWU7pzzqrPFp
	a0HbfvXLns0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83173387A0;
	Tue, 29 Dec 2015 19:09:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 028E33879E;
	Tue, 29 Dec 2015 19:09:22 -0500 (EST)
In-Reply-To: <20151229063545.GA30340@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Dec 2015 01:35:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9486930A-AE89-11E5-8550-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283161>

Jeff King <peff@peff.net> writes:

> diff --git a/diff.h b/diff.h
> index f7208ad..893f446 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -91,7 +91,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
>  #define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
>  #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
>  #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
> -#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1 << 31)
> +#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1U << 31)
>  
>  #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
>  #define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)

Thanks.

Seeing (1 << 30) and (1U <<31) together made me feel that we are way
_too_ explicit being careful about 32-bit archs (iow, it would be
more consistent to turn all of these "1 <<" into "1U <<"), but at
the same time, (1 << 30) won't be broken unless we are on 31-bit
arch in the sense that if we are on 30-bit or smaller arch the
expression is already broken with or without "U", and if we are on
32-bit or more, then with or without "U" we are OK---which made me
feel somewhat funny.

In any case, these two are good changes.  Thanks.
