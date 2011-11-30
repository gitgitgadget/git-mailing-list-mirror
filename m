From: Jeff King <peff@peff.net>
Subject: Re: log: option "--follow" not the default for a single file?
Date: Wed, 30 Nov 2011 01:37:43 -0500
Message-ID: <20111130063743.GB5317@sigill.intra.peff.net>
References: <CAN0XMOJsiw0c4j_LooRrj80CVVy0omGLUcjDg4QoD4mNS3y1GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 07:37:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVdni-0002ey-UP
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 07:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450Ab1K3Ghq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 01:37:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55992
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873Ab1K3Ghq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 01:37:46 -0500
Received: (qmail 7698 invoked by uid 107); 30 Nov 2011 06:44:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Nov 2011 01:44:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2011 01:37:43 -0500
Content-Disposition: inline
In-Reply-To: <CAN0XMOJsiw0c4j_LooRrj80CVVy0omGLUcjDg4QoD4mNS3y1GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186107>

On Tue, Nov 29, 2011 at 07:25:47PM +0100, Ralf Thielow wrote:

> Why is the option "--follow" not the default if the log-command
> is used with a single file? Many GUI tools don't show me the
> full history of a single file if there was a rename in it.

A few reasons, I think:

  1. There is no such thing as giving log a single file. You give it a
     pathspec. That may happen to match a single file in the current
     revision, but to git it is actually a prefix-limiting pattern, and
     "git log foo" will match "foo" if it is a file, or "foo/bar" if it
     was a directory in a previous revision.

  2. It can be slower than a regular traversal, since we have to do
     rename detection whenever we see a deletion. In practice I don't
     think it is much slower, though (mainly because files don't get
     moved all that much).

  3. The implementation is a bit hacky.  In particular, things like
     history simplification and parent rewriting won't work. So a
     GUI tool that tries to draw a graph will make a very ugly graph.

     Try looking at "gitk $file" and then "gitk --follow $file" in some
     repository (if you don't have gitk, try "git log --graph
     --oneline"). Even with a linear history, things look ugly: there
     are big gaps in the graph. But in a branch-y history, it's
     downright unreadable, as you have parallel disconnected lines of
     history next to each other.

I think (1) and (3) are fixable by improving the implementation (making
--follow respect pathspecs and not single files, and having it work at
the history-simplification level). And then you might argue that (2)
isn't a big deal, and we can turn on --follow all the time.

-Peff
