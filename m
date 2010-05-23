From: Jeff King <peff@peff.net>
Subject: Re: Bug with URL-decoding
Date: Sun, 23 May 2010 05:16:13 -0400
Message-ID: <20100523091612.GB26123@coredump.intra.peff.net>
References: <loom.20100507T000406-241@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sun May 23 11:16:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG7IG-00041p-S7
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 11:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab0EWJQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 05:16:19 -0400
Received: from peff.net ([208.65.91.99]:40944 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab0EWJQT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 05:16:19 -0400
Received: (qmail 21102 invoked by uid 107); 23 May 2010 09:16:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 23 May 2010 05:16:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 May 2010 05:16:13 -0400
Content-Disposition: inline
In-Reply-To: <loom.20100507T000406-241@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147560>

On Thu, May 06, 2010 at 10:06:50PM +0000, Dave Abrahams wrote:

> $ cd /tmp
> $ mkdir x+y
> $ cd x+y
> $ git init
> $ cd ..
> $ git clone file:///tmp/x%2By zz  # <==== ERROR
> $ git clone file:///tmp/x+y zz # <====== OK
> 
> Funny characters do come up in names, especially in test suites

Yeah, at this point file:// is more or less just an alias for a straight
path (and ssh:// an alias for "host:path" syntax). We correctly
percent-decode http:// URLs because we just hand them to curl, which
does the right thing. We should be decoding these ones when we pick
apart the URL components.

Patch series to follow:

  [1/2]: make url-related functions reusable
  [2/2]: decode file:// and ssh:// URLs

With these patches, you can do:

  git clone file:///tmp/x%2By

or

  git clone /tmp/x+y

The former will clone into "x%2By". Which I'm not even sure is wrong, so
I left it as-is.

-Peff
