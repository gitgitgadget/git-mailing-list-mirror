From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 15:51:16 +0200
Message-ID: <vpqhagnwraj.fsf@anie.imag.fr>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 15:53:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur7Cf-0003hY-Fo
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 15:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275Ab3FXNxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 09:53:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50650 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250Ab3FXNxD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 09:53:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5ODpEff031709
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Jun 2013 15:51:14 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ur7Aq-0004bG-A2; Mon, 24 Jun 2013 15:51:16 +0200
In-Reply-To: <1372077912-18625-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 24 Jun 2013 18:15:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 24 Jun 2013 15:51:15 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228812>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Contrary to its description, the output of
>
>   $ git status --porcelain
>
> now depends on the configuration variables status.short and
> status.branch.

Ouch, indeed :-(.

> The correct solution is therefore to skip the config parser completely
> when --porcelain is given.  Unfortunately, to determine that --porcelain
> is given, we have to run the command-line option parser.  Running the
> command-line option parser before the config parser is undesirable, as
> configuration variables would override options on the command-line.  As
> a fair compromise, check that argv[1] is equal to the string
> "--porcelain" and skip the config parser in this case.

I really don't like this. If we go for a solution looking explicitely at
argv[], we should at least iterate over it (also not satisfactory
because --porcelain could be the argument of another switch).

I think it's possible to have an actually robust solution, either

* running the CLI parser after, if --porcelain is given, reset the
  effect of the variables. Not very clean because we'd have to reset all
  the variables to their default, and there is a risk of forgetting one.

* Or, running the CLI parser before, but with different variables to
  specify what the command-line says and what will actually be done,
  with something like

  actual_short = 0;
  switch (command_line_short) {
  case yes:
          actual_short = 1;
          break;
  case no:
          actual_short = 0;
          break;
  case unset: /* nothing */
  }
  switch (config_short) {
  // same
  }

> ---
>  builtin/commit.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

No time to contribute one now myself, but this would really deserve a
test.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
