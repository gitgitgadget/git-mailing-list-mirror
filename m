From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/2] checkout: proper error message on 'git checkout foo bar --'
Date: Thu, 26 Sep 2013 10:59:10 +0200
Message-ID: <vpqk3i4klgh.fsf@anie.imag.fr>
References: <1380137471-26972-1-git-send-email-Matthieu.Moy@imag.fr>
	<1380137471-26972-2-git-send-email-Matthieu.Moy@imag.fr>
	<20130925224306.GC9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	jc@sahnwaldt.de
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 10:59:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP7Q6-0005CZ-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 10:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab3IZI73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 04:59:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50471 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505Ab3IZI70 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 04:59:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8Q8x9tI029790
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Sep 2013 10:59:09 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VP7Pi-0001oa-KK; Thu, 26 Sep 2013 10:59:10 +0200
In-Reply-To: <20130925224306.GC9464@google.com> (Jonathan Nieder's message of
	"Wed, 25 Sep 2013 15:43:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 26 Sep 2013 10:59:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8Q8x9tI029790
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380790754.37929@rFgtE8C63uAxIciXwI0bhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235405>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  (a) rename has_dash_dash here to dash_dash_pos, or
>  (b) put the check in the loop, like so:

I agree with (a), but not with (b). I think separating the computation
of the position and the diagnosis makes it clearer.

I reworked the code a bit, the diagnosis part now looks like

	if (dash_dash_pos == 0)
		return 1; /* case (2) */
	else if (dash_dash_pos == 1)
		has_dash_dash = 1; /* case (3) or (1) */
	else if (dash_dash_pos >= 2)
		die(_("only one reference expected, %d given."), dash_dash_pos);

>> +test_expect_success C_LOCALE_OUTPUT 'accurate error message with more than one ref' '
>> +	test_must_fail git checkout HEAD master -- 2>actual &&
>> +	echo "fatal: only one reference expected, 2 given." >expect &&
>> +	test_cmp expect actual
>
> Nits:
>
>  - if we change this from 'fatal' to 'error' or reword the message as
>    part of a libification some day, it would be a nuisance to have to
>    update this test.  Maybe a 'grep' could make it more flexible.
>
>  - most of the test (though not the interesting part) can run in the
>    !C_LOCALE_OUTPUT case if you use test_i18ncmp or test_i18ngrep
>
>  - even the check for "2" can run in the !C_LOCALE_OUTPUT case. :)
>    e.g. something like
>
> 	test_must_fail ... 2>actual &&
> 	grep 2 actual &&
> 	test_i18ngrep "one reference expected, 2 given" actual

OK, I buy your version. Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
