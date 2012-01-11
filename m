From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 10/13] credentials: add "cache" helper
Date: Wed, 11 Jan 2012 17:50:10 -0600
Message-ID: <20120111235009.GB30243@burratino>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103407.GJ16529@sigill.intra.peff.net>
 <20120110015038.GA17754@burratino>
 <20120110044430.GA23619@sigill.intra.peff.net>
 <20120110174420.GA22184@burratino>
 <20120110175312.GA7289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 12 00:45:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl7r8-0003yL-8Z
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 00:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230Ab2AKXpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 18:45:17 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42354 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab2AKXpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 18:45:16 -0500
Received: by iabz25 with SMTP id z25so1794836iab.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 15:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1iTbAI147nX5OvxetJcEy60r2+zdyQkCBpXMoRSZ6ds=;
        b=kbSdqOa7BJxc7IIM2iOT7Ks7VpnA/2iL1YP33N9/FGmlNEbHiF+xWPf1P/AJ60JKw6
         mrsgpXHm/a3T8pm6oBwRUUlvo5ytejT5nmSSK8y8hTP7TPXHOoz6r0vUod/2EeYAxBT1
         RyVGW44fCM8MdpL/B8WMYlc4v8CLtP1mA6j9A=
Received: by 10.50.188.166 with SMTP id gb6mr1113654igc.18.1326325515475;
        Wed, 11 Jan 2012 15:45:15 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id lu10sm5364281igc.0.2012.01.11.15.45.14
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 15:45:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120110175312.GA7289@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188404>

Jeff King wrote:

> Still, it would be slightly more robust. I wonder how portable fchdir
> is in practice (I guess we could always fall back to the getcwd code
> path). Do you want to prepare a patch on top?

I've been wanting to get around to doing something similar for setup.c
for a while.  I'm happy enough to forget about it for now. ;-)

Thanks again for the fix.  Here's another quick nit.

-- >8 --
Subject: unix-socket: do not let close() or chdir() clobber errno during cleanup

unix_stream_connect and unix_stream_listen return -1 on error, with
errno set by the failing underlying call to allow the caller to write
a useful diagnosis.

Unfortunately the error path involves a few system calls itself, such
as close(), that can themselves touch errno.

This is not as worrisome as it might sound.  If close() fails, this
just means substituting one meaningful error message for another,
which is perfectly fine.  However, when the call _succeeds_, it is
allowed to (and sometimes might) clobber errno along the way with some
undefined value, so it is good higiene to save errno and restore it
immediately before returning to the caller.  Do so.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 unix-socket.c |   39 ++++++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/unix-socket.c b/unix-socket.c
index 7d8bec61..01f119f9 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -73,25 +73,29 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
 
 int unix_stream_connect(const char *path)
 {
-	int fd;
+	int fd, saved_errno;
 	struct sockaddr_un sa;
 	struct unix_sockaddr_context ctx;
 
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		return -1;
 	fd = unix_stream_socket();
-	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
-		unix_sockaddr_cleanup(&ctx);
-		close(fd);
-		return -1;
-	}
+	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
+		goto fail;
 	unix_sockaddr_cleanup(&ctx);
 	return fd;
+
+fail:
+	saved_errno = errno;
+	unix_sockaddr_cleanup(&ctx);
+	close(fd);
+	errno = saved_errno;
+	return -1;
 }
 
 int unix_stream_listen(const char *path)
 {
-	int fd;
+	int fd, saved_errno;
 	struct sockaddr_un sa;
 	struct unix_sockaddr_context ctx;
 
@@ -100,18 +104,19 @@ int unix_stream_listen(const char *path)
 	fd = unix_stream_socket();
 
 	unlink(path);
-	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
-		unix_sockaddr_cleanup(&ctx);
-		close(fd);
-		return -1;
-	}
+	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
+		goto fail;
 
-	if (listen(fd, 5) < 0) {
-		unix_sockaddr_cleanup(&ctx);
-		close(fd);
-		return -1;
-	}
+	if (listen(fd, 5) < 0)
+		goto fail;
 
 	unix_sockaddr_cleanup(&ctx);
 	return fd;
+
+fail:
+	saved_errno = errno;
+	unix_sockaddr_cleanup(&ctx);
+	close(fd);
+	errno = saved_errno;
+	return -1;
 }
-- 
1.7.8.3
