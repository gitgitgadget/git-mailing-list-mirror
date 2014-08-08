From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2 20/23] rebase -i: parse to-do list command line options
Date: Fri, 08 Aug 2014 21:10:11 +0200
Message-ID: <87vbq2ajcc.fsf@thomasrast.ch>
References: <53A258D2.7080806@gmail.com>
	<cover.1407368621.git.bafain@gmail.com>
	<8d01ff53a49647906c9008620435a62f08a1f76f.1407368621.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 21:10:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFpYa-0003R9-Te
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 21:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbaHHTKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 15:10:25 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:57826 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbaHHTKX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 15:10:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 631194D6572;
	Fri,  8 Aug 2014 21:10:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26YeCgwKa-uL; Fri,  8 Aug 2014 21:10:11 +0200 (CEST)
Received: from linux-1gf2.thomasrast.ch (173-161-212-225-Philadelphia.hfc.comcastbusiness.net [173.161.212.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id CE88B4D65DF;
	Fri,  8 Aug 2014 21:10:10 +0200 (CEST)
In-Reply-To: <8d01ff53a49647906c9008620435a62f08a1f76f.1407368621.git.bafain@gmail.com>
	(Fabian Ruch's message of "Thu, 7 Aug 2014 01:59:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255065>

Fabian Ruch <bafain@gmail.com> writes:

[...]
> are not supported at the moment. Neither are options that contain
> spaces because the shell expansion of `args` in `do_next` interprets
> white space characters as argument separator, that is a command line
> like
>
>     pick --author "A U Thor" fa1afe1 Some change
>
> is parsed as the pick command
>
>     pick --author
>
> and the commit hash
>
>     "A
>
> which obviously results in an unknown revision error. For the sake of
> completeness, in the example above the message title variable `rest`
> is assigned the string 'U Thor" fa1afe1 Some change' (without the
> single quotes).

You could probably trim down the non-example a bit and instead give an
example :-)

> Print an error message for unknown or unsupported command line
> options, which means an error for all specified options at the
> moment.

Can you add a test that verifies we catch an obvious unknown option
(such as --unknown-option)?

> Cleanly break the `do_next` loop by assigning the special
> value 'unknown' to the local variable `command`, which triggers the
> unknown command case in `do_cmd`.
[...]
>  do_replay () {
>  	command=$1
> -	sha1=$2
> -	rest=$3
> +	shift
> +
> +	opts=
> +	while test $# -gt 0
> +	do
> +		case "$1" in
> +		-*)
> +			warn "Unknown option: $1"
> +			command=unknown
> +			;;
> +		*)
> +			break
> +			;;

This seems a rather hacky solution to me.  Doesn't this now print

  warning: Unknown option: --unknown-option
  warning: Unknown command: pick --unknown-option

?

It shouldn't claim the command is unknown if the command itself was
valid.

Also, you speak of do_cmd above, but the unknown command handling seems
to be part of do_replay?

-- 
Thomas Rast
tr@thomasrast.ch
