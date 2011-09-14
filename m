From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential-osxkeychain: load Security framework
 dynamically
Date: Wed, 14 Sep 2011 19:08:16 -0400
Message-ID: <20110914230816.GA5754@sigill.intra.peff.net>
References: <1316023117-84755-1-git-send-email-jaysoffian@gmail.com>
 <1316040926-89429-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 01:13:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3yde-0006FI-T5
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 01:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107Ab1INXIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 19:08:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44225
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab1INXIS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 19:08:18 -0400
Received: (qmail 15268 invoked by uid 107); 14 Sep 2011 23:09:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 19:09:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 19:08:16 -0400
Content-Disposition: inline
In-Reply-To: <1316040926-89429-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181407>

On Wed, Sep 14, 2011 at 06:55:26PM -0400, Jay Soffian wrote:

> Something like this. I'm going to pause here for feedback. Is the (not yet
> existant) followup commit referenced above allowing git-credential-osxkeychain
> to be a hard link to git a worthwhile endeavor? Or would a better approach be
> to make git-credential-osxkeychain.c not use any git code?

To be honest, I was surprised to see you linking against git. I had
always envisioned OS-specific helpers as living outside of the git.git
repo.  That's why I provided git-credential-getpass; it should be the
only part of git that helpers really want to reuse.

What are you getting from git that is useful? From my skim of your
patch, it looks like xmalloc/die, parse_options, and credential_getpass.

The first can be replaced with a few trivial lines of code. The second
is overkill, I think. The helper code will always hand you the
"--option=value" form, and I always intended it to stay that way
(whether that is well documented, I'm not sure). But a simple loop with
strncmps would be fine.

The hardest part is credential_getpass. You can call "git
credential-getpass", but you'll have to read the output yourself (though
it's quite simple to parse; see read_credential_response).

I'm not a fan of cutting and pasting code, and this will add a number of
lines to your C program. But I feel like keeping the build completely
separate from core git is probably a good boundary (especially because
this will not be getting built or tested all the time, as most of the
core code is).

-Peff
