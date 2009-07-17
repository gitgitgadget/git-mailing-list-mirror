From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] show: suppress extra newline when showing annotated tag
Date: Fri, 17 Jul 2009 19:18:34 -0400
Message-ID: <20090717231834.GA13624@coredump.intra.peff.net>
References: <20090717231622.GA13511@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 01:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRwhS-0004Rd-3U
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 01:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbZGQXSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 19:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbZGQXSj
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 19:18:39 -0400
Received: from peff.net ([208.65.91.99]:39286 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbZGQXSj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 19:18:39 -0400
Received: (qmail 29675 invoked by uid 107); 17 Jul 2009 23:20:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Jul 2009 19:20:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jul 2009 19:18:34 -0400
Content-Disposition: inline
In-Reply-To: <20090717231622.GA13511@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123496>

When showing a tag, our header parsing finishes with the
offset pointing to the newline separating the tag header
from the tag body. This means that the printed body will
always start with a newline.

However, we also add an extra newline when printing the
tagger information. This leads to an ugly double-newline:

    $ git show v1.6.3
    tag v1.6.3
    Tagger: Junio C Hamano <gitster@pobox.com>
    Date:   Wed May 6 18:16:47 2009 -0700

    GIT 1.6.3
    -----BEGIN PGP SIGNATURE-----
    ...

This patch removes the extra newline from the end of the
tagger headers. This is a better solution than suppressing
the separator newline, because it retains the behavior for
tags which have no tagger. E.g., "git show v0.99" will
continue to look like:

      $ git show v0.99
      tag v0.99

      Test-release for wider distribution.
      ...

Signed-off-by: Jeff King <peff@peff.net>
---
I tried to consider the output for real-world cases. In theory, you
could have a corrupted tag with not only no body, but no newline
separator. Then it would display as:

  tag foo
  commit ...

with no extra newline. But since nothing should be generating such a
tag, I don't think it is a problem.

 builtin-log.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 0c2fa0a..b05796d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -257,7 +257,7 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
 	pp_user_info("Tagger", rev->commit_format, &out, buf, rev->date_mode,
 		git_log_output_encoding ?
 		git_log_output_encoding: git_commit_encoding);
-	printf("%s\n", out.buf);
+	printf("%s", out.buf);
 	strbuf_release(&out);
 }
 
-- 
1.6.4.rc1.174.g317bf.dirty
