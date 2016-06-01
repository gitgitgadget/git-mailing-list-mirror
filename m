From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Tue, 31 May 2016 23:54:08 -0400
Message-ID: <20160601035408.GD5411@sigill.intra.peff.net>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
 <20160531225628.GA4585@sigill.intra.peff.net>
 <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
 <20160601023159.GA5411@sigill.intra.peff.net>
 <20160601033139.GB5411@sigill.intra.peff.net>
 <20160601034413.GC5411@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 05:54:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7xEa-0001ez-7D
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 05:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185AbcFADyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 23:54:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:46930 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757005AbcFADyM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 23:54:12 -0400
Received: (qmail 15013 invoked by uid 102); 1 Jun 2016 03:54:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 23:54:11 -0400
Received: (qmail 29534 invoked by uid 107); 1 Jun 2016 03:54:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 23:54:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2016 23:54:08 -0400
Content-Disposition: inline
In-Reply-To: <20160601034413.GC5411@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296048>

On Tue, May 31, 2016 at 11:44:13PM -0400, Jeff King wrote:

> # probably not portable; also, possible without sub-program?
> is_exported () {
> 	export -p | grep "^declare -x $1="
> }

Obviously this should have been "grep -q" (and my test didn't notice
because the variable isn't actually exported!).

But yeah, this is not very portable. Doing:

  export AAAA=content
  for i in bash dash mksh ksh93
  do
    printf '%5s ==> ' $i
    $i -c 'export -p' | head -1
  done

yields:

   bash ==> declare -x AAAA="content"
   dash ==> export AAAA='content'
   mksh ==> export AAAA=content
  ksh93 ==> export AAAA=content

which is actually not too hard to pattern-match, but who knows what else
exists. I guess another strategy would be to actually spawn a
sub-process and see if it has the variable set.

I think my code also doesn't handle exported-but-unset variables, though
I'm not sure we really need to care about that in practice.

-Peff
