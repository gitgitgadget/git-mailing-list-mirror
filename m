From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] prune-packed: fix a possible buffer overflow
Date: Wed, 18 Dec 2013 19:04:15 -0500
Message-ID: <20131219000415.GA17420@sigill.intra.peff.net>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
 <1387287838-25779-2-git-send-email-mhagger@alum.mit.edu>
 <CACsJy8DVc4soBrS1RbTLv93b5rere3htyL1DjRw=UcT4zVN9FA@mail.gmail.com>
 <xmqqd2kvmi85.fsf@gitster.dls.corp.google.com>
 <52B2256A.3060802@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 19 01:04:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtR6E-0004hK-DZ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 01:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528Ab3LSAES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 19:04:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:47007 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750975Ab3LSAER (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 19:04:17 -0500
Received: (qmail 16251 invoked by uid 102); 19 Dec 2013 00:04:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Dec 2013 18:04:17 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Dec 2013 19:04:15 -0500
Content-Disposition: inline
In-Reply-To: <52B2256A.3060802@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239501>

On Wed, Dec 18, 2013 at 11:44:58PM +0100, Michael Haggerty wrote:

> [While doing so, I got sidetracked by the question: what happens if a
> prune process deletes the "objects/XX" directory just the same moment
> that another process is trying to write an object into that directory?
> I think the relevant function is sha1_file.c:create_tmpfile().  It looks
> like there is a nonzero but very small race window that could result in
> a spurious "unable to create temporary file" error, but even then I
> don't think there would be any corruption or anything.]

There's a race there, but I think it's hard to trigger.

Our strategy with object creation is to call open, recognize ENOENT,
mkdir, and then try again. If the rmdir happens before our call to open,
then we're fine. If open happens first, then the rmdir will fail.

But we don't loop on ENOENT. So if the rmdir happens in the middle,
after the mkdir but before we call open again, we'd fail, because we
don't treat ENOENT specially in the second call to open. That is
unlikely to happen, though, as prune would not be removing a directory
it did not just enter and clean up an object from (in which case we
would not have gotten the first ENOENT in the creator). I think you'd So
you'd have to have something creating and then pruning the directory in
the time between our open and mkdir. It would probably be more likely to
see it if you had two prunes running (the first one kills the directory,
creator notices and calls mkdir, then the second prune kills the
directory, too).

So it seems unlikely and the worst case is a temporary failure, not a
corruption. It's probably not worth caring too much about, but we could
solve it pretty easily by looping on ENOENT on creation.

On a similar note, I imagine that a simultaneous "branch foo/bar" and
"branch -d foo/baz" could race over the creation/deletion of
"refs/heads/foo", but I didn't look into it.

-Peff
