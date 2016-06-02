From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1308: do not get fooled by symbolic links to the source
 tree
Date: Thu, 2 Jun 2016 19:16:20 -0400
Message-ID: <20160602231619.GA11277@sigill.intra.peff.net>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
 <712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
 <xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com>
 <xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com>
 <20160602213920.GA13356@sigill.intra.peff.net>
 <xmqqeg8fs0dw.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 01:16:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8bqr-0001iX-Ol
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 01:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161245AbcFBXQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 19:16:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:48123 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161088AbcFBXQX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 19:16:23 -0400
Received: (qmail 9651 invoked by uid 102); 2 Jun 2016 23:16:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 19:16:22 -0400
Received: (qmail 15414 invoked by uid 107); 2 Jun 2016 23:16:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 19:16:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2016 19:16:20 -0400
Content-Disposition: inline
In-Reply-To: <xmqqeg8fs0dw.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296260>

On Thu, Jun 02, 2016 at 03:15:39PM -0700, Junio C Hamano wrote:

> When your $PWD does not match $(/bin/pwd), e.g. you have your copy
> of the git source tree in one place, point it with a symbolic link,
> and then "cd" to that symbolic link before running 'make test', one
> of the tests in t1308 expects that the per-user configuration was
> reported to have been read from the true path (i.e. relative to the
> target of such a symbolic link), but the test-config program reports
> a path relative to $PWD (i.e. the symbolic link).
> 
> Instead, expect a path relative to $HOME (aka $TRASH_DIRECTORY), as
> per-user configuration is read from $HOME/.gitconfig and the test
> framework sets these shell variables up in such a way to avoid this
> problem.

Looks good.

  Acked-by: Jeff King <peff@peff.net>

To prevent this in the future, I switched my default --root= to point to
a symlink. I wonder if we could do something in the test suite, though,
as we did long ago by introducing "trash directory" with a space to
catch corner cases.

I guess it would be something like:

  if test_have_prereq SYMLINKS
  then
	mkdir "$TRASH_DIRECTORY.real" &&
	ln -s "$TRASH_DIRECTORY.real" "$TRASH_DIRECTORY"
  else
	mkdir "$TRASH_DIRECTORY"
  fi

but there may be some other tweaks required (e.g., for cleanup).

-Peff
