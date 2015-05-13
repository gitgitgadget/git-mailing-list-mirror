From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Wed, 13 May 2015 01:09:51 -0400
Message-ID: <20150513050951.GA7122@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <20150513045650.GA6070@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 07:10:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOvf-0002m3-0t
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 07:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbbEMFJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 01:09:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:57635 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751869AbbEMFJy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 01:09:54 -0400
Received: (qmail 2769 invoked by uid 102); 13 May 2015 05:09:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:09:54 -0500
Received: (qmail 7066 invoked by uid 107); 13 May 2015 05:09:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 01:09:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 01:09:51 -0400
Content-Disposition: inline
In-Reply-To: <20150513045650.GA6070@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268935>

On Wed, May 13, 2015 at 12:56:50AM -0400, Jeff King wrote:

>   - Lots of places where we backslash-escape some syntax for AsciiDoc
>     ends up rendered by AsciiDoctor with the backslashes included. In
>     some cases the quoting is unnecessary and we can drop it (see
>     patches 6 and 7 below). But in others it really is necessary, and
>     AsciiDoc generates bad output without the backslashes. The major
>     ones are "--" surrounded by spaces (which becomes an emdash), and
>     things like @\{HEAD}, which needs quoted to tell AsciiDoc that HEAD
>     isn't an attribute.

That example should be HEAD@\{yesterday}, of course, but I think you get
the point.

>   [1/8]: doc: fix misrendering due to `single quote'
>   [2/8]: doc: fix unquoted use of "{type}"
>   [3/8]: doc: fix hanging "+"-continuation
>   [4/8]: doc: fix length of underlined section-title
>   [5/8]: doc/add: reformat `--edit` option
>   [6/8]: doc: convert \--option to --option
>   [7/8]: doc: drop backslash quoting of some curly braces
>   [8/8]: doc: put example URLs inside literal backticks

While reviewing the changes to the output, I found this script, which
shows the diff of the rendered HTML against the parent, very valuable:

    #!/bin/sh
    
    me=$(git rev-parse HEAD^{tree})
    parent=$(git rev-parse HEAD^^{tree})
    
    build() {
    	test -d build/$1 && return 0
    	mkdir -p build/tmp &&
    	make -j16 html &&
    	cp *.html build/tmp &&
    	mv build/tmp build/$1
    }
    
    check() {
    	test -d build/$1 && return 0
    	echo >&2 "doc for $1 not built"
    	return 1
    }
    
    build $me &&
    check $parent &&
    diff -Nru -I'^ 2015-05' build/$parent build/$me

I basically stopped at each commit in an interactive rebase and checked
the output (to confirm that it was sane, and especially to confirm the
cases where I claimed there should be no changes to the output).

-Peff
