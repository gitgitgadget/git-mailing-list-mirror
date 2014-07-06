From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 2/2] test-config: Add tests for the config_set API
Date: Sun, 06 Jul 2014 20:33:27 +0200
Message-ID: <vpqzjgm49s8.fsf@anie.imag.fr>
References: <1404631162-18556-1-git-send-email-tanayabh@gmail.com>
	<1404631162-18556-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 20:33:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3rFu-0002Xf-U8
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 20:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaGFSdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 14:33:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42571 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906AbaGFSdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 14:33:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s66IXPMQ019899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Jul 2014 20:33:25 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s66IXRt1020515;
	Sun, 6 Jul 2014 20:33:27 +0200
In-Reply-To: <1404631162-18556-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Sun, 6 Jul 2014 00:19:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 06 Jul 2014 20:33:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s66IXPMQ019899
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405276409.29374@l6IOFo2KYT+EUILz8HbzHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252941>

Tanay Abhra <tanayabh@gmail.com> writes:

> +test_expect_success 'get value for a simple key' '
> +	echo "very blue" >expect &&
> +	test-config get_value core.penguin >actual &&
> +	test_cmp expect actual
> +'

All these tests would greatly benefit from a helper like

test_expect_config () {
	echo "1" >expect &&
	test-config get_value "$2" >actual &&
	test_cmp expect actual
}

Then, all the 3-liners below would become 1-liners.

Should not block inclusion, but may be worth considering.

> +test_expect_success 'get value for a key with value as an empty string' '
> +	echo "" >expect &&
> +	test-config get_value core.my >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'get value for a key with value as NULL' '
> +	echo "(NULL)" >expect &&
> +	test-config get_value core.foo >actual &&
> +	test_cmp expect actual
> +'
[...]

> +test_expect_success 'key with case sensitive subsection' '
> +	echo "mixed-case" >expect &&
> +	echo "upper-case" >>expect &&
> +	echo "lower-case" >>expect &&
> +	test-config get_value "my.Foo bAr.hi" >actual &&
> +	test-config get_value "my.FOO BAR.hi" >>actual &&
> +	test-config get_value "my.foo bar.hi" >>actual &&
> +	test_cmp expect actual
> +'

This would become a 3-liner with my helper.

> +test_expect_success 'key with case insensitive section header' '
> +	echo "ball" >expect &&
> +	echo "ball" >>expect &&
> +	echo "ball" >>expect &&
> +	test-config get_value cores.baz >actual &&
> +	test-config get_value Cores.baz >>actual &&
> +	test-config get_value CORES.baz >>actual &&
> +	test_cmp expect actual
> +'

I think you miss a simple case: get_value with a case that doesn't exist
in the config file, like "get_value coreS.baz".

> +test_expect_success 'find value with the highest priority' '
> +	echo hask >expect &&
> +	test-config get_value "core.baz">actual &&

Space before >.

> diff --git a/test-config.c b/test-config.c

No time for a real review of this file, but from a quick look, it seems
OK.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
