From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0005: ksh93 portability workaround
Date: Tue, 31 May 2016 19:03:01 -0400
Message-ID: <20160531230301.GB4585@sigill.intra.peff.net>
References: <xmqqinxt3kwq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 01:03:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7sgq-0005bo-2p
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 01:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601AbcEaXDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 19:03:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:46819 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752711AbcEaXDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 19:03:06 -0400
Received: (qmail 2960 invoked by uid 102); 31 May 2016 23:03:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 19:03:05 -0400
Received: (qmail 28187 invoked by uid 107); 31 May 2016 23:03:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 19:03:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2016 19:03:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqqinxt3kwq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296030>

On Tue, May 31, 2016 at 03:47:01PM -0700, Junio C Hamano wrote:

> The test has two things ksh93 does not happy about:
> 
>  * It thinks "(( command1; command2 ) | command3)" is a perfectly
>    sane way to write a pipeline.  ksh93, unlike other POSIX shells,
>    does not like the two open parentheses next to each other for
>    whatever reason it has.
> 
>  * It adds 256, unlike 128 that are used by other POSIX shells, to
>    the signal number that caused the process to die when coming up
>    with the exit status.
> 
> What is interesting is that we knew about the latter issue and had a
> workaround in the test-sigchain test when verifying that SIGTERM
> works OK, but we didn't have corresponding workaround for SIGPIPE.

Hmm. We discussed these back in:

  http://thread.gmane.org/gmane.comp.version-control.git/268657

but I thought we decided not to do anything about them (according to
that thread, I found a bunch of other ksh93 oddities, but maybe we've
since fixed them?).

> +died_with_sigpipe () {
> +	case "$1" in
> +	141 | 269)
> +		# POSIX w/ SIGPIPE=13 gives 141
> +		# ksh w/ SIGPIPE=13 gives 269
> +		true ;;
> +	*)	false ;;
> +	esac
> +}

This is OK, but I like the patch I posted in

  http://article.gmane.org/gmane.comp.version-control.git/268666

better, as it contains the shell logic in a single place (though I am
not sure how these tests fare on Windows, where I think every signal
just looks like "3").

-Peff
