From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 5/6] Change copy_fd() to not close input fd
Date: Tue, 26 Aug 2014 14:29:06 -0400
Message-ID: <20140826182905.GD17546@peff.net>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
 <1409066605-4851-6-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:29:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMLUX-0006m6-OA
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 20:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbaHZS3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 14:29:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:59456 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751954AbaHZS3I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 14:29:08 -0400
Received: (qmail 5405 invoked by uid 102); 26 Aug 2014 18:29:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 13:29:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 14:29:06 -0400
Content-Disposition: inline
In-Reply-To: <1409066605-4851-6-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255934>

On Tue, Aug 26, 2014 at 05:23:24PM +0200, Steffen Prohaska wrote:

> The caller opened the fd, so it should be responsible for closing it.
> 
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  copy.c     | 5 +----
>  lockfile.c | 3 +++
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/copy.c b/copy.c
> index a7f58fd..d0a1d82 100644
> --- a/copy.c
> +++ b/copy.c
> @@ -10,7 +10,6 @@ int copy_fd(int ifd, int ofd)
>  			break;
>  		if (len < 0) {
>  			int read_error = errno;
> -			close(ifd);
>  			return error("copy-fd: read returned %s",
>  				     strerror(read_error));
>  		}

This saved errno is not necessary anymore (the problem was that close()
clobbered the error in the original code). It can go away, and we can
even drop the curly braces.

> @@ -21,17 +20,14 @@ int copy_fd(int ifd, int ofd)
>  				len -= written;
>  			}
>  			else if (!written) {
> -				close(ifd);
>  				return error("copy-fd: write returned 0");
>  			} else {
>  				int write_error = errno;
> -				close(ifd);
>  				return error("copy-fd: write returned %s",
>  					     strerror(write_error));
>  			}
>  		}

Ditto here. Actually, isn't this whole write just a reimplementation of
write_in_full? The latter treats a return of 0 as ENOSPC rather than
using a custom message, but I think that is sane.

All together:

---
 copy.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/copy.c b/copy.c
index a7f58fd..53a9ece 100644
--- a/copy.c
+++ b/copy.c
@@ -4,34 +4,16 @@ int copy_fd(int ifd, int ofd)
 {
 	while (1) {
 		char buffer[8192];
-		char *buf = buffer;
 		ssize_t len = xread(ifd, buffer, sizeof(buffer));
 		if (!len)
 			break;
-		if (len < 0) {
-			int read_error = errno;
-			close(ifd);
+		if (len < 0)
 			return error("copy-fd: read returned %s",
-				     strerror(read_error));
-		}
-		while (len) {
-			int written = xwrite(ofd, buf, len);
-			if (written > 0) {
-				buf += written;
-				len -= written;
-			}
-			else if (!written) {
-				close(ifd);
-				return error("copy-fd: write returned 0");
-			} else {
-				int write_error = errno;
-				close(ifd);
-				return error("copy-fd: write returned %s",
-					     strerror(write_error));
-			}
-		}
+				     strerror(errno));
+		if (write_in_full(ofd, buffer, len) < 0)
+			return error("copy-fd: write returned %s",
+				     strerror(errno));
 	}
-	close(ifd);
 	return 0;
 }
 
