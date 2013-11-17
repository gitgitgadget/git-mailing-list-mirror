From: Jeff King <peff@peff.net>
Subject: Re: Symbolic refs break ref advertisement on 1.8.4.3+
Date: Sun, 17 Nov 2013 05:02:51 -0500
Message-ID: <20131117100251.GB22166@sigill.intra.peff.net>
References: <CAGyf7-EX2QXKyAwoxv2Ux5cjSp71m-dR+Vq4C3pevJrYaGu42g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Sun Nov 17 11:02:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhzBx-0003xP-DM
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 11:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab3KQKCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 05:02:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:40774 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752442Ab3KQKCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 05:02:52 -0500
Received: (qmail 15928 invoked by uid 102); 17 Nov 2013 10:02:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Nov 2013 04:02:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Nov 2013 05:02:51 -0500
Content-Disposition: inline
In-Reply-To: <CAGyf7-EX2QXKyAwoxv2Ux5cjSp71m-dR+Vq4C3pevJrYaGu42g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237959>

On Sun, Nov 17, 2013 at 01:39:52AM +1100, Bryan Turner wrote:

> Aphrael:example bturner$ for ((i=1;i<21;i++)); do git symbolic-ref
> refs/heads/syms/$i refs/heads/master; done
> Aphrael:example bturner$ git ls-remote .
> fatal: protocol error: impossibly long line
> fatal: Could not read from remote repository.
> 
> A symref= entry is written into the first packet of the ref
> advertisement, right after the capabilities, for each symbolic ref in
> the repository. Unfortunately, no splitting is done on that value and
> so once you have 15-20 symbolic refs (more or less depending on path
> lengths), you blow the 996 byte limit in format_packet (pkt-line.c)
> and all further clone/fetch operations fail.

Ick, yeah. I don't think there is a way around that with the way the
information is shoe-horned into the protocol.  We should probably just
revert 5e7dcad (upload-pack: send non-HEAD symbolic refs, 2013-09-17),
and assume the HEAD branch name is short enough to fit.

Another option would be to cap the number of non-HEAD symrefs we'd send
(by counting up the bytes and keeping below the limit). That at least
makes the "easy" cases work, but it's a bit too flaky for my taste.

-Peff
