From: Jeff King <peff@peff.net>
Subject: Re: git web--browse error handling URL with & in it (Was Re:
 [RFC/PATCH] Configurable hyperlinking in gitk)
Date: Sat, 17 Sep 2011 23:29:34 -0400
Message-ID: <20110918032933.GA17977@sigill.intra.peff.net>
References: <20110917022903.GA2445@unpythonic.net>
 <4E7467B7.1090201@gmail.com>
 <20110917134527.GA28463@unpythonic.net>
 <4E752E32.2010208@gmail.com>
 <4E753BB9.7030804@gmail.com>
 <4E753C04.1070202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 05:29:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R584m-0002ze-6X
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 05:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab1IRD3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 23:29:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46286
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271Ab1IRD3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 23:29:36 -0400
Received: (qmail 11183 invoked by uid 107); 18 Sep 2011 03:30:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Sep 2011 23:30:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Sep 2011 23:29:34 -0400
Content-Disposition: inline
In-Reply-To: <4E753C04.1070202@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181600>

On Sun, Sep 18, 2011 at 12:32:04PM +1200, Chris Packham wrote:

> Update: it's the call to eval that causes the problem
> 
>   eval kfmclient newTab https://internalhost/code\&stuff/bugs.php?id=foo
>   [1] 14728
>   bash: stuff/bugs.php?id=foo: No such file or directory

Hmm. The offending lines look like:

  eval "$browser_path" "$@" &

Normally in git we treat user-configured commands as shell snippets,
meaning the user is responsible for any quoting. But in this script, we
seem to run:

  type "$browser_path"

several times. Which implies that "$browser_path" must be the actual
executable. In which case, I would think that:

  "$browser_path" "$@" &

would be the right thing. And indeed, that is what the firefox arm of
the case statement does. But chrome, konqueror, and others use eval.

Unrelated, but it also looks like $browser_path is used unquoted in the
firefox case (see inside the vers=$(...)).

-Peff
