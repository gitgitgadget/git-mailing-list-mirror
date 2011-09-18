From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-web--browse: invoke kfmclient directly
Date: Sun, 18 Sep 2011 14:38:47 -0400
Message-ID: <20110918183846.GA31176@sigill.intra.peff.net>
References: <20110918032933.GA17977@sigill.intra.peff.net>
 <1316341224-4359-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, jepler@unpythonic.net
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 20:42:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5MK0-0001Ms-KW
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 20:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab1IRSit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 14:38:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57048
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755997Ab1IRSit (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 14:38:49 -0400
Received: (qmail 16644 invoked by uid 107); 18 Sep 2011 18:39:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 Sep 2011 14:39:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Sep 2011 14:38:47 -0400
Content-Disposition: inline
In-Reply-To: <1316341224-4359-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181618>

On Sun, Sep 18, 2011 at 10:20:24PM +1200, Chris Packham wrote:

> Instead of using eval which causes problems when a URL contains an
> appropriately escaped ampersand (\&).

I think this probably should just remove all of the evals. I don't see
how any of them is doing any good, and they're actively breaking URLs
that need quoting.

Hmm. Actually, the one for custom browser commands might need it,
because that one is expected to be a shell snippet. I suspect the
simplest thing is to do something like:

  eval "$browser_cmd \"\$@\""

The other option would be to actually shell-quote each argument, which
is a pain to do in the shell (but is what C git does).

> For what it's worth I've included a testcase that detects my problem. I'm not
> sure if the testcase is really worth it because the test library suppresses X
> applications and even if it didn't the testcase is fairly trivial and might
> just annoy people by opening web-browsers (and it snaps up the last t99xx
> prefix).

Ick, yeah. Actually starting real browsers interacts too much with the
world outside of the test scripts. The results will be annoying (new
browser windows) and cause non-deterministic test results.

If you want to make a test, I think you would do better with something
like:

  echo someurl_with_&_in_it >expect &&
  git config browser.custom.cmd echo &&
  git web--browse --browser=custom someurl_with_&_in_it >actual &&
  test_cmp expect actual

That won't test that we are invoking kfmclient correctly, obviously, but
you can confirm at least that URLs are making it through to the browser
script intact.

-Peff
