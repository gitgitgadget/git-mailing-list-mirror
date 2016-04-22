From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [git-multimail] smtplib, check certificate
Date: Fri, 22 Apr 2016 08:05:11 +0200
Message-ID: <vpqoa92rxew.fsf@anie.imag.fr>
References: <571949D2.10507@le-huit.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Simon P <simon.git@le-huit.fr>
X-From: git-owner@vger.kernel.org Fri Apr 22 08:05:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atUDT-0000SB-94
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 08:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbcDVGFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 02:05:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36121 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbcDVGFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 02:05:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3M65BZq023240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 22 Apr 2016 08:05:11 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3M65BRD021615;
	Fri, 22 Apr 2016 08:05:11 +0200
In-Reply-To: <571949D2.10507@le-huit.fr> (Simon P.'s message of "Thu, 21 Apr
	2016 23:44:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 22 Apr 2016 08:05:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3M65BZq023240
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461909911.94502@xwZfphUqtNWrcddkEciV4Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292173>

Simon P <simon.git@le-huit.fr> writes:

> Hi,

Hi, and thanks for the patch.

Please, add your sign-off and a proper commit message to your patch,
see:

https://github.com/git-multimail/git-multimail/blob/master/CONTRIBUTING.rst

I'm OK with patches by email, but you may prefer using a pull-request
(among other things, creating a pull-request triggers a Travis-CI build
and would have noticed the absence of sign-off and a minor PEP8 issue in
your code.

The patch obviously lacks documentation, and some way to test it.
Actually, the testsuite will fail if you document the configuration
variable and they don't appear somewhere in the testsuite. A fully
automatic test would be hard to write, but I have a semi-automated
testsuite for smtp: some configurations in t/*.config.in, and a script
test-email-config to run a test with each of the configurations (then I
check my mailbox). There should be one configuration with a valid
certificate and another with a buggy one so that we can check that the
certificate is actually checked.

> @@ -1945,6 +1946,7 @@ class SMTPMailer(Mailer):
>                   smtpservertimeout=10.0, smtpserverdebuglevel=0,
>                   smtpencryption='none',
>                   smtpuser='', smtppass='',
> +                 smtpcacerts='/etc/ssl/certs/ca-certificates.crt',smtpcheckcert=False

Do you need a default for smtpcheckcert if you already have one in
config.get(smtpcheckcert)? In any case, I'd rather avoid having two
hardcoded path in the code. If you need
'/etc/ssl/certs/ca-certificates.crt' in two places, please define a
constant elsewhere in the code and use it here.

Missing space after ,.

> +                if smtpcheckcert:
> +                    # inspired form:
> +                    #   https://github.com/graingert/secure-smtplib/blob/master/src/secure_smtplib/__init__.py
> +                    # but add the path to trusted ca, and force ceritficate verification.
> +                    self.smtp.ehlo_or_helo_if_needed()
> +                    if not self.smtp.has_extn("starttls"):
> +                        msg = "STARTTLS extension not supported by server"
> +                        raise smtplib.SMTPException(msg)
> +                    (resp, reply) = self.smtp.docmd("STARTTLS")

Parenthesis around (resp, reply) are not needed, I prefer to omit them.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
