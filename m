From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] sha1_name: don't trigger detailed diagnosis for file arguments
Date: Mon, 18 Jun 2012 19:42:02 +0200
Message-ID: <vpqpq8wpled.fsf@bauges.imag.fr>
References: <vpq395tvlc0.fsf@bauges.imag.fr>
	<1339958341-22186-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vehpc4jpw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 19:42:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgfy7-0005j6-6p
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 19:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659Ab2FRRmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 13:42:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37712 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab2FRRmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 13:42:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5IHfmeW028350
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 18 Jun 2012 19:41:48 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sgfxj-0003PC-6q; Mon, 18 Jun 2012 19:42:03 +0200
In-Reply-To: <7vehpc4jpw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 18 Jun 2012 10:23:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 18 Jun 2012 19:41:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5IHfmeW028350
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340646110.84875@DE8qOnC9BHAX4Y0wJ87kDg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200149>

Junio C Hamano <gitster@pobox.com> writes:

> I am not so sure about that.  The "only-to-die" caller is not even
> expecting that the call to this codepath would successfully return.
>
> Or at least, it shouldn't.
>
> So it might not be a bad idea to actually catch this as a
> programming error and do
>
> 	if (only_to_die) {
>         	if (!ret)
>                 	die("BUG");
> 		diagnose_invalid_sha1_path(...);
> 	}

I disagree.

The only-to-die caller can expect that get_sha1_with_context_1 never
returns when called with only-to-die, but it's a stronger assumption to
expect that this particular place will trigger the failure.

In this case, the assumption is correct because there's a "return ret;"
a bit later in the code, but I don't think we should have to look at
this to check the correctness of the code (for example, if something
like "if (ret) try_some_fallback_method();" is later added before
"return ret;", then the assumption would become false).

My version reads as

  try something;
  if (it failed && I'm only here to report an error)
          report_error();

which I find easier to understand.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
