From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add a 'source' decorator for commits
Date: Tue, 28 Oct 2008 01:45:40 -0400
Message-ID: <20081028054539.GA23195@sigill.intra.peff.net>
References: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271305500.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271306230.3386@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 06:47:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuhPv-0005eG-IT
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 06:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbYJ1Fpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 01:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbYJ1Fpq
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 01:45:46 -0400
Received: from peff.net ([208.65.91.99]:4858 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186AbYJ1Fpp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 01:45:45 -0400
Received: (qmail 17995 invoked by uid 111); 28 Oct 2008 05:45:42 -0000
Received: from c-98-207-159-21.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (98.207.159.21)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 01:45:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 01:45:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810271306230.3386@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99276>

On Mon, Oct 27, 2008 at 01:07:10PM -0700, Linus Torvalds wrote:

> We already support decorating commits by tags or branches that point to
> them, but especially when we are looking at multiple branches together,
> we sometimes want to see _how_ we reached a particular commit.

I think this is a cool feature, but I have a few questions/complaints:

  - Does it make sense to have this _in addition_ to --decorate (since
    for any commit with a --decorate field, it would likely be the same
    as --source)? Should it be a different type of decorate instead,
    like --decorate=source or --decorate=branch?

  - Should this be triggered by the "%d" --pretty=format specifier? This
    two-liner:

diff --git a/pretty.c b/pretty.c
index f6ff312..bdaad19 100644
--- a/pretty.c
+++ b/pretty.c
@@ -487,6 +487,8 @@ static void format_decoration(struct strbuf *sb, const struct commit *commit)
 	const char *prefix = " (";
 
 	load_ref_decorations();
+	if (commit->util)
+		printf("%s", (char *)commit->util);
 	d = lookup_decoration(&name_decoration, &commit->object);
 	while (d) {
 		strbuf_addstr(sb, prefix);

    works, but:

      - it doesn't check revs->show_source, so is it possible that
        commit->util is being used for something else?

      - using '%d' automatically turns on --decorate, so you end up with
        both the --source and --decorate values. More sensible semantics
        would be "%d turns on --decorate, unless you have done
        --decorate=<explicit format>".

        Alternatively, this should just be "%b" or "%S".

  - If you don't specify --all, you just get "HEAD" for everything.
    Which makes sense when you consider the implementation, but I think
    is probably a bit confusing for users.

> Of course, if the commit is reachable through multiple sources (which is
> common), our particular choice of "first" reachable is entirely random
> and depends on the particular path we happened to follow.

Hmm. It would be nice to keep even a simple counter to get a "distance"
from the ref and choose the one with the smallest distance (I think we
can get away without the complex rules that git-describe uses, since we
are not interested in describing the full commit, but rather finding a
"likely" branch).

However, that would require making multiple passes over the commit
graph, which might impact the startup speed.

-Peff
