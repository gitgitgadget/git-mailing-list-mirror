From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] show: add space between tag body and tagged object
Date: Fri, 17 Jul 2009 19:22:28 -0400
Message-ID: <20090717232227.GB13624@coredump.intra.peff.net>
References: <20090717231622.GA13511@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 01:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRwlE-0005Yr-1v
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 01:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbZGQXWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 19:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbZGQXWd
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 19:22:33 -0400
Received: from peff.net ([208.65.91.99]:43841 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667AbZGQXWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 19:22:32 -0400
Received: (qmail 29724 invoked by uid 107); 17 Jul 2009 23:24:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Jul 2009 19:24:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jul 2009 19:22:28 -0400
Content-Disposition: inline
In-Reply-To: <20090717231622.GA13511@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123497>

When showing an annotated tag, "git show" will always
display the pointed-to object. However, it didn't separate
the two with whitespace, making it more difficult to notice
where the new object started. For example:

  $ git tag -m 'my message' foo
  $ git show foo
  tag foo
  Tagger: Jeff King <peff@peff.net>
  Date:   Fri Jul 17 18:46:25 2009 -0400

  my message
  commit 41cabf8fed2694ba33e01d64f9094f2fc5e5805a
  Author: Jeff King <peff@peff.net>
  Date:   Thu Jul 16 17:31:34 2009 -0400
  ...

This patch adds a blank line between "my message" and
"commit 41c...", making it easier to read.

Signed-off-by: Jeff King <peff@peff.net>
---
I was tempted to add logic for "put a blank line separator between each
two items printed by git show", instead of just tags. But:

  - commits already do that (e.g., "git show HEAD HEAD^" looks fine)

  - blobs don't do it, but you probably don't want them to. I don't know
    why you would really do "git show HEAD:foo HEAD:bar", but you could,
    and I would expect it to concatenate them without extra data.

Trees don't do it, so if you "git show HEAD^{tree} HEAD^{tree}" there is
no separator. Maybe that is worth fixing separately, but I find it
unlikely for somebody to do that. Annotated tags are the much more
common case, because you always get two objects displayed.

 builtin-log.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index b05796d..d3e4d1a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -342,6 +342,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					    sha1_to_hex(t->tagged->sha1));
 			objects[i].item = o;
 			i--;
+			putchar('\n');
 			break;
 		}
 		case OBJ_TREE:
-- 
1.6.4.rc1.174.g317bf.dirty
