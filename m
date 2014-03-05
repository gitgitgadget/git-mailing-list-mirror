From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] push: detect local refspec errors early
Date: Wed, 5 Mar 2014 14:02:48 -0500
Message-ID: <20140305190248.GB31252@sigill.intra.peff.net>
References: <259061394012172@web5j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry <wipedout@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Mar 05 20:03:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLH5q-0002u8-BF
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbaCETCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 14:02:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:33565 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753070AbaCETCu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 14:02:50 -0500
Received: (qmail 17770 invoked by uid 102); 5 Mar 2014 19:02:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Mar 2014 13:02:50 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2014 14:02:48 -0500
Content-Disposition: inline
In-Reply-To: <259061394012172@web5j.yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243463>

On Wed, Mar 05, 2014 at 01:36:12PM +0400, Dmitry wrote:

> Here's my usecase. I have created a BranchWithVeryLongName and I want
> to have it pushed to origin. So I use this command with version
> 1.8.1.2:
> 
> git push origin BranchMistypedLongName
> 
> (note that I mistyped the branch name). The following happens:
> 1. git asks me for username and password
> 2. it authenticates on the origin server
> 3. it bails out with "error: sfc refspec BranchMistypedLongName does not match any"
> 
> Can't git perhaps check that the branch exists before it asks me for
> credentials and just say there's no such branch?

We can't fully process the refspecs until we have talked to the other
side, because they may involve matching refs from the remote; I don't
think git even really looks at them until after we've connected.

But I think there are some obvious cases, like a bogus left-hand side
(i.e., what you have here) that cannot ever succeed, no matter what the
other side has. We could sanity check the refspecs before doing anything
else.

Here's a patch series that does that.

  [1/3]: match_explicit: hoist refspec lhs checks into their own function
  [2/3]: match_explicit_lhs: allow a "verify only" mode
  [3/3]: push: detect local refspec errors early

-Peff
