From: Jeff King <peff@peff.net>
Subject: Re: git bugs
Date: Fri, 13 Jun 2008 06:10:24 -0400
Message-ID: <20080613101024.GA8221@sigill.intra.peff.net>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com> <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Lynn <benlynn@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 12:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K76Fe-0002iC-5w
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 12:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757255AbYFMKK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 06:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757385AbYFMKK2
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 06:10:28 -0400
Received: from peff.net ([208.65.91.99]:3825 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757087AbYFMKK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 06:10:27 -0400
Received: (qmail 12773 invoked by uid 111); 13 Jun 2008 10:10:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 06:10:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 06:10:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84861>

On Tue, Jun 10, 2008 at 10:44:43AM -0700, Linus Torvalds wrote:

> You can fix this multiple ways. One would be to pick another size that is 
> simply less likely (eg ~0 instead), which leaves the theoretical race, and 
> just makes it practically impossible to hit (not that I think it's very 
> practical to hit already).

Hmm. I may have just hit it in the test suite.

Try this:

  cd git/t
  for i in `seq 1 1000`; do
    ./t4126-apply-empty.sh -v -i || break
  done
  echo made it to $i

Most of the time it works, but somewhere in that thousand (generally
within a few hundred), I end up with a failed test. The failure looks
like:

   * expecting success:
           git reset --hard &&
           >empty &&
           rm -f missing &&
           git apply --index patch0 &&
           test_cmp expect empty &&
           git diff --exit-code

   HEAD is now at e3f79fd initial
   error: empty: does not match index
   * FAIL 3: apply --index empty

> The other approach is to know that an empty blob always has a very 
> specific SHA1. Here's an trial patch.

However, I can still trigger the failure with your patch, so I wonder if
it is some other race entirely...

-Peff
