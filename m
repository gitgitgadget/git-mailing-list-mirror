From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test suite: add a check that all test numbers are
 unique
Date: Fri, 21 Aug 2009 08:53:24 -0400
Message-ID: <20090821125324.GA6280@coredump.intra.peff.net>
References: <4A8E68AF.8040001@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 14:53:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeTca-0007bE-F8
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 14:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563AbZHUMxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 08:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbZHUMxX
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 08:53:23 -0400
Received: from peff.net ([208.65.91.99]:38363 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785AbZHUMxW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 08:53:22 -0400
Received: (qmail 764 invoked by uid 107); 21 Aug 2009 12:53:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 21 Aug 2009 08:53:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Aug 2009 08:53:24 -0400
Content-Disposition: inline
In-Reply-To: <4A8E68AF.8040001@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126707>

On Fri, Aug 21, 2009 at 11:28:15AM +0200, Johannes Sixt wrote:

> The test runs only if 'make all' is used. Its purpose is to alert our
> valued integrator if different branches are merged that happen to
> introduce the same test number.

I think this is probably useful. In addition to the t7406 you posted a
patch for, it looks like t4037 has a duplicate in next.

As for the implementation:

> +++ b/t/check_unique_numbers.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +
> +# checks whether test case numbers are unique;
> +# returns non-zero if any duplicates were found
> +
> +check_numbers () {
> +	last= dup=
> +	while read name
> +	do
> +		case $name in
> +		t[0-9][0-9][0-9][0-9]-*.sh)
> +			number=${name%%-*}
> +			if test "$number" = "$last"; then
> +				dup="$dup $number"
> +			fi
> +			last=$number
> +			;;
> +		esac
> +	done
> +	test -z "$dup" || {
> +		echo >&2 "error: duplicate test numbers:" $dup
> +		return 1
> +	}
> +}
> +
> +ls -1 |	# no wildcard to avoid overflow of command line
> +check_numbers

Why not the much shorter:

tests() {
  ls | sed -n 's/^\(t[0-9][0-9][0-9][0-9]\)-.*\.sh$/\1/p'
}
dups=`tests | uniq -d`

instead of the long shell loop?

-Peff
