From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] describe/name-rev: tell name-rev to peel the
 incoming object to commit first
Date: Tue, 9 Jul 2013 01:06:15 -0400
Message-ID: <20130709050615.GF27903@sigill.intra.peff.net>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
 <1373236424-25617-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 07:06:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwQ8G-000738-22
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 07:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab3GIFGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 01:06:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:35548 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab3GIFGS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 01:06:18 -0400
Received: (qmail 3461 invoked by uid 102); 9 Jul 2013 05:07:34 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 00:07:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 01:06:15 -0400
Content-Disposition: inline
In-Reply-To: <1373236424-25617-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229909>

On Sun, Jul 07, 2013 at 03:33:44PM -0700, Junio C Hamano wrote:

> With this on top of the other patches in this series, you would get:
> 
>     $ git describe --contains $(git rev-parse v1.8.3 v1.8.3^0)
>     v1.8.3
>     v1.8.3
> 
> while you can still differentiate tags and the commits they point at
> with:
> 
>     $ git name-rev --refs=tags/\* --name-only $(git rev-parse v1.8.3 v1.8.3^0)
>     v1.8.3
>     v1.8.3^0
> 
> The difference in these two behaviours is achieved by adding --peel-to-commit
> option to "name-rev" and using it when "describe" internally calls it.

I am somewhat mixed on this.

You are changing the default behavior of name-rev and adding a new
option to restore it, so I wonder who (if anyone) might be broken. The
documentation is now also out of date; not only does it not mention
"peel-to-commit", but it claims the argument to name-rev is a
committish, which is not really true without that option.

On the other hand, the new default behavior seems way more sane to me.
In general, I would expect name-rev to:

  1. Behave more or less the same between "git name-rev $sha1" and "echo
     $sha1 | git name-rev --stdin". Your patch improves that. Though I
     note that --peel-to-commit does not affect --stdin at all. Should
     it? And of course the two differ in that the command line will take
     any rev-parse expression, and --stdin only looks for full sha1s.

  2. If name-rev prints "$X $Y", I would expect "git rev-parse $X" to
     equal "git rev-parse $Y". With peeling, that is not the case, and
     you get the misleading example that Ram showed:

       $ git name-rev 8af0605
       8af0605 tags/v1.8.3^0

    or more obviously weird:

       $ git name-rev v1.8.3
       v1.8.3 tags/v1.8.3^0

So I think your series moves in a good direction, but I would just worry
that it is breaking backwards compatibility (but like I said, I am not
clear on who is affected and what it means for them).

-Peff
