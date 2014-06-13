From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 4/6] t7510: exit for loop with test result
Date: Fri, 13 Jun 2014 07:46:15 -0400
Message-ID: <20140613114615.GE14066@sigill.intra.peff.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
 <99893263f1819646a3a324b2fff0bcd0d56f3818.1402655839.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 13:46:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvPw5-0002jO-HX
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 13:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbaFMLqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 07:46:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:43410 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751256AbaFMLqR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 07:46:17 -0400
Received: (qmail 23258 invoked by uid 102); 13 Jun 2014 11:46:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 06:46:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 07:46:15 -0400
Content-Disposition: inline
In-Reply-To: <99893263f1819646a3a324b2fff0bcd0d56f3818.1402655839.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251550>

On Fri, Jun 13, 2014 at 12:42:46PM +0200, Michael J Gruber wrote:

> When t7510 was introduced, the author made sure that a for loop in
> a subshell would return with the appropriate error code.
> 
> Make sure this is true also the for the first line in each loop, which
> was missed.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  t/t7510-signed-commit.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 5ddac1a..a5ba48e 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -49,7 +49,7 @@ test_expect_success GPG 'show signatures' '
>  	(
>  		for commit in initial second merge fourth-signed fifth-signed sixth-signed master
>  		do
> -			git show --pretty=short --show-signature $commit >actual &&
> +			git show --pretty=short --show-signature $commit >actual || exit 1
>  			grep "Good signature from" actual || exit 1

Hrm. The original is:

  X &&
  Y || exit 1

Won't that still exit (i.e., it is already correct)? Doing:

  for X in true false; do
    for Y in true false; do
      ($X && $Y || exit 1)
      echo "$X/$Y: $?"
    done
  done

yields:

  true/true: 0
  true/false: 1
  false/true: 1
  false/false: 1

(and should still short-circuit Y, because we go from left-to-right).

I do not mind changing it to keep the style of each line consistent,
though. I would have written it as a series of "&&"-chains, with a
single exit at the end, but I think that is just a matter of preference.

-Peff
