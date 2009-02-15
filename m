From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] refactor find_refs_by_name to accept const list
Date: Sun, 15 Feb 2009 01:12:39 -0500
Message-ID: <20090215061239.GC30414@coredump.intra.peff.net>
References: <20090215060815.GA7473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 07:14:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYaGW-0005P6-Sn
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 07:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbZBOGMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 01:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbZBOGMl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 01:12:41 -0500
Received: from peff.net ([208.65.91.99]:41097 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbZBOGMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 01:12:41 -0500
Received: (qmail 5398 invoked by uid 107); 15 Feb 2009 06:13:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 01:13:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 01:12:39 -0500
Content-Disposition: inline
In-Reply-To: <20090215060815.GA7473@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109968>

Since it doesn't actually touch its argument, this makes
sense.

However, we still want to return a non-const version (which
requires a cast) so that this:

  struct ref *a, *b;
  a = find_ref_by_name(b);

works. Unfortunately, you can also silently strip the const
from a variable:

  struct ref *a;
  const struct ref *b;
  a = find_ref_by_name(b);

This is a classic C const problem because there is no way to
say "return the type with the same constness that was passed
to us"; we provide the same semantics as standard library
functions like strchr.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |    2 +-
 refs.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 7f1a6e8..ba6c070 100644
--- a/cache.h
+++ b/cache.h
@@ -801,7 +801,7 @@ struct ref {
 #define REF_HEADS	(1u << 1)
 #define REF_TAGS	(1u << 2)
 
-extern struct ref *find_ref_by_name(struct ref *list, const char *name);
+extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
 
 #define CONNECT_VERBOSE       (1u << 0)
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
diff --git a/refs.c b/refs.c
index 6eb5f53..b2a37e1 100644
--- a/refs.c
+++ b/refs.c
@@ -1628,10 +1628,10 @@ int update_ref(const char *action, const char *refname,
 	return 0;
 }
 
-struct ref *find_ref_by_name(struct ref *list, const char *name)
+struct ref *find_ref_by_name(const struct ref *list, const char *name)
 {
 	for ( ; list; list = list->next)
 		if (!strcmp(list->name, name))
-			return list;
+			return (struct ref *)list;
 	return NULL;
 }
-- 
1.6.2.rc0.256.gf004c.dirty
