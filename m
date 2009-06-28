From: Jeff King <peff@peff.net>
Subject: Re: git mailinfo strips important context from patch subjects
Date: Sun, 28 Jun 2009 16:02:59 -0400
Message-ID: <20090628200259.GB8828@sigio.peff.net>
References: <20090628193858.GA29467@codelibre.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Sun Jun 28 22:01:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ML0Z0-0007JO-ED
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 22:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbZF1UBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 16:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbZF1UBN
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 16:01:13 -0400
Received: from peff.net ([208.65.91.99]:39756 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888AbZF1UBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 16:01:06 -0400
Received: (qmail 8846 invoked by uid 1000); 28 Jun 2009 20:02:59 -0000
Content-Disposition: inline
In-Reply-To: <20090628193858.GA29467@codelibre.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122419>

On Sun, Jun 28, 2009 at 08:38:58PM +0100, Roger Leigh wrote:

> In most of the projects I work on, the git commit message has
> the affected subsystem or component in square brackets, such as
> 
>   [foo] change bar to baz
>
> [...]
>
> The [sbuild] prefix has been dropped from the Subject, so an
> important bit of context about the patch has been lost.
> 
> It's a bit of a bug that you can't round trip from a git-format-patch
> to import with git-am and then not be able to produce the exact same
> patch set with git-format-patch again (assuming preparing and applying
> to the same point, of course).

As an immediate solution, you probably want to use "-k" when generating
the patch (not to add the [PATCH] munging) and "-k" when reading the
patch via "git am" (which will avoid trying to strip any munging).

However:

> Would it be possible to change the git-mailinfo logic to use a less
> greedy pattern match so it leaves everything after
> ([PATCH( [0-9/])+])+ in the subject?  AFAICT this is cleanup_subject in
> builtin-mailinfo.c?  Could this rather complex function not just do a
> simple regex match which can also take care of stripping ([Rr]e:) ?

Yes, I think in the long run it makes sense to strip just the _first_
set of brackets. I don't think we want to be more specific than that in
the match, because we allow arbitrary cruft inside the brackets (like
"[RFC/PATCH]", etc). But if format-patch always puts exactly one set of
brackets, and am strips exactly one set, then that should retain your
subject in practice, even if it starts with [foo].

-Peff
