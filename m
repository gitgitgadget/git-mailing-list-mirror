From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Tue, 28 Jul 2015 10:50:41 +0200
Message-ID: <vpq7fpk1x9a.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 10:51:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK0bE-0007KY-Hh
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 10:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550AbbG1Iu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 04:50:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54707 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752996AbbG1Iux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 04:50:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6S8oe2o006400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 10:50:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6S8ofas026823;
	Tue, 28 Jul 2015 10:50:41 +0200
In-Reply-To: <1438066594-5620-4-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 28 Jul 2015 12:26:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 28 Jul 2015 10:50:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6S8oe2o006400
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438678241.68253@AsxmIHV6VCgHslxjaE5COw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274760>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -149,4 +149,25 @@ test_expect_success 'check `colornext` format option' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'check `ifexists` format option' '
> +	cat >expect <<-\EOF &&
> +	[foo1.10]
> +	[foo1.3]
> +	[foo1.6]
> +	EOF
> +	git for-each-ref --format="%(ifexists:[%s])%(refname:short)" | grep "foo" >actual &&
> +	test_cmp expect actual
> +'

You're testing only the positive case of ifexists, right? You need a
test for the negative case (i.e. the attribute does not exist) too.
Ideally, check that the ifexist actually applies to the right attribute,
like

--format '%(ifexist:<%s>)%(attribute1) %(ifexist:[%s])%(attribute2)'

and manage to get an output like

<foo>
 [bar]
<foobar> [barfoo]

> +cat >expect <<EOF &&
> +[$(get_color green)foo1.10$(get_color reset)]||foo1.10
> +[$(get_color green)foo1.3$(get_color reset)]||foo1.3
> +[$(get_color green)foo1.6$(get_color reset)]||foo1.6
> +EOF
> +
> +test_expect_success 'check `ifexists` with `colornext` format option' '
> +	git for-each-ref --format="%(ifexists:[%s])%(colornext:green)%(refname:short)||%(refname:short)" | grep "foo" >actual &&
> +	test_cmp expect actual
> +'

You have a double || that is not useful. Not really harmful either, but
it may distract the reader. You may want to s/||/|/.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
