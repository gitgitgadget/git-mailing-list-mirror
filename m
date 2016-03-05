From: Jeff King <peff@peff.net>
Subject: [PATCH 0/6] avoid touching ref code in non-repositories
Date: Sat, 5 Mar 2016 17:08:29 -0500
Message-ID: <20160305220829.GA31316@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 23:08:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acKNI-0006TO-TC
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 23:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbcCEWId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 17:08:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:55297 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750781AbcCEWIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 17:08:32 -0500
Received: (qmail 12871 invoked by uid 102); 5 Mar 2016 22:08:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:08:31 -0500
Received: (qmail 12050 invoked by uid 107); 5 Mar 2016 22:08:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:08:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2016 17:08:29 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288328>

Here's the series I mentioned earlier, to avoid avoid accessing the ref
code if we know we aren't in a repository. For those just joining us,
the end goal is to be able to detect and complain when code tries to
open a ref without having run check_repository_format() or similar. Once
we have pluggable ref backends, doing so would be wrong, since we won't
know which backend we're supposed to be using.

It's already _kind of_ wrong, in the sense that we should not be looking
for file-backend refs if we know we don't have a repository. But nobody
really noticed in practice, because you do not generally have
".git/HEAD" lying around in non-repository directories. So it was a de
facto noop, though you could construct pathological cases where it did
the wrong thing.

The patches are:

  [1/6]: setup: make startup_info available everywhere
  [2/6]: setup: set startup_info->have_repository more reliably
  [3/6]: remote: don't resolve HEAD in non-repository
  [4/6]: mailmap: do not resolve blobs in a non-repository
  [5/6]: grep: turn off gitlink detection for --no-index
  [6/6]: use setup_git_directory() in test-* programs

There's a sort-of "7/6" I used to find these spots:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 81f68f8..22c1b6d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -947,6 +947,8 @@ static struct ref_cache *lookup_ref_cache(const char *submodule)
 {
 	struct ref_cache *refs;
 
+	assert(startup_info->have_repository);
+
 	if (!submodule || !*submodule)
 		return &ref_cache;
 
@@ -1414,6 +1416,8 @@ static const char *resolve_ref_1(const char *refname,
 	int depth = MAXDEPTH;
 	int bad_name = 0;
 
+	assert(startup_info->have_repository);
+
 	if (flags)
 		*flags = 0;
 

Running the test suite with that patch and 1/6 turned up the cases I've
fixed here. But I'm not including it here for a few reasons:

  1. I'm not sure that asserting is the best behavior. It's great for
     finding problems (and that's why I used assert() -- to get a
     coredump for the backtrace), but in practice it might be friendlier
     to turn it into a silent noop ("no, I don't even have a ref
     backend, so your ref definitely does not exist").

  2. In a pluggable ref-backend world, this isn't where we'd put the
     asserts, anyway. We'd do it when accessing the ref_backend vtable
     (or just starting with a dummy vtable that asserts, or returns
     "nope, no refs", or whatever).

So it was useful for debugging/analysis now, and we may want something
like it later, but I think that should come on top the ref-backend
series.

-Peff
