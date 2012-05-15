From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] drop length limitations on gecos-derived names and
 emails
Date: Mon, 14 May 2012 22:32:20 -0400
Message-ID: <20120515023220.GA22947@sigill.intra.peff.net>
References: <20120511231303.GA24611@sigill.intra.peff.net>
 <20120514162824.GA24457@sigill.intra.peff.net>
 <20120514210225.GA9677@sigill.intra.peff.net>
 <20120514211324.GA11578@sigill.intra.peff.net>
 <20120515015437.GA13833@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 15 04:32:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU7Z0-0007G0-6H
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 04:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965493Ab2EOCca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 22:32:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43347
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965286Ab2EOCcW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 22:32:22 -0400
Received: (qmail 27696 invoked by uid 107); 15 May 2012 02:32:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 May 2012 22:32:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2012 22:32:20 -0400
Content-Disposition: inline
In-Reply-To: <20120515015437.GA13833@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197818>

On Mon, May 14, 2012 at 09:54:37PM -0400, Jeff King wrote:

> Of course we've still polluted this crappy fake name into
> git_default_name, so that later calls with error_on_no_name will see it
> and not error. I think so far it hasn't mattered because the only user
> of this "warn" code is format-patch, which otherwise does not care about
> ident (and doesn't even end up using the name at all!). And I doubt this
> code path gets triggered much anyway; do people really run
> "GIT_COMMITTER_NAME= git format-patch"?
> 
> I can just leave it as it's not really hurting anybody, I think. But I
> was refactoring in the area and it just seemed flaky and questionable. I
> wonder if we can simply get rid of the IDENT_WARN_ON_NO_NAME code path
> entirely. The use here is grabbing the email address to use as part of a
> message id. Could we just call setup_ident and then read from
> git_default_email directly? There's no need to respect
> GIT_COMMITTER_EMAIL here at all.

Hmm, I was mistaken. This code path also gets followed whenever
IDENT_ERROR_ON_NO_NAME is not set (regardless of IDENT_WARN_ON_NO_NAME).
So other programs may accidentally get this pollution of
git_default_name and show a username when we _could_ have shown the name
from config. I can see the pollution in a debugger in "git commit", but
I don't think you can actually trigger a commit with it, because later
calls to fmt_ident use ERROR_ON_NO_NAME.

I really wonder if we can just get rid of all of the calls which do not
use ERROR_ON_NO_NAME. As far as I can tell, they are all part of
programs which later end up using ERROR_ON_NO_NAME anyway.

-Peff
