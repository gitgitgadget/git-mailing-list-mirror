From: Jeff King <peff@peff.net>
Subject: Re: "Unexpected end of command stream" message looks irrelevant when
 I try to pull a non-existing branch
Date: Wed, 9 Jul 2014 16:59:02 -0400
Message-ID: <20140709205902.GB25854@sigill.intra.peff.net>
References: <787461404891471@web12h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry <wipedout@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Jul 09 22:59:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4yxN-00064q-FS
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 22:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbaGIU7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 16:59:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:58955 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750919AbaGIU7E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 16:59:04 -0400
Received: (qmail 6925 invoked by uid 102); 9 Jul 2014 20:59:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 15:59:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 16:59:02 -0400
Content-Disposition: inline
In-Reply-To: <787461404891471@web12h.yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253150>

On Wed, Jul 09, 2014 at 11:37:51AM +0400, Dmitry wrote:

> I'm using Git 1.8.1 and when I run the following command:
> 
> git pull origin matser
> 
> I get the following output:
> 
> fatal: couldn't find remote ref matser
> Unexpected end of command stream
> 
> The first line in the output is right on the money but the second one
> looks completely irrelevant - the command is well formed except I
> perhaps mistyped the branch name. It looks like there's some bug that
> prevents the program from just exiting after printing the first line
> and so the second line is being output.

I imagine your origin remote is over http. For some protocols, git
delegates the hard work to a helper program and communicates over a
pipe. In this case, the parent git process detects a problem and dies.
The second message comes from the helper, who is surprised that the
parent has gone away.

Probably the right solution is teaching the parent to properly hang up
the connection with the helper before exiting (alternatively, we could
just silence the helper; that means we would get less output when the
parent really does unexpectedly go away, but that isn't supposed to ever
happen).

-Peff
