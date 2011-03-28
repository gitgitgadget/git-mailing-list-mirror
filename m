From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] squash! tests: fix overeager scrubbing of environment
 variables
Date: Mon, 28 Mar 2011 09:58:03 -0400
Message-ID: <20110328135803.GA14763@sigill.intra.peff.net>
References: <4D8FAAAC.3050905@web.de>
 <20110327213756.GD25927@elie>
 <20110327221753.GB27445@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 15:58:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4CxU-0003cu-Tc
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 15:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470Ab1C1N6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 09:58:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44705
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372Ab1C1N6H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 09:58:07 -0400
Received: (qmail 10014 invoked by uid 107); 28 Mar 2011 13:58:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Mar 2011 09:58:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2011 09:58:03 -0400
Content-Disposition: inline
In-Reply-To: <20110327221753.GB27445@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170127>

On Sun, Mar 27, 2011 at 05:17:53PM -0500, Jonathan Nieder wrote:

> How about something like this on top?  Would it still be safe on
> platforms with ancient perl?
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  t/test-lib.sh |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 4a8c443..d28e647 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -46,7 +46,15 @@ unset VISUAL
>  unset EMAIL
>  unset $(perl -e '
>  	my @env = keys %ENV;
> -	my @vars = grep(/^GIT_/ && !/^GIT_(TRACE|DEBUG|USE_LOOKUP|SKIP_TESTS|TEST|PROVE_OPTS)/, @env);
> +	my @vars = grep(/^GIT_/ && !m{^GIT_(
> +			TRACE |
> +			DEBUG |
> +			USE_LOOKUP |
> +			TEST |
> +			.*_TEST |
> +			PROVE |
> +			VALGRIND
> +		)}x, @env);

I think that should be fine. The most exotic thing you use is /x. I
don't know when it was introduced, but perl5004delta refers to it as
something that was already around before then.

I think it might be a little more readable to get rid of the "|" on each
line like this:

    my $ok = join("|", qw(
      TRACE
      DEBUG
      USE_LOOKUP
      TEST
      .*_TEST
      PROVE
      VALGRIND
    ));
    my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o) @env;

which is a little simpler syntax, and makes patches nicer (you don't
have to add a trailing "|" on the line before). But that is a minor nit.

-Peff
