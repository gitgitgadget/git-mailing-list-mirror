From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] clone: use computed length in guess_dir_name
Date: Wed, 5 Aug 2015 04:39:46 -0400
Message-ID: <20150805083945.GB28212@sigill.intra.peff.net>
References: <20150805083526.GA22325@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 10:39:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMuEv-00005w-Av
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 10:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbbHEIjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 04:39:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:40998 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751132AbbHEIju (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 04:39:50 -0400
Received: (qmail 21391 invoked by uid 102); 5 Aug 2015 08:39:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 03:39:50 -0500
Received: (qmail 27269 invoked by uid 107); 5 Aug 2015 08:39:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 04:39:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2015 04:39:46 -0400
Content-Disposition: inline
In-Reply-To: <20150805083526.GA22325@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275355>

Commit 7e837c6 (clone: simplify string handling in
guess_dir_name(), 2015-07-09) changed clone to use
strip_suffix instead of hand-rolled pointer manipulation.
However, strip_suffix will strip from the end of a
NUL-terminated string, and we may have already stripped some
characters (like directory separators, or "/.git"). This
leads to commands like:

  git clone host:foo.git/

failing to strip the ".git".

We must instead convert our pointer arithmetic into a
computed length and feed that to strip_suffix_mem, which will
then reduce the length further for us.

It would be nicer if we could drop the pointer manipulation
entirely, and just continually strip using strip_suffix. But
that doesn't quite work for two reasons:

  1. The early suffixes we're stripping are not constant; we
     need to look for is_dir_sep, which could be one of
     several characters.

  2. Mid-way through the stripping we compute the pointer
     "start", which shows us the beginning of the pathname.
     Which really give us two lengths to work with: the
     offset from the start of the string, and from the start
     of the path. By using pointers for the early part, we
     can just compute the length from "start" when we need
     it.

Signed-off-by: Jeff King <peff@peff.net>
---
I suspect you _could_ clean up this logic further, but I
really wanted to do the minimal fix for the regression.
Especially because Patrick is hopefully going to sweep
through and make it all more robust soon enough. :)

 builtin/clone.c          | 3 ++-
 t/t5603-clone-dirname.sh | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 303a3a7..bf45199 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -174,7 +174,8 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	/*
 	 * Strip .{bundle,git}.
 	 */
-	strip_suffix(start, is_bundle ? ".bundle" : ".git" , &len);
+	len = end - start;
+	strip_suffix_mem(start, &len, is_bundle ? ".bundle" : ".git");
 
 	if (is_bare)
 		dir = xstrfmt("%.*s.git", (int)len, start);
diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index a0140b9..46725b9 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -46,7 +46,7 @@ test_clone_dir host:foo foo.git bare
 test_clone_dir host:foo.git foo
 test_clone_dir host:foo.git foo.git bare
 test_clone_dir host:foo/.git foo
-test_clone_dir host:foo/.git foo.git bare fail
+test_clone_dir host:foo/.git foo.git bare
 
 # similar, but using ssh URL rather than host:path syntax
 test_clone_dir ssh://host/foo foo
@@ -54,11 +54,11 @@ test_clone_dir ssh://host/foo foo.git bare
 test_clone_dir ssh://host/foo.git foo
 test_clone_dir ssh://host/foo.git foo.git bare
 test_clone_dir ssh://host/foo/.git foo
-test_clone_dir ssh://host/foo/.git foo.git bare fail
+test_clone_dir ssh://host/foo/.git foo.git bare
 
 # we should remove trailing slashes
 test_clone_dir ssh://host/foo/ foo
-test_clone_dir ssh://host/foo.git/ foo fail
+test_clone_dir ssh://host/foo.git/ foo
 test_clone_dir ssh://host/foo/.git/ foo
 
 # omitting the path should default to the hostname
-- 
2.5.0.148.g63828c1
