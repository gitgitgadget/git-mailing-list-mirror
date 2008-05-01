From: Jeff King <peff@peff.net>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 10:45:24 -0400
Message-ID: <20080501144524.GA10876@sigill.intra.peff.net>
References: <4819CF50.2020509@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Thu May 01 16:46:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jra3A-00048n-W9
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 16:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761124AbYEAOpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 10:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761006AbYEAOp3
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 10:45:29 -0400
Received: from peff.net ([208.65.91.99]:4530 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760965AbYEAOp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 10:45:27 -0400
Received: (qmail 11194 invoked by uid 111); 1 May 2008 14:45:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 10:45:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 10:45:24 -0400
Content-Disposition: inline
In-Reply-To: <4819CF50.2020509@tikalk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80913>

On Thu, May 01, 2008 at 05:10:24PM +0300, Ittay Dror wrote:

> Say I have a file A, I rename to 'B', commit, then change file B and  
> commit. Does 'git diff -M HEAD^^..' detect that? From what I see now, it  
> will show 'B' as new (all of it with '+' prefix in the output). Am I 
> right?

Yes, it should find it, assuming the changes to B leave it recognizable.
Try:

  mkdir repo && cd repo && git init
  cp /usr/share/dict/words A
  git add . && git commit -m added
  mv A B && git add B && git commit -a -m rename
  echo change >>B && git commit -a -m change
  git diff -M HEAD^^.. | head -n 7

You should see something like:

  diff --git a/A b/B
  similarity index 99%
  rename from A
  rename to B
  index 8e50f11..6525618 100644
  --- a/A
  +++ b/B

However, note the similarity index. If you change B so much that it
doesn't look close to the original A, then the rename is not detected
(and intentionally so -- the argument is that it is no longer a rename
in that context, but a rewritten file).

-Peff
