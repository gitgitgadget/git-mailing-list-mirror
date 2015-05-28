From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] config.c: rewrite ENODEV into EISDIR when mmap fails
Date: Thu, 28 May 2015 04:03:01 -0400
Message-ID: <20150528080300.GD23395@peff.net>
References: <20150528075142.GB3688@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 10:03:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxsme-00053i-Gk
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 10:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbbE1IDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 04:03:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:37114 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751381AbbE1IDE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 04:03:04 -0400
Received: (qmail 16508 invoked by uid 102); 28 May 2015 08:03:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 03:03:03 -0500
Received: (qmail 14160 invoked by uid 107); 28 May 2015 08:03:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 04:03:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2015 04:03:01 -0400
Content-Disposition: inline
In-Reply-To: <20150528075142.GB3688@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270132>

If we try to mmap a directory, we'll get ENODEV. This
translates to "no such device" for the user, which is not
very helpful. Since we've just fstat()'d the file, we can
easily check whether the problem was a directory to give a
better message.

Signed-off-by: Jeff King <peff@peff.net>
---
It feels a bit wrong to put this magic conversion here, and not in
xmmap. But of course xmmap does not have the stat information.

Which makes me wonder if we should provide an interface that will take
the whole "struct stat" rather than just the size. That's less flexible,
but in most cases, we're mapping the whole file (the packfiles are the
big exception, where we use a window).

We could also potentially drop some of the useless options. As of patch
1, all of our calls are PROT_READ. They must all be MAP_PRIVATE, or our
pread compatibility wrapper will fail, and we never use other flags. We
never request a specific address. And in a whole-file remap, the offset
will always be 0. So something like:

  void *xmmap_file(int fd, struct stat *st);

would probably work. We could even do the fstat() on behalf of the
caller, though they need to know the length themselves. Maybe:

  void *xmmap_file(int fd, size_t *len);

I dunno if it is worth it or not.

 config.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.c b/config.c
index e7dc155..29fa012 100644
--- a/config.c
+++ b/config.c
@@ -2056,6 +2056,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
 		contents = xmmap_gently(NULL, contents_sz, PROT_READ,
 					MAP_PRIVATE, in_fd, 0);
 		if (contents == MAP_FAILED) {
+			if (errno == ENODEV && S_ISDIR(st.st_mode))
+				errno = EISDIR;
 			error("unable to mmap '%s': %s",
 			      config_filename, strerror(errno));
 			ret = CONFIG_INVALID_FILE;
-- 
2.4.2.668.gc3b1ade.dirty
