From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] strtoul_ui: actually report error in case of negative input
Date: Mon, 14 Sep 2015 08:30:54 +0200
Message-ID: <vpqr3m1seap.fsf@anie.imag.fr>
References: <1442181636-27821-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 08:31:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbNIO-0004KR-Ks
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 08:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbbINGbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 02:31:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50913 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbbINGbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 02:31:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8E6UrLG008007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 14 Sep 2015 08:30:54 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8E6UsAQ013707;
	Mon, 14 Sep 2015 08:30:54 +0200
In-Reply-To: <1442181636-27821-1-git-send-email-max@max630.net> (Max
	Kirillov's message of "Mon, 14 Sep 2015 01:00:36 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 14 Sep 2015 08:30:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8E6UrLG008007
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442817059.18898@OepLEFx/5GpkDaMLMTZXdQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277809>

Max Kirillov <max@max630.net> writes:

> If s == "-1" and CPU is i386, then none of the checks is triggered, including
> the last "(unsigned int) ul != ul", because ul == 2**32 - 1, which fits into
> "unsigned int".

Thanks for noticing and reporting.

> Fix it by changing the last check to trigger earlier, as soon as it
> becomes bigger than INT_MAX.

What if the value is actually greater than INT_MAX? The function is
returning an unsigned long (64 bits on 64bits architectures), and your
version is restricting it to integers smaller than 2^31, right?

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -815,7 +815,7 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>  
>  	errno = 0;
>  	ul = strtoul(s, &p, base);
> -	if (errno || *p || p == s || (unsigned int) ul != ul)
> +	if (errno || *p || p == s || ul > (unsigned long) INT_MAX)

I think you at least want to use LONG_MAX and drop the cast here
(untested, and beware of my advices when given before coffee).
That would restrict to values smaller than 2^63, and I guess no one is
interested in the interval ]2^63, 2^64].

The other option would be to look for a leading '-' before calling
strtoul.

(Actually, this makes me wonder why strtoul happily returns a big
positive when fed with the string "-1", but we can't change it)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
