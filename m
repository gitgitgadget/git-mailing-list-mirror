From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v4 07/10] send-email: reduce dependancies impact on parse_address_line
Date: Fri, 19 Jun 2015 09:16:45 +0200
Message-ID: <vpqpp4sw4ki.fsf@anie.imag.fr>
References: <2114933489.627454.1434658853079.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<114284546.628903.1434662953414.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 19 09:17:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5qXp-0004yM-12
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 09:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbbFSHQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 03:16:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53059 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbbFSHQv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 03:16:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5J7GidV021322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Jun 2015 09:16:44 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5J7Gj14016151;
	Fri, 19 Jun 2015 09:16:45 +0200
In-Reply-To: <114284546.628903.1434662953414.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Thu, 18 Jun 2015 23:29:13 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 19 Jun 2015 09:16:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5J7GidV021322
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435303006.32058@gPoUN4WdtqcQXwQvTa05JA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272105>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Cool. Then almost all the work is done to get an automated test. Next
>> step would be to add the tests itself in the code. I would do that by
>> adding a hidden --selfcheck option to git send-email that would compare
>> Mail::Address->parse($string); and split_addrs($string); for all your
>> testcases, and die if they do not match. Then calling it from the
>> testsuite would be trivial.
>
> Ok, are there such "--selfcheck" options elsewhere?

Not as far as I know.

> If I understand it right, you want to put the tests inside the
> git-send-email script. I don't feel really good about that but I guess
> it's hard to test it otherwise...

Hmm, actually there is, I didn't look at the right places yesterday.
git-send-email.perl already does 'use Git;', and there's already a set
of unit-tests for Git.pm: t9700-perl-git.sh, which calls perl
"$TEST_DIRECTORY"/t9700/test.pl.

So, you can just add your code as a function in Git.pm and unit-tests in
t/t9700/test.pl.

> Also what will we do with the failing tests? Just discard them? I
> think there's two sort of failing test:
>
>  - When output provided by parse_address_ without Mail::Address
>    is better or has no impact at all on the code. Such as:

I'm not sure we can be "better" as long as we do use Mail::Address when
available. Any difference is potentially harmfull for the user because
it means that Git will have different behavior on different machines.

Perhaps this is an argument to use your version unconditionally and drop
Mail::Address actually.

But you can still test that with

  is(parse_address_(...), "Doe, Jane", "<description>");

(possibly not calling Mail::Address)

http://search.cpan.org/~exodist/Test-Simple-1.001014/lib/Test/More.pm

The cases where Mail::Address and your version give the same result can
be tested with a foreach loop calling

  is(parse_address_(...), Mail::Address(...), ...);

>  - When we don't really care about the output, because the user entry
>    is wrong, and we just expect the script to be aborted somehow... We
>    don't need to test that.

... but if you already have the tests, you can keep them as known
failure.

See the "TODO: BLOCK" section of the doc of Test::More.

>> I can do that on top of your series if you don't have time.
>
> Time will become a problem soon, but I think I can handle it unless
> you really want to do it !

If you have time, just do it.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
