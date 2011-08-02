From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Tue, 2 Aug 2011 08:24:02 +0200
Message-ID: <201108020824.03046.chriscool@tuxfamily.org>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com> <1312222025-28453-18-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 08:25:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo8Px-00026b-LV
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 08:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034Ab1HBGYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 02:24:13 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47577 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab1HBGYM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 02:24:12 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 95A5DA623C;
	Tue,  2 Aug 2011 08:24:04 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1312222025-28453-18-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178443>

On Monday 01 August 2011 20:07:04 Ramkumar Ramachandra wrote:
> +static void verify_opt_mutually_compatible(const char *me, ...)
> +{
> +	const char *opt1, *opt2;
> +	va_list ap;
> +	int set;
> +
> +	va_start(ap, me);
> +	while ((opt1 = va_arg(ap, const char *))) {
> +		set = va_arg(ap, int);
> +		if (set)
> +			break;
> +	}
> +	if (!opt1)
> +		goto ok;
> +	while ((opt2 = va_arg(ap, const char *))) {
> +		set = va_arg(ap, int);
> +		if (set) {
> +			va_end(ap);
> +			die(_("%s: %s cannot be used with %s"),
> +				me, opt1, opt2);
> +		}
> +	}
> +ok:
> +	va_end(ap);
> +}

I'd suggest something like this:

static void verify_opt_mutually_compatible(const char *me, ...)
{
	const char *opt1, *opt2;
	va_list ap;

	va_start(ap, me);
	while ((opt1 = va_arg(ap, const char *))) {
		int set = va_arg(ap, int);
		if (set)
			break;
	}
	if (opt1) {
		while ((opt2 = va_arg(ap, const char *))) {
			int set = va_arg(ap, int);
			if (set)
				break;
		}
	}
	va_end(ap);

	if (opt1 && opt2)
		die(_("%s: %s cannot be used with %s"), me, opt1, opt2);
}

Thanks,
Christian.
