From: Jeff King <peff@peff.net>
Subject: Re: Possible regression: overwriting untracked files in a fresh
 repo
Date: Mon, 24 Aug 2009 15:07:10 -0400
Message-ID: <20090824190710.GB25168@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0908241829510.11375@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 24 21:07:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfetE-0004cr-Qe
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 21:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbZHXTHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 15:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbZHXTHQ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 15:07:16 -0400
Received: from peff.net ([208.65.91.99]:40762 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbZHXTHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 15:07:12 -0400
Received: (qmail 10382 invoked by uid 107); 24 Aug 2009 19:07:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 24 Aug 2009 15:07:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2009 15:07:10 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908241829510.11375@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126958>

On Mon, Aug 24, 2009 at 06:31:21PM +0200, Johannes Schindelin wrote:

> I _think_ that this used to complain about untracked files being 
> overwritten:
> 
> 	$ git init
> 	$ git remote add -f origin <url>
> 	$ git checkout -b blub origin/master
> 
> It does not do that here (any longer, IIAC).  Intended?

I agree that it probably _should_ complain, but I don't think it ever
did. I tried a handful of released versions as far back as v1.4.4, and
all of them overwrite local files without complaining. My test was:

-- >8 --
#!/bin/sh

rm -rf parent child

mkdir parent && (
  cd parent &&
  git init-db &&
  echo content >file &&
  git add file &&
  git commit -m add
) &&
mkdir child && (
  cd child &&
  git init-db &&
  git fetch ../parent master:origin &&
  echo precious >file &&
  ! git checkout -b foo origin
)
-- >8 --

However, if I then do this:

  (cd parent && echo content >another && git add . && git commit -m more)
  (cd child && git fetch ../parent && git checkout -b new FETCH_HEAD)

then it does complain. I'm guessing there is a different code path for
the case that we have no index at all, and that it is not properly
checking for overwrites.

But now I have a small child waking up so I can't look into it further.
:)

-Peff
