From: Jeff King <peff@peff.net>
Subject: Re: BUG: "git checkout" displays Q-escaped commit titles
Date: Fri, 2 May 2008 10:05:36 -0400
Message-ID: <20080502140536.GA3518@sigill.intra.peff.net>
References: <20080502133903.GA3079@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Fri May 02 16:07:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrvuO-000840-D3
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 16:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933745AbYEBOFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 10:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933751AbYEBOFi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 10:05:38 -0400
Received: from peff.net ([208.65.91.99]:4977 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760710AbYEBOFh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 10:05:37 -0400
Received: (qmail 6600 invoked by uid 111); 2 May 2008 14:05:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 May 2008 10:05:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 May 2008 10:05:36 -0400
Content-Disposition: inline
In-Reply-To: <20080502133903.GA3079@mithlond.arda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81000>

On Fri, May 02, 2008 at 04:39:03PM +0300, Teemu Likonen wrote:

> When commit message's first line (i.e. the title) contains non-Ascii
> characters "git checkout <commit>" displays this title in Q-escaped form
> which looks something like this: =?utf-8?q?=C3=84=C3=A4kk=C3=B6si=C3=A4?=

Definitely a bug. This patch fixes it, but I'm not sure it's the best
solution. It seems like pp_title_line should perhaps just be checking
for fmt == CMIT_FMT_EMAIL, but I'm not sure if that would break anything
else, and I don't have time to investigate further right now.

-- >8 --
checkout: don't rfc2047-encode oneline on detached HEAD

When calling pretty_print_commit, there is an implicit
assumption that passing in a non-NULL "subject" variable
for oneline or email formats means that the output is part
of a subject and therefore "subject" to rfc2047 encoding.
This is not the desired effect when reporting the movement
of detached HEAD.
---
 builtin-checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 14b2fe7..10ec137 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -142,7 +142,7 @@ static void describe_detached_head(char *msg, struct commit *commit)
 	struct strbuf sb;
 	strbuf_init(&sb, 0);
 	parse_commit(commit);
-	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, 0, "", "", 0, 0);
+	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, 0, NULL, NULL, 0, 0);
 	fprintf(stderr, "%s %s... %s\n", msg,
 		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV), sb.buf);
 	strbuf_release(&sb);
-- 
1.5.5.1.221.ga481
