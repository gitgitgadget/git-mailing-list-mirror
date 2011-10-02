From: Jeff King <peff@peff.net>
Subject: Re: Bug?: 'git log --find-copies' doesn't match 'git log --follow
 <rev> -- path/to/file'
Date: Sun, 2 Oct 2011 11:25:17 -0400
Message-ID: <20111002152517.GA10353@sigill.intra.peff.net>
References: <DBC73B3F-2703-4651-AADA-233A9CC38AFD@inf.fu-berlin.de>
 <20110930213841.GA9384@sigill.intra.peff.net>
 <67B22035-4B90-4A68-8960-DDB58F640CD9@inf.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Pepper <pepper@inf.fu-berlin.de>
X-From: git-owner@vger.kernel.org Sun Oct 02 17:25:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RANuw-0003hp-EX
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 17:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab1JBPZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 11:25:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51236
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718Ab1JBPZV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 11:25:21 -0400
Received: (qmail 19815 invoked by uid 107); 2 Oct 2011 15:30:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 02 Oct 2011 11:30:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Oct 2011 11:25:17 -0400
Content-Disposition: inline
In-Reply-To: <67B22035-4B90-4A68-8960-DDB58F640CD9@inf.fu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182605>

On Sun, Oct 02, 2011 at 05:10:26PM +0200, Alexander Pepper wrote:

> Using 'git log --numstat --find-copies-harder dd4e90f9' yields "immutable.java" as you expected:
> 
> $ git log --numstat --find-copies-harder dd4e90f9
> [...]
> 6       10      src/java/voldemort/annotations/concurrency/Immutable.java => contrib/ec2-testing/src/java/voldemort/utils/ClusterOperation.java

OK. That at least explains what's going on.

> So is there a way to tell --follow to only use --find-copies instead
> of --find-copies harder?

No, it's hard-coded.

> And what is the advantage of using "--find-copies-harder" over "--find-copies"?

It finds more copies. The rename detection works like this:

  --find-renames: for each newly-created file, consider any deleted
                  files as possible sources

  --find-copies: like above, but also consider any modified files as
                 possible sources

  --find-copies-harder: like above, but consider any file in the
                        repository as a possible source

So in theory --find-copies-harder is the most accurate, but it is also
the most expensive. We can afford to do it for --follow since we're only
considering a small subset of the possible destinations.

So git is saying that your immutable.java is actually a better match;
it's just that we don't usually find it because it wasn't modified in
the same commit. Have you looked at the contents? Is it actually a
better match, or is git wrong?

-Peff
