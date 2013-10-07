From: Jeff King <peff@peff.net>
Subject: Re: Feature Request: gitignore recursion
Date: Mon, 7 Oct 2013 07:24:11 -0400
Message-ID: <20131007112411.GA5792@sigill.intra.peff.net>
References: <loom.20131007T000517-673@post.gmane.org>
 <CACsJy8CHcyDrzieX1Ps3LU2UxCP+QJdv9+5BXZj9Mw2bMs5v3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: AJ <alljeep@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 07 13:24:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VT8vF-0003ux-W9
	for gcvg-git-2@plane.gmane.org; Mon, 07 Oct 2013 13:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456Ab3JGLYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Oct 2013 07:24:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:45088 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751306Ab3JGLYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Oct 2013 07:24:16 -0400
Received: (qmail 25759 invoked by uid 102); 7 Oct 2013 11:24:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Oct 2013 06:24:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Oct 2013 07:24:11 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CHcyDrzieX1Ps3LU2UxCP+QJdv9+5BXZj9Mw2bMs5v3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235757>

On Mon, Oct 07, 2013 at 05:26:17PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Mon, Oct 7, 2013 at 5:23 AM, AJ <alljeep@gmail.com> wrote:
> > I'm hoping to get the following feature implemented into git.
> >
> > Add the ability to recursively include using:
> > !/my_dir/**/*
> 
> You can do that since v1.8.2. Actually the pattern should be
> 
> !/my_dir/**
> 
> Checkout gitignore man page for more information.

I think that is a reasonable approach to doing what the OP wants.

However, one thing I expected to work but didn't is:

  echo '*' >.gitignore
  echo '!*' >my_dir/.gitignore

That _does_ work for attributes, like:

  echo '* foo=one' >.gitattributes
  echo '* foo=two' >my_dir/.gitattributes

where the more-specific file takes precedence. It works because we keep
an attribute stack, and look from most-specific directory to least.

The directory traversal code, however, tries to avoid entering
directories that are ignored. So if you have told it to ignore "my_dir",
we will not even look at "my_dir/.gitignore".

This is arguably a bug, as the documentation says that more specific
paths should take precedence over toplevel ones. But the optimization of
pruning ignored paths is very important for performance; otherwise, we
would end up enumerating entire ignored subdirectories on the off chance
that they have a negative .gitignore entry buried deep inside them.

So I don't think it is worth fixing, but it might be worth mentioning in
the documentation. Or is it mentioned somewhere that I missed?

-Peff
