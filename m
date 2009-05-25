From: Jeff King <peff@peff.net>
Subject: [PATCH] convert bare readlink to strbuf_readlink
Date: Mon, 25 May 2009 06:46:09 -0400
Message-ID: <20090525104609.GA26895@coredump.intra.peff.net>
References: <20090522153426.GA10390@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Jarosch <thomas.jarosch@intra2net.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 12:46:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8XhE-0006GU-16
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 12:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbZEYKqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 06:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbZEYKqL
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 06:46:11 -0400
Received: from peff.net ([208.65.91.99]:34485 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbZEYKqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 06:46:10 -0400
Received: (qmail 3885 invoked by uid 107); 25 May 2009 10:46:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 06:46:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 06:46:09 -0400
Content-Disposition: inline
In-Reply-To: <20090522153426.GA10390@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119919>

This particular readlink call never NUL-terminated its
result, making it a potential source of bugs (though there
is no bug now, as it currently always respects the length
field). Let's just switch it to strbuf_readlink which is
shorter and less error-prone.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a re-post with the missing strbuf_release added.

I am not overly married to this patch, so if you think it is code churn,
please just say so and drop it. I am just clearing out my "clean up and
submit" queue. :)

 diff.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index f06876b..dcfbcb0 100644
--- a/diff.c
+++ b/diff.c
@@ -2014,18 +2014,15 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 			die("stat(%s): %s", name, strerror(errno));
 		}
 		if (S_ISLNK(st.st_mode)) {
-			int ret;
-			char buf[PATH_MAX + 1]; /* ought to be SYMLINK_MAX */
-			ret = readlink(name, buf, sizeof(buf));
-			if (ret < 0)
+			struct strbuf sb = STRBUF_INIT;
+			if (strbuf_readlink(&sb, name, st.st_size) < 0)
 				die("readlink(%s)", name);
-			if (ret == sizeof(buf))
-				die("symlink too long: %s", name);
-			prep_temp_blob(name, temp, buf, ret,
+			prep_temp_blob(name, temp, sb.buf, sb.len,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
 				       (one->sha1_valid ?
 					one->mode : S_IFLNK));
+			strbuf_release(&sb);
 		}
 		else {
 			/* we can borrow from the file in the work tree */
-- 
1.6.3.1.250.g01b8b.dirty
