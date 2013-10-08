From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] parse_commit cleanups
Date: Tue, 8 Oct 2013 09:48:43 -0400
Message-ID: <20131008134843.GA7530@sigill.intra.peff.net>
References: <20131006044856.GA12301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 09 18:37:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTwle-0001zL-Ip
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 18:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912Ab3JIQhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 12:37:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:46336 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754164Ab3JIQhS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 12:37:18 -0400
Received: (qmail 21464 invoked by uid 102); 8 Oct 2013 13:48:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Oct 2013 08:48:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Oct 2013 09:48:43 -0400
Content-Disposition: inline
In-Reply-To: <20131006044856.GA12301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235826>

On Sun, Oct 06, 2013 at 12:48:56AM -0400, Jeff King wrote:

> Instead of a segfault, let's print an error message and die
> a little more gracefully.
> [...]
> ---
> Not a huge deal, since we are terminating the program either way. There
> are other places in the code with a bare parse_commit that could
> probably use the same treatment. I didn't investigate them, but they
> could easily build on the parse_commit_or_die here if somebody wants to
> follow up.

Here are some follow-up patches that go on top. The first two are noop
cleanups. The third and fourth are not strictly noops, but are minor
behavior changes that should be strict improvements.

There are a number of unchecked parse_commit calls whose fallout is more
complicated. In many cases, we want to ignore an error (keeping in mind
that parse_commit will already have printed a message to stderr) and
keep going, in order to allow users to to get as much done as they can
in a broken repository.

The fifth patch deals with one of these cases. There are 8 more
unchecked calls after this series, some of which may want to die(), or
may want to be left alone; I didn't investigate deeply.

There are also some cases where we do not die, but perhaps should. In
general, I think it makes sense to let fetch-pack and rev-list work
around broken history, but probably not things like blame, which would
then provide subtly wrong answers. Still, I doubt it's a big deal in
practice, since corrupted repositories are relatively rare (and the
message to stderr does inform the user that something is wrong).

  [1/5]: assume parse_commit checks commit->object.parsed
  [2/5]: assume parse_commit checks for NULL commit
  [3/5]: use parse_commit_or_die instead of segfaulting
  [4/5]: use parse_commit_or_die instead of custom message
  [5/5]: checkout: do not die when leaving broken detached HEAD

-Peff
