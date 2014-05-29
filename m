From: Jeff King <peff@peff.net>
Subject: Re: .gitmodules containing SSH clone URLs should fall back to HTTPS
 when SSH key is not valid/existent
Date: Thu, 29 May 2014 19:56:43 -0400
Message-ID: <20140529235643.GB28683@sigill.intra.peff.net>
References: <CA+OJ3uv0XqeodTCzeauUrH9FjzknBupMd5kxh+3qgyji5TwOzA@mail.gmail.com>
 <53871B8D.40608@web.de>
 <CA+OJ3utofb+od5uct4HF1yoQGfWgX7YTn4hPChDpC7LTFVJDYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	John Albietz <inthecloud247@gmail.com>
To: Jonathan Leonard <johanatan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 01:56:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqABm-0008OQ-1x
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 01:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbaE2X4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 19:56:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:33789 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751745AbaE2X4p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 19:56:45 -0400
Received: (qmail 29973 invoked by uid 102); 29 May 2014 23:56:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 18:56:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 19:56:43 -0400
Content-Disposition: inline
In-Reply-To: <CA+OJ3utofb+od5uct4HF1yoQGfWgX7YTn4hPChDpC7LTFVJDYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250422>

On Thu, May 29, 2014 at 04:12:38PM -0700, Jonathan Leonard wrote:

> We are using GitHub.
> [...]
> > But why is https special? Why not fall back to the git
> > protocol? Or http? (And no: I'm not serious here ;-)
> >
> 
> HTTPS isn't special except in that it is the least privileged
> transport type (and thus should be the last resort). Whether to
> fallback to git:// from ssh:// or vice versa is inconsequential to
> this request.

That's not quite true. git:// is the least privileged transport, as it
always anonymous and read-only (there ways to allow insecure pushes over
it, but GitHub does not enable them). Https is actually the most
flexible protocol, in that the same URL works of the box for both
logged-in and anonymous users (the latter assuming the repo is publicly
available). The server only prompts for credentials if necessary.

For that reason, it's a good choice for things like submodule URLs baked
into .gitmodules files.

The reasons not to are:

  1. It isn't _quite_ as efficient or robust as the regular git
     protocol, though in practice it's generally not a big deal.

  2. Pushers may prefer to authenticate with ssh keys (e.g., because
     they run ssh agent). I hope with modern credential helpers that
     logging in via http should not be a pain, either, though.

> > After the first failed clone of the submodule at via SSH the
> > developer could also just do a
> >
> >    git config submodule.<name>.url https://host/repo
> >
> > and override the URL from .gitmodules.
>
> Yes, this would work. But it would be a painful manual step which we
> would not want to force on ordinary users (and would not want to
> experience ourselves either).

Using insteadOf of in your global ~/.gitconfig would make this a
one-liner per-user. So one option would be to reverse things. Put
"https" URLs into the .gitmodules file, so most people have to do
nothing, and then developers who really want to do git-over-ssh can do a
one-time:

  git config --global url.git@github.com:.insteadOf https://github.com/

-Peff
