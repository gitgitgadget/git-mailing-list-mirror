From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 02 Sep 2015 10:41:30 +0200
Message-ID: <vpq613tusat.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 10:41:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX3c5-0004ZF-Ap
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 10:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbbIBIlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 04:41:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42928 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbbIBIlg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 04:41:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t828fTtN018280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 2 Sep 2015 10:41:29 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t828fUuI020860;
	Wed, 2 Sep 2015 10:41:30 +0200
In-Reply-To: <1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 1 Sep 2015 23:56:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Sep 2015 10:41:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t828fTtN018280
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441788091.42866@Pjo6Rx23nSh5B3pI9CsHMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277082>

Karthik Nayak <karthik.188@gmail.com> writes:

> +test_expect_success 'alignment with format quote' '
> +	cat >expect <<-EOF &&
> +	refname is ${sq}           ${sq}\\${sq}${sq}master${sq}\\${sq}${sq}           ${sq}|
> +	refname is ${sq}            ${sq}\\${sq}${sq}side${sq}\\${sq}${sq}            ${sq}|
> +	refname is ${sq}          ${sq}\\${sq}${sq}odd/spot${sq}\\${sq}${sq}          ${sq}|
> +	refname is ${sq}         ${sq}\\${sq}${sq}double-tag${sq}\\${sq}${sq}         ${sq}|
> +	refname is ${sq}            ${sq}\\${sq}${sq}four${sq}\\${sq}${sq}            ${sq}|
> +	refname is ${sq}            ${sq}\\${sq}${sq}one${sq}\\${sq}${sq}             ${sq}|
> +	refname is ${sq}         ${sq}\\${sq}${sq}signed-tag${sq}\\${sq}${sq}         ${sq}|
> +	refname is ${sq}           ${sq}\\${sq}${sq}three${sq}\\${sq}${sq}            ${sq}|
> +	refname is ${sq}            ${sq}\\${sq}${sq}two${sq}\\${sq}${sq}             ${sq}|
> +	EOF
> +	git for-each-ref --shell --format="refname is %(align:30,middle)${sq}%(refname:short)${sq}%(end)|" >actual &&
> +	test_cmp expect actual
> +'

Someone (Eric IIRC) suggested using double-quotes around the last
argument of test_expect_success. Even though I'm the one who suggested
this ${sq}, I have to agree with this suggestion. The result looks like

test_expect_success 'alignment with quote' "
	cat >expect <<-\EOF &&
	refname is '               '\\'''master'\\''
	...
"

Because you used "" at the toplevel, ' is not a special character
anymore. You do have to be careful with \\ though, but adding before EOF
as I did should do the trick. Untested.

You don't have test for nested alignment with quotes. I think it
deserves to be tested, if only to cast in stone that the current
behavior is your intention.

Perhaps just adding --shell to the test below would be OK to avoid the
proliferation of tests :

> +test_expect_success 'nested alignment' '
> +	cat >expect <<-\EOF &&
> +	|         master               |
> +	|           side               |
> +	|       odd/spot               |
> +	|     double-tag               |
> +	|           four               |
> +	|            one               |
> +	|     signed-tag               |
> +	|          three               |
> +	|            two               |
> +	EOF
> +	git for-each-ref --format="|%(align:30,left)%(align:15,right)%(refname:short)%(end)%(end)|" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
