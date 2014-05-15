From: Jeff King <peff@peff.net>
Subject: [PATCH] open_sha1_file: report "most interesting" errno
Date: Thu, 15 May 2014 04:54:06 -0400
Message-ID: <20140515085405.GA27033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 10:54:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkrQe-0004r3-0F
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 10:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbaEOIyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 04:54:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:52073 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752059AbaEOIyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 04:54:08 -0400
Received: (qmail 21347 invoked by uid 102); 15 May 2014 08:54:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 03:54:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 04:54:06 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249075>

When we try to open a loose object file, we first attempt to
open in the local object database, and then try any
alternates. This means that the errno value when we return
will be from the last place we looked (and due to the way
the code is structured, simply ENOENT if we do not have have
any alternates).

This can cause confusing error messages, as read_sha1_file
checks for ENOENT when reporting a missing object. If errno
is something else, we report that. If it is ENOENT, but
has_loose_object reports that we have it, then we claim the
object is corrupted. For example:

    $ chmod 0 .git/objects/??/*
    $ git rev-list --all
    fatal: loose object b2d6fab18b92d49eac46dc3c5a0bcafabda20131 (stored in .git/objects/b2/d6fab18b92d49eac46dc3c5a0bcafabda20131) is corrupt

This patch instead keeps track of the "most interesting"
errno we receive during our search. We consider ENOENT to be
the least interesting of all, and otherwise report the first
error found (so problems in the object database take
precedence over ones in alternates). Here it is with this
patch:

    $ git rev-list --all
    fatal: failed to read object b2d6fab18b92d49eac46dc3c5a0bcafabda20131: Permission denied

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3e9f55f..34d527f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1437,19 +1437,23 @@ static int open_sha1_file(const unsigned char *sha1)
 {
 	int fd;
 	struct alternate_object_database *alt;
+	int most_interesting_errno;
 
 	fd = git_open_noatime(sha1_file_name(sha1));
 	if (fd >= 0)
 		return fd;
+	most_interesting_errno = errno;
 
 	prepare_alt_odb();
-	errno = ENOENT;
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		fill_sha1_path(alt->name, sha1);
 		fd = git_open_noatime(alt->base);
 		if (fd >= 0)
 			return fd;
+		if (most_interesting_errno == ENOENT)
+			most_interesting_errno = errno;
 	}
+	errno = most_interesting_errno;
 	return -1;
 }
 
-- 
2.0.0.rc1.436.g03cb729
