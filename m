From: Jeff King <peff@peff.net>
Subject: [PATCH] diff: clarify textconv interface
Date: Mon, 22 Feb 2016 13:28:54 -0500
Message-ID: <20160222182854.GA11732@sigill.intra.peff.net>
References: <1456145545-5374-1-git-send-email-pclouds@gmail.com>
 <1456145545-5374-3-git-send-email-pclouds@gmail.com>
 <20160222180645.GB4587@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:29:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXvED-0007QD-H2
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 19:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbcBVS25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 13:28:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:46887 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753401AbcBVS25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 13:28:57 -0500
Received: (qmail 10418 invoked by uid 102); 22 Feb 2016 18:28:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 13:28:56 -0500
Received: (qmail 20871 invoked by uid 107); 22 Feb 2016 18:29:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 13:29:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 13:28:54 -0500
Content-Disposition: inline
In-Reply-To: <20160222180645.GB4587@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286941>

On Mon, Feb 22, 2016 at 01:06:45PM -0500, Jeff King wrote:

> I have a feeling you were confused by the fact that fill_textconv()
> does:

Looking over it, I agree this is a pretty confusing interface that grew
out of control over time.  But refactoring it is kind of tricky, because
we really do want to avoid extra allocations, or cross-module
assumptions (e.g., userdiff doesn't know about diff_filespec, but rather
the other way around, and we probably do not want to muck with the
internals of a diff_filespec when doing a textconv).

So I think the patch below is an improvement, but if somebody really
wants to dig into refactoring it, be my guest.

-- >8 --
Subject: [PATCH] diff: clarify textconv interface

The memory allocation scheme for the textconv interface is a
bit tricky, and not well documented. It was originally
designed as an internal part of diff.c (matching
fill_mmfile), but gradually was made public.

Refactoring it is difficult, but we can at least improve the
situation by documenting the intended flow and enforcing it
with an in-code assertion.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c     |  5 ++++-
 diff.h     | 16 ++++++++++++++++
 userdiff.h |  4 ++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 2136b69..a088e26 100644
--- a/diff.c
+++ b/diff.c
@@ -5085,7 +5085,7 @@ size_t fill_textconv(struct userdiff_driver *driver,
 {
 	size_t size;
 
-	if (!driver || !driver->textconv) {
+	if (!driver) {
 		if (!DIFF_FILE_VALID(df)) {
 			*outbuf = "";
 			return 0;
@@ -5096,6 +5096,9 @@ size_t fill_textconv(struct userdiff_driver *driver,
 		return df->size;
 	}
 
+	if (!driver->textconv)
+		die("BUG: fill_textconv called with non-textconv driver");
+
 	if (driver->textconv_cache && df->sha1_valid) {
 		*outbuf = notes_cache_get(driver->textconv_cache, df->sha1,
 					  &size);
diff --git a/diff.h b/diff.h
index 70b2d70..4505b4d 100644
--- a/diff.h
+++ b/diff.h
@@ -349,10 +349,26 @@ extern void diff_no_index(struct rev_info *, int, const char **);
 
 extern int index_differs_from(const char *def, int diff_flags);
 
+/*
+ * Fill the contents of the filespec "df", respecting any textconv defined by
+ * its userdiff driver.  The "driver" parameter must come from a
+ * previous call to get_textconv(), and therefore should either be NULL or have
+ * textconv enabled.
+ *
+ * Note that the memory ownership of the resulting buffer depends on whether
+ * the driver field is NULL. If it is, then the memory belongs to the filespec
+ * struct. If it is non-NULL, then "outbuf" points to a newly allocated buffer
+ * that should be freed by the caller.
+ */
 extern size_t fill_textconv(struct userdiff_driver *driver,
 			    struct diff_filespec *df,
 			    char **outbuf);
 
+/*
+ * Look up the userdiff driver for the given filespec, and return it if
+ * and only if it has textconv enabled (otherwise return NULL). The result
+ * can be passed to fill_textconv().
+ */
 extern struct userdiff_driver *get_textconv(struct diff_filespec *one);
 
 extern int parse_rename_score(const char **cp_p);
diff --git a/userdiff.h b/userdiff.h
index 4a7e78f..2ef0ce5 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -23,6 +23,10 @@ int userdiff_config(const char *k, const char *v);
 struct userdiff_driver *userdiff_find_by_name(const char *name);
 struct userdiff_driver *userdiff_find_by_path(const char *path);
 
+/*
+ * Initialize any textconv-related fields in the driver and return it, or NULL
+ * if it does not have textconv enabled at all.
+ */
 struct userdiff_driver *userdiff_get_textconv(struct userdiff_driver *driver);
 
 #endif /* USERDIFF */
-- 
2.7.1.652.g2fdcad6
