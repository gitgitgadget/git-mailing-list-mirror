From: Jeff King <peff@peff.net>
Subject: Re: speed of git reset -- file
Date: Tue, 31 May 2011 17:26:39 -0400
Message-ID: <20110531212639.GA13234@sigill.intra.peff.net>
References: <20110531190015.GA12113@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue May 31 23:26:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRWSd-0003rl-JY
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 23:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543Ab1EaV0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 17:26:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34851
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932529Ab1EaV0m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 17:26:42 -0400
Received: (qmail 32510 invoked by uid 107); 31 May 2011 21:26:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 May 2011 17:26:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2011 17:26:39 -0400
Content-Disposition: inline
In-Reply-To: <20110531190015.GA12113@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174829>

On Tue, May 31, 2011 at 03:00:15PM -0400, Joey Hess wrote:

> I'd expect that resetting a single file would need to update the index,
> reading some objects from .git to do it.
> 
> But according to strace, it also stats every file in the working tree.
> I have lots of files, and so that is very slow. Is it really necessary?

Conceptually, no, I don't think so. But remember that your "file" is not
really a file at all, but a pathspec that may match many entries. Also,
we try not to overwrite things that would not be changed. So that
complicates it a little bit.

You can see the implementation in builtin/reset.c:read_from_tree. We
actually diff the tree (e.g., HEAD) against the index, and update only
the differences. Unfortunately this seems to trash the index (see the
comment there), and we end up having to refresh it. I'm not sure how
avoidable that trashing is. I think we're getting deep into how
unpack_trees works, and it handles a lot more cases than just "unpack a
few entries". So I don't know how easy it would be to separate this
relatively simple case from more complex ones.

-Peff
