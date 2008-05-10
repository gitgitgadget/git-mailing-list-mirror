From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] repack: modify behavior of -A option to leave
	unreferenced objects unpacked
Date: Sat, 10 May 2008 02:03:45 -0400
Message-ID: <20080510060345.GC11556@sigill.intra.peff.net>
References: <7vabj0b1re.fsf@gitster.siamese.dyndns.org> <3927888.1210392047922.JavaMail.teamon@b303.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: drafnel@gmail.com
X-From: git-owner@vger.kernel.org Sat May 10 08:04:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuiCL-0006qg-Q2
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 08:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbYEJGDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 02:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYEJGDn
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 02:03:43 -0400
Received: from peff.net ([208.65.91.99]:4133 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905AbYEJGDm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 02:03:42 -0400
Received: (qmail 25678 invoked by uid 111); 10 May 2008 06:03:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 10 May 2008 02:03:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 May 2008 02:03:45 -0400
Content-Disposition: inline
In-Reply-To: <3927888.1210392047922.JavaMail.teamon@b303.teamon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81653>

On Fri, May 09, 2008 at 11:01:55PM -0500, drafnel@gmail.com wrote:

> -		keep_unreachable=--keep-unreachable ;;
> +		keep_unreachable=t ;;

Can we call this something else (like unpack_unreachable) since it now
has nothing to do with the --keep-unreachable flag?

Also, should --keep-unreachable be deprecated / removed?

> +			*)
> +				rm -f "$e.idx" "$e.keep"
> +				if test -n "$keep_unreachable" &&
> +				   test -f "$e.pack"
> +				then
> +					git unpack-objects < "$e.pack" || {
> +						echo >&2 "Failed unpacking unreachable objects from redundant pack file $e.pack"
> +						exit 1
> +					}
> +				fi

I still like Geert's suggestion of unpacking them to a _different_
place. That helps to avoid spurious "gc --auto" invocations caused by
too many prunable objects. Though it certainly doesn't solve it, and
maybe that just needs to be fixed separately.

Possibly the "gc --auto" test should be:

  - count objects; if too few, exit
  - count unreachable loose objects; if too few, exit
  - run gc

That means having a lot of unreachable objects will still incur some
extra processing, but not as much as a full repack. And it won't bug the
user with a "you need to repack" message.

-Peff
