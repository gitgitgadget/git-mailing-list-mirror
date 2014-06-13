From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 4/6] t7510: exit for loop with test result
Date: Fri, 13 Jun 2014 14:54:55 +0200
Message-ID: <539AF49F.3010309@viscovery.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net> <99893263f1819646a3a324b2fff0bcd0d56f3818.1402655839.git.git@drmicha.warpmail.net> <20140613114615.GE14066@sigill.intra.peff.net> <539AE8CA.50009@drmicha.warpmail.net> <539AED0C.8050107@drmicha.warpmail.net> <539AEF7E.1050402@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 14:55:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvR0h-0002LU-G3
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbaFMMzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 08:55:05 -0400
Received: from so.liwest.at ([212.33.55.14]:56200 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbaFMMzE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:55:04 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WvR0R-00027I-Tu; Fri, 13 Jun 2014 14:54:56 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8131A16613;
	Fri, 13 Jun 2014 14:54:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <539AEF7E.1050402@drmicha.warpmail.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251592>

Am 6/13/2014 14:33, schrieb Michael J Gruber:
> .... with this loop, sorry:
> 
> for X in true false; do
>      for Y in false true; do
>        ($X && $Y || exit 1)
>      done
>      echo "$X/last inner $Y: $?"
> done
> 
> gives
> 
> true/last inner true: 0
> false/last inner true: 1
> 
> even though on both cases we have at least one failure of Y. (failure of
> one subtest = failure of the test)

Place the loop(s) inside the subshell, and you observe termination on the
first failure, and a failure exit code of the subshell.

The change proposed in this patch should not be necessary. Something else
must be wrong with your tests.

Ah, here it is:

@@ -58,7 +58,7 @@ test_expect_success GPG 'show signatures' '
 	(
 		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
 		do
-			git show --pretty=short --show-signature $commit >actual &&
+			git show --pretty=short --show-signature $commit >actual || exit 1
 			grep "Good signature from" actual && exit 1
 			! grep "BAD signature from" actual || exit 1
 			echo $commit OK

Notice the '&& exit 1'! It should be '|| exit 1', right?

-- Hannes
