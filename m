From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1bis/2] Diff patterns for POSIX shells
Date: Wed, 3 Aug 2011 03:32:52 -0600
Message-ID: <20110803093252.GA16351@sigill.intra.peff.net>
References: <7vzkjrem6b.fsf@alter.siamese.dyndns.org>
 <1312349176-20984-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 11:33:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoXp2-0001oi-FK
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 11:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab1HCJc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 05:32:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46710
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917Ab1HCJc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 05:32:58 -0400
Received: (qmail 5758 invoked by uid 107); 3 Aug 2011 09:33:30 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 05:33:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 03:32:52 -0600
Content-Disposition: inline
In-Reply-To: <1312349176-20984-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178551>

On Wed, Aug 03, 2011 at 07:26:16AM +0200, Giuseppe Bilotta wrote:

> All diffs following a function definition will have that function name
> as chunck header, but this is the best we can do with the current
> userdiff capabilities.

Curious as to how this would look in git.git, I tried "git log -p"
before and after your patches, and diffed the result. I noticed two
things:

  1. Given a block of shell code like this:

        foo() {
          ... do something ...
        }

        test_expect_success 'test foo' '
          ... the actual test ...
        '

     if we add new code after the test, the old regex would print:

        @@ -1,2 +3,4 @@ test_expect_success 'test foo' '

     and now we say:

        @@ -1,2 +3,4 @@ foo

     which seems more misleading. I know the function-matching code has
     no way to say "look for ^}, which signals end of function", so we
     can't be entirely accurate. But I wonder if the new heuristic
     (which seems to look for a name followed by parentheses) is
     actually any better than the old.

  2. What would have printed before:

       @@ -1,2 +3,4 @@ foo() {

     now prints

       @@ -1,2 +3,4 @@ foo

     without the parentheses or brace. It looks like the similar C one
     keeps the parentheses, at least. I find that a bit more readable,
     as it is more clear that the line indicates a function, and not
     simply some top-level command.

-Peff
