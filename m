From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v4 07/10] send-email: reduce dependancies impact on
 parse_address_line
Date: Thu, 18 Jun 2015 23:29:13 +0200 (CEST)
Message-ID: <114284546.628903.1434662953414.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <2114933489.627454.1434658853079.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 18 23:27:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5hLg-0006yJ-Hm
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 23:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbbFRV1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 17:27:45 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:44081 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645AbbFRV1o (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2015 17:27:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 9F3D03740;
	Thu, 18 Jun 2015 23:27:41 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WL2rqtXEg5DC; Thu, 18 Jun 2015 23:27:41 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 81EB4373F;
	Thu, 18 Jun 2015 23:27:41 +0200 (CEST)
In-Reply-To: <vpqvbelylfk.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: reduce dependancies impact on parse_address_line
Thread-Index: DTqF3tjVQS9Gv8qvdL7Vh0MDxUomnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272080>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Cool. Then almost all the work is done to get an automated test. Next
> step would be to add the tests itself in the code. I would do that by
> adding a hidden --selfcheck option to git send-email that would compare
> Mail::Address->parse($string); and split_addrs($string); for all your
> testcases, and die if they do not match. Then calling it from the
> testsuite would be trivial.

Ok, are there such "--selfcheck" options elsewhere? If I understand it
right, you want to put the tests inside the git-send-email script. I
don't feel really good about that but I guess it's hard to test it
otherwise...  Also what will we do with the failing tests?  Just
discard them?  I think there's two sort of failing test:

 - When output provided by parse_address_ without Mail::Address
   is better or has no impact at all on the code. Such as:

    Input: "Doe, Ja"ne <jdoe@example.com>
    Split: "Doe, Ja ne" <jdoe@example.com>
    M::A : "Doe, Ja" ne <jdoe@example.com>

   This output is done on purpose. If it was the same output with
   Mail::Address, we could have avoided commit 8/9 of this serie btw.

   I think we should also test these cases.

 - When we don't really care about the output, because the user entry
   is wrong, and we just expect the script to be aborted somehow... We
   don't need to test that.

We could also add an option to specify whether we want to use
Mail::Address or not and do the tests in t9001* (but this would
take much more time).

> I can do that on top of your series if you don't have time.

Time will become a problem soon, but I think I can handle it unless
you really want to do it !
