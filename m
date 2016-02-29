From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 28/32] config: read ref storage config on startup
Date: Mon, 29 Feb 2016 17:21:07 -0500
Message-ID: <20160229222107.GA18931@sigill.intra.peff.net>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
 <1456354744-8022-29-git-send-email-dturner@twopensource.com>
 <20160227035634.GA10829@sigill.intra.peff.net>
 <1456783062.18017.65.camel@twopensource.com>
 <20160229221024.GE25342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 23:21:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaWBn-0000vO-TI
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbcB2WVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:21:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:51835 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750779AbcB2WVL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:21:11 -0500
Received: (qmail 12753 invoked by uid 102); 29 Feb 2016 22:21:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 17:21:10 -0500
Received: (qmail 31896 invoked by uid 107); 29 Feb 2016 22:21:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 17:21:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 17:21:07 -0500
Content-Disposition: inline
In-Reply-To: <20160229221024.GE25342@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287923>

On Mon, Feb 29, 2016 at 05:10:24PM -0500, Jeff King wrote:

> > We apparently don't always call check_repo_format before calling
> > git_config_early -- or, more to the point, before doing ref operations.
> > So I think we need this in git_config_early.
> 
> That seems horribly broken, though. If a program is accessing refs
> without calling check_repository_format, isn't it bypassing all of our
> regular version and extension checks?
> 
> I think we should be smoking out such cases (e.g., by setting
> a null refs-backend, as I mentioned earlier) and fixing them, rather
> than working around them by putting the backend setup in the wrong
> place.

So even without your series, this isn't too bad to instrument, like the
patch below.

It does reveal a handful of failures in the test suite. I haven't dug
yet, but I strongly suspect those are all bugs that should be fixed.

diff --git a/cache.h b/cache.h
index af2aeb8..a286f99 100644
--- a/cache.h
+++ b/cache.h
@@ -639,6 +639,7 @@ extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
 
 /* Environment bits from configuration mechanism */
+extern int repo_initialized;
 extern int trust_executable_bit;
 extern int trust_ctime;
 extern int check_stat;
diff --git a/environment.c b/environment.c
index 10451ee..6ee9812 100644
--- a/environment.c
+++ b/environment.c
@@ -12,6 +12,7 @@
 #include "fmt-merge-msg.h"
 #include "commit.h"
 
+int repo_initialized;
 int trust_executable_bit = 1;
 int trust_ctime = 1;
 int check_stat = 1;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 339f5c7..a4e9df6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -947,6 +947,9 @@ static struct ref_cache *lookup_ref_cache(const char *submodule)
 {
 	struct ref_cache *refs;
 
+	if (!repo_initialized)
+		die("BUG: lookup_ref_cache called without initializing repo");
+
 	if (!submodule || !*submodule)
 		return &ref_cache;
 
@@ -1414,6 +1417,9 @@ static const char *resolve_ref_1(const char *refname,
 	int depth = MAXDEPTH;
 	int bad_name = 0;
 
+	if (!repo_initialized)
+		die("BUG: resolve_ref called without initializing repo");
+
 	if (flags)
 		*flags = 0;
 
diff --git a/setup.c b/setup.c
index 76609fa..ed86094 100644
--- a/setup.c
+++ b/setup.c
@@ -446,6 +446,9 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 		ret = -1;
 	}
 
+	if (ret == 0)
+		repo_initialized = 1;
+
 	strbuf_release(&sb);
 	return ret;
 }
