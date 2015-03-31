From: Jeff King <peff@peff.net>
Subject: Re: git branch --contains is slow with a lot of branches
Date: Mon, 30 Mar 2015 23:03:58 -0400
Message-ID: <20150331030357.GA19170@peff.net>
References: <20150331014511.GA28418@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 05:04:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcmTI-0007SB-RC
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 05:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbbCaDEC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 23:04:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:40135 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751883AbbCaDEB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 23:04:01 -0400
Received: (qmail 467 invoked by uid 102); 31 Mar 2015 03:04:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 22:04:01 -0500
Received: (qmail 19467 invoked by uid 107); 31 Mar 2015 03:04:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 23:04:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2015 23:03:58 -0400
Content-Disposition: inline
In-Reply-To: <20150331014511.GA28418@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266506>

On Tue, Mar 31, 2015 at 10:45:11AM +0900, Mike Hommey wrote:

> Using git branch --contains can be a very expensive thing:
> [...]

Yes, this is well known. It does a separate traversal for each branch,
which is why you noticed that it's linear in the number of branches.

I changed the "tag --contains" algorithm a while ago to do it all in one
traversal. The downside is that it uses a depth-first approach which
means it almost always goes to the roots. This is more appropriate for
tags (as you often have old tags), but less so for branches.

I did some work on a contains() implementation that would is
breadth-first, but handles multiple tips in a single traversal. It needs
a little polish, and then to be hooked into "git branch". This is part
of the proposed GSoC project for unifying "tag -l", "branch -l", and
"for-each-ref".

-Peff
