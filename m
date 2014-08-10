From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Update hard-coded header dependencies
Date: Sun, 10 Aug 2014 15:48:24 -0400
Message-ID: <20140810194824.GC9886@peff.net>
References: <20140808215825.GH12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 21:48:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGZ6b-0004bn-Jh
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 21:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbaHJTse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 15:48:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:49838 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751122AbaHJTsd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 15:48:33 -0400
Received: (qmail 945 invoked by uid 102); 10 Aug 2014 19:48:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (204.237.18.137)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Aug 2014 14:48:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Aug 2014 15:48:24 -0400
Content-Disposition: inline
In-Reply-To: <20140808215825.GH12427@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255103>

On Fri, Aug 08, 2014 at 02:58:26PM -0700, Jonathan Nieder wrote:

> Maybe it's worth switching to plain
> 
> 	LIB_H += $(wildcard *.h)
> 
> ?  People using ancient compilers that never change headers wouldn't
> be hurt, people using modern compilers that do change headers also
> wouldn't be hurt, and we could stop pretending to maintain an
> up-to-date list.

Yeah, I think that makes sense. I'd imagine most of the developers are
on a modern platform and don't use the static list at all, so we don't
notice when it breaks (and even when you do use it, it's quite hard to
notice anyway).

We'd have to do a multi-directory wildcard, though, to catch the header
files stuck in compat/* and elsewhere. We could list the containing
directories manually, but that's yet another thing to go wrong. For
people using the git repo, it would probably be fine to do:

  LIB_H += $(shell git ls-files -- '*.h')

That wouldn't count new files a developer adds until they "git add" some
version of the file, but that is not so bad (right now they have to add
it to the Makefile, and anyway, I think most devs are using the computed
dependencies).

But that doesn't work for distributed tarballs, which would have to
convert that to a static list somehow. Maybe

  LIB_H += $(shell find . -name '*.h' -print)

would work?

-Peff
