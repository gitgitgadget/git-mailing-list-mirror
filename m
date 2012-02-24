From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] bulk checkin does not respect filters
Date: Fri, 24 Feb 2012 03:28:03 -0500
Message-ID: <20120224082803.GB18688@sigill.intra.peff.net>
References: <20120224030244.GA15742@sigill.intra.peff.net>
 <7vvcmw2a3m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 09:28:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0qVf-0001ms-VP
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 09:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab2BXI2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 03:28:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55418
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755133Ab2BXI2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 03:28:05 -0500
Received: (qmail 21906 invoked by uid 107); 24 Feb 2012 08:28:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 03:28:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 03:28:03 -0500
Content-Disposition: inline
In-Reply-To: <7vvcmw2a3m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191416>

On Thu, Feb 23, 2012 at 07:17:49PM -0800, Junio C Hamano wrote:

> > Thoughts? Was this intentional, or just overlooked?
> 
> This is intentional in the sense it is not worth worrying about (I
> personally consider large and binary gunk equivalent and something nobody
> should care about anything more than 1. what the exact contents it had at
> each point in history and 2. if it did or did not change between two
> versions, but definitely not 3. how different these two versions were),
> and does not deserve the complexity to support filtering and textconv'ing.

We're purely in the hypothetical devil's advocate realm here, as I do
not use the filtering feature myself. But what if I had a filter that
canonicalized large binary files in some way (e.g., by re-zipping large
zipfiles using deterministic parameters). Even though they are large
binary gunk and you would never want to diff two versions, the important
thing is getting an identical sha1 when the underlying data has not
changed. I.e., your point 2 above, but applied to the "clean" repository
versions of files.

> If somebody strongly feels about lifting the limitation with a clean patch
> that does not harm the common case codepaths, patches are welcome, but I
> am not planning to do it myself ;-)

Perhaps something like this:

---
 convert.c   |   18 ++++++++++++++++++
 convert.h   |    1 +
 sha1_file.c |    3 ++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 12868ed..254301a 100644
--- a/convert.c
+++ b/convert.c
@@ -742,6 +742,24 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 	}
 }
 
+int want_convert_to_git(const char *path)
+{
+	struct conv_attrs ca;
+	convert_attrs(&ca, path);
+
+	if (ca.drv && ca.drv->clean)
+		return 1;
+	if (ca.ident)
+		return 1;
+
+	ca.crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
+	if (ca.crlf_action == CRLF_BINARY)
+		return 0;
+	if (ca.crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE)
+		return 0;
+	return 1;
+}
+
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
diff --git a/convert.h b/convert.h
index d799a16..4d5936d 100644
--- a/convert.h
+++ b/convert.h
@@ -36,6 +36,7 @@ extern enum eol core_eol;
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t len,
 			  struct strbuf *dst, enum safe_crlf checksafe);
+extern int want_convert_to_git(const char *path);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
diff --git a/sha1_file.c b/sha1_file.c
index f9f8d5e..6c0e05c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2720,7 +2720,8 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 
 	if (!S_ISREG(st->st_mode))
 		ret = index_pipe(sha1, fd, type, path, flags);
-	else if (size <= big_file_threshold || type != OBJ_BLOB)
+	else if (size <= big_file_threshold || type != OBJ_BLOB ||
+		 want_convert_to_git(path))
 		ret = index_core(sha1, fd, size, type, path, flags);
 	else
 		ret = index_stream(sha1, fd, size, type, path, flags);

There should be no performance impact, as the new code only kicks in for
files that exceed big_file_threshold (and even then, it is just an extra
duplicate attr lookup, which the check_attr code caches anyway).

I don't like repeating all of the convert_to_git policy logic. Perhaps
if you pass a NULL buffer to convert_to_git, it should run through its
usual logic, stopping just short of actually writing anything, and
return a flag indicating whether it _would_ convert (this can't be 100%
accurate, as sometimes conversion depends on looking at the actual
contents of the buffer, but it could at least tell us "yes, I might
convert" versus "no, I will definitely not convert").

-Peff
