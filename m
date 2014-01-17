From: Jeff King <peff@peff.net>
Subject: Re: git quietly fails on https:// URL, https errors are never
 reported to user
Date: Fri, 17 Jan 2014 16:10:35 -0500
Message-ID: <20140117211035.GA8447@sigill.intra.peff.net>
References: <52D7D017.107@rawbw.com>
 <20140116180310.GA27180@sigill.intra.peff.net>
 <52D8FAA6.1010601@rawbw.com>
 <xmqqmwiuwg0o.fsf@gitster.dls.corp.google.com>
 <20140117201325.GB775@sigill.intra.peff.net>
 <52D9950B.3030300@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Yuri <yuri@rawbw.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 22:10:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4Ggc-0006iG-3f
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 22:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbaAQVKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 16:10:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:34396 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751649AbaAQVKh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 16:10:37 -0500
Received: (qmail 32302 invoked by uid 102); 17 Jan 2014 21:10:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Jan 2014 15:10:37 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:10:35 -0500
Content-Disposition: inline
In-Reply-To: <52D9950B.3030300@rawbw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240631>

On Fri, Jan 17, 2014 at 12:39:39PM -0800, Yuri wrote:

> >That second line is not adding anything, and IMHO is making things
> >uglier and more confusing. We_expected_  the helper to hang up; that's
> >how it signals an error to us. It is not an unexpected condition at all.
> >The exit(128) we do is simply propagating the error report of the
> >helper.
> >
> >That's the common error case: the message is redundant and annoying. The
> >_uncommon_  case is the one Yuri hit: some library misconfiguration that
> >causes the helper not to run at all.  Adding back any message is hurting
> >the common case to help the uncommon one.
> 
> But you can use the error code value to convey the cause of the
> failure to git, and avoid an unnecessary message in git itself. Based
> on the error code value git could tell if the error has already been
> reported to user.

Yes, we can, but that is in the same boat as a protocol change: you have
to teach every remote helper (some of which are written by third
parties) to communicate over this sideband channel.

It's should be slightly easier than a change to the protocol text,
because it's mostly backwards compatible (helpers should already be
returning a non-zero error code). I think there is some complication
with exit codes and remote-helpers, where you cannot expect just check
the exit code at any time. I _think_ from previous discussions that it
is safe to waitpid() on the helper after we have gotten EOF on the
reading pipe, though.

-Peff
