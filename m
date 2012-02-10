From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Remove empty ref directories while reading loose refs
Date: Fri, 10 Feb 2012 15:53:30 -0500
Message-ID: <20120210205330.GE5504@sigill.intra.peff.net>
References: <1328891127-17150-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 21:53:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvxTP-0001kk-Cn
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 21:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488Ab2BJUxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 15:53:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33546
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932214Ab2BJUxc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 15:53:32 -0500
Received: (qmail 7655 invoked by uid 107); 10 Feb 2012 21:00:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Feb 2012 16:00:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2012 15:53:30 -0500
Content-Disposition: inline
In-Reply-To: <1328891127-17150-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190453>

On Fri, Feb 10, 2012 at 11:25:27PM +0700, Nguyen Thai Ngoc Duy wrote:

> Empty directories in $GIT_DIR/refs increases overhead at startup.
> Removing a ref does not remove its parent directories even if it's the
> only file left so empty directories will be hanging around.
> [...]
> This patch removes empty directories as we see while traversing
> $GIT_DIR/refs and reverts be7c6d4 because it's no longer needed.

It feels wrong to me to be writing to the repository during what would
otherwise be a read-only operation. Especially without locking. Doesn't
this create a race condition with:

  git update-ref refs/foo/bar $sha1 &      (a)
  git for-each-ref                         (b)

if you have this sequence of events:

  1. (a) wants to create the ref, so it must first mkdir
     ".git/refs/foo".

  2. (b) is reading refs and notices the empty "foo" directory. It
     rmdirs it.

  3. (a) now attempts to create "bar" inside the newly created "foo"
     directory. This fails, because the directory does not exist.

A similar race already can happen with:

  git update-ref refs/foo/bar $sha1 &
  git update-ref refs/foo $sha1

since the latter will remove a stale "foo" directory before it can
create the new ref file.  But that race is OK, I think. Those are both
write operations, and one of them _must_ fail, because they are in
conflict (and I think even with the race they fail gracefully, with the
latter one "winning").

> pack-refs was taught of cleaning up empty directories in be7c6d4
> (pack-refs: remove newly empty directories - 2010-07-06), but it only
> checks parent directories of packed refs only. Already empty dirs are
> left untouched.

I'd much rather have pack-refs simply learn to remove all stale
directories. We at least know that "gc" is a slightly riskier operation.

-Peff
