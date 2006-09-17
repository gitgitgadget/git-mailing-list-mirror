From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: [PATCH] upload-archive: monitor child communication even more carefully.
Date: Sun, 17 Sep 2006 16:09:18 +0200
Message-ID: <cda58cb80609170709l1f2732d4s2c606aeafd6b9257@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 17 16:09:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOxKn-0001xW-Tf
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 16:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWIQOJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 10:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWIQOJU
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 10:09:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:38195 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932201AbWIQOJT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 10:09:19 -0400
Received: by wx-out-0506.google.com with SMTP id s14so3690675wxc
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 07:09:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Gyfi93rmBZxS0d7rIhhupWXBFqU35W7kCFkqQbyWnieEfwbRADaTMhgYJy5ojBymYVDGHMY39WqJKH/eKmZpGob+clP7sggAy6j2Ay5ttPN9nED9IZiCHorqek6RFLK51Eqgs1fs4VXG9Po1bA0iEwfozDcXs7sSF/TQJgvIRes=
Received: by 10.70.95.19 with SMTP id s19mr18200295wxb;
        Sun, 17 Sep 2006 07:09:18 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Sun, 17 Sep 2006 07:09:18 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27193>

The current code works like this: if others flags than POLLIN is
raised we assume that (a) something bad happened and the child died or
(b) the child has closed the pipe because it had no more data to send.

For the latter case, we assume wrongly that one call to
process_input() will empty the pipe. Indeed it reads only 16Ko of data
by call and the the pipe capacity can be larger than that (on current
Linux kernel, it is 65536 bytes). Therefore the child can write 32ko
of data, for example, and close the pipe. After that poll will return
POLLIN _and_ POLLHUP and the parent will read only 16ko of data.

This patch forces the parent to empty the pipe as soon as POLLIN is
raised and even if POLLHUP or something else is raised too.

Moreover, some implementations of poll might return POLLRDNORM flag
even if it is non standard.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---

 My own fault.

 builtin-upload-archive.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 115a12d..0596865 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -160,7 +160,8 @@ int cmd_upload_archive(int argc, const c
 		if (pfd[1].revents & POLLIN)
 			/* Status stream ready */
 			process_input(pfd[1].fd, 2);
-		if ((pfd[0].revents | pfd[1].revents) == POLLIN)
+		/* Always finish to read data when available */
+		if ((pfd[0].revents | pfd[1].revents) & POLLIN)
 			continue;

 		if (waitpid(writer, &status, 0) < 0)
-- 
1.4.2.1.gcd6f1-dirty
